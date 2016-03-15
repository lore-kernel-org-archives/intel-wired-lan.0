From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 16:25:13 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 03/13] i40e: Save off
	VSI	resource count when updating VSI
In-Reply-To: <1457650791-100229-4-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-4-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D31B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S30 v3 03/13] i40e: Save off VSI
> resource count when updating VSI
> 
> From: Kevin Scott <kevin.c.scott@intel.com>
> 
> When updating a VSI, save off the number of allocated and unallocated VSIs
> as we do when adding a VSI.
> 
> Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VSI stats correctly operate
