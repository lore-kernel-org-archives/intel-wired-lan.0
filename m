From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 15 Aug 2019 13:55:19 -0700
Subject: [Intel-wired-lan] [PATCH net 1/2] igb: Enable media autosense for
 the i350.
Message-ID: <20190815205520.22475-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Manfred Rudigier <manfred.rudigier@omicronenergy.com>

This patch enables the hardware feature "Media Auto Sense" also on the
i350. It works in the same way as on the 82850 devices. Hardware designs
using dual PHYs (fiber/copper) can enable this feature by setting the MAS
enable bits in the NVM_COMPAT register (0x03) in the EEPROM.

Signed-off-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 3ec2ce0725d5..8a6ef3514129 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -466,7 +466,7 @@ static s32 igb_init_mac_params_82575(struct e1000_hw *hw)
 			? igb_setup_copper_link_82575
 			: igb_setup_serdes_link_82575;
 
-	if (mac->type == e1000_82580) {
+	if (mac->type == e1000_82580 || mac->type == e1000_i350) {
 		switch (hw->device_id) {
 		/* feature not supported on these id's */
 		case E1000_DEV_ID_DH89XXCC_SGMII:
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b4df3e319467..95fc1a178ff3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2370,7 +2370,7 @@ void igb_reset(struct igb_adapter *adapter)
 		adapter->ei.get_invariants(hw);
 		adapter->flags &= ~IGB_FLAG_MEDIA_RESET;
 	}
-	if ((mac->type == e1000_82575) &&
+	if ((mac->type == e1000_82575 || mac->type == e1000_i350) &&
 	    (adapter->flags & IGB_FLAG_MAS_ENABLE)) {
 		igb_enable_mas(adapter);
 	}
