From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 27 May 2015 16:20:00 +0300
Subject: [Intel-wired-lan] [PATCH 4/5] e1000e: fix unit hang during loopback
	test
In-Reply-To: <f063947281680c84305a9376b0ea73fa1698eeb1.1432732734.git.yanirx.lubetkin@intel.com>
References: <f063947281680c84305a9376b0ea73fa1698eeb1.1432732734.git.yanirx.lubetkin@intel.com>
Message-ID: <e18e1cc292a73a4d19c9d8eb07e6d1a810e4e351.1432732734.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

system would hang during execution of "ethtool -t <NIC>" for the same
reason that required flushing the descriptor rings. this fix disables MULR
for the loopback test to avoid the hang state.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 11f486e..2edac5d 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -1516,8 +1516,17 @@ static int e1000_set_es2lan_mac_loopback(struct e1000_adapter *adapter)
 static int e1000_setup_loopback_test(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	u32 rctl;
+	u32 rctl, fext_nvm11, tarc0;
 
+	if (hw->mac.type == e1000_pch_spt) {
+		fext_nvm11 = er32(FEXTNVM11);
+		fext_nvm11 |= E1000_FEXTNVM11_DISABLE_MULR_FIX;
+		ew32(FEXTNVM11, fext_nvm11);
+		tarc0 = er32(TARC(0));
+		tarc0 &= 0xcfffffff;
+		tarc0 |= 0x20000000;
+		ew32(TARC(0), tarc0);
+	}
 	if (hw->phy.media_type == e1000_media_type_fiber ||
 	    hw->phy.media_type == e1000_media_type_internal_serdes) {
 		switch (hw->mac.type) {
@@ -1542,7 +1551,7 @@ static int e1000_setup_loopback_test(struct e1000_adapter *adapter)
 static void e1000_loopback_cleanup(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	u32 rctl;
+	u32 rctl, fext_nvm11, tarc0;
 	u16 phy_reg;
 
 	rctl = er32(RCTL);
@@ -1550,6 +1559,14 @@ static void e1000_loopback_cleanup(struct e1000_adapter *adapter)
 	ew32(RCTL, rctl);
 
 	switch (hw->mac.type) {
+	case e1000_pch_spt:
+		fext_nvm11 = er32(FEXTNVM11);
+		fext_nvm11 &= ~E1000_FEXTNVM11_DISABLE_MULR_FIX;
+		ew32(FEXTNVM11, fext_nvm11);
+		tarc0 = er32(TARC(0));
+		tarc0 &= 0xcfffffff;
+		ew32(TARC(0), tarc0);
+		/* fall through */
 	case e1000_80003es2lan:
 		if (hw->phy.media_type == e1000_media_type_fiber ||
 		    hw->phy.media_type == e1000_media_type_internal_serdes) {
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

