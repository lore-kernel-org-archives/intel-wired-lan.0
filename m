From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 17 May 2017 15:17:56 -0700
Subject: [Intel-wired-lan] [PATCH 4/5] ixgbe: add missing configuration for
	rate select 1
In-Reply-To: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
Message-ID: <20170517221756.15538.27845.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add RS1 configuration to ixgbe_set_soft_rate_select_speed()

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 8a2e8bf8..9b8e594 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -4278,4 +4278,23 @@ void ixgbe_set_soft_rate_select_speed(struct ixgbe_hw *hw,
 		hw_dbg(hw, "Failed to write Rx Rate Select RS0\n");
 		return;
 	}
+
+	/* Set RS1 */
+	status = hw->phy.ops.read_i2c_byte(hw, IXGBE_SFF_SFF_8472_ESCB,
+					   IXGBE_I2C_EEPROM_DEV_ADDR2,
+					   &eeprom_data);
+	if (status) {
+		hw_dbg(hw, "Failed to read Rx Rate Select RS1\n");
+		return;
+	}
+
+	eeprom_data = (eeprom_data & ~IXGBE_SFF_SOFT_RS_SELECT_MASK) | rs;
+
+	status = hw->phy.ops.write_i2c_byte(hw, IXGBE_SFF_SFF_8472_ESCB,
+					    IXGBE_I2C_EEPROM_DEV_ADDR2,
+					    eeprom_data);
+	if (status) {
+		hw_dbg(hw, "Failed to write Rx Rate Select RS1\n");
+		return;
+	}
 }

