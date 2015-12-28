From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 18:02:58 +0000
Subject: [Intel-wired-lan] [next PATCH S25 14/16] i40e: remove VF device
 IDs	from PF
In-Reply-To: <1450901156-30904-15-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-15-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B5C7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S25 14/16] i40e: remove VF device IDs
> from PF
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The PF doesn't need to know about the VF's device IDs, so remove them.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: I62cf0e0fffa1ace586e58e00bc271b10ae440f05
> ---
> Testing-Hints:
> Build only change.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 8 --------
> drivers/net/ethernet/intel/i40e/i40e_devids.h | 4 ----
>  2 files changed, 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
