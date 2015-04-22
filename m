From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 22 Apr 2015 14:40:37 -0700
Subject: [Intel-wired-lan] [PATCH 8/8] dp83640: only report generic filters
	in ts_info
In-Reply-To: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1429738837-25158-8-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/phy/dp83640.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 496e02f961d3..2fdd271b424f 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1434,17 +1434,9 @@ static int dp83640_ts_info(struct phy_device *dev, struct ethtool_ts_info *info)
 	info->rx_filters =
 		(1 << HWTSTAMP_FILTER_NONE) |
 		(1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
-		(1 << HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
-		(1 << HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
+		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT);
 	return 0;
 }
 
-- 
2.1.0

