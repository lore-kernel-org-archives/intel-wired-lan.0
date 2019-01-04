From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 03 Jan 2019 16:55:38 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix Kconfig when driver is not
 a module
In-Reply-To: <9484abfd-0a07-31be-c738-6b770bbd3dc4@silicom-usa.com>
References: <20190103213519.9754-1-jeffrey.t.kirsher@intel.com>
 <9484abfd-0a07-31be-c738-6b770bbd3dc4@silicom-usa.com>
Message-ID: <f82aa264a695a7719b9a9f6b013bd2686b4a4661.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-01-04 at 00:00 +0000, Steve Douthit wrote:
> Just tested this against a DSA dev in hardware and it works, but I
> still think the simpler solution would be to just select PHYLIB:
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig
> b/drivers/net/ethernet/intel/Kconfig
> index 31fb76ee9d82..a1246e89aad4 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -159,7 +159,7 @@ config IXGBE
>         tristate "Intel(R) 10GbE PCI Express adapters support"
>         depends on PCI
>         select MDIO
> -       select MDIO_DEVICE
> +       select PHYLIB
>         imply PTP_1588_CLOCK
>         ---help---
>           This driver supports Intel(R) 10GbE PCI Express family of
> 
> That seems to be the pattern for most of the other ethernet adapters:
> $ grep -r 'select PHYLIB' drivers/net/ethernet/ | wc -l
> 71
> 
> vs checking MDIO_BUS (not counting this patch):
> $ grep -r 'depends on.*MDIO_BUS' drivers/net/ethernet/ | wc -l
> 0

I initially tried that, but we get a recursive Kconfig dependency error
when IPSec is enabled as well, which I noted in the commit message.

I agree the help text could be expanded to include the clause 22/45
address information, so I will submit a v2 of the patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190103/daf59a5a/attachment-0001.asc>
