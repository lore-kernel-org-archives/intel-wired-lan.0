From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 16:11:39 +0000
Subject: [Intel-wired-lan] [next PATCH S19 04/15] i40e: remove BUG_ON
 from	fcoe setup
In-Reply-To: <1445471236-35918-5-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3E65@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S19 04/15] i40e: remove BUG_ON
> from fcoe setup
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> There's no need to kill the kernel thread here. If this condition was true, the
> probe() would have died long before we got here. In any case, we'll get the
> same result when this code tries to use the vsi pointer being checked.
> 
> Prompted by a recent Linus diatribe.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I62f531cac34d4fc28ff9657d5b2d9523ae5e33a4
> 
> ---
> Testing-hints: Internal code change, check that the patch was applied and
> compiled correctly.
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
