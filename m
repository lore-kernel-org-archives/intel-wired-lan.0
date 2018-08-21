From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:18:34 +0000
Subject: [Intel-wired-lan] [PATCH v3 03/15] ice: Update request resource
 command to latest specification
In-Reply-To: <20180809132958.23036-4-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-4-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26195459D8@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 03/15] ice: Update request resource
> command to latest specification
> 
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> Align Request Resource Ownership AQ command (0x0008) to the latest
> specification. This includes:
> 
> - Correcting the resource IDs for the Global Cfg and Change locks.
> - new enum ICE_CHANGE_LOCK_RES_ID
> - new enum ICE_GLOBAL_CFG_LOCK_RES_ID
> - Altering the flow for Global Config Lock to allow only the first PF to
>   download the package.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 75 ++++++++++++++++-----
> drivers/net/ethernet/intel/ice/ice_common.h |  2 +-
>  drivers/net/ethernet/intel/ice/ice_nvm.c    |  2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h   |  9 ++-
>  4 files changed, 67 insertions(+), 21 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


