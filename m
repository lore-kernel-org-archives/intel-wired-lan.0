From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Sep 2016 19:07:16 +0000
Subject: [Intel-wired-lan] [next PATCH S48 5/7] i40e: Fix for long link
 down	notification time
In-Reply-To: <1475000934-27335-6-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
 <1475000934-27335-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F035@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 27, 2016 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S48 5/7] i40e: Fix for long link down
> notification time
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a problem where it could take a very long time (>100 msec)
> to print the link down notification.
> This problem is fixed by changing how often we update link info from fw,
> when link is down. Without this patch, it can take over 100msec to notify user
> link is down.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Ib876eb30834c7080792becd13ee093b9cbb35d78
> ---
> Testing Hints : Check msec to link down notification appearance.
> Should be less than 100msec vs.more before.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Link down notification appears immediately upon downing the interface

