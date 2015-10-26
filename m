From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 16:10:09 +0000
Subject: [Intel-wired-lan] [next PATCH S19 03/15] i40e: remove BUG_ON
 from	feature string building
In-Reply-To: <1445471236-35918-4-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3E55@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S19 03/15] i40e: remove BUG_ON
> from feature string building
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> There's really no reason to kill the kernel thread just because of a little info
> string. This reworks the code to use snprintf's limiting to assure that the
> string is never too long, and WARN_ON to still put out a warning that we
> might want to look at the feature list length.
> 
> Prompted by a recent Linus diatribe.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: If52ba5ca1c2344d8bf454a31bbb805eb5d2c5802
> 
> ---
> Testing-hints: Internal code change, check that the patch was applied and
> compiled correctly.
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 34 +++++++++++++++--------
> ------
>  1 file changed, 18 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
