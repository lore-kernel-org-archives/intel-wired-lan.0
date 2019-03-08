From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:52:50 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 14/17] ice: update VSI config
 dynamically
In-Reply-To: <20190227003523.28733-15-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368FA0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 26, 2019 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 v2 14/17] ice: update VSI config
> dynamically
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> When VSI increases the number of queues dynamically, the scheduler just
> needs to add the new required nodes rather than re-adjusting with
> previously allocated number of nodes. Readjusting didn't provide enough
> parents to add the upper layer nodes also can't place lan and rdma subtrees
> separately.
> 
> In decrese case, keep the VSI configuration with max number of queues
> always. This will leave some extra nodes in the tree but no harm done.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 75 ++++++------------------------
>  1 file changed, 13 insertions(+), 62 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


