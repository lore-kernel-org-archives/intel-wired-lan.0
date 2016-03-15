From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 18:37:31 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 07/13] i40e: Remove timer
 and	task only if created
In-Reply-To: <1457650791-100229-8-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-8-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D40C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of ajdayana
> Sent: Thursday, March 10, 2016 3:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S30 v3 07/13] i40e: Remove timer and
> task only if created
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> In some error scenarios, we may find ourselves trying to remove a non-
> existent timer or worktask.  This causes the kernel some bit of consternation,
> so don't do it.
> 
> Testing Hints: Inject an error into the i40e_probe before these are created
> and see if you can get a clean remove.
> 
> Signed-off-by: Nelson, Shannon <shannon.nelson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver will remove cleanly in error state
