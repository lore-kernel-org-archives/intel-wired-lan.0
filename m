From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Oct 2015 16:41:41 +0000
Subject: [Intel-wired-lan] [next-queue v2 4/6] i40evf: clean up
	local	variable initialization
In-Reply-To: <1444719992-301-4-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
 <1444719992-301-4-git-send-email-sakiwit@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D119B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jean Sacren
> Sent: Tuesday, October 13, 2015 12:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v2 4/6] i40evf: clean up local variable
> initialization
> 
> From: Jean Sacren <sakiwit@gmail.com>
> 
> In i40evf_msix_aq(), the first two lines of rd32() are mainly to clear the
> registers. If we initialize 'val' at this point, it will be overwritten immediately.
> We shall simply discard the return value here.
> 
> When we initialize 'val', we might as well include the mask in one step.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes except for the serial number.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
