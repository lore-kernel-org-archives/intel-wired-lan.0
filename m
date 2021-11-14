From: Jason Wang <wangborong@cdjrlc.com>
Date: Sun, 14 Nov 2021 14:02:22 +0800
Subject: [Intel-wired-lan] [PATCH] igb: remove never changed variable
 `ret_val'
Message-ID: <20211114060222.231075-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The variable used for return status in `igb_write_xmdio_reg' function
is never changed  and this function is just need return 0. Thus, the
`ret_val' can be removed and return 0 at the end of the
`igb_write_xmdio_reg' function.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/net/ethernet/intel/igb/e1000_i210.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 9265901455cd..b9b9d35494d2 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -792,7 +792,6 @@ s32 igb_write_xmdio_reg(struct e1000_hw *hw, u16 addr, u8 dev_addr, u16 data)
  **/
 s32 igb_init_nvm_params_i210(struct e1000_hw *hw)
 {
-	s32 ret_val = 0;
 	struct e1000_nvm_info *nvm = &hw->nvm;
 
 	nvm->ops.acquire = igb_acquire_nvm_i210;
@@ -813,7 +812,7 @@ s32 igb_init_nvm_params_i210(struct e1000_hw *hw)
 		nvm->ops.validate = NULL;
 		nvm->ops.update   = NULL;
 	}
-	return ret_val;
+	return 0;
 }
 
 /**
-- 
2.33.0

