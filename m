From: linmiaohe <linmiaohe@huawei.com>
Date: Mon, 20 Jul 2020 16:29:14 +0800
Subject: [Intel-wired-lan] [PATCH] igb: use eth_zero_addr() to clear mac
 address
Message-ID: <1595233754-13765-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Miaohe Lin <linmiaohe@huawei.com>

Use eth_zero_addr() to clear mac address insetad of memset().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8bb3db2cbd41..adedd98f1e3e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7168,7 +7168,7 @@ static void igb_flush_mac_table(struct igb_adapter *adapter)
 
 	for (i = 0; i < hw->mac.rar_entry_count; i++) {
 		adapter->mac_table[i].state &= ~IGB_MAC_STATE_IN_USE;
-		memset(adapter->mac_table[i].addr, 0, ETH_ALEN);
+		eth_zero_addr(adapter->mac_table[i].addr);
 		adapter->mac_table[i].queue = 0;
 		igb_rar_set_index(adapter, i);
 	}
@@ -7317,7 +7317,7 @@ static int igb_del_mac_filter_flags(struct igb_adapter *adapter,
 		} else {
 			adapter->mac_table[i].state = 0;
 			adapter->mac_table[i].queue = 0;
-			memset(adapter->mac_table[i].addr, 0, ETH_ALEN);
+			eth_zero_addr(adapter->mac_table[i].addr);
 		}
 
 		igb_rar_set_index(adapter, i);
-- 
2.19.1

