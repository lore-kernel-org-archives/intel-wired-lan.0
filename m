From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Nov 2019 19:27:25 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix virtchnl_queue_select
 bitmap validation
In-Reply-To: <20191113192817.531297-1-jeffrey.t.kirsher@intel.com>
References: <20191113192817.531297-1-jeffrey.t.kirsher@intel.com>
Message-ID: <ab226666b7e74c7fa7ca5cd6ade44bc1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, November 13, 2019 11:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Creeley, Brett <brett.creeley@intel.com>; Arkady Gilinksky
> <arkady.gilinsky@harmonicinc.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix virtchnl_queue_select bitmap
> validation
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently in i40e_vc_disable_queues_msg() we are incorrectly validating the
> virtchnl queue select bitmaps. The virtchnl_queue_select rx_queues and
> tx_queue bitmap is being compared against ICE_MAX_VF_QUEUES, but the
> problem is that these bitmaps can have a value greater than
> I40E_MAX_VF_QUEUES.
> Fix this by comparing the bitmaps against BIT(I40E_MAX_VF_QUEUES).
> 
> Also, add the function i40e_vc_validate_vqs_bitmaps() that checks to see if
> both virtchnl_queue_select bitmaps are empty along with checking that the
> bitmaps only have valid bits set. This function can then be used in both the
> queue enable and disable flows.
> 
> Suggested-by: Arkady Gilinksky <arkady.gilinsky@harmonicinc.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


