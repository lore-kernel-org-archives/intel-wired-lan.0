From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:45 -0700
Subject: [Intel-wired-lan] [next PATCH S91 07/11] i40e: add tx_busy to
 ethtool stats
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch adds the tx_busy stat to the ethtool stats. The tx_busy
stat tracks the number of times we return NETDEV_TX_BUSY to the stack
during transmit.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index e6e58e8..329e59e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -66,6 +66,7 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
 	I40E_VSI_STAT("tx_linearize", tx_linearize),
 	I40E_VSI_STAT("tx_force_wb", tx_force_wb),
+	I40E_VSI_STAT("tx_busy", tx_busy),
 	I40E_VSI_STAT("rx_alloc_fail", rx_buf_failed),
 	I40E_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
 };
-- 
2.9.5

