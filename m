From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 22 Apr 2015 14:40:34 -0700
Subject: [Intel-wired-lan] [PATCH 5/8] igb: only report generic filters in
	get_ts_info
In-Reply-To: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1429738837-25158-5-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index d5673eb90c54..109cad928e71 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2396,10 +2396,6 @@ static int igb_get_ts_info(struct net_device *dev,
 			info->rx_filters |=
 				(1 << HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
 				(1 << HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
-				(1 << HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
-				(1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
-				(1 << HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
-				(1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
 				(1 << HWTSTAMP_FILTER_PTP_V2_EVENT);
 
 		return 0;
-- 
2.1.0

