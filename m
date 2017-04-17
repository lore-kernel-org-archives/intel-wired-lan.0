From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Apr 2017 17:26:24 +0000
Subject: [Intel-wired-lan] [next PATCH S70 08/12] i40e: split some code
 in	i40e_reset_vf into helpers
In-Reply-To: <20170413084555.6962-8-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BEF5@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 08/12] i40e: split some code in
> i40e_reset_vf into helpers
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A future patch is going to want to re-use some of the code in i40e_reset_vf,
> so lets break up the beginning and ending parts into their own helper
> functions. The first function will be used to initialize the reset on a VF, while
> the second function will be used to finalize the reset and restore
> functionality.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I48df808b8bf09de3c2ed8c521f57b3f0ab9e5907
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 109 ++++++++++++++-
> ------
>  1 file changed, 72 insertions(+), 37 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

