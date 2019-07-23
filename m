From: Alice Michael <alice.michael@intel.com>
Date: Tue, 23 Jul 2019 06:03:42 -0400
Subject: [Intel-wired-lan] [next PATCH S8 09/12] i40e: make
 i40e_set_mac_type() public
In-Reply-To: <20190723100345.57522-1-alice.michael@intel.com>
References: <20190723100345.57522-1-alice.michael@intel.com>
Message-ID: <20190723100345.57522-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Make i40e_set_mac_type() public. i40e driver requires i40e_set_mac_type()
to be public. It is required for recovery mode handling. Without this patch
recovery mode could not be detected in i40e_probe().

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 7af1b7477140..de996a80013e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -13,7 +13,7 @@
  * This function sets the mac type of the adapter based on the
  * vendor ID and device ID stored in the hw structure.
  **/
-static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
+i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 {
 	i40e_status status = 0;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index eac88bcc6c06..9c810d54df1c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -326,6 +326,8 @@ void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode,
 void i40e_nvmupd_clear_wait_state(struct i40e_hw *hw);
 void i40e_set_pci_config_data(struct i40e_hw *hw, u16 link_status);
 
+i40e_status i40e_set_mac_type(struct i40e_hw *hw);
+
 extern struct i40e_rx_ptype_decoded i40e_ptype_lookup[];
 
 static inline struct i40e_rx_ptype_decoded decode_rx_desc_ptype(u8 ptype)
-- 
2.21.0

