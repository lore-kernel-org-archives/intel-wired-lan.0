From: Yang Li <yang.lee@linux.alibaba.com>
Date: Tue,  8 Feb 2022 09:35:07 +0800
Subject: [Intel-wired-lan] [PATCH -next] ixgbevf: clean up some inconsistent
 indenting
Message-ID: <20220208013507.51096-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Eliminate the follow smatch warning:
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:2756
ixgbevf_alloc_q_vector() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 17fbc450da61..84222ec2393c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2753,7 +2753,7 @@ static int ixgbevf_alloc_q_vector(struct ixgbevf_adapter *adapter, int v_idx,
 		ring->reg_idx = reg_idx;
 
 		/* assign ring to adapter */
-		 adapter->tx_ring[txr_idx] = ring;
+		adapter->tx_ring[txr_idx] = ring;
 
 		/* update count and index */
 		txr_count--;
-- 
2.20.1.7.g153144c

