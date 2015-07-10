From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:35:57 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 02/15] i40e: add
	RX to port CRC errors label
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

The port.crc_errors is really an RX counter, so let's mark it as such.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I179afd3f8a95d45229bb4163a6aeb01f0d2d250b
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 83d41c2..d6c7eb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -114,7 +114,7 @@ static struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("tx_errors", stats.eth.tx_errors),
 	I40E_PF_STAT("rx_dropped", stats.eth.rx_discards),
 	I40E_PF_STAT("tx_dropped_link_down", stats.tx_dropped_link_down),
-	I40E_PF_STAT("crc_errors", stats.crc_errors),
+	I40E_PF_STAT("rx_crc_errors", stats.crc_errors),
 	I40E_PF_STAT("illegal_bytes", stats.illegal_bytes),
 	I40E_PF_STAT("mac_local_faults", stats.mac_local_faults),
 	I40E_PF_STAT("mac_remote_faults", stats.mac_remote_faults),
-- 
1.9.3

