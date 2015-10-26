From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 16:05:29 +0000
Subject: [Intel-wired-lan] [next PATCH S19 02/15] i40e: Change BUG_ON
	to	WARN_ON in service event complete
In-Reply-To: <1445471236-35918-3-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3E42@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S19 02/15] i40e: Change BUG_ON to
> WARN_ON in service event complete
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> There's no need to kill the thread and eventually the kernel in this case.  In
> fact, the remainder of the code won't hurt anything anyway, so just complain
> that we're here and move along.
> 
> Prompted by a recent Linus diatribe.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Iec020d8bcfedffc1cd2553cc6905fd915bb3e670
> 
> ---
> Testing-hints: Internal code change only, check that the patch was applied
> and compiled correctly.
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
