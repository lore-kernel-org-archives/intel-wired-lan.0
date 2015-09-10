From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 16:49:17 +0000
Subject: [Intel-wired-lan] [next PATCH S14 03/15] i40e: Use BIT() macro
 for	priority map parsing
In-Reply-To: <1441065295-234333-4-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A616F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 03/15] i40e: Use BIT() macro for
> priority map parsing
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> Replace one left over (1 << up) in the i40e_dcb.c file with the BIT() macro.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: I39492a400a2cee5ac566143a5b436cc478bea0db
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
