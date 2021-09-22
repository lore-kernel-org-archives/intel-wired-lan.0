From: Cai Huoqing <caihuoqing@baidu.com>
Date: Wed, 22 Sep 2021 20:59:46 +0800
Subject: [Intel-wired-lan] [PATCH] ice: Make use of the helper function
 devm_add_action_or_reset()
Message-ID: <20210922125947.480-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The helper function devm_add_action_or_reset() will internally
call devm_add_action(), and if devm_add_action() fails then it will
execute the action mentioned and return the error code. So
use devm_add_action_or_reset() instead of devm_add_action()
to simplify the error handling, reduce the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 14afce82ef63..f9d8410f29ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -482,10 +482,8 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
 		return NULL;
 
 	/* Add an action to teardown the devlink when unwinding the driver */
-	if (devm_add_action(dev, ice_devlink_free, devlink)) {
-		devlink_free(devlink);
+	if (devm_add_action_or_reset(dev, ice_devlink_free, devlink))
 		return NULL;
-	}
 
 	return devlink_priv(devlink);
 }
-- 
2.25.1

