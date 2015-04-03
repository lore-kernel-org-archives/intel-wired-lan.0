From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:12 -0700
Subject: [Intel-wired-lan] [net-next 22/25] fm10k: renamed mbx_tx_dropped to
	mbx_tx_oversized
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-22-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The use of dropped doesn't really mean dropped mailbox messages, but
rather specifically messages which were too large to fit in the remote
Rx FIFO. Rename the stat to more clearly indicate what it means.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 45e504f..4b9d9f8 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -77,7 +77,7 @@ static const struct fm10k_stats fm10k_gstrings_global_stats[] = {
 	FM10K_STAT("mac_rules_avail", hw.swapi.mac.avail),
 
 	FM10K_STAT("mbx_tx_busy", hw.mbx.tx_busy),
-	FM10K_STAT("mbx_tx_dropped", hw.mbx.tx_dropped),
+	FM10K_STAT("mbx_tx_oversized", hw.mbx.tx_dropped),
 	FM10K_STAT("mbx_tx_messages", hw.mbx.tx_messages),
 	FM10K_STAT("mbx_tx_dwords", hw.mbx.tx_dwords),
 	FM10K_STAT("mbx_rx_messages", hw.mbx.rx_messages),
-- 
1.9.3

