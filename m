From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Fri, 26 Mar 2021 19:43:43 +0100
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse warning: missing
 error code 'err'
In-Reply-To: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
References: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210326184343.133396-4-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set proper return values inside error checking if-statements.

Previously following warning was produced when compiling against sparse.
i40e_main.c:15162 i40e_init_recovery_mode() warn: missing error code 'err'

Fixes: 4ff0ee1af0169 ("i40e: Introduce recovery mode support")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2e9c22c..73d0c01 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15157,12 +15157,16 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	 * in order to register the netdev
 	 */
 	v_idx = i40e_vsi_mem_alloc(pf, I40E_VSI_MAIN);
-	if (v_idx < 0)
+	if (v_idx < 0) {
+		err = v_idx;
 		goto err_switch_setup;
+	}
 	pf->lan_vsi = v_idx;
 	vsi = pf->vsi[v_idx];
-	if (!vsi)
+	if (!vsi) {
+		err = -EFAULT;
 		goto err_switch_setup;
+	}
 	vsi->alloc_queue_pairs = 1;
 	err = i40e_config_netdev(vsi);
 	if (err)

base-commit: ca4303103f33952646218db4e0869e6f6aa1c840
-- 
2.26.0

