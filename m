From: Jianglei Nie <niejianglei2021@163.com>
Date: Sat,  2 Apr 2022 10:17:15 +0800
Subject: [Intel-wired-lan] [PATCH v2] ice: Fix memory leak in
 ice_get_orom_civd_data()
Message-ID: <20220402021715.4740-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A memory chunk was allocated for orom_data in ice_get_orom_civd_data()
by vzmalloc(). But when ice_read_flash_module() fails, the allocated
memory is not freed, which will lead to a memory leak.

We can fix it by freeing the orom_data when ce_read_flash_module() fails.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 4eb0599714f4..13cdb5ea594d 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -641,6 +641,7 @@ ice_get_orom_civd_data(struct ice_hw *hw, enum ice_bank_select bank,
 	status = ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR, 0,
 				       orom_data, hw->flash.banks.orom_size);
 	if (status) {
+		vfree(orom_data);
 		ice_debug(hw, ICE_DBG_NVM, "Unable to read Option ROM data\n");
 		return status;
 	}
-- 
2.25.1

