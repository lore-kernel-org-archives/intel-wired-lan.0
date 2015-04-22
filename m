From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 22 Apr 2015 14:40:33 -0700
Subject: [Intel-wired-lan] [PATCH 4/8] i40e: only report generic filters in
	get_ts_info
In-Reply-To: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1429738837-25158-4-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0b68f61eeb0c..f2075d5b800c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1467,17 +1467,8 @@ static int i40e_get_ts_info(struct net_device *dev,
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
-			   (1 << HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
-			   (1 << HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
-			   (1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ);
+			   (1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
+			   (1 << HWTSTAMP_FILTER_PTP_V2_EVENT);
 
 	return 0;
 }
-- 
2.1.0

