From: Qinglang Miao <miaoqinglang@huawei.com>
Date: Mon, 21 Sep 2020 21:10:34 +0800
Subject: [Intel-wired-lan] [PATCH -next] ice: simplify the return expression
 of ice_finalize_update()
Message-ID: <20200921131034.92063-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index deaefe00c..292d87b99 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -608,14 +608,9 @@ static int ice_finalize_update(struct pldmfw *context)
 	struct ice_fwu_priv *priv = container_of(context, struct ice_fwu_priv, context);
 	struct netlink_ext_ack *extack = priv->extack;
 	struct ice_pf *pf = priv->pf;
-	int err;
 
 	/* Finally, notify firmware to activate the written NVM banks */
-	err = ice_switch_flash_banks(pf, priv->activate_flags, extack);
-	if (err)
-		return err;
-
-	return 0;
+	return ice_switch_flash_banks(pf, priv->activate_flags, extack);
 }
 
 static const struct pldmfw_ops ice_fwu_ops = {
-- 
2.23.0

