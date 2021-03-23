From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 23 Mar 2021 14:29:20 -0500
Subject: [Intel-wired-lan] [PATCH next-queue v3 2/3] igc: Enable PCIe PTM
In-Reply-To: <20210322161822.1546454-3-vinicius.gomes@intel.com>
Message-ID: <20210323192920.GA597326@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 22, 2021 at 09:18:21AM -0700, Vinicius Costa Gomes wrote:
> In practice, enabling PTM also sets the enabled_ptm flag in the PCI
> device, the flag will be used for detecting if PTM is enabled before
> adding support for the SYSOFFSET_PRECISE ioctl() (which is added by
> implementing the getcrosststamp() PTP function).

I think you're referring to the "pci_dev.ptm_enabled" flag.  I'm not
sure what the connection to this patch is.  The SYSOFFSET_PRECISE
stuff also seems to belong with some other patch.

This patch merely enables PTM if it's supported (might be worth
expanding Precision Time Measurement for context).

> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index f77feadde8d2..04319ffae288 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -12,6 +12,8 @@
>  #include <net/pkt_sched.h>
>  #include <linux/bpf_trace.h>
>  #include <net/xdp_sock_drv.h>
> +#include <linux/pci.h>
> +
>  #include <net/ipv6.h>
>  
>  #include "igc.h"
> @@ -5792,6 +5794,10 @@ static int igc_probe(struct pci_dev *pdev,
>  
>  	pci_enable_pcie_error_reporting(pdev);
>  
> +	err = pci_enable_ptm(pdev, NULL);
> +	if (err < 0)
> +		dev_err(&pdev->dev, "PTM not supported\n");
> +
>  	pci_set_master(pdev);
>  
>  	err = -ENOMEM;
> -- 
> 2.31.0
> 
