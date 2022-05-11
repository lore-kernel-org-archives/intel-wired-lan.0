From: xiaolinkui <xiaolinkui@gmail.com>
Date: Wed, 11 May 2022 17:20:04 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Convert a series of if statements to
 switch case
Message-ID: <20220511092004.30173-1-xiaolinkui@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Linkui Xiao <xiaolinkui@kylinos.cn>

Convert a series of if statements that handle different events to a switch
case statement to simplify the code.

V2: fix patch description and email format.

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 34b33b21e0dc..4ce0718eeff6 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4588,13 +4588,17 @@ static inline void igb_set_vf_vlan_strip(struct igb_adapter *adapter,
 	struct e1000_hw *hw = &adapter->hw;
 	u32 val, reg;
 
-	if (hw->mac.type < e1000_82576)
+	switch (hw->mac.type) {
+	case e1000_undefined:
+	case e1000_82575:
 		return;
-
-	if (hw->mac.type == e1000_i350)
+	case e1000_i350:
 		reg = E1000_DVMOLR(vfn);
-	else
+		break;
+	default:
 		reg = E1000_VMOLR(vfn);
+		break;
+	}
 
 	val = rd32(reg);
 	if (enable)
-- 
2.17.1

