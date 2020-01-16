From: Sasha Levin <sashal@kernel.org>
Date: Thu, 16 Jan 2020 11:43:55 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 4.19 004/671] ixgbe: don't clear
 IPsec sa counters on HW clearing
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
Message-ID: <20200116165502.8838-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@oracle.com>

[ Upstream commit 9e3f2f5ecee69b0f70003fb3e07639151e91de73 ]

The software SA record counters should not be cleared when clearing
the hardware tables.  This causes the counters to be out of sync
after a driver reset.

Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index b27f7a968820..49e6d66ccf80 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -114,7 +114,6 @@ static void ixgbe_ipsec_set_rx_ip(struct ixgbe_hw *hw, u16 idx, __be32 addr[])
  **/
 static void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_ipsec *ipsec = adapter->ipsec;
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 buf[4] = {0, 0, 0, 0};
 	u16 idx;
@@ -133,9 +132,6 @@ static void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 		ixgbe_ipsec_set_tx_sa(hw, idx, buf, 0);
 		ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
 	}
-
-	ipsec->num_rx_sa = 0;
-	ipsec->num_tx_sa = 0;
 }
 
 /**
-- 
2.20.1

