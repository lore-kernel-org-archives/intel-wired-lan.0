From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 18:36:56 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 05/13] i40e: Remove msix
 only	if created
In-Reply-To: <1457650791-100229-6-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-6-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D3FC@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S30 v3 05/13] i40e: Remove msix only
> if created
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> When cleaning up the interrupt handling, clean up the irqs only if we actually
> got them set up.  There are a couple of error recovery paths that were
> violating this and causing the kernel a bit of indigestion.
> 
> Testing Hints:
> Inject an error om the i40e_probe() that puts the driver into the debug
> mode, then remove the driver.  Often this causes a NULL pointer warning
> from the i40e_remove trace.
> 
> Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver will remove cleanly in error state
