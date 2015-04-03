From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:03 -0700
Subject: [Intel-wired-lan] [net-next 13/25] fm10k: expose tx_timeout_count
	as an ethtool stat
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-13-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Named it tx_hang_count to differentiate it from tx_hwtstamp_timeout.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 4687f37..45e504f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -84,6 +84,8 @@ static const struct fm10k_stats fm10k_gstrings_global_stats[] = {
 	FM10K_STAT("mbx_rx_dwords", hw.mbx.rx_dwords),
 	FM10K_STAT("mbx_rx_parse_err", hw.mbx.rx_parse_err),
 
+	FM10K_STAT("tx_hang_count", tx_timeout_count),
+
 	FM10K_STAT("tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
 };
 
-- 
1.9.3

