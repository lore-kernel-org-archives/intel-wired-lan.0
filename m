From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:39:16 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix the conditional for
 i40e_vc_validate_vqs_bitmaps
In-Reply-To: <20200206092810.26378-1-anthony.l.nguyen@intel.com>
References: <20200206092810.26378-1-anthony.l.nguyen@intel.com>
Message-ID: <960e96829bef48289e787a5bb1651cf5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix the conditional for
> i40e_vc_validate_vqs_bitmaps
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Commit d9d6a9aed3f6 ("i40e: Fix virtchnl_queue_select bitmap
> validation") introduced a necessary change for verifying how queue bitmaps
> from the iavf driver get validated. Unfortunately, the conditional was
> reversed. Fix this.
> 
> Fixes: d9d6a9aed3f6 ("i40e: Fix virtchnl_queue_select bitmap validation")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


