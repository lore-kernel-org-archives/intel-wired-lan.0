From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 20:30:49 +0000
Subject: [Intel-wired-lan] [next PATCH S1 3/6] i40e: Change unmatched
 function types
In-Reply-To: <20181219144542.85924-3-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
 <20181219144542.85924-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343997@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 19, 2018 6:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S1 3/6] i40e: Change unmatched
> function types
> 
> From: Grzegorz Siwik <grzegorz.siwik@intel.com>
> 
> Change of function declaration from int to u64 due to return type mismatch
> (u64).
> 
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


