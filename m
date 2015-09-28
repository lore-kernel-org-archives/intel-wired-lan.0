From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:31 -0400
Subject: [Intel-wired-lan] [next PATCH S16 02/15] i40e/i40evf: Fix compile
	issue related to const string
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jingjing Wu <jingjing.wu@intel.com>

Add const to functions that return strings that aren't going to be
modified. This addresses some reported compile complaints.

Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
Change-ID: Ic56b1e814ab4d23a50480e7fdec652445f776ee8
---
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   | 4 ++--
 drivers/net/ethernet/intel/i40evf/i40e_common.c    | 4 ++--
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index a6ea6be..01d5f0b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -87,7 +87,7 @@ static i40e_status i40e_set_mac_type(struct i40e_hw *hw)
  * @hw: pointer to the HW structure
  * @aq_err: the AQ error code to convert
  **/
-char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
+const char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
 {
 	switch (aq_err) {
 	case I40E_AQ_RC_OK:
@@ -147,7 +147,7 @@ char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
  * @hw: pointer to the HW structure
  * @stat_err: the status error code to convert
  **/
-char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err)
+const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 {
 	switch (stat_err) {
 	case 0:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 21572be..58e384a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -651,7 +651,7 @@ static inline u8 i40e_nvmupd_get_transaction(u32 val)
 	return (u8)((val & I40E_NVM_TRANS_MASK) >> I40E_NVM_TRANS_SHIFT);
 }
 
-static char *i40e_nvm_update_state_str[] = {
+static const char * const i40e_nvm_update_state_str[] = {
 	"I40E_NVMUPD_INVALID",
 	"I40E_NVMUPD_READ_CON",
 	"I40E_NVMUPD_READ_SNT",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 0e2bfb1ad..642c9aa5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -58,8 +58,8 @@ void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
 void i40e_idle_aq(struct i40e_hw *hw);
 bool i40e_check_asq_alive(struct i40e_hw *hw);
 i40e_status i40e_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
-char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
-char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err);
+const char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
+const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err);
 
 i40e_status i40e_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
 				bool pf_lut, u8 *lut, u16 lut_size);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index b98b642..7435fb3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -87,7 +87,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
  * @hw: pointer to the HW structure
  * @aq_err: the AQ error code to convert
  **/
-char *i40evf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
+const char *i40evf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
 {
 	switch (aq_err) {
 	case I40E_AQ_RC_OK:
@@ -147,7 +147,7 @@ char *i40evf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err)
  * @hw: pointer to the HW structure
  * @stat_err: the status error code to convert
  **/
-char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err)
+const char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 {
 	switch (stat_err) {
 	case 0:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_prototype.h b/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
index 55ae4b0..8ed0edf 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
@@ -60,8 +60,8 @@ void i40e_idle_aq(struct i40e_hw *hw);
 void i40evf_resume_aq(struct i40e_hw *hw);
 bool i40evf_check_asq_alive(struct i40e_hw *hw);
 i40e_status i40evf_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
-char *i40evf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
-char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err);
+const char *i40evf_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
+const char *i40evf_stat_str(struct i40e_hw *hw, i40e_status stat_err);
 
 i40e_status i40evf_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
 				  bool pf_lut, u8 *lut, u16 lut_size);
-- 
1.9.3

