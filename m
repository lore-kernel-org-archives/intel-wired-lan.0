From: Marc Zyngier <maz@kernel.org>
Date: Wed, 25 Aug 2021 14:30:04 +0100
Subject: [Intel-wired-lan] [PATCH v3 2/3] PCI/sysfs: Don't depend on
 pci_dev.irq for IRQ entry
In-Reply-To: <20210825102636.52757-3-21cnbao@gmail.com>
References: <20210825102636.52757-1-21cnbao@gmail.com>
 <20210825102636.52757-3-21cnbao@gmail.com>
Message-ID: <87czq1ps83.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 25 Aug 2021 11:26:35 +0100,
Barry Song <21cnbao@gmail.com> wrote:
> 
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> Explicitly use IRQ number from MSI list for IRQ sysfs entry. Then sysfs
> will decouple with the odd implementation depending on pci_dev.irq.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/pci/pci-sysfs.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7bbf2673..f5a06b9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/vgaarb.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/msi.h>
>  #include <linux/of.h>
>  #include "pci.h"
>  
> @@ -49,7 +50,27 @@ static DEVICE_ATTR_RO(field)
>  pci_config_attr(subsystem_device, "0x%04x\n");
>  pci_config_attr(revision, "0x%02x\n");
>  pci_config_attr(class, "0x%06x\n");
> -pci_config_attr(irq, "%u\n");
> +
> +static ssize_t irq_show(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +#ifdef CONFIG_PCI_MSI
> +	/*
> +	 * For MSI, return the 1st IRQ in IRQ vector; for all other cases
> +	 * including MSI-X, return legacy INTx
> +	 */
> +	if (pdev->msi_enabled) {
> +		struct msi_desc *desc = first_pci_msi_entry(pdev);
> +
> +		return sysfs_emit(buf, "%u\n", desc->irq);
> +	}
> +#endif

nit: It would be worth adding a comment indicating that we only do
this to preserve an existing userspace ABI. Just in case someone
thinks it is pointless and remove it... ;-)

	M.

-- 
Without deviation from the norm, progress is not possible.
