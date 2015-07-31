From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 30 Jul 2015 17:20:20 -0700
Subject: [Intel-wired-lan] [PATCH V3 08/13] ixgbe: Allow reduced delays
	during sfp detection
In-Reply-To: <20150731001845.112031.6979.stgit@mdrustad-wks.jf.intel.com>
References: <20150731001845.112031.6979.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150731002020.112031.17424.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the number of retries during phy detection. This reduces
pauses when no SFP is present. Once an SFP is detected, the normal
retry count will be used.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c |   17 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h |    2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 174e75b6b6d4..615ca764e110 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1724,6 +1724,20 @@ s32 ixgbe_write_i2c_eeprom_generic(struct ixgbe_hw *hw, u8 byte_offset,
 					  eeprom_data);
 }
 
+/** ixgbe_is_sfp_probe - Returns true if SFP is being detected
+ * @hw: pointer to hardware structure
+ * @offset: eeprom offset to be read
+ * @addr: I2C address to be read
+ */
+static bool ixgbe_is_sfp_probe(struct ixgbe_hw *hw, u8 offset, u8 addr)
+{
+	if (addr == IXGBE_I2C_EEPROM_DEV_ADDR &&
+	    offset == IXGBE_SFF_IDENTIFIER &&
+	    hw->phy.sfp_type == ixgbe_sfp_type_not_present)
+		return true;
+	return false;
+}
+
 /** ixgbe_read_i2c_byte_generic_int - Reads 8 bit word over I2C
  *  @hw: pointer to hardware structure
  *  @byte_offset: byte offset to read
@@ -1742,6 +1756,9 @@ static s32 ixgbe_read_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 	bool nack = true;
 
+	if (ixgbe_is_sfp_probe(hw, byte_offset, dev_addr))
+		max_retry = IXGBE_SFP_DETECT_RETRIES;
+
 	*data = 0;
 
 	do {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 4c06484fdebc..0769b40399ea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -109,6 +109,8 @@
 #define IXGBE_I2C_T_SU_STO  4
 #define IXGBE_I2C_T_BUF     5
 
+#define IXGBE_SFP_DETECT_RETRIES	2
+
 #define IXGBE_TN_LASI_STATUS_REG        0x9005
 #define IXGBE_TN_LASI_STATUS_TEMP_ALARM 0x0008
 

