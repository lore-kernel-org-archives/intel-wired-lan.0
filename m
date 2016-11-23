From: Phil Turnbull <phil.turnbull@oracle.com>
Date: Wed, 23 Nov 2016 13:33:58 -0500
Subject: [Intel-wired-lan] [PATCH] fm10k: correctly check if interface is
	removed.
Message-ID: <20161123183358.16851-1-phil.turnbull@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

FM10K_REMOVED expects a hardware address, not a 'struct fm10k_hw'.

Fixes: 5cb8db4a4cbc ("fm10k: Add support for VF")
Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 5241e0873397..7041d83d48bf 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -942,7 +942,7 @@ static void fm10k_self_test(struct net_device *dev,
 
 	memset(data, 0, sizeof(*data) * FM10K_TEST_LEN);
 
-	if (FM10K_REMOVED(hw)) {
+	if (FM10K_REMOVED(hw->hw_addr)) {
 		netif_err(interface, drv, dev,
 			  "Interface removed - test blocked\n");
 		eth_test->flags |= ETH_TEST_FL_FAILED;
-- 
2.10.0

