From: Michael S. Tsirkin <mst@redhat.com>
Date: Thu, 3 Dec 2020 16:57:03 -0500
Subject: [Intel-wired-lan] [PATCH v4 2/2] hw/virtio-pci Added AER
 capability.
In-Reply-To: <20201203132517.220811-3-andrew@daynix.com>
References: <20201203132517.220811-1-andrew@daynix.com>
 <20201203132517.220811-3-andrew@daynix.com>
Message-ID: <20201203165317-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Dec 03, 2020 at 03:25:17PM +0200, Andrew Melnychenko wrote:
> From: Andrew <andrew@daynix.com>
> 
> Added AER capability for virtio-pci devices.
> Also added property for devices, by default AER is disabled.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  hw/virtio/virtio-pci.c | 16 ++++++++++++++++
>  hw/virtio/virtio-pci.h |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index ceaa233129..f863f69ede 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1817,6 +1817,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>           */
>          pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
>  
> +        if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
> +            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
> +                          PCI_ERR_SIZEOF, NULL);
> +            last_pcie_cap_offset += PCI_ERR_SIZEOF;
> +        }
> +


What I dislike here is that the property can be added to
pci devices (not express) and will apparently succeed.
Pls add code to validate and fail init.


>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
>              /* Init error enabling flags */
>              pcie_cap_deverr_init(pci_dev);
> @@ -1858,7 +1864,15 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>  
>  static void virtio_pci_exit(PCIDevice *pci_dev)
>  {
> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
> +    bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
> +                     !pci_bus_is_root(pci_get_bus(pci_dev));
> +
>      msix_uninit_exclusive_bar(pci_dev);
> +    if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
> +        pci_is_express(pci_dev)) {
> +        pcie_aer_exit(pci_dev);
> +    }
>  }
>  
>  static void virtio_pci_reset(DeviceState *qdev)
> @@ -1911,6 +1925,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> +    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_AER_BIT, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 06e2af12de..d7d5d403a9 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -41,6 +41,7 @@ enum {
>      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
>      VIRTIO_PCI_FLAG_INIT_PM_BIT,
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> +    VIRTIO_PCI_FLAG_AER_BIT,
>  };
>  
>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -80,6 +81,9 @@ enum {
>  /* Init Function Level Reset capability */
>  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
>  
> +/* Advanced Error Reporting capability */
> +#define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
> +
>  typedef struct {
>      MSIMessage msg;
>      int virq;
> -- 
> 2.29.2

