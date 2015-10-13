From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Oct 2015 16:43:30 +0000
Subject: [Intel-wired-lan] [next-queue v2 5/6] i40e: clean up local
 variable	initialization
In-Reply-To: <1444719992-301-5-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
 <1444719992-301-5-git-send-email-sakiwit@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D11AC@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v2 5/6] i40e: clean up local variable
> initialization
> 
> From: Jean Sacren <sakiwit@gmail.com>
> 
> In both i40e_calc_nvm_checksum() and i40e_update_nvm_checksum(), the
> local variables designated by 'ret_code' are overwritten immediately. As
> such, they should merely be declared.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes except for the serial number.
> 
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
