From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 16:11:42 +0000
Subject: [Intel-wired-lan] [next PATCH S15 08/15] i40e: allow FD SB if
 MFP	mode only has 1 partition
In-Reply-To: <1441315142-173025-9-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A63F7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 03, 2015 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S15 08/15] i40e: allow FD SB if MFP
> mode only has 1 partition
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Even though the device might be in MFP mode, if there's only one partition
> enabled, then we still have plenty of interrupts for managing the Flow
> Directory Sideband activity.  This patch enables FD SB in this case.
> This patch also reverses the sense of the conditional in order to remove the
> negative logic.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I9edf211a6219fc8d159b4be9964f9fd7f4e00bc0
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
