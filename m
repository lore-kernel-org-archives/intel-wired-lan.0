From: Igor Pylypiv <igor.pylypiv@gmail.com>
Date: Thu,  3 Oct 2019 23:53:57 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove duplicate clear_bit() call
Message-ID: <20191004065357.19138-1-igor.pylypiv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

__IXGBE_RX_BUILD_SKB_ENABLED bit is already cleared.

Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1ce2397306b9..91b3780ddb04 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4310,7 +4310,6 @@ static void ixgbe_set_rx_buffer_len(struct ixgbe_adapter *adapter)
 		if (test_bit(__IXGBE_RX_FCOE, &rx_ring->state))
 			set_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state);
 
-		clear_bit(__IXGBE_RX_BUILD_SKB_ENABLED, &rx_ring->state);
 		if (adapter->flags2 & IXGBE_FLAG2_RX_LEGACY)
 			continue;
 
-- 
2.20.1

