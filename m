From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 4 Sep 2018 10:41:09 +0800
Subject: [Intel-wired-lan] [PATCH v2 net-next] i40e: remove inline directive
Message-ID: <20180904024109.21492-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes follow gcc warning:

drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_stat_strings':
drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: function '__i40e_add_stat_strings' can never be inlined because it uses variable argument lists

Fixes: 8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethtool_stats.h")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: move __i40e_add_stat_strings back to i40e_ethtool.c as Sergei Shtylyov suggested.
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c       | 15 +++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 16 ++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d7d3974..363c85b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -232,6 +232,21 @@ static const struct i40e_priv_flags i40e_gl_gstrings_priv_flags[] = {
 
 #define I40E_GL_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gl_gstrings_priv_flags)
 
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+                                    const unsigned int size, ...)
+{
+        unsigned int i;
+
+        for (i = 0; i < size; i++) {
+                va_list args;
+
+                va_start(args, size);
+                vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
+                *p += ETH_GSTRING_LEN;
+                va_end(args);
+        }
+}
+
 /**
  * i40e_partition_setting_complaint - generic complaint for MFP restriction
  * @pf: the PF struct
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
index bba1cb0..4265db6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
@@ -190,20 +190,8 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
  * Format and copy the strings described by stats into the buffer pointed at
  * by p.
  **/
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
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+				    const unsigned int size, ...);
 
 /**
  * 40e_add_stat_strings - copy stat strings into ethtool buffer
-- 
2.7.0


