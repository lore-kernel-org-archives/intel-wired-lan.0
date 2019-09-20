From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Sep 2019 02:17:20 -0700
Subject: [Intel-wired-lan] [next PATCH S10 06/10] i40e: remove the macro
 with it's argument reuse
In-Reply-To: <20190920091724.51767-1-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
Message-ID: <20190920091724.51767-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Remove macro and call i40e_update_vfid_in_stats() function directly
to avoid checkpatch.pl complains about macro argument reuse and
possible side effects.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 28 ++++---------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 67a6bd52eb95..883b43ac9816 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2417,7 +2417,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 }
 
 /**
- * __i40e_update_vfid_in_stats_strings - print VF num to stats names
+ * i40e_update_vfid_in_stats - print VF num to stats names
  * @stats_extra: array of stats structs with stats name strings
  * @strings_num: number of stats name strings in array above (length)
  * @vf_id: VF number to update stats name strings with
@@ -2425,8 +2425,8 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
  * Helper function to i40e_get_stat_strings() in case of extra stats.
  **/
 static inline void
-__i40e_update_vfid_in_stats_strings(struct i40e_stats stats_extra[],
-				    int strings_num, int vf_id)
+i40e_update_vfid_in_stats(struct i40e_stats stats_extra[],
+			  int strings_num, int vf_id)
 {
 	int i;
 
@@ -2438,24 +2438,6 @@ __i40e_update_vfid_in_stats_strings(struct i40e_stats stats_extra[],
 	}
 }
 
-/**
- * i40e_update_vfid_in_stats - print VF num to stat names
- * @stats_extra: array of stats structs with stats name strings
- * @vf_id: VF number to update stats name strings with
- *
- * Helper macro to i40e_get_stat_strings() to ease use of
- * __i40e_update_vfid_in_stats_strings() function due to extra stats.
- *
- * Macro to ease the use of __i40e_update_vfid_in_stats_strings by taking
- * a static constant stats array and passing the ARRAY_SIZE(). This avoids typos
- * by ensuring that we pass the size associated with the given stats array.
- *
- * The parameter @stats_extra is evaluated twice, so parameters with side
- * effects should be avoided.
- **/
-#define i40e_update_vfid_in_stats(stats_extra, vf_id) \
-__i40e_update_vfid_in_stats_strings(stats_extra, ARRAY_SIZE(stats_extra), vf_id)
-
 /**
  * i40e_get_stat_strings - copy stat strings into supplied buffer
  * @netdev: the netdev to collect strings for
@@ -2499,7 +2481,9 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 		i40e_add_stat_strings(&data, i40e_gstrings_pfc_stats, i);
 
 	for (i = 0; i < I40E_STATS_EXTRA_COUNT; i++) {
-		i40e_update_vfid_in_stats(i40e_gstrings_eth_stats_extra, i);
+		i40e_update_vfid_in_stats
+			(i40e_gstrings_eth_stats_extra,
+			 ARRAY_SIZE(i40e_gstrings_eth_stats_extra), i);
 		i40e_add_stat_strings(&data, i40e_gstrings_eth_stats_extra);
 	}
 
-- 
2.21.0

