From: Jonathan Toppins <jtoppins@cumulusnetworks.com>
Date: Mon, 27 Apr 2015 11:42:29 -0400
Subject: [Intel-wired-lan] [PATCH v1 net-next 1/3] igb: set driver data
 for device entries that were missing
In-Reply-To: <1428707018-6405-1-git-send-email-jtoppins@cumulusnetworks.com>
References: <1428707018-6405-1-git-send-email-jtoppins@cumulusnetworks.com>
Message-ID: <553E58E5.9000105@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/10/15 7:03 PM, Jonathan Toppins wrote:
> Three of the supported PCI device entries neglected to set driver data
> to "board_82575". This is not a problem until a new board type is
> defined, so avoid the potential problem all together.
>
> Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 8457d03..bb467bb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -73,9 +73,9 @@ static const struct e1000_info *igb_info_tbl[] = {
>   };
>
>   static const struct pci_device_id igb_pci_tbl[] = {
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_BACKPLANE_1GBPS) },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_SGMII) },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_BACKPLANE_2_5GBPS) },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_BACKPLANE_1GBPS), board_82575 },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_SGMII), board_82575 },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I354_BACKPLANE_2_5GBPS), board_82575 },
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I211_COPPER), board_82575 },
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_COPPER), board_82575 },
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_I210_FIBER), board_82575 },
>


Simple keepalive to make sure these have not been forgotten, the 
patchworks entries are still in "new" state.

http://patchwork.ozlabs.org/patch/460268/
http://patchwork.ozlabs.org/patch/460270/
http://patchwork.ozlabs.org/patch/460269/

Regards,
-Jon

