From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 22 Apr 2015 14:40:32 -0700
Subject: [Intel-wired-lan] [PATCH 3/8] bnx2x: only report most generic
	filters in get_ts_info
In-Reply-To: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1429738837-25158-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index e3d853cab7c9..c02701dc4393 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -3517,17 +3517,8 @@ static int bnx2x_get_ts_info(struct net_device *dev,
 
 		info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 				   (1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
-				   (1 << HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
-				   (1 << HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
 				   (1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
-				   (1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
-				   (1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
-				   (1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
-				   (1 << HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
-				   (1 << HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
-				   (1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
-				   (1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
-				   (1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
+				   (1 << HWTSTAMP_FILTER_PTP_V2_EVENT);
 
 		info->tx_types = (1 << HWTSTAMP_TX_OFF)|(1 << HWTSTAMP_TX_ON);
 
-- 
2.1.0

