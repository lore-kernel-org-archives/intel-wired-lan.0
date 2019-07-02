From: Alice Michael <alice.michael@intel.com>
Date: Tue,  2 Jul 2019 08:22:58 -0400
Subject: [Intel-wired-lan] [next PATCH S7 8/9] i40e: verify string count
 matches even on early return
In-Reply-To: <20190702122259.79070-1-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
Message-ID: <20190702122259.79070-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Similar to i40e_get_ethtool_stats, add a goto to verify that the data
pointer for the strings lines up with the expected stats count. This
helps ensure that bugs are not introduced when adding stats.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 663de4fd7bbe..5c45ef3390c9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2342,7 +2342,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	}
 
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
-		return;
+		goto check_data_pointer;
 
 	i40e_add_stat_strings(&data, i40e_gstrings_veb_stats);
 
@@ -2354,6 +2354,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++)
 		i40e_add_stat_strings(&data, i40e_gstrings_pfc_stats, i);
 
+check_data_pointer:
 	WARN_ONCE(data - p != i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
 		  "stat strings count mismatch!");
 }
-- 
2.21.0

