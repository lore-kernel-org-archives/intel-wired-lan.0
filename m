From: Karen Sornek <karen.sornek@intel.com>
Date: Wed,  7 Jul 2021 08:40:25 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1] igbvf: Refactor trace
Message-ID: <20210707064025.55096-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Refactoring "PF still resetting" message, because previous version looked
like a bug - it informed about changes that worked as designed but might
confuse users. Changes requested to make message more user-friendly.

Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 1bbe9862a..5c1574855 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1520,7 +1520,7 @@ static void igbvf_reset(struct igbvf_adapter *adapter)
 
 	/* Allow time for pending master requests to run */
 	if (mac->ops.reset_hw(hw))
-		dev_warn(&adapter->pdev->dev, "PF still resetting\n");
+		dev_info(&adapter->pdev->dev, "PF still resetting\n");
 
 	mac->ops.init_hw(hw);
 
-- 
2.27.0

