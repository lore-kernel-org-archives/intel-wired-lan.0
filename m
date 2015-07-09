From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 09 Jul 2015 12:28:59 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix bounds checking in
	ixgbe_setup_tc for 82598
Message-ID: <20150709192859.29234.71282.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch resolves an issue where users were not able to dynamically
set number of queues for 82598 via ethtool -L

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reported-by: Tal Abudi <talabudi@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 193d5da..0f990d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7863,9 +7863,10 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 	bool pools;
 
 	/* Hardware supports up to 8 traffic classes */
-	if (tc > adapter->dcb_cfg.num_tcs.pg_tcs ||
-	    (hw->mac.type == ixgbe_mac_82598EB &&
-	     tc < MAX_TRAFFIC_CLASS))
+	if (tc > adapter->dcb_cfg.num_tcs.pg_tcs)
+		return -EINVAL;
+
+	if (hw->mac.type == ixgbe_mac_82598EB && tc && tc < MAX_TRAFFIC_CLASS)
 		return -EINVAL;
 
 	pools = (find_first_zero_bit(&adapter->fwd_bitmask, 32) > 1);

