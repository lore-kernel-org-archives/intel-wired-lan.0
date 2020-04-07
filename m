From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  7 Apr 2020 14:07:09 -0700
Subject: [Intel-wired-lan] [PATCH 3/5] igc: Fix MAX_ETYPE_FILTER value
In-Reply-To: <20200407210711.24371-1-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
Message-ID: <20200407210711.24371-4-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The I225 controller has 8 ethertype filters, not 4. This patch fixes the
MAX_ETYPE_FILTER macro accordingly.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 3666914724b0..c20ac078fdef 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -26,7 +26,7 @@ void igc_set_ethtool_ops(struct net_device *);
 #define MAX_Q_VECTORS			8
 #define MAX_STD_JUMBO_FRAME_SIZE	9216
 
-#define MAX_ETYPE_FILTER		4
+#define MAX_ETYPE_FILTER		8
 #define IGC_RETA_SIZE			128
 
 struct igc_tx_queue_stats {
-- 
2.26.0

