From: Hisashi T Fujinaka <htodd@twofifty.com>
Date: Mon, 12 Oct 2015 08:33:37 -0700 (PDT)
Subject: [Intel-wired-lan] [next-queue 1/8] igb: fix a typo in the
 configuration help menu
In-Reply-To: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
References: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
Message-ID: <alpine.NEB.2.11.1510120829380.18208@chris.i8u.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

NAK, no, it's warming.

On Sun, 11 Oct 2015, J?an Sacren wrote:

> From: Jean Sacren <sakiwit@gmail.com>
>
> 'warming' should be 'warning'. Fix it so that the pertinent text in
> Direct Cache Access (DCA) Support menu would deliver the intended
> semantics.
>
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> drivers/net/ethernet/intel/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 4163b16489b3..1268a182d1a2 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -124,7 +124,7 @@ config IGB_DCA
> 	depends on IGB && DCA && !(IGB=y && DCA=m)
> 	---help---
> 	  Say Y here if you want to use Direct Cache Access (DCA) in the
> -	  driver.  DCA is a method for warming the CPU cache before data
> +	  driver.  DCA is a method for warning the CPU cache before data
> 	  is used, with the intent of lessening the impact of cache misses.
>
> config IGBVF
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>

-- 
Hisashi T Fujinaka - htodd at twofifty.com
BSEE + BSChem + BAEnglish + MSCS + $2.50 = coffee
