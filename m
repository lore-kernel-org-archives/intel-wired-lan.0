From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 5 May 2020 16:35:54 +0800
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove unused inline
 function ixgbe_irq_disable_queues
Message-ID: <20200505083554.25808-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

commit b5f69ccf6765 ("ixgbe: avoid bringing rings up/down as macvlans are added/removed")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 29 -------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 718931d951bc..ebfe6b57ed30 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2954,35 +2954,6 @@ static inline void ixgbe_irq_enable_queues(struct ixgbe_adapter *adapter,
 	/* skip the flush */
 }
 
-static inline void ixgbe_irq_disable_queues(struct ixgbe_adapter *adapter,
-					    u64 qmask)
-{
-	u32 mask;
-	struct ixgbe_hw *hw = &adapter->hw;
-
-	switch (hw->mac.type) {
-	case ixgbe_mac_82598EB:
-		mask = (IXGBE_EIMS_RTX_QUEUE & qmask);
-		IXGBE_WRITE_REG(hw, IXGBE_EIMC, mask);
-		break;
-	case ixgbe_mac_82599EB:
-	case ixgbe_mac_X540:
-	case ixgbe_mac_X550:
-	case ixgbe_mac_X550EM_x:
-	case ixgbe_mac_x550em_a:
-		mask = (qmask & 0xFFFFFFFF);
-		if (mask)
-			IXGBE_WRITE_REG(hw, IXGBE_EIMC_EX(0), mask);
-		mask = (qmask >> 32);
-		if (mask)
-			IXGBE_WRITE_REG(hw, IXGBE_EIMC_EX(1), mask);
-		break;
-	default:
-		break;
-	}
-	/* skip the flush */
-}
-
 /**
  * ixgbe_irq_enable - Enable default interrupt generation settings
  * @adapter: board private structure
-- 
2.17.1


