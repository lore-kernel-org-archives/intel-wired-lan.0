From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:28:40 +0000
Subject: [Intel-wired-lan] [PATCH v4 13/13] ice: Trivial formatting fixes
In-Reply-To: <20180809132903.22819-14-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-14-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A13@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 13/13] ice: Trivial formatting fixes
> 
> 1) Add missing "\n" when printing link event error message.
> 
> 2) Update dev_err statement in probe.
> 
> 3) Add function description for ice_clear_pf_cfg.
> 
> 4) Fix coding style for ice_acquire_nvm.
> 
> 5) netdev->mtu is unsigned so use %u.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 3 +++
>  drivers/net/ethernet/intel/ice/ice_main.c   | 6 +++---
>  drivers/net/ethernet/intel/ice/ice_nvm.c    | 5 ++---
>  3 files changed, 8 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


