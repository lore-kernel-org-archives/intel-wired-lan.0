From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 15 Aug 2018 09:25:09 -0700
Subject: [Intel-wired-lan] [PATCH v5 06/11] igc: Add transmit and
 receive fastpath and interrupt handlers
In-Reply-To: <1534345350-5628-1-git-send-email-sasha.neftin@intel.com>
References: <1534345350-5628-1-git-send-email-sasha.neftin@intel.com>
Message-ID: <ae8e4483436d33a01794d1520bab56b952088ee9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-08-15 at 18:02 +0300, Sasha Neftin wrote:
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h
> b/drivers/net/ethernet/intel/igc/igc_defines.h
> index f9d1842..8f0ce02 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -78,7 +78,7 @@
>  #define IGC_IMS_DOUTSYNC       IGC_ICR_DOUTSYNC /* NIC DMA out of
> sync */
>  #define IGC_IMS_DRSTA          IGC_ICR_DRSTA   /* Device Reset
> Asserted */
>  #define IGC_IMS_RXT0           IGC_ICR_RXT0    /* Rx timer intr */
> -#define IGC_IMS_RXDMT0         IGC_ICR_RXDMT0  /* Rx desc min.
> threshold */
> +#define IGC_IMS_RXDMT0         IGC_ICR_RXDMT0  /* Rx desc min.
> threshold */

This fix to replace a tab with spaces should be in patch 4, where this
code was introduced.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180815/2f88fc2e/attachment.asc>
