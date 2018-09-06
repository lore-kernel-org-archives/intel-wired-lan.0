From: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>
Date: Thu, 6 Sep 2018 03:36:08 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] net: ethernet: i40e: fix build
 error
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <02874ECE860811409154E81DA85FBB5884C78D88@ORSMSX115.amr.corp.intel.com>
Message-ID: <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/9/6 0:52, Keller, Jacob E wrote:





-----Original Message-----
From: Wang Dongsheng [mailto:dongsheng.wang at hxt-semitech.com]
Sent: Tuesday, September 04, 2018 7:27 PM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com><mailto:jeffrey.t.kirsher@intel.com>;
sergei.shtylyov at cogentembedded.com<mailto:sergei.shtylyov@cogentembedded.com>
Cc: Keller, Jacob E <jacob.e.keller@intel.com><mailto:jacob.e.keller@intel.com>; davem at davemloft.net<mailto:davem@davemloft.net>; intel-
wired-lan at lists.osuosl.org<mailto:wired-lan@lists.osuosl.org>; netdev at vger.kernel.org<mailto:netdev@vger.kernel.org>; linux-
kernel at vger.kernel.org<mailto:kernel@vger.kernel.org>; Wang Dongsheng <dongsheng.wang@hxt-
semitech.com><mailto:dongsheng.wang@hxt-semitech.com>
Subject: [PATCH v2 1/2] net: ethernet: i40e: fix build error

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

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com><mailto:dongsheng.wang@hxt-semitech.com>



Thanks for the fix.

A bit off topic, but these two files in the i40e and i40evf share some code. Is there a good mechanism for sharing these between the two drivers that would allow the modules to be independent? That would be ideal.


Yes,  but not only i40e. igb/vf, ixgb/vf also share same code. If we change any of them, means we need to broken the whole layout of driver/net/ethernet/intel/ . Obviously we can't put header files to $src/include/net. ?|

Cheers,
Dongsheng



Acked-by: Jacob Keller <jacob.e.keller@intel.com><mailto:jacob.e.keller@intel.com>



---
v2:
1. Move function.
2. Include a new patch at [2/2].

---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++++++++++++
 .../ethernet/intel/i40e/i40e_ethtool_stats.h  | 25 ++-----------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d7d3974beca2..f4a70d67a80a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1821,6 +1821,30 @@ static void i40e_get_ethtool_stats(struct net_device
*netdev,
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
+                            const unsigned int size, ...)
+{
+       unsigned int i;
+
+       for (i = 0; i < size; i++) {
+               va_list args;
+
+               va_start(args, size);
+               vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
+               *p += ETH_GSTRING_LEN;
+               va_end(args);
+       }
+}
+
 /**
  * i40e_get_stat_strings - copy stat strings into supplied buffer
  * @netdev: the netdev to collect strings for
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
index bba1cb0b658f..0874c352136a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
@@ -181,29 +181,8 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring
*ring)
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
-                                   const unsigned int size, ...)
-{
-       unsigned int i;
-
-       for (i = 0; i < size; i++) {
-               va_list args;
-
-               va_start(args, size);
-               vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
-               *p += ETH_GSTRING_LEN;
-               va_end(args);
-       }
-}
+void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+                            const unsigned int size, ...);

 /**
  * 40e_add_stat_strings - copy stat strings into ethtool buffer
--
2.18.0






-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180906/2bfd2308/attachment-0001.html>
