From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 20:42:39 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V8 07/12] i40e: ensure
	reset	occurs when disabling VF
In-Reply-To: <20170822105754.29486-8-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
 <20170822105754.29486-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F31F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S78-V8 07/12] i40e: ensure reset
> occurs when disabling VF
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> It is possible although rare that we may not reset when
> i40e_vc_disable_vf() is called. This can lead to some weird circumstances
> with some values not being properly set. Modify
> i40e_reset_vf() to return a code indicating whether it reset or not.
> 
> Now, i40e_vc_disable_vf() can wait until a reset actually occurs. If it fails to
> free up within a reasonable timeframe we'll display a warning message.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 42
> +++++++++++++++++-----
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  4 +--
>  2 files changed, 35 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


