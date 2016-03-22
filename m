From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Mar 2016 20:33:45 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 11/12] i40e: Request phy
 media	event at reset time
In-Reply-To: <1458328696-135941-12-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-12-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EEB2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S31 v4 11/12] i40e: Request phy media
> event at reset time
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add the Media Not Available flag to the link event mask.  It seems that event
> comes first if you have a DA cable pulled out, but there's no followup event
> for Link Down; if you're not looking for MEDIA_NA you will get no event,
> even though there's now no Link.
> 
> Testing Hints:
> 	Do some link tests, removing and reinserting the wire, etc.
> 	after a reset.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: cb3340a2849805bb881f64f6f2ae810eef46eba7
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver reports correct link statuses after reset
