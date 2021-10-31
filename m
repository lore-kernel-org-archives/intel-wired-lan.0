From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 31 Oct 2021 12:45:56 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove obsolete nvm type
Message-ID: <20211031104556.2312804-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i225 devices use only spi nvm type. This patch comes to tidy up
obsolete nvm types.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h   | 2 --
 drivers/net/ethernet/intel/igc/igc_i225.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 76832e55cbbb..b1e72ec5f131 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -67,8 +67,6 @@ enum igc_media_type {
 enum igc_nvm_type {
 	igc_nvm_unknown = 0,
 	igc_nvm_eeprom_spi,
-	igc_nvm_flash_hw,
-	igc_nvm_invm,
 };
 
 struct igc_info {
diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index b2ef9fde97b3..6e3e6097af60 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -473,13 +473,11 @@ s32 igc_init_nvm_params_i225(struct igc_hw *hw)
 
 	/* NVM Function Pointers */
 	if (igc_get_flash_presence_i225(hw)) {
-		hw->nvm.type = igc_nvm_flash_hw;
 		nvm->ops.read = igc_read_nvm_srrd_i225;
 		nvm->ops.write = igc_write_nvm_srwr_i225;
 		nvm->ops.validate = igc_validate_nvm_checksum_i225;
 		nvm->ops.update = igc_update_nvm_checksum_i225;
 	} else {
-		hw->nvm.type = igc_nvm_invm;
 		nvm->ops.read = igc_read_nvm_eerd;
 		nvm->ops.write = NULL;
 		nvm->ops.validate = NULL;
-- 
2.25.1

