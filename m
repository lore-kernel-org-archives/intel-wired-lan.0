From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:26 -0700
Subject: [Intel-wired-lan] [PATCH S44 14/14] ice: Declare functions static
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516004226.4795-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_get_pfa_module_tlv() and ice_read_sr_word() are not being called
outside of their file. Declare them as static.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 5 +++--
 drivers/net/ethernet/intel/ice/ice_nvm.h | 4 ----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 7c2a06892bbb..b049c1c30c88 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -172,7 +172,8 @@ void ice_release_nvm(struct ice_hw *hw)
  *
  * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_word_aq.
  */
-enum ice_status ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
+static enum ice_status
+ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
 {
 	enum ice_status status;
 
@@ -196,7 +197,7 @@ enum ice_status ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
  * Area (PFA) and returns the TLV pointer and length. The caller can
  * use these to read the variable length TLV value.
  */
-enum ice_status
+static enum ice_status
 ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		       u16 module_type)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
index 999f273ba6ad..165eda07b93d 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.h
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
@@ -11,10 +11,6 @@ enum ice_status
 ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 		  bool read_shadow_ram);
 enum ice_status
-ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
-		       u16 module_type);
-enum ice_status
 ice_read_pba_string(struct ice_hw *hw, u8 *pba_num, u32 pba_num_size);
 enum ice_status ice_init_nvm(struct ice_hw *hw);
-enum ice_status ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data);
 #endif /* _ICE_NVM_H_ */
-- 
2.20.1

