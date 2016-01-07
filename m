From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 15:46:38 +0000
Subject: [Intel-wired-lan] [next PATCH S26 01/12] i40e: trivial:
	drop	duplicate definition
In-Reply-To: <1451932392-15538-2-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-2-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E3C5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Monday, January 04, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S26 01/12] i40e: trivial: drop duplicate
> definition
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The probe routine already had a u32 val declared, no need to do it again.
> Found by W=2 compile.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Id7b65f6d0ef6bb71067d0557f5be0202b6d8741e
> ---
> Testing-Hints:
> Try making W=2 and check output for:
>  "val" shadow declaration is gone.
>  /driver/i40e/i40e_main.c: In function ?i40e_probe?:
>  /driver/i40e/i40e_main.c:10752:7: warning: declaration of ?val? shadows  a
> previous local [-Wshadow]
>  /driver/i40e/i40e_main.c:10411:6: note: shadowed declaration is here
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, warning not present at compile time
