From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 10 Sep 2020 11:16:05 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up _nvm_info structure
Message-ID: <20200910081605.2562950-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

flash_bank_size and flash_base_addr field not in use and can
be removed from a _nvm_info structure

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 17d6669959db..55dae7c4703f 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -130,9 +130,6 @@ struct igc_nvm_info {
 	struct igc_nvm_operations ops;
 	enum igc_nvm_type type;
 
-	u32 flash_bank_size;
-	u32 flash_base_addr;
-
 	u16 word_size;
 	u16 delay_usec;
 	u16 address_bits;
-- 
2.18.4

