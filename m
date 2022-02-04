From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Fri,  4 Feb 2022 09:02:17 +0100
Subject: [Intel-wired-lan] [PATCH net] igc: Clear old XDP info when changing
 ring settings
Message-ID: <20220204080217.70054-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When changing ring sizes the driver triggers kernel warnings in XDP code.

For instance, running 'ethtool -G $interface tx 1024 rx 1024' yields:

|[  754.838136] Missing unregister, handled but fix driver
|[  754.838143] WARNING: CPU: 4 PID: 704 at net/core/xdp.c:170 xdp_rxq_info_reg+0x7d/0xe0

The newly allocated ring is copied by memcpy() and still contains the old XDP
information. Therefore, it has to be cleared before allocating new resources
by igc_setup_rx_resources().

Igb does it the same way. Keep the code in sync.

Fixes: 4609ffb9f615 ("igc: Refactor XDP rxq info registration")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 8cc077b712ad..93839106504d 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -671,6 +671,10 @@ igc_ethtool_set_ringparam(struct net_device *netdev,
 			memcpy(&temp_ring[i], adapter->rx_ring[i],
 			       sizeof(struct igc_ring));
 
+			/* Clear copied XDP RX-queue info */
+			memset(&temp_ring[i].xdp_rxq, 0,
+			       sizeof(temp_ring[i].xdp_rxq));
+
 			temp_ring[i].count = new_rx_count;
 			err = igc_setup_rx_resources(&temp_ring[i]);
 			if (err) {
-- 
2.30.2

