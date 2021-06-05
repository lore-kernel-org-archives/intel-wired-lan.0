From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sat, 5 Jun 2021 08:42:58 +0200
Subject: [Intel-wired-lan] [PATCH next-queue v5 3/4] igc: Enable PCIe PTM
In-Reply-To: <20210605002356.3996853-4-vinicius.gomes@intel.com>
References: <20210605002356.3996853-1-vinicius.gomes@intel.com>
 <20210605002356.3996853-4-vinicius.gomes@intel.com>
Message-ID: <70d32740-eb4b-f7bf-146e-8dc06199d6c9@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Vinicius,


Am 05.06.21 um 02:23 schrieb Vinicius Costa Gomes:
> Enables PCIe PTM (Precision Time Measurement) support in the igc
> driver. Notifies the PCI devices that PCIe PTM should be enabled.
> 
> PCIe PTM is similar protocol to PTP (Precision Time Protocol) running
> in the PCIe fabric, it allows devices to report time measurements from
> their internal clocks and the correlation with the PCIe root clock.
> 
> The i225 NIC exposes some registers that expose those time
> measurements, those registers will be used, in later patches, to
> implement the PTP_SYS_OFFSET_PRECISE ioctl().
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index a05e6d8ec660..f23d0303e53b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -12,6 +12,8 @@
>   #include <net/pkt_sched.h>
>   #include <linux/bpf_trace.h>
>   #include <net/xdp_sock_drv.h>
> +#include <linux/pci.h>
> +
>   #include <net/ipv6.h>
>   
>   #include "igc.h"
> @@ -5864,6 +5866,10 @@ static int igc_probe(struct pci_dev *pdev,
>   
>   	pci_enable_pcie_error_reporting(pdev);
>   
> +	err = pci_enable_ptm(pdev, NULL);
> +	if (err < 0)
> +		dev_err(&pdev->dev, "PTM not supported\n");
> +

Sorry, if I am missing something, but do all devices supported by this 
driver support PTM or only the i225 NIC? In that case, it wouldn?t be an 
error for a device not supporting PTM, would it?

>   	pci_set_master(pdev);
>   
>   	err = -ENOMEM;
> 


Kind regards,

Paul
