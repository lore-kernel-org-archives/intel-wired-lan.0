From: Radoslaw Tyl <radoslawx.tyl@intel.com>
Date: Tue,  8 Dec 2020 12:53:43 -0500
Subject: [Intel-wired-lan] [PATCH] ixgbe: aggregate of all receive errors
 through netdev's rx_errors
Message-ID: <20201208175343.454313-1-radoslawx.tyl@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The global rx error does not take into account all the error counters
that are counted by device.

Extend rx error with the following counters:
- illegal byte error
- number of receive fragment errors
- receive jabber
- receive oversize error
- receive undersize error
- frames marked as checksum invalid by hardware

The above were added in order to align statistics with other products.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 45ae33e15303..413a13b2578f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7234,12 +7234,21 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
 	hwstats->ptc1023 += IXGBE_READ_REG(hw, IXGBE_PTC1023);
 	hwstats->ptc1522 += IXGBE_READ_REG(hw, IXGBE_PTC1522);
 	hwstats->bptc += IXGBE_READ_REG(hw, IXGBE_BPTC);
+	hwstats->illerrc += IXGBE_READ_REG(hw, IXGBE_ILLERRC);
 
 	/* Fill out the OS statistics structure */
 	netdev->stats.multicast = hwstats->mprc;
 
 	/* Rx Errors */
-	netdev->stats.rx_errors = hwstats->crcerrs + hwstats->rlec;
+	netdev->stats.rx_errors = hwstats->crcerrs +
+				    hwstats->illerrc +
+				    hwstats->rlec +
+				    hwstats->rfc +
+				    hwstats->rjc +
+				    hwstats->roc +
+				    hwstats->ruc +
+				    hw_csum_rx_error;
+
 	netdev->stats.rx_dropped = 0;
 	netdev->stats.rx_length_errors = hwstats->rlec;
 	netdev->stats.rx_crc_errors = hwstats->crcerrs;
-- 
2.27.0

