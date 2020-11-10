From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 10 Nov 2020 12:01:32 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next v2 3/5] xsk: introduce padding
 between more ring pointers
In-Reply-To: <1605006094-31097-1-git-send-email-magnus.karlsson@gmail.com>
References: <1605006094-31097-1-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <1605006094-31097-4-git-send-email-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Introduce one cache line worth of padding between the consumer pointer
and the flags field as well as between the flags field and the start
of the descriptors in all the lockless rings. This so that the x86 HW
adjacency prefetcher will not prefetch the adjacent pointer/field when
only one pointer/field is going to be used. This improves throughput
performance for the l2fwd sample app with 1% on my machine with HW
prefetching turned on in the BIOS.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 net/xdp/xsk_queue.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index cdb9cf3..74fac80 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -18,9 +18,11 @@ struct xdp_ring {
 	/* Hinder the adjacent cache prefetcher to prefetch the consumer
 	 * pointer if the producer pointer is touched and vice versa.
 	 */
-	u32 pad ____cacheline_aligned_in_smp;
+	u32 pad1 ____cacheline_aligned_in_smp;
 	u32 consumer ____cacheline_aligned_in_smp;
+	u32 pad2 ____cacheline_aligned_in_smp;
 	u32 flags;
+	u32 pad3 ____cacheline_aligned_in_smp;
 };
 
 /* Used for the RX and TX queues for packets */
-- 
2.7.4

