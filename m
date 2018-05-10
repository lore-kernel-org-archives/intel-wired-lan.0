From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:43 -0700
Subject: [Intel-wired-lan] [next PATCH S91 05/11] i40e: cleanup whitespace
 for some ethtool stat definitions
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

A future patch is going to refactor some of the ethtool statistic code.
To keep the patches easy to review, cleanup some of the indentation used
for macro definitions first.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0f23739..e6e58e8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -19,13 +19,13 @@ struct i40e_stats {
 }
 
 #define I40E_NETDEV_STAT(_net_stat) \
-		I40E_STAT(struct rtnl_link_stats64, #_net_stat, _net_stat)
+	I40E_STAT(struct rtnl_link_stats64, #_net_stat, _net_stat)
 #define I40E_PF_STAT(_name, _stat) \
-		I40E_STAT(struct i40e_pf, _name, _stat)
+	I40E_STAT(struct i40e_pf, _name, _stat)
 #define I40E_VSI_STAT(_name, _stat) \
-		I40E_STAT(struct i40e_vsi, _name, _stat)
+	I40E_STAT(struct i40e_vsi, _name, _stat)
 #define I40E_VEB_STAT(_name, _stat) \
-		I40E_STAT(struct i40e_veb, _name, _stat)
+	I40E_STAT(struct i40e_veb, _name, _stat)
 
 static const struct i40e_stats i40e_gstrings_net_stats[] = {
 	I40E_NETDEV_STAT(rx_packets),
@@ -144,9 +144,9 @@ static const struct i40e_stats i40e_gstrings_stats[] = {
 	    * 2 /* Tx and Rx together */                                     \
 	    * (sizeof(struct i40e_queue_stats) / sizeof(u64)))
 #define I40E_GLOBAL_STATS_LEN	ARRAY_SIZE(i40e_gstrings_stats)
-#define I40E_NETDEV_STATS_LEN   ARRAY_SIZE(i40e_gstrings_net_stats)
+#define I40E_NETDEV_STATS_LEN	ARRAY_SIZE(i40e_gstrings_net_stats)
 #define I40E_MISC_STATS_LEN	ARRAY_SIZE(i40e_gstrings_misc_stats)
-#define I40E_VSI_STATS_LEN(n)   (I40E_NETDEV_STATS_LEN + \
+#define I40E_VSI_STATS_LEN(n)	(I40E_NETDEV_STATS_LEN + \
 				 I40E_MISC_STATS_LEN + \
 				 I40E_QUEUE_STATS_LEN((n)))
 #define I40E_PFC_STATS_LEN ( \
-- 
2.9.5

