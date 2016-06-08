From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 7 Jun 2016 20:54:17 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state upon
	probe
In-Reply-To: <20160608002043.10367-1-jacob.e.keller@intel.com>
References: <20160608002043.10367-1-jacob.e.keller@intel.com>
Message-ID: <CAKgT0UdmTRUesM9hD9ifUw=+rx117=Ck7bzEgezHX=WGR2rArQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 7, 2016 at 5:20 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> It seems that under some circumstances, such as after performing an
> unbind following an AER injection recovery, the power state of a VF
> isn't set to PCI_D0. Following the unbind if we attempt to bind the
> device, the MSI-X initialization fails due to incorrect power state.

That doesn't make much sense.  I didn't think the VFs had their own
power state control.  After all it isn't as if they could switch off
while the PF is active on the host.

> Fix this by always calling pci_set_power_state(pdev, PCI_D0) on driver
> device probe.

That should be redundant.  There is already code that is called to
transition the power state to D0 in pci_enable_device_mem.  As long as
nobody else has enabled the device it will be ran.

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index b8245c734c96..f2b7b8447cb7 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -1975,6 +1975,8 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>
>         pci_enable_pcie_error_reporting(pdev);
>
> +       pci_set_power_state(pdev, PCI_D0);
> +
>         pci_set_master(pdev);
>         pci_save_state(pdev);

The placement of this seems a bit suspicious to me.  Is it that you
cannot enable the D0 power state until after error reporting has been
enabled or is there some other reason to place it out there rather
than enabling D0 before performing any other operations on the device.

It might make more sense to offload this work to the PF and have it
reset the power state on the VF from underneath rather than relying on
it being performed by the VF once it is in the guest.  There might be
some hypervisors that prevent the guest from being able to make power
state changes for devices on the host.

- Alex
