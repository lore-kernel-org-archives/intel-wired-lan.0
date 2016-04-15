From: Alexander Duyck <aduyck@mirantis.com>
Date: Fri, 15 Apr 2016 13:00:46 -0400
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Align Rx buffers to
	512B blocks
Message-ID: <20160415170046.3137.8553.stgit@ahduyck-xeon-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While reviewing the i40e driver changes to support page based receive I
realized that I had overlooked the fact that the fm10k hardware required a
512 byte alignment for Rx buffers.  This patch is meant to address that by
changing the alignment for Rx buffers to 512 bytes instead of allowing it
to be L1 cache aligned.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 0e166e9c90c8..53d02416476c 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -272,7 +272,7 @@ static bool fm10k_add_rx_frag(struct fm10k_rx_buffer *rx_buffer,
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = FM10K_RX_BUFSZ;
 #else
-	unsigned int truesize = SKB_DATA_ALIGN(size);
+	unsigned int truesize = ALIGN(size, 512);
 #endif
 	unsigned int pull_len;
 

