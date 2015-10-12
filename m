From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sun, 11 Oct 2015 23:59:47 -0600
Subject: [Intel-wired-lan] [next-queue 7/8] i40e: clean up local variable
	initialization
In-Reply-To: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
References: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1444629588-29933-7-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

In both i40e_calc_nvm_checksum() and i40e_update_nvm_checksum(), the
local variables designated by 'ret_code' are overwritten immediately. As
such, they should merely be declared.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 58e384a372a0..1715358a8a6c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -484,7 +484,7 @@ static i40e_status i40e_write_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
 static i40e_status i40e_calc_nvm_checksum(struct i40e_hw *hw,
 						    u16 *checksum)
 {
-	i40e_status ret_code = 0;
+	i40e_status ret_code;
 	struct i40e_virt_mem vmem;
 	u16 pcie_alt_module = 0;
 	u16 checksum_local = 0;
@@ -564,7 +564,7 @@ i40e_calc_nvm_checksum_exit:
  **/
 i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw)
 {
-	i40e_status ret_code = 0;
+	i40e_status ret_code;
 	u16 checksum;
 	__le16 le_sum;
 
