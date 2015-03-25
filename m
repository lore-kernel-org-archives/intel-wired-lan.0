From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:07:06 -0700
Subject: [Intel-wired-lan] [next-queue] igb: cleanup igb_enable_mas() a bit
Message-ID: <1427256426-24377-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

Static checkers complain about this because we do:

	if (!(connsw & E1000_CONNSW_SERDESD)) {
		...
	} else if (connsw & E1000_CONNSW_SERDESD) {
		...
	} else {
		...
	}

Once you eliminate that E1000_CONNSW_SERDESD is set and not set then
there aren't any other possibilities so the else statement is dead
code.

This function always returns zero so if you delete the "ret_val"
variable, the code is shorter and more clear.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 0e07545..51def6e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1838,11 +1838,10 @@ static s32 igb_enable_mas(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 connsw;
-	s32 ret_val = 0;
 
 	connsw = rd32(E1000_CONNSW);
-	if (!(hw->phy.media_type == e1000_media_type_copper))
-		return ret_val;
+	if (hw->phy.media_type != e1000_media_type_copper)
+		return 0;
 
 	/* configure for SerDes media detect */
 	if (!(connsw & E1000_CONNSW_SERDESD)) {
@@ -1850,15 +1849,8 @@ static s32 igb_enable_mas(struct igb_adapter *adapter)
 		connsw |= E1000_CONNSW_AUTOSENSE_EN;
 		wr32(E1000_CONNSW, connsw);
 		wrfl();
-	} else if (connsw & E1000_CONNSW_SERDESD) {
-		/* already SerDes, no need to enable anything */
-		return ret_val;
-	} else {
-		netdev_info(adapter->netdev,
-			"MAS: Unable to configure feature, disabling..\n");
-		adapter->flags &= ~IGB_FLAG_MAS_ENABLE;
 	}
-	return ret_val;
+	return 0;
 }
 
 void igb_reset(struct igb_adapter *adapter)
-- 
1.9.3

