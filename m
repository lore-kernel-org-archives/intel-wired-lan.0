From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:31:10 +0000
Subject: [Intel-wired-lan] [PATCH v4 02/13] ice: Remove unncessary node
 owner check
In-Reply-To: <20180809132903.22819-3-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-3-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A6F@ORSMSX109.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 02/13] ice: Remove unncessary node
> owner check
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> There is already a check for owner == ICE_SCHED_NODE_OWNER_LAN at the
> beginning of ice_sched_update_vsi_child_nodes. Remove the additional
> check to address the static anlaysis tool smatch issue "warn: we tested
> 'owner' before and it was 'false'".
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> --
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


