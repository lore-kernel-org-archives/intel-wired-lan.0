From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Apr 2019 16:52:02 -0700
Subject: [Intel-wired-lan] [PATCH 5/5] ixgbe: add a kernel documentation
 comment for ixgbe_ptp_get_ts_config
In-Reply-To: <20190408235202.10676-1-jacob.e.keller@intel.com>
References: <20190408235202.10676-1-jacob.e.keller@intel.com>
Message-ID: <20190408235202.10676-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This function was missing a documentation comment. Add one now.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 8f8cb0a1bea0..745f457161f5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -946,6 +946,15 @@ void ixgbe_ptp_rx_rgtstamp(struct ixgbe_q_vector *q_vector,
 	ixgbe_ptp_convert_to_hwtstamp(adapter, skb_hwtstamps(skb), regval);
 }
 
+/**
+ * ixgbe_ptp_get_ts_config - get current hardware timestamping configuration
+ * @adapter: pointer to adapter structure
+ * @ifr: ioctl data
+ *
+ * This function returns the current timestamping settings. Rather than
+ * attempt to deconstruct registers to fill in the values, simply keep a copy
+ * of the old settings around, and return a copy when requested.
+ */
 int ixgbe_ptp_get_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr)
 {
 	struct hwtstamp_config *config = &adapter->tstamp_config;
-- 
2.21.0.564.g2d7e7e4d310b

