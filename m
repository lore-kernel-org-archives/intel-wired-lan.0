From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 22 Apr 2015 14:40:36 -0700
Subject: [Intel-wired-lan] [PATCH 7/8] siena: only report generic filters in
	get_ts_info
In-Reply-To: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1429738837-25158-7-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/sfc/siena.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena.c b/drivers/net/ethernet/sfc/siena.c
index f12c811938d2..bd5fdce65815 100644
--- a/drivers/net/ethernet/sfc/siena.c
+++ b/drivers/net/ethernet/sfc/siena.c
@@ -1021,9 +1021,5 @@ const struct efx_nic_type siena_a0_nic_type = {
 	.max_rx_ip_filters = FR_BZ_RX_FILTER_TBL0_ROWS,
 	.hwtstamp_filters = (1 << HWTSTAMP_FILTER_NONE |
 			     1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT |
-			     1 << HWTSTAMP_FILTER_PTP_V1_L4_SYNC |
-			     1 << HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ |
-			     1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT |
-			     1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC |
-			     1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ),
+			     1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT),
 };
-- 
2.1.0

