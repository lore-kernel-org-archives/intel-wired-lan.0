From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 16:26:11 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 04/13] i40e: Fix up return
 code
In-Reply-To: <1457650791-100229-5-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-5-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D32C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of ajdayana
> Sent: Thursday, March 10, 2016 3:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S30 v3 04/13] i40e: Fix up return code
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The i40e_common.c typically uses i40e_status as a return code, but got
> missed this one case.
> 
> Testing Hints: Compile Linux kernel build.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Compiles normally
