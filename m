From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:48 -0700
Subject: [Intel-wired-lan] [next PATCH S93 11/11] i40e: fix
 i40e_add_queue_stats data pointer update
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <20180731104148.11896-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This function accidentally failed to update the data pointer, which
caused the reported stats to be incorrect. Additionally, statistics
which follow queue stats in the output would potentially read non-zeroed
garbage data from the ethtool buffer.

This occurred because the data double pointer was not dereferenced
before incrementing the size.

Additionally, make sure this issue is more visible by adding a WARN_ONCE
to the i40e_get_ethtool_stats function. This warning will trigger
whenever the data pointer is not at the expected address, similar to the
check that we make in the i40e_get_stat_strings() function.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index cd23d1e..abcd096 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1860,6 +1860,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	unsigned int i;
 	unsigned int start;
 	bool veb_stats;
+	u64 *p = data;
 
 	i40e_update_stats(vsi);
 
@@ -1902,7 +1903,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	}
 	rcu_read_unlock();
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
-		return;
+		goto check_data_pointer;
 
 	veb_stats = ((pf->lan_veb != I40E_NO_VEB) &&
 		     (pf->flags & I40E_FLAG_VEB_STATS_ENABLED));
@@ -1925,6 +1926,10 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 
 		i40e_add_ethtool_stats(&data, &pfc, i40e_gstrings_pfc_stats);
 	}
+
+check_data_pointer:
+	WARN_ONCE(data - p != i40e_get_stats_count(netdev),
+		  "ethtool stats count mismatch!");
 }
 
 /**
-- 
2.9.5

