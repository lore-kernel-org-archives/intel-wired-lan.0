From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Sun, 31 Jul 2016 11:30:58 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] net: e1000: do not use uninitalized
	variable.
Message-ID: <1469957458-494-1-git-send-email-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

phy_data has to be set to zero to avoid undefined
behavior.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 8172cf0..456bb07 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -5390,7 +5390,7 @@ static s32 e1000_set_phy_mode(struct e1000_hw *hw)
 static s32 e1000_set_d3_lplu_state(struct e1000_hw *hw, bool active)
 {
 	s32 ret_val;
-	u16 phy_data;
+	u16 phy_data = 0;
 
 	if (hw->phy_type != e1000_phy_igp)
 		return E1000_SUCCESS;
-- 
2.8.1

