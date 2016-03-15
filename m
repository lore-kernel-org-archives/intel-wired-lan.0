From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 16:39:29 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 09/13] i40e: Added code
	to	prevent double resets
In-Reply-To: <1457650791-100229-10-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-10-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D35E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S30 v3 09/13] i40e: Added code to
> prevent double resets
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Clear the VFLR bit after reset processing, instead of before. This prevents
> double resets on VF init.
> 
> Testing Hints: Should be no functional change but a large number of VFs will
> initialize more quickly. Mostly look for no loss of functionality.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VF allocation works as expected
