From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Mon, 18 May 2015 23:31:28 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
 protect	VPD operations
In-Reply-To: <20150516001407.98487.1056.stgit@mdrustad-wks.jf.intel.com>
References: <20150516001407.98487.1056.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AE66237@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> On Behalf Of Mark D Rustad
> Sent: Friday, May 15, 2015 5:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
> protect VPD operations
> 
> Some devices have a problem with concurrent VPD access to different
> functions of the same physical device, so move the protecting mutex
> from the pci_vpd structure to the pci_bus structure. There are a
> number of reports on support sites for a variety of devices from
> various vendors getting the "vpd r/w failed" message. This is likely
> to at least fix some of them. Thanks to Shannon Nelson for helping
> to come up with this approach.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>


Acked-by: Shannon Nelson <shannon.nelson@intel.com>


> ---
>  drivers/pci/access.c |   10 ++++------
>  drivers/pci/probe.c  |    1 +
>  include/linux/pci.h  |    1 +
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d9b64a175990..6a1c8d6f95f1 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -281,7 +281,6 @@ PCI_USER_WRITE_CONFIG(dword, u32)
> 
>  struct pci_vpd_pci22 {
>  	struct pci_vpd base;
> -	struct mutex lock;
>  	u16	flag;
>  	bool	busy;
>  	u8	cap;
> @@ -340,7 +339,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev
> *dev, loff_t pos, size_t count,
>  	if (pos < 0 || pos > vpd->base.len || end > vpd->base.len)
>  		return -EINVAL;
> 
> -	if (mutex_lock_killable(&vpd->lock))
> +	if (mutex_lock_killable(&dev->bus->vpd_mutex))
>  		return -EINTR;
> 
>  	ret = pci_vpd_pci22_wait(dev);
> @@ -376,7 +375,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev
> *dev, loff_t pos, size_t count,
>  		}
>  	}
>  out:
> -	mutex_unlock(&vpd->lock);
> +	mutex_unlock(&dev->bus->vpd_mutex);
>  	return ret ? ret : count;
>  }
> 
> @@ -392,7 +391,7 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev
> *dev, loff_t pos, size_t count
>  	if (pos < 0 || (pos & 3) || (count & 3) || end > vpd->base.len)
>  		return -EINVAL;
> 
> -	if (mutex_lock_killable(&vpd->lock))
> +	if (mutex_lock_killable(&dev->bus->vpd_mutex))
>  		return -EINTR;
> 
>  	ret = pci_vpd_pci22_wait(dev);
> @@ -424,7 +423,7 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev
> *dev, loff_t pos, size_t count
>  		pos += sizeof(u32);
>  	}
>  out:
> -	mutex_unlock(&vpd->lock);
> +	mutex_unlock(&dev->bus->vpd_mutex);
>  	return ret ? ret : count;
>  }
> 
> @@ -453,7 +452,6 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
> 
>  	vpd->base.len = PCI_VPD_PCI22_SIZE;
>  	vpd->base.ops = &pci_vpd_pci22_ops;
> -	mutex_init(&vpd->lock);
>  	vpd->cap = cap;
>  	vpd->busy = false;
>  	dev->vpd = &vpd->base;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6675a7a1b9fc..40c2a5a751d0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -494,6 +494,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus
> *parent)
>  	INIT_LIST_HEAD(&b->devices);
>  	INIT_LIST_HEAD(&b->slots);
>  	INIT_LIST_HEAD(&b->resources);
> +	mutex_init(&b->vpd_mutex);
>  	b->max_bus_speed = PCI_SPEED_UNKNOWN;
>  	b->cur_bus_speed = PCI_SPEED_UNKNOWN;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 353db8dc4c6e..f8a51d172255 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -454,6 +454,7 @@ struct pci_bus {
>  	struct msi_controller *msi;	/* MSI controller */
>  	void		*sysdata;	/* hook for sys-specific extension */
>  	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci
> */
> +	struct mutex	vpd_mutex;	/* bus-wide VPD access mutex */
> 
>  	unsigned char	number;		/* bus number */
>  	unsigned char	primary;	/* number of primary bridge */
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
