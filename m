From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 18:16:17 +0000
Subject: [Intel-wired-lan] [next PATCH S96 7/9] i40e: Remove unused
 msglen parameter from virtchnl functions
In-Reply-To: <20180828171609.78242-7-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
 <20180828171609.78242-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB27D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S96 7/9] i40e: Remove unused msglen
> parameter from virtchnl functions
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> msglen parameter seems to be unused in several virtchnl function.
> This patch removes it from signatures of those functions.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 96 +++++++++-----------
> --
>  1 file changed, 37 insertions(+), 59 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


