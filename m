From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 10 Apr 2018 10:49:51 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v7 02/10] igb: Fix queue
 selection on MAC filters on i210
In-Reply-To: <20180410174959.18757-1-vinicius.gomes@intel.com>
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
Message-ID: <20180410174959.18757-3-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On the RAH registers there are semantic differences on the meaning of
the "queue" parameter for traffic steering depending on the controller
model: there is the 82575 meaning, which "queue" means a RX Hardware
Queue, and the i350 meaning, where it is a reception pool.

The previous behaviour was having no effect for i210 based controllers
because the QSEL bit of the RAH register wasn't being set.

This patch separates the condition in discrete cases, so the different
handling is clearer.

Fixes: 83c21335c876 ("igb: improve MAC filter handling")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c1c0bc30a16d..0a79fef3c4fb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8748,12 +8748,17 @@ static void igb_rar_set_index(struct igb_adapter *adapter, u32 index)
 		if (is_valid_ether_addr(addr))
 			rar_high |= E1000_RAH_AV;
 
-		if (hw->mac.type == e1000_82575)
+		switch (hw->mac.type) {
+		case e1000_82575:
+		case e1000_i210:
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
2.17.0

