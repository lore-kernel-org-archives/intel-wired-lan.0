From: Nicholas Krause <xerofoify@gmail.com>
Date: Wed,  1 Jul 2015 10:50:53 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe:Fix function comments for the
	function ixgbe_setup_tx_resources
Message-ID: <1435762253-21649-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This makes the function comments for the function
ixgbe_setup_tx_resources properly state that the
only error code returned for this function is the
error code -ENOMEM.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9aa6104..0ee64958 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5389,7 +5389,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
  * ixgbe_setup_tx_resources - allocate Tx resources (Descriptors)
  * @tx_ring:    tx descriptor ring (for a specific queue) to setup
  *
- * Return 0 on success, negative on failure
+ * Return 0 on success, -ENOMEM on failure
  **/
 int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
 {
-- 
2.1.4

