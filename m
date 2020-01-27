From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:16:25 +0000
Subject: [Intel-wired-lan] [PATCH S38 10/15] ice: Fix
 virtchnl_queue_select bitmap validation
In-Reply-To: <20200122152138.41585-10-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-10-anthony.l.nguyen@intel.com>
Message-ID: <5467f7e0e5724ba5bc49a0962120223b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 10/15] ice: Fix virtchnl_queue_select
> bitmap validation
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently in ice_vc_ena_qs_msg() we are incorrectly validating the virtchnl
> queue select bitmaps. The virtchnl_queue_select rx_queues and tx_queue
> bitmap is being compared against ICE_MAX_BASE_QS_PER_VF, but the
> problem is that these bitmaps can have a value greater than
> ICE_MAX_BASE_QS_PER_VF. Fix this by comparing the bitmaps against
> BIT(ICE_MAX_BASE_QS_PER_VF).
> 
> Also, add the function ice_vc_validate_vqs_bitmaps() that checks to see if
> both virtchnl_queue_select bitmaps are empty along with checking that the
> bitmaps only have valid bits set. This function can then be used in both the
> queue enable and disable flows.
> 
> Arkady Gilinksky's patch on the intel-wired-lan mailing list
> ("i40e/iavf: Fix msg interface between VF and PF") made me aware of this
> issue.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 26 +++++++++++++------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
