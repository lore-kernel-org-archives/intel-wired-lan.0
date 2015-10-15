From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 15 Oct 2015 14:24:57 -0700
Subject: [Intel-wired-lan] [next-queue v3 17/17] fm10k: TRIVIAL cleanup
	order at top of fm10k_xmit_frame
In-Reply-To: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
References: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1444944297-9733-17-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 2ee02e51afe9..946c073fd7eb 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1098,11 +1098,11 @@ static void fm10k_tx_map(struct fm10k_ring *tx_ring,
 netdev_tx_t fm10k_xmit_frame_ring(struct sk_buff *skb,
 				  struct fm10k_ring *tx_ring)
 {
-	struct fm10k_tx_buffer *first;
-	int tso;
-	u32 tx_flags = 0;
-	unsigned short f;
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
+	struct fm10k_tx_buffer *first;
+	unsigned short f;
+	u32 tx_flags = 0;
+	int tso;
 
 	/* need: 1 descriptor per page * PAGE_SIZE/FM10K_MAX_DATA_PER_TXD,
 	 *       + 1 desc for skb_headlen/FM10K_MAX_DATA_PER_TXD,
-- 
2.6.1.264.gbab76a9

