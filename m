From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 23 Mar 2021 14:40:46 -0500
Subject: [Intel-wired-lan] [PATCH next-queue v3 1/3] Revert "PCI: Make
 pci_enable_ptm() private"
In-Reply-To: <20210322161822.1546454-2-vinicius.gomes@intel.com>
Message-ID: <20210323194046.GA598671@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 22, 2021 at 09:18:20AM -0700, Vinicius Costa Gomes wrote:
> Make pci_enable_ptm() accessible from the drivers.
> 
> Even if PTM still works on the platform I am using without calling
> this function, it might be possible that it's not always the case.

I don't understand the value of this paragraph.  The rest of it makes
good sense (although I think we might want to add a wrapper as I
mentioned elsewhere).

> Exposing this to the driver enables the driver to use the
> 'ptm_enabled' field of 'pci_dev' to check if PTM is enabled or not.
> 
> This reverts commit ac6c26da29c12fa511c877c273ed5c939dc9e96c.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.h   | 3 ---
>  include/linux/pci.h | 7 +++++++
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ef7c4661314f..2c61557e1cc1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -599,11 +599,8 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>  
>  #ifdef CONFIG_PCIE_PTM
>  void pci_ptm_init(struct pci_dev *dev);
> -int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
>  #else
>  static inline void pci_ptm_init(struct pci_dev *dev) { }
> -static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> -{ return -EINVAL; }
>  #endif
>  
>  struct pci_dev_reset_methods {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..3d3dc07eac3b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1610,6 +1610,13 @@ static inline bool pci_aer_available(void) { return false; }
>  
>  bool pci_ats_disabled(void);
>  
> +#ifdef CONFIG_PCIE_PTM
> +int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
> +#else
> +static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> +{ return -EINVAL; }
> +#endif
> +
>  void pci_cfg_access_lock(struct pci_dev *dev);
>  bool pci_cfg_access_trylock(struct pci_dev *dev);
>  void pci_cfg_access_unlock(struct pci_dev *dev);
> -- 
> 2.31.0
> 
