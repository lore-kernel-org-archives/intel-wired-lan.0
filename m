From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:01:59 +0000
Subject: [Intel-wired-lan] [PATCH S8 13/16] ice: Remove node before
 releasing VSI
In-Reply-To: <20181026174105.11628-14-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328D4B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 13/16] ice: Remove node before
> releasing VSI
> 
> Before releasing the VSI, remove the VSI scheduler node. If not, the node is
> left in the scheduler tree and, on subsequent load, the scheduler tree
> contains the node so it does not set it in vsi_ctx.
> This, later, causes the node to not be found in ice_sched_get_free_qparent
> which leads to a "Failed to set LAN Tx queue context, error: -1".
> 
> To remove the scheduler node, this patch introduces ice_rm_vsi_lan_cfg and
> related helpers.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c   |   1 +
>  drivers/net/ethernet/intel/ice/ice_sched.c | 108
> ++++++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_sched.h |   2 +
>  3 files changed, 110 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


