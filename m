From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Sep 2017 21:45:46 +0000
Subject: [Intel-wired-lan] [RFC PATCH v3 5/6] i40e: Refactor VF BW
	rate	limiting
In-Reply-To: <150478202784.24662.17062791162973773248.stgit@anamdev.jf.intel.com>
References: <150478158684.24662.17975701233699487888.stgit@anamdev.jf.intel.com>
 <150478202784.24662.17062791162973773248.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA2E7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Thursday, September 7, 2017 4:00 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [RFC PATCH v3 5/6] i40e: Refactor VF BW rate
> limiting
> 
> This patch refactors the BW rate limiting for Tx traffic on the VF to be reused
> in the next patch for rate limiting Tx traffic for the VSIs on the PF as well.
> 
> v3: Minor fixes, clean up log messages based on Shannon's comments.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |    5 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |   64
> ++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   45 +-------------
>  3 files changed, 71 insertions(+), 43 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


