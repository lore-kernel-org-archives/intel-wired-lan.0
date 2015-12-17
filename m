From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Dec 2015 17:00:58 +0000
Subject: [Intel-wired-lan] [next PATCH S23 11/13] i40e: Cleanup the
	code	with respect to restarting autoneg
In-Reply-To: <1449705033-4968-12-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-12-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96F101@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 11/13] i40e: Cleanup the code
> with respect to restarting autoneg
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The restart-autoneg work around does not apply to X722.
> Added a flag to set it only for the right MAC and right FW version where the
> work around should be applied.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I942c3ff40cccd1e56f424b1da776b020fe3c9d2a
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
