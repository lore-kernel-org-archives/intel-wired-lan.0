From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 02 Jun 2015 19:28:55 -0700
Subject: [Intel-wired-lan] [PATCH V2 1/2] pci: Add dev_flags bit to
 access VPD through function 0
In-Reply-To: <20150603001011.71269.79857.stgit@mdrustad-wks.jf.intel.com>
References: <20150603000645.71269.26134.stgit@mdrustad-wks.jf.intel.com>
 <20150603001011.71269.79857.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <556E6667.1020000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/02/2015 05:10 PM, Mark D Rustad wrote:
> Add a dev_flags bit, PCI_DEV_FLAGS_VPD_REF_F0, to access VPD through
> function 0 to provide VPD access on other functions. This solves
> concurrent access problems on many devices without changing the
> attributes exposed in sysfs. Never set this bit on function 0 or
> there will be an infinite recursion.
>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Corrected spelling in log message
> - Added checks to see that the referenced function 0 is reasonable
> ---
>   drivers/pci/access.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d9b64a175990..74634d4868a2 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -439,6 +439,40 @@ static const struct pci_vpd_ops pci_vpd_pci22_ops = {
>   	.release = pci_vpd_pci22_release,
>   };
>   
> +static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
> +			       void *arg)
> +{
> +	struct pci_dev *tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
> +	ssize_t ret;
> +
> +	if (!tdev)
> +		return -ENODEV;
> +
> +	ret = pci_read_vpd(tdev, pos, count, arg);
> +	pci_dev_put(tdev);
> +	return ret;
> +}
> +
> +static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
> +				const void *arg)
> +{
> +	struct pci_dev *tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
> +	ssize_t ret;
> +
> +	if (!tdev)
> +		return -ENODEV;
> +
> +	ret = pci_write_vpd(tdev, pos, count, arg);
> +	pci_dev_put(tdev);
> +	return ret;
> +}
> +
> +static const struct pci_vpd_ops pci_vpd_f0_ops = {
> +	.read = pci_vpd_f0_read,
> +	.write = pci_vpd_f0_write,
> +	.release = pci_vpd_pci22_release,
> +};
> +
>   int pci_vpd_pci22_init(struct pci_dev *dev)
>   {
>   	struct pci_vpd_pci22 *vpd;
> @@ -447,12 +481,24 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
>   	cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
>   	if (!cap)
>   		return -ENODEV;
> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> +		struct pci_dev *tdev;
> +
> +		tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
> +		if (!tdev || !dev->multifunction || !tdev->multifunction ||
> +		    dev->class != tdev->class || dev->vendor != tdev->vendor ||
> +		    dev->device != tdev->device)
> +			return -ENODEV;
> +	}

You can probably combine the dev->multifunction check with the dev_flags 
check.  After all you don't need this workaround if the device is not 
multifunction.  It might even make more sense to move the multifunction 
check to the quirk in patch 2/2.

I also believe this leaks a reference to the device.  You should be 
calling pci_dev_put(tdev) if tdev is not NULL.  As such you probably 
need to split up the !tdev and the rest of the checks.

- Alex
