From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 21 Nov 2017 15:58:27 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: remove redundant setting of
 xcast_mode
Message-ID: <20171121235827.20363.89.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Removed leftover assignment of xcast_mode.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index feed11b..208d946 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1896,10 +1896,6 @@ static void ixgbevf_set_rx_mode(struct net_device *netdev)
 	unsigned int flags = netdev->flags;
 	int xcast_mode;
 
-	xcast_mode = (flags & IFF_ALLMULTI) ? IXGBEVF_XCAST_MODE_ALLMULTI :
-		     (flags & (IFF_BROADCAST | IFF_MULTICAST)) ?
-		     IXGBEVF_XCAST_MODE_MULTI : IXGBEVF_XCAST_MODE_NONE;
-
 	/* request the most inclusive mode we need */
 	if (flags & IFF_PROMISC)
 		xcast_mode = IXGBEVF_XCAST_MODE_PROMISC;

