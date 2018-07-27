From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Fri, 27 Jul 2018 16:04:53 +0800
Subject: [Intel-wired-lan] [PATCH 1/2] net: intel: igb: Replace GFP_ATOMIC
 with GFP_KERNEL in igb_sw_init()
Message-ID: <20180727080453.3198-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igb_sw_init() is never called in atomic context.
It calls kzalloc() and kcalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index cce7ada89255..5332a1b608e6 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3534,7 +3534,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	adapter->flags |= IGB_FLAG_HAS_MSIX;
 
 	adapter->mac_table = kzalloc(sizeof(struct igb_mac_addr) *
-				     hw->mac.rar_entry_count, GFP_ATOMIC);
+				     hw->mac.rar_entry_count, GFP_KERNEL);
 	if (!adapter->mac_table)
 		return -ENOMEM;
 
@@ -3544,7 +3544,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
 
 	/* Setup and initialize a copy of the hw vlan table array */
 	adapter->shadow_vfta = kcalloc(E1000_VLAN_FILTER_TBL_SIZE, sizeof(u32),
-				       GFP_ATOMIC);
+				       GFP_KERNEL);
 	if (!adapter->shadow_vfta)
 		return -ENOMEM;
 
-- 
2.17.0

