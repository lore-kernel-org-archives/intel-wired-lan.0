From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 24 Jul 2019 09:50:08 -0700
Subject: [Intel-wired-lan] [PATCH -next v2] ixgbevf: fix a compilation error
 of skb_frag_t
Message-ID: <20190724165008.12142-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Qian Cai <cai@lca.pw>

The linux-next commit "net: Rename skb_frag_t size to bv_len" [1]
introduced a compilation error on powerpc as it forgot to deal with the
renaming from "size" to "bv_len" for ixgbevf.

[1] https://lore.kernel.org/netdev/20190723030831.11879-1-willy at infradead.org/T/#md052f1c7de965ccd1bdcb6f92e1990a52298eac5

In file included from ./include/linux/cache.h:5,
                 from ./include/linux/printk.h:9,
                 from ./include/linux/kernel.h:15,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:9,
                 from
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:12:
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function
'ixgbevf_xmit_frame_ring':
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4138:51: error:
'skb_frag_t' {aka 'struct bio_vec'} has no member named 'size'
   count += TXD_USE_COUNT(skb_shinfo(skb)->frags[f].size);
                                                   ^
./include/uapi/linux/kernel.h:13:40: note: in definition of macro
'__KERNEL_DIV_ROUND_UP'
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
                                        ^
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4138:12: note: in
expansion of macro 'TXD_USE_COUNT'
   count += TXD_USE_COUNT(skb_shinfo(skb)->frags[f].size);

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Use the fine accessor per Matthew.

Sent to intel-wired-lan at lists.osuosl.org, since it was left off in the original
submission.

 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index bdfccaf38edd..8c011d4ce7a9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4134,8 +4134,11 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	 * otherwise try next time
 	 */
 #if PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD
-	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
-		count += TXD_USE_COUNT(skb_shinfo(skb)->frags[f].size);
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[f];
+
+		count += TXD_USE_COUNT(skb_frag_size(frag));
+	}
 #else
 	count += skb_shinfo(skb)->nr_frags;
 #endif
