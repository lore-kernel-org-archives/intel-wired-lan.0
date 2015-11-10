From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 21:08:36 +0000
Subject: [Intel-wired-lan] [next PATCH S21 11/14] i40e: Remove
	separate	functions gathering XOFF Rx stats
In-Reply-To: <1446852372-25480-12-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-12-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1F54@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 11/14] i40e: Remove separate
> functions gathering XOFF Rx stats
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> The separate functions to gather Flow control Rx XOFF stats was to
> determine if the Tx for a queue was paused due to Link Flow Control(LFC) or
> Priority Flow Control(PFC).
> 
> But, with recent change in the i40e driver the logic for checking th Tx hang
> has been removed and these functions don't do anything meaningful.
> Hence, there is no need to keep these separate functions to gather Rx XOFF
> stats for LFC or PFC.
> 
> This patch removes these functions and moves the stat collection for XOFF
> Rx to the i40e_update_pf_stats() that collects all the PF stats.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: Iec1452dac3a6766f0d968e754cb407530d7c60cd
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 77 +++--------------------------
>  1 file changed, 7 insertions(+), 70 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
