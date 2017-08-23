From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 20:41:21 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V8 06/12] i40e: make use
	of	i40e_vc_disable_vf
In-Reply-To: <20170822105754.29486-7-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
 <20170822105754.29486-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F30E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S78-V8 06/12] i40e: make use of
> i40e_vc_disable_vf
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Replace i40e_vc_notify_vf_reset and i40e_reset_vf with a call to
> i40e_vc_disable_vf which does this exact thing. This matches similar code
> patterns throughout the driver.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


