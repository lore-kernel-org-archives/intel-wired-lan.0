From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 19:30:24 +0000
Subject: [Intel-wired-lan] [next PATCH S26 11/12] i40e: avoid large
 memcpy	by assigning struct
In-Reply-To: <1451932392-15538-12-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-12-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E4C5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Monday, January 04, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S26 11/12] i40e: avoid large memcpy
> by assigning struct
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Assign the i40e_pf structure directly instead of using a large memcpy, which
> avoids a sparse warning and lets the compiler optimize the copy since it
> knows the size of the structure in advance.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Change-ID: I17604e23be2616521eb760290befcb767b52b3f7
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
