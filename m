From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Tue,  2 Jun 2015 17:05:47 +0300
Subject: [Intel-wired-lan] [PATCH v2 4/5] e1000e: fix unit hang during
	loopback test
In-Reply-To: <5c0f5ad24e5ae3adfede0279b6fdfea4312e32da.1433253642.git.yanirx.lubetkin@intel.com>
References: <5c0f5ad24e5ae3adfede0279b6fdfea4312e32da.1433253642.git.yanirx.lubetkin@intel.com>
Message-ID: <0b084820b85c25826686f51a078c5b95fe2dd696.1433253642.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

system would hang during execution of "ethtool -t <NIC>" for the same
reason that required flushing the descriptor rings. this fix disables
MULR for the loopback test to avoid the hang state.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 11f486e..51b7806 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -1516,8 +1516,19 @@ static int e1000_set_es2lan_mac_loopback(struct e1000_adapter *adapter)
 static int e1000_setup_loopback_test(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	u32 rctl;
-
+	u32 rctl, fext_nvm11, tarc0;
+ 
+	if (hw->mac.type == e1000_pch_spt) {
+		fext_nvm11 = er32(FEXTNVM11);
+		fext_nvm11 |= E1000_FEXTNVM11_DISABLE_MULR_FIX;
+		ew32(FEXTNVM11, fext_nvm11);
+		tarc0 = er32(TARC(0));
+		/* clear bits 28 & 29 (control of MULR concurrent requests) */
+		tarc0 &= 0xcfffffff;
+		/* set bit 29 (value of MULR requests is now 2) */
+		tarc0 |= 0x20000000;
+		ew32(TARC(0), tarc0);
+	}
 	if (hw->phy.media_type == e1000_media_type_fiber ||
 	    hw->phy.media_type == e1000_media_type_internal_serdes) {
 		switch (hw->mac.type) {
@@ -1542,7 +1553,7 @@ static int e1000_setup_loopback_test(struct e1000_adapter *adapter)
 static void e1000_loopback_cleanup(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	u32 rctl;
+	u32 rctl, fext_nvm11, tarc0;
 	u16 phy_reg;
 
 	rctl = er32(RCTL);
@@ -1550,6 +1561,16 @@ static void e1000_loopback_cleanup(struct e1000_adapter *adapter)
 	ew32(RCTL, rctl);
 
 	switch (hw->mac.type) {
+	case e1000_pch_spt:
+		fext_nvm11 = er32(FEXTNVM11);
+		fext_nvm11 &= ~E1000_FEXTNVM11_DISABLE_MULR_FIX;
+		ew32(FEXTNVM11, fext_nvm11);
+		tarc0 = er32(TARC(0));
+		/* clear bits 28 & 29 (control of MULR concurrent requests) */
+		/* set bit 29 (value of MULR requests is now 0) */
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

