From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 18:15:24 +0000
Subject: [Intel-wired-lan] [next PATCH S96 5/9] i40e: add a helper
 function to validate a vf based on the vf id
In-Reply-To: <20180828171609.78242-5-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
 <20180828171609.78242-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB25D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 28, 2018 10:16 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S96 5/9] i40e: add a helper function to
> validate a vf based on the vf id
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> When we are trying to change VF settings, it is possible for 2 race conditions
> to happen. One, when the VF is created but not yet enabled.
> Second, the VF is enabled but the vsi is still not created or not yet re-created
> in the VF reset flow.
> 
> This patch introduces a helper function to validate that the vf is enabled and
> that the vsi is set up. This patch also calls this function from other functions
> which could get into these race conditions.
> While we are poking around here, remove unnecessary parenthesis that
> checkpatch was complaining about.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 62 ++++++++++++++---
> -----
>  1 file changed, 41 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


