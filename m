From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 16:15:46 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 02/13] i40e/i40evf:
	Remove	I40E_MAX_USER_PRIORITY define
In-Reply-To: <1457650791-100229-3-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-3-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D302@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S30 v3 02/13] i40e/i40evf: Remove
> I40E_MAX_USER_PRIORITY define
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> This patch removes the duplicate definition of I40E_MAX_USER_PRIORITY in
> i40e.h that is not needed.
> 
> Testing Hints: Make sure everything compiles.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Compiles normally
