From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 17 Apr 2018 21:21:51 +0000
Subject: [Intel-wired-lan] [PATCH v2] ice: Do not check INTEVENT bit for
 OICR interrupts
In-Reply-To: <20180411192133.25503-1-anirudh.venkataramanan@intel.com>
References: <20180411192133.25503-1-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26194B3A87@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, April 11, 2018 12:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ice: Do not check INTEVENT bit for OICR
> interrupts
> 
> From: Ben Shelton <benjamin.h.shelton@intel.com>
> 
> According to the hardware spec, checking the INTEVENT bit isn't a reliable
> way to detect if an OICR interrupt has occurred. This is because this bit can be
> cleared by the hardware/firmware before the interrupt service routine has
> run. So instead, just check for OICR events everytime.
> 
> Fixes: 940b61af02f4 ("ice: Initialize PF and setup miscellaneous
> interrupt")
> 
> Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> 
> ---
> v2: Add credits to the original author and fix formatting for "Fixes"
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 2 --
>  drivers/net/ethernet/intel/ice/ice_main.c       | 4 ----
>  2 files changed, 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


