From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Aug 2017 22:16:26 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V6 05/12] i40e: drop i40e_pf
 *pf	from i40e_vc_disable_vf()
In-Reply-To: <20170807142839.60975-6-alice.michael@intel.com>
References: <20170807142839.60975-1-alice.michael@intel.com>
 <20170807142839.60975-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E8FCCF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 7, 2017 7:29 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S78-V6 05/12] i40e: drop i40e_pf *pf
> from i40e_vc_disable_vf()
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> It's never used, and the vf structure could get back to the PF if necessary.
> Lets just drop the extra unneeded parameter.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


