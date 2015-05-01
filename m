From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Fri, 01 May 2015 10:34:38 -0700
Subject: [Intel-wired-lan] [net PATCH 1/3] fm10k: Do not assume budget will
	never be 0 for NAPI
In-Reply-To: <20150501173049.1029.54421.stgit@ahduyck-vm-fedora22>
References: <20150501173049.1029.54421.stgit@ahduyck-vm-fedora22>
Message-ID: <20150501173438.1029.2870.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The netpoll path will call napi->poll with a budget of 0 in order to clean
the Tx rings only.  This change updates the fm10k driver so that it will
correctly support that instead of cleaning 1 Rx frame if a budget of 0 is
received.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 4eafdad318b4..982fdcdc795b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -584,7 +584,7 @@ static bool fm10k_clean_rx_irq(struct fm10k_q_vector *q_vector,
 	unsigned int total_bytes = 0, total_packets = 0;
 	u16 cleaned_count = fm10k_desc_unused(rx_ring);
 
-	do {
+	while (likely(total_packets < budget)) {
 		union fm10k_rx_desc *rx_desc;
 
 		/* return some buffers to hardware, one@a time is too slow */
@@ -633,7 +633,7 @@ static bool fm10k_clean_rx_irq(struct fm10k_q_vector *q_vector,
 
 		/* update budget accounting */
 		total_packets++;
-	} while (likely(total_packets < budget));
+	}
 
 	/* place incomplete frames back on ring for completion */
 	rx_ring->skb = skb;

