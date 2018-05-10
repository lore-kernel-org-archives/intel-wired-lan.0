From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:42 -0700
Subject: [Intel-wired-lan] [next PATCH S91 04/11] i40e: remove duplicate pfc
 stats
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The pfc related priority stats are already handled separately as these
stats are actually arrays of length I40E_MAX_USER_PRIORITY. Thus,
including them within i40e_gstrings_stats will just duplicate data.

Worse, the sizeof will be incorrect, as it will be the total size of the
stat arrays, which in this case is 8 * sizeof(u64), so we will only copy
the stat contents as if they were a u32.

Since we already correctly handle these stats else where, remove them
from the i40e_gstrings_stats.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a62142f..0f23739 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -103,10 +103,6 @@ static const struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("link_xoff_rx", stats.link_xoff_rx),
 	I40E_PF_STAT("link_xon_tx", stats.link_xon_tx),
 	I40E_PF_STAT("link_xoff_tx", stats.link_xoff_tx),
-	I40E_PF_STAT("priority_xon_rx", stats.priority_xon_rx),
-	I40E_PF_STAT("priority_xoff_rx", stats.priority_xoff_rx),
-	I40E_PF_STAT("priority_xon_tx", stats.priority_xon_tx),
-	I40E_PF_STAT("priority_xoff_tx", stats.priority_xoff_tx),
 	I40E_PF_STAT("rx_size_64", stats.rx_size_64),
 	I40E_PF_STAT("rx_size_127", stats.rx_size_127),
 	I40E_PF_STAT("rx_size_255", stats.rx_size_255),
-- 
2.9.5

