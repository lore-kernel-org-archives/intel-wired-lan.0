From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Mar 2016 17:32:12 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 07/12] i40e: Disable
	link	polling
In-Reply-To: <1458328696-135941-8-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-8-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EE1E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Friday, March 18, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S31 v4 07/12] i40e: Disable link polling
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Periodic link polling was added when the link events were found not to be
> trustworthy.  This was the case early on, but was likely because the link event
> mask was being used incorrectly.  As this has been fixed in recent code, we
> can disable the link polling to lessen the AQ traffic.
> 
> Testing Hints:
> 	Do some link tests, removing and reinserting the wire, etc.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Id890b5ee3c2d04381fc76ffa434777644f5d8eb0
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Link events work properly
