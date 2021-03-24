From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 24 Mar 2021 10:05:31 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Fix overwrites return value
Message-ID: <20210324080531.2051963-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

drivers/net/ethernet/intel/igc/igc_i225.c:235 igc_write_nvm_srwr()
warn: loop overwrites return value 'ret_val'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_i225.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index cc83bb5c15e8..b2ef9fde97b3 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -229,10 +229,11 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
 	    words == 0) {
 		hw_dbg("nvm parameter(s) out of bounds\n");
-		goto out;
+		return ret_val;
 	}
 
 	for (i = 0; i < words; i++) {
+		ret_val = -IGC_ERR_NVM;
 		eewr = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) |
 			(data[i] << IGC_NVM_RW_REG_DATA) |
 			IGC_NVM_RW_REG_START;
@@ -254,7 +255,6 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 		}
 	}
 
-out:
 	return ret_val;
 }
 
-- 
2.25.1

