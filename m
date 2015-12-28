From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 18:20:30 +0000
Subject: [Intel-wired-lan] [next PATCH S25 15/16] i40e: trivial:
	remove	unnecessary local var
In-Reply-To: <1450901156-30904-16-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-16-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B5DE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Wednesday, December 23, 2015 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S25 15/16] i40e: trivial: remove
> unnecessary local var
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Probe routine already has too many locals, just convert one used for kzalloc
> into a kcalloc, eliminating the local.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Singhai, Anjali <anjali.singhai@intel.com>
> Change-ID: I349049872b71f858cbeb91ad7836e6767fc7b7d1
> ---
> Testing-Hints: compile test only.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
