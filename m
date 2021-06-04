From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 4 Jun 2021 17:27:12 -0500
Subject: [Intel-wired-lan] [PATCH next-queue v4 2/4] PCI: Add
 pcie_ptm_enabled()
In-Reply-To: <20210604220933.3974558-3-vinicius.gomes@intel.com>
Message-ID: <20210604222712.GA2246328@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 04, 2021 at 03:09:31PM -0700, Vinicius Costa Gomes wrote:
> Adds a predicate that returns if PCIe PTM (Precision Time Measurement)
> is enabled.

Ideally, "Add a predicate ..."

> It will only return true if it's enabled in all the ports in the path
> from the device to the root.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

But either way,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/ptm.c | 9 +++++++++
>  include/linux/pci.h    | 3 +++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 95d4eef2c9e8..8a4ad974c5ac 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -204,3 +204,12 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  	return 0;
>  }
>  EXPORT_SYMBOL(pci_enable_ptm);
> +
> +bool pcie_ptm_enabled(struct pci_dev *dev)
> +{
> +	if (!dev)
> +		return false;
> +
> +	return dev->ptm_enabled;
> +}
> +EXPORT_SYMBOL(pcie_ptm_enabled);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a687dda262dd..fe7f264b2b15 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1619,9 +1619,12 @@ bool pci_ats_disabled(void);
>  
>  #ifdef CONFIG_PCIE_PTM
>  int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
> +bool pcie_ptm_enabled(struct pci_dev *dev);
>  #else
>  static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  { return -EINVAL; }
> +static inline bool pcie_ptm_enabled(struct pci_dev *dev)
> +{ return false; }
>  #endif
>  
>  void pci_cfg_access_lock(struct pci_dev *dev);
> -- 
> 2.31.1
> 
