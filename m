From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 20:06:53 +0000
Subject: [Intel-wired-lan] [next PATCH S57 01/11] i40e: fix disable
 overflow	promiscuous mode
In-Reply-To: <1481586257-28872-2-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA49970@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, December 12, 2016 3:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S57 01/11] i40e: fix disable overflow
> promiscuous mode
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> There exists a bug in which the driver is unable to exit overflow promiscuous
> mode after having added "too many" mac filters.  It is expected that after
> triggering overflow promiscuous, removing the failed/extra filters should
> then disable overflow promiscuous mode.
> 
> The bug exists because we were intentionally skipping the sync_vsi_filter
> path in cases where we were removing failed filters since they shouldn't
> have been added to the firmware in the first place, however we still need to
> go through the sync_vsi_filter code path to determine whether or not it is ok
> to exit overflow promiscuous mode.  This patch fixes the bug by making sure
> we go through the sync_vsi_filter path in cases of failed filters.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: I634d249ca3e5fa50729553137c295e73e7722143
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


