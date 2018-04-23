From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Apr 2018 20:58:31 +0000
Subject: [Intel-wired-lan] [next PATCH S90 7/8] i40e/i40evf: take into
 account queue map from vf when handling queues
In-Reply-To: <20180420084140.8081-7-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
 <20180420084140.8081-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A976999@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, April 20, 2018 1:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S90 7/8] i40e/i40evf: take into account
> queue map from vf when handling queues
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> The expectation of the ops VIRTCHNL_OP_ENABLE_QUEUES and
> VIRTCHNL_OP_DISABLE_QUEUES is that the queue map sent by the VF is
> taken into account when enabling/disabling queues in the VF VSI. This patch
> makes sure that happens.
> 
> By breaking out the individual queue set up functions so that they can be
> called directly from the i40e_virtchnl_pf.c file, only the queues as specified
> by the queue bit map that accompanies the enable/disable queues ops will
> be handled.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  3 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 40 +++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 69
> +++++++++++++++++++++-
>  3 files changed, 99 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


