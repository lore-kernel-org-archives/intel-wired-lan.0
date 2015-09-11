From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 21:39:22 +0000
Subject: [Intel-wired-lan] [next PATCH S12 03/15] i40evf:
	propagate	interrupt allocation failure
In-Reply-To: <1440690163-128213-4-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6532@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 03/15] i40evf: propagate interrupt
> allocation failure
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Lower level functions are properly reporting errors, and higher-level
> functions are correctly responding to errors, but the errors aren't actually
> getting through. Typically, the middle-manager function seems to want to
> shield its boss from any bad news.
> 
> This change fixes a panic if the driver is unable to enable MSI-X or is unable to
> acquire enough vectors.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ifd5787ce92519a5d97e4b465902db930d97b71a1
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
