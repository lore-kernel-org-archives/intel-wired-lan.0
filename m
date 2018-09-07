From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Date: Fri, 7 Sep 2018 19:19:35 +0800
Subject: [Intel-wired-lan] [PATCH v3 2/2] net: ethernet: i40evf: fix
 underlying build error
In-Reply-To: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
Message-ID: <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Can't have non-inline function in a header file.
There is a risk of "Multiple definition" from cross-including.

Tested on: x86_64, make ARCH=i386

Modules section .text:
i40e: 00019380 <__i40e_add_stat_strings>:
i40evf: 00006b00 <__i40e_add_stat_strings>:

Buildin section .text:
i40e: c351ca60 <__i40e_add_stat_strings>:
i40evf: c354f2c0 <__i40e_add_stat_strings>:

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
V3: add static 
---
 .../intel/i40evf/i40e_ethtool_stats.h         | 23 +-----------------
 .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
index 60b595dd8c39..62ab67a77753 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
@@ -181,29 +181,8 @@ i40evf_add_queue_stats(u64 **data, struct i40e_ring *ring)
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
 static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
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
+				    const unsigned int size, ...);
 
 /**
  * 40e_add_stat_strings - copy stat strings into ethtool buffer
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index 9319971c5c92..eb2e910bc3a1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -171,6 +171,30 @@ static void i40evf_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 	}
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
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+				    const unsigned int size, ...)
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
  * i40evf_get_stat_strings - Get stat strings
  * @netdev: network interface device structure
-- 
2.18.0

