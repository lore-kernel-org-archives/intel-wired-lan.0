From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 16:40:21 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 10/13] i40e: Change
 unknown	event error msg to ignore message
In-Reply-To: <1457650791-100229-11-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-11-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D36F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S30 v3 10/13] i40e: Change unknown
> event error msg to ignore message
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> There's no real error in an unknown event from the Firmware, we're just
> posting a useful FYI notice, so this patch simply removes the "Error" word.
> 
> Testing Hints:
> 	Not really testable live with current FW/SW, so just
> 	compile and go.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Compiles normally
