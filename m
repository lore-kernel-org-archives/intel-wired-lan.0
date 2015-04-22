From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 22 Apr 2015 14:40:35 -0700
Subject: [Intel-wired-lan] [PATCH 6/8] ixgbe: only report generic filters in
	get_ts_info
In-Reply-To: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1429738837-25158-6-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 9f6fb19062a0..0f1bff34d6b6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2923,14 +2923,6 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
 			(1 << HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
-			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
-			(1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
-			(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
-			(1 << HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
-			(1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
-			(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ) |
-			(1 << HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
-			(1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_EVENT);
 		break;
 	default:
-- 
2.1.0

