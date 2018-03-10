From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 10 Mar 2018 04:50:14 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] Revert "e1000e: Separate
 signaling for link check/link up"
In-Reply-To: <20180306015553.10441-1-bpoirier@suse.com>
References: <20180306015553.10441-1-bpoirier@suse.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C801AAC@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Benjamin Poirier
> Sent: Monday, March 5, 2018 5:56 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Subject: [Intel-wired-lan] [PATCH 1/2] Revert "e1000e: Separate signaling for
> link check/link up"
> 
> This reverts commit 19110cfbb34d4af0cdfe14cd243f3b09dc95b013.
> This reverts commit 4110e02eb45ea447ec6f5459c9934de0a273fb91.
> This reverts commit d3604515c9eda464a92e8e67aae82dfe07fe3c98.
> 
> Commit 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> changed what happens to the link status when there is an error which
> happens after "get_link_status = false" in the copper check_for_link
> callbacks. Previously, such an error would be ignored and the link
> considered up. After that commit, any error implies that the link is down.
> 
> Revert commit 19110cfbb34d ("e1000e: Separate signaling for link check/link
> up") and its followups. After reverting, the race condition described in
> the log of commit 19110cfbb34d is reintroduced. It may still be triggered
> by LSC events but this should keep the link down in case the link is
> electrically unstable, as discussed. The race may no longer be
> triggered by RXO events because commit 4aea7a5c5e94 ("e1000e: Avoid
> receiver overrun interrupt bursts") restored reading icr in the Other
> handler.
> 
> Link: https://lkml.org/lkml/2018/3/1/789
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 13 ++++---------
>  drivers/net/ethernet/intel/e1000e/mac.c     | 13 ++++---------
>  drivers/net/ethernet/intel/e1000e/netdev.c  |  2 +-
>  3 files changed, 9 insertions(+), 19 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
