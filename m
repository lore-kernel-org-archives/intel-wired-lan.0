From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 24 Mar 2021 15:15:25 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Expose LPI counters
Message-ID: <20210324131525.2196955-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Expose EEE tx and rx low power idle counters via ethtool
A EEE TX or RX LPI event occurs when the transmitter or the receiver
enters EEE (IEEE802.3az) LPI state.
ethtool --statistics <iface>

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 8722294ab90c..9722449d7633 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -65,6 +65,8 @@ static const struct igc_stats igc_gstrings_stats[] = {
 	IGC_STAT("tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
 	IGC_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
 	IGC_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
+	IGC_STAT("tx_lpi_counter", stats.tlpic),
+	IGC_STAT("rx_lpi_counter", stats.rlpic),
 };
 
 #define IGC_NETDEV_STAT(_net_stat) { \
-- 
2.25.1

