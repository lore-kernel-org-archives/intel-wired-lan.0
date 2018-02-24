From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 23 Feb 2018 17:20:30 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 2/8] igb: Fix queue selection
 on MAC filters on i210 and i211
In-Reply-To: <20180224012036.5834-1-vinicius.gomes@intel.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
Message-ID: <20180224012036.5834-3-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On the RAH registers there are semantic differences on the meaning of
the "queue" parameter for traffic steering depending on the controller
model: there is the 82575 meaning, which "queue" means a RX Hardware
Queue, and the i350 meaning, where it is a reception pool.

The previous behaviour was having no effect for i210 and i211 based
controllers because the QSEL bit of the RAH register wasn't being set.

This patch separates the condition in discrete cases, so the different
handling is clearer.

Fixes: 83c21335c876 ("igb: improve MAC filter handling")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c      | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 83cabff1e0ab..573bf177fd08 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -490,6 +490,7 @@
  * manageability enabled, allowing us room for 15 multicast addresses.
  */
 #define E1000_RAH_AV  0x80000000        /* Receive descriptor valid */
+#define E1000_RAH_QSEL_ENABLE 0x10000000
 #define E1000_RAL_MAC_ADDR_LEN 4
 #define E1000_RAH_MAC_ADDR_LEN 2
 #define E1000_RAH_POOL_MASK 0x03FC0000
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b88fae785369..0ea32be07d71 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8741,12 +8741,19 @@ static void igb_rar_set_index(struct igb_adapter *adapter, u32 index)
 		if (is_valid_ether_addr(addr))
 			rar_high |= E1000_RAH_AV;
 
-		if (hw->mac.type == e1000_82575)
+		switch (hw->mac.type) {
+		case e1000_82575:
+		case e1000_i210:
+		case e1000_i211:
+			rar_high |= E1000_RAH_QSEL_ENABLE;
 			rar_high |= E1000_RAH_POOL_1 *
-				    adapter->mac_table[index].queue;
-		else
+				      adapter->mac_table[index].queue;
+			break;
+		default:
 			rar_high |= E1000_RAH_POOL_1 <<
-				    adapter->mac_table[index].queue;
+				adapter->mac_table[index].queue;
+			break;
+		}
 	}
 
 	wr32(E1000_RAL(index), rar_low);
-- 
2.16.2

