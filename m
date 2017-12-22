From: Jiri Pirko <jiri@resnulli.us>
Date: Fri, 22 Dec 2017 12:45:16 +0100
Subject: [Intel-wired-lan] [patch net] i40e: flower: Fix return value for
 unsupported offload
Message-ID: <20171222114516.1816-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@mellanox.com>

When filter configuration is not supported, drivers should return
-EOPNOTSUPP so the core can react correctly.

Fixes: 2f4b411a3d67 ("i40e: Enable cloud filters via tc-flower")
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 321d8be..9da2069 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7356,7 +7356,7 @@ static int i40e_configure_clsflower(struct i40e_vsi *vsi,
 
 	if (tc < 0) {
 		dev_err(&vsi->back->pdev->dev, "Invalid traffic class\n");
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	if (test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state) ||
-- 
2.9.5

