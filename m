From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:35:38 +0000
Subject: [Intel-wired-lan] [PATCH S10 02/15] ice: Refactor a few Tx
 scheduler functions
In-Reply-To: <20181219180334.1104-3-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3439E9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 02/15] ice: Refactor a few Tx scheduler
> functions
> 
> The following functions were refactored to call a new common function,
> ice_aqc_send_sched_elem_cmd():
> 
> - ice_aq_add_sched_elems()
> - ice_aq_delete_sched_elems()
> - ice_aq_move_sched_elems()
> - ice_aq_query_sched_elems()
> - ice_aq_cfg_sched_elems()
> - ice_aq_suspend_sched_elems()
> - ice_aq_resume_sched_elems()
> 
> Signed-off-by: Greg Priest <greg.priest@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  22 ++---
>  drivers/net/ethernet/intel/ice/ice_sched.c      | 122 +++++++++---------------
>  2 files changed, 53 insertions(+), 91 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


