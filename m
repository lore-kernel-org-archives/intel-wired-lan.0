From: Colin King <colin.king@canonical.com>
Date: Thu, 21 Sep 2017 23:01:58 +0100
Subject: [Intel-wired-lan] [PATCH] e1000: avoid null pointer dereference on
	invalid stat type
Message-ID: <20170921220158.19341-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Currently if the stat type is invalid then data[i] is being set
either by dereferencing a null pointer p, or it is reading from
an incorrect previous location if we had a valid stat type
previously.  Fix this by nullify pointer p if a stat type is
invalid and only setting data if p is not null.

Detected by CoverityScan, CID#113385 ("Explicit null dereferenced")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index ec8aa4562cc9..2ef6f08b580b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -1824,11 +1824,12 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	int i;
-	char *p = NULL;
 	const struct e1000_stats *stat = e1000_gstrings_stats;
 
 	e1000_update_stats(adapter);
 	for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
+		char *p;
+
 		switch (stat->type) {
 		case NETDEV_STATS:
 			p = (char *)netdev + stat->stat_offset;
@@ -1837,12 +1838,13 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 			p = (char *)adapter + stat->stat_offset;
 			break;
 		default:
+			p = NULL;
 			WARN_ONCE(1, "Invalid E1000 stat type: %u index %d\n",
 				  stat->type, i);
 			break;
 		}
 
-		if (stat->sizeof_stat == sizeof(u64))
+		if (p && stat->sizeof_stat == sizeof(u64))
 			data[i] = *(u64 *)p;
 		else
 			data[i] = *(u32 *)p;
-- 
2.14.1

