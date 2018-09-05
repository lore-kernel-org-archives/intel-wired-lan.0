From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Date: Wed, 5 Sep 2018 10:27:09 +0800
Subject: [Intel-wired-lan] [PATCH v2 1/2] net: ethernet: i40e: fix build
 error
Message-ID: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove "inline" from __i40e_add_stat_strings.

In file included from
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:0:
drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
?__i40e_add_stat_strings?:
drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
function ?__i40e_add_stat_strings? can never be inlined because it uses
variable argument lists
 static inline void __i40e_add_stat_strings(u8 **p, const struct
					    i40e_stats stats[],

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
v2:
1. Move function.
2. Include a new patch at [2/2].

---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++++++++++++
 .../ethernet/intel/i40e/i40e_ethtool_stats.h  | 25 ++-----------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d7d3974beca2..f4a70d67a80a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1821,6 +1821,30 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 		  "ethtool stats count mismatch!");
 }
 
+/**
+ * __i40e_add_stat_strings - copy stat strings into ethtool buffer
+ * @p: ethtool supplied buffer
+ * @stats: stat definitions array
+ * @size: size of the stats array
+ *
+ * Format and copy the strings described by stats into the buffer pointed at
+ * by p.
+ **/
+void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+			     const unsigned int size, ...)
+{
+	unsigned int i;
+
+	for (i = 0; i < size; i++) {
+		va_list args;
+
+		va_start(args, size);
+		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
+		*p += ETH_GSTRING_LEN;
+		va_end(args);
+	}
+}
+
 /**
  * i40e_get_stat_strings - copy stat strings into supplied buffer
  * @netdev: the netdev to collect strings for
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
index bba1cb0b658f..0874c352136a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
@@ -181,29 +181,8 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
 	*data += size;
 }
 
-/**
- * __i40e_add_stat_strings - copy stat strings into ethtool buffer
- * @p: ethtool supplied buffer
- * @stats: stat definitions array
- * @size: size of the stats array
- *
- * Format and copy the strings described by stats into the buffer pointed at
- * by p.
- **/
-static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
-				    const unsigned int size, ...)
-{
-	unsigned int i;
-
-	for (i = 0; i < size; i++) {
-		va_list args;
-
-		va_start(args, size);
-		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
-		*p += ETH_GSTRING_LEN;
-		va_end(args);
-	}
-}
+void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+			     const unsigned int size, ...);
 
 /**
  * 40e_add_stat_strings - copy stat strings into ethtool buffer
-- 
2.18.0

