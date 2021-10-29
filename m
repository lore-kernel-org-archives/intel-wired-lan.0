From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri, 29 Oct 2021 11:26:01 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix display error code in
 dmesg
Message-ID: <20211029092601.24709-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>

Fix misleading display error in dmesg if tc filter return fail.
Only i40e status error code should be converted to string, not linux
error code. Otherwise, we return false information about the error.

Fixes: 2f4b411a3d67 ("i40e: Enable cloud filters via tc-flower")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4664d07..8f1f870 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8557,8 +8557,7 @@ static int i40e_configure_clsflower(struct i40e_vsi *vsi,
 
 	if (err) {
 		dev_err(&pf->pdev->dev,
-			"Failed to add cloud filter, err %s\n",
-			i40e_stat_str(&pf->hw, err));
+			"Failed to add cloud filter, err %d\n", err);
 		goto err;
 	}
 
-- 
2.27.0

