From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 6 May 2020 14:18:35 +0800
Subject: [Intel-wired-lan] [PATCH net-next] i40e: Make
 i40e_shutdown_adminq() return void
Message-ID: <20200506061835.19662-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the following coccicheck warning:

drivers/net/ethernet/intel/i40e/i40e_adminq.c:699:13-21: Unneeded
variable: "ret_code". Return "0" on line 710

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c    | 6 +-----
 drivers/net/ethernet/intel/i40e/i40e_prototype.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 37514a75f928..6a089848c857 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -694,10 +694,8 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
  *  i40e_shutdown_adminq - shutdown routine for the Admin Queue
  *  @hw: pointer to the hardware structure
  **/
-i40e_status i40e_shutdown_adminq(struct i40e_hw *hw)
+void i40e_shutdown_adminq(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
-
 	if (i40e_check_asq_alive(hw))
 		i40e_aq_queue_shutdown(hw, true);
 
@@ -706,8 +704,6 @@ i40e_status i40e_shutdown_adminq(struct i40e_hw *hw)
 
 	if (hw->nvm_buff.va)
 		i40e_free_virt_mem(hw, &hw->nvm_buff);
-
-	return ret_code;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index bbb478f09093..5c1378641b3b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -17,7 +17,7 @@
 
 /* adminq functions */
 i40e_status i40e_init_adminq(struct i40e_hw *hw);
-i40e_status i40e_shutdown_adminq(struct i40e_hw *hw);
+void i40e_shutdown_adminq(struct i40e_hw *hw);
 void i40e_adminq_init_ring_data(struct i40e_hw *hw);
 i40e_status i40e_clean_arq_element(struct i40e_hw *hw,
 					     struct i40e_arq_event_info *e,
-- 
2.21.1

