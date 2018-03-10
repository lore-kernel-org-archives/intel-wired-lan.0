From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 10 Mar 2018 04:53:31 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: Fix link check race
 condition
In-Reply-To: <20180306015553.10441-2-bpoirier@suse.com>
References: <20180306015553.10441-1-bpoirier@suse.com>
 <20180306015553.10441-2-bpoirier@suse.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C801AC3@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Benjamin Poirier
> Sent: Monday, March 5, 2018 5:56 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>; Lennart Sorensen
> <lsorense@csclub.uwaterloo.ca>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH 2/2] e1000e: Fix link check race condition
> 
> Alex reported the following race condition:
> 
> /* link goes up... interrupt... schedule watchdog */
> \ e1000_watchdog_task
> 	\ e1000e_has_link
> 		\ hw->mac.ops.check_for_link() ===
> e1000e_check_for_copper_link
> 			\ e1000e_phy_has_link_generic(..., &link)
> 				link = true
> 
> 					 /* link goes down... interrupt */
> 					 \ e1000_msix_other
> 						 hw->mac.get_link_status =
> true
> 
> 			/* link is up */
> 			mac->get_link_status = false
> 
> 		link_active = true
> 		/* link_active is true, wrongly, and stays so because
> 		 * get_link_status is false */
> 
> Avoid this problem by making sure that we don't set get_link_status = false
> after having checked the link.
> 
> It seems this problem has been present since the introduction of e1000e.
> 
> Link: https://lkml.org/lkml/2018/1/29/338
> Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 31 ++++++++++++++++-------
> ------
>  drivers/net/ethernet/intel/e1000e/mac.c     | 14 ++++++-------
>  2 files changed, 24 insertions(+), 21 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
