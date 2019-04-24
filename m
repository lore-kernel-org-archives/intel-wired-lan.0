From: Alice Michael <alice.michael@intel.com>
Date: Wed, 24 Apr 2019 05:20:54 -0700
Subject: [Intel-wired-lan] [next PATCH S5 09/10] i40e: remove duplicate stat
 calculation for tx_errors
In-Reply-To: <20190424122055.27896-1-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
Message-ID: <20190424122055.27896-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The tx_errors statistic was being calculated twice in
i40e_update_eth_stats.

This appears to be as of commit 201db2898f2c ("i40e: add missing VSI
statistics", 2014-03-25).

Remove the extra i40e_stat_update32 call for GLV_TEPC.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d640da4a8835..3a0c77cd7a44 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -636,9 +636,6 @@ void i40e_update_eth_stats(struct i40e_vsi *vsi)
 	i40e_stat_update32(hw, I40E_GLV_RUPP(stat_idx),
 			   vsi->stat_offsets_loaded,
 			   &oes->rx_unknown_protocol, &es->rx_unknown_protocol);
-	i40e_stat_update32(hw, I40E_GLV_TEPC(stat_idx),
-			   vsi->stat_offsets_loaded,
-			   &oes->tx_errors, &es->tx_errors);
 
 	i40e_stat_update48(hw, I40E_GLV_GORCH(stat_idx),
 			   I40E_GLV_GORCL(stat_idx),
-- 
2.19.2

