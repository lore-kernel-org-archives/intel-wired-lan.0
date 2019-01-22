From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 22 Jan 2019 17:51:34 -0600
Subject: [Intel-wired-lan] [PATCH] PCI / ACPI: Don't clear pme_poll on
 device that has unreliable ACPI wake
In-Reply-To: <20190122064544.27426-1-kai.heng.feng@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
Message-ID: <20190122235134.GE14636@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 22, 2019 at 02:45:44PM +0800, Kai-Heng Feng wrote:
> There are some e1000e devices can only be woken up from D3 one time, by
> plugging ethernet cable. Subsequent cable plugging does set PME bit
> correctly, but it still doesn't get woken up.
> 
> Since e1000e connects to the root complex directly, we rely on ACPI to
> wake it up. In this case, the GPE from _PRW only works once and stops
> working after that.
> 
> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
> platform firmwares that have unreliable GPE wake.

This quirk applies to all 0x15bb (E1000_DEV_ID_PCH_CNP_I219_LM7) and
0x15bd (E1000_DEV_ID_PCH_CNP_I219_LM6) devices.  The e1000e driver
claims about a zillion different device IDs.

I would be surprised if these two devices are defective but all the
others work correctly.  Could it be that there is a problem with the
wiring on this particular motherboard or with the ACPI _PRW methods
(or the way Linux interprets them) in this firmware?

Would you mind attaching a complete dmesg log and "sudo lspci -vvv"
output to the bugzilla, please?

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  drivers/pci/quirks.c   | 8 ++++++++
>  include/linux/pci.h    | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e1949f7efd9c..184e2fc8a294 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -430,7 +430,7 @@ static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
>  
>  	pci_dev = to_pci_dev(context->dev);
>  
> -	if (pci_dev->pme_poll)
> +	if (pci_dev->pme_poll && !pci_dev->unreliable_acpi_wake)
>  		pci_dev->pme_poll = false;
>  
>  	if (pci_dev->current_state == PCI_D3cold) {
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..ed4863496fa8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4948,6 +4948,14 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  
> +static void quirk_unreliable_acpi_wake(struct pci_dev *pdev)
> +{
> +	pci_info(pdev, "ACPI Wake unreliable, always poll PME\n");
> +	pdev->unreliable_acpi_wake = 1;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bb, quirk_unreliable_acpi_wake);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bd, quirk_unreliable_acpi_wake);
> +
>  /*
>   * Some IDT switches incorrectly flag an ACS Source Validation error on
>   * completions for config read requests even though PCIe r4.0, sec
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c2f082..d22065c1576f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -331,6 +331,7 @@ struct pci_dev {
>  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>  					   can be generated */
>  	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
> +	unsigned int	unreliable_acpi_wake:1;	/* ACPI Wake doesn't always work */
>  	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>  	unsigned int	d2_support:1;	/* Low power state D2 is supported */
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
> -- 
> 2.17.1
> 
