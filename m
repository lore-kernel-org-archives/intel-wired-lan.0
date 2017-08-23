From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 20:53:28 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V8 10/12] i40e: fix handling
 of	vf_states variable
In-Reply-To: <20170822105754.29486-11-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
 <20170822105754.29486-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F37C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 22, 2017 3:58 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S78-V8 10/12] i40e: fix handling of
> vf_states variable
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Currently we inappropriately clear the vf_states variable with a null
> assignment.  This is problematic because we should be using atomic bitops on
> this variable and we don't actually want to clear all the flags.  We should just
> clear the ones we know we want to clear.
> Additionally remove the I40E_VF_STATE_FCOEENA bit because it is no longer
> being used.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 ++++-
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 1 -
>  2 files changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


