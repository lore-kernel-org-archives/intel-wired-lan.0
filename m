From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 07 Apr 2016 10:43:50 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add register wait for slow links
Message-ID: <20160407174350.39412.3975.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use a new register to wait for previous register writes to complete
before issuing a register read. This is needed when slower links
are in use.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Testing-hints:
- Test that x550em_a devices operate at lower speeds without complaint
- Test that x550em_a devices do not suffer throughput loss with fast links
- Test that X550EM_x, X550 and other devices operate normally
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   21 +++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cf95f8098f1f..bb21186d5b50 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -370,6 +370,27 @@ u32 ixgbe_read_reg(struct ixgbe_hw *hw, u32 reg)
 
 	if (ixgbe_removed(reg_addr))
 		return IXGBE_FAILED_READ_REG;
+	if (unlikely(hw->phy.nw_mng_if_sel &
+		     IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M)) {
+		struct ixgbe_adapter *adapter;
+		int i;
+
+		for (i = 0; i < 200; ++i) {
+			value = readl(reg_addr + IXGBE_MAC_SGMII_BUSY);
+			if (likely(!value))
+				goto writes_completed;
+			if (value == IXGBE_FAILED_READ_REG) {
+				ixgbe_remove_adapter(hw);
+				return IXGBE_FAILED_READ_REG;
+			}
+			udelay(5);
+		}
+
+		adapter = hw->back;
+		e_warn(hw, "register writes incomplete %08x\n", value);
+	}
+
+writes_completed:
 	value = readl(reg_addr + reg);
 	if (unlikely(value == IXGBE_FAILED_READ_REG))
 		ixgbe_check_remove(hw, reg);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index af43b0c9c6c4..1ba2c21d4a2b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1130,6 +1130,7 @@ struct ixgbe_thermal_sensor_data {
 #define IXGBE_XPCSS     0x04290
 #define IXGBE_MFLCN     0x04294
 #define IXGBE_SERDESC   0x04298
+#define IXGBE_MAC_SGMII_BUSY 0x04298
 #define IXGBE_MACS      0x0429C
 #define IXGBE_AUTOC     0x042A0
 #define IXGBE_LINKS     0x042A4

