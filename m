From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:33 -0700
Subject: [Intel-wired-lan] [PATCH 16/19] fm10k: cast page_addr to u8 * when
 incrementing it
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-17-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The page_addr variable is a void pointer. Incrementing it before calling
prefetch is technically undefined. Fix this by casting it to a u8*
pointer before incrementing it. This ensures that we increment the
pointer value in byte units, instead of relying on this undefined
behavior.

This was detected by cppcheck, and resolves the following warning
produced by that tool:

[fm10k_main.c:328]: (portability) 'page_addr' is of type 'void *'. When
using void pointers in calculations, the behaviour is undefined.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 3bacf35fbfad..cf87812bdf4a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -315,7 +315,7 @@ static struct sk_buff *fm10k_fetch_rx_buffer(struct fm10k_ring *rx_ring,
 		/* prefetch first cache line of first page */
 		prefetch(page_addr);
 #if L1_CACHE_BYTES < 128
-		prefetch(page_addr + L1_CACHE_BYTES);
+		prefetch((void *)((u8 *)page_addr + L1_CACHE_BYTES));
 #endif
 
 		/* allocate a skb to store the frags */
-- 
2.22.0.214.g8dca754b1e87

