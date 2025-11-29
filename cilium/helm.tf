resource "helm_release" "cilium" {
  name              = "cilium"
  chart             = "cilium"
  repository        = "https://helm.cilium.io/"
  version           = var.cilium_version
  namespace         = "kube-system"
  create_namespace  = false
  wait              = false
  timeout           = 120
  dependency_update = true

  values = [yamlencode({
    l2announcements = {
      enabled = true
    }
    devices = var.devices

    cni = {
      exclusive = var.exclusive_cni
    }

    bpf = {
      vlanBypass = [
        200
      ]
    }

    k8sClientRateLimit = {
      qps   = 10
      burst = 20
    }

    ingressController = {
      enabled          = true
      loadbalancerMode = "dedicated"
    }

    prometheus = {
      enabled = true
    }

    operator = {
      prometheus = {
        enabled = true
      }
    }

    hubble = {
      enabled = true
      metrics = {
        enableOpenMetrics = true
        enabled = [
          "dns",
          "drop",
          "tcp",
          "flow",
          "port-distribution",
          "icmp",
          "httpV2:exemplars=true;labelsContext=source_ip,source_namespace,source_workload,destination_ip,destination_namespace,destination_workload,traffic_direction"
        ]
      }
      relay = {
        enabled = true
      }
      ui = {
        enabled = true
      }
    }

    ipam = {
      mode = "kubernetes"
    }

    kubeProxyReplacement = true

    securityContext = {
      capabilities = {
        ciliumAgent = [
          "CHOWN",
          "KILL",
          "NET_ADMIN",
          "NET_RAW",
          "IPC_LOCK",
          "SYS_ADMIN",
          "SYS_RESOURCE",
          "DAC_OVERRIDE",
          "FOWNER",
          "SETGID",
          "SETUID"
        ]
        cleanCiliumState = [
          "NET_ADMIN",
          "SYS_ADMIN",
          "SYS_RESOURCE"
        ]
      }
    }

    cgroup = {
      autoMount = {
        enabled = false
      }
      hostRoot = "/sys/fs/cgroup"
    }

    k8sServiceHost = "localhost"
    k8sServicePort = 7445

    gatewayAPI = {
      enabled          = true
      enableAlpn       = true 
      enableAppProtocol = true 
    }

    loadBalancer = {
      algorithm = "maglev"
    }

    loadBalancerIPAM = {
      enabled = true
    }
  })]
  depends_on = [resource.kubectl_manifest.gateway_api_crds]
}

resource "kubernetes_manifest" "cilium_l2_announcement_policy" {
  manifest = {
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumL2AnnouncementPolicy"
    metadata = {
      name = "basic-policy"
    }
    spec = {
      interfaces      = [var.ip_pool_interface]
      serviceSelector = {
        matchExpressions = [{
          key = "service-group"
          operator = "NotIn"
          values = [
            "management"
          ]
        }]
      }
      externalIPs     = true
      loadBalancerIPs = true
    }
  }
  depends_on = [resource.helm_release.cilium]
}

resource "kubernetes_manifest" "cilium_load_balancer_ip_pool" {
  manifest = {
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumLoadBalancerIPPool"
    metadata = {
      name = "service-subnet"
    }
    spec = {
      blocks = [
        {
          start = var.ip_pool_start
          stop  = var.ip_pool_end
        }
      ]
    }
  }
  depends_on = [resource.helm_release.cilium]
}
resource "kubernetes_manifest" "cilium_l2_announcement_policy" {
  manifest = {
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumL2AnnouncementPolicy"
    metadata = {
      name = "mgt-policy"
    }
    spec = {
      interfaces      = [var.ip_pool_mgt_interface]
      serviceSelector = {
        matchLabels = {
          service-group = "management"
        }
      }
      externalIPs     = true
      loadBalancerIPs = true
    }
  }
  depends_on = [resource.helm_release.cilium]
  }
}

resource "kubernetes_manifest" "cilium_mgt_load_balencer_ip_pool" {
  manifest = {
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumLoadBalancerIPPool"
    metadata = {
      name = "mgt-service-subnet"
    }
    spec = {
      blocks = [
        {
          start = var.mgt_ip_pool_start
          stop  = var.mgt_ip_pool_end
        }
      ]
    }
  }
  depends_on = [resource.helm_release.cilium]
}
