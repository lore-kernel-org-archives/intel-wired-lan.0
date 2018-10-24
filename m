From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 24 Oct 2018 08:09:11 -0700
Subject: [Intel-wired-lan] [PATCH] igc: Minor cleaning up of code
In-Reply-To: <20181024145000.39034-1-sasha.neftin@intel.com>
References: <20181024145000.39034-1-sasha.neftin@intel.com>
Message-ID: <f171207c4a9fa28ea33d3e10ff71ba4e685bb4f5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-10-24 at 17:50 +0300, Sasha Neftin wrote:
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -9,7 +9,7 @@
>  #include "igc.h"
>  #include "igc_hw.h"
>  
> -#define DRV_VERSION    "0.0.1-k"
> +#define DRV_VERSION    "0.4.20-k"
>  #define DRV_SUMMARY    "Intel(R) 2.5G Ethernet Linux Driver"
>  
>  static int debug = -1;

This is the only change that I do not agree with and feel we should not
implement the suggested change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181024/f69386d4/attachment.asc>
