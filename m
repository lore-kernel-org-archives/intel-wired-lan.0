From: Stefan Assmann <sassmann@kpanic.de>
Date: Wed, 12 Aug 2020 16:39:50 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: fix uninitialized variable in
 i40e_set_vsi_promisc
Message-ID: <20200812143950.11675-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function ?i40e_set_vsi_promisc?:
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1176:14: error: ?aq_ret? may be used uninitialized in this function [-Werror=maybe-uninitialized]
  i40e_status aq_ret;

In case the code inside the if statement and the for loop does not get
executed aq_ret will be uninitialized when the variable gets returned at
the end of the function.

Fixes: 37d318d7805f ("i40e: Remove scheduling while atomic possibility")
Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8e133d6545bd..ae290ebd83cf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1173,7 +1173,7 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 {
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status aq_ret;
+	i40e_status aq_ret = 0;
 	int i;
 
 	/* No VLAN to set promisc on, set on VSI */
-- 
2.26.2

