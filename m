From: Alice Michael <alice.michael@intel.com>
Date: Mon, 20 Aug 2018 08:12:27 -0700
Subject: [Intel-wired-lan] [next PATCH S95 06/12] i40e: fix condition of
 WARN_ONCE for stat strings
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <20180820151233.14629-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 9b10df596bd4 ("i40e: use WARN_ONCE to replace the commented
BUG_ON size check") introduced a warning check to make sure
that the size of the stat strings was always the expected value. This
code accidentally inverted the check of the data pointer. Fix this so
that we accurately count the size of the stats we copied in.

This fixes an erroneous WARN kernel splat that occurs when requesting
ethtool statistics.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ecc30524..3ef9069 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1863,7 +1863,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++)
 		i40e_add_stat_strings(&data, i40e_gstrings_pfc_stats, i);
 
-	WARN_ONCE(p - data != i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
+	WARN_ONCE(data - p != i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
 		  "stat strings count mismatch!");
 }
 
-- 
2.9.5

