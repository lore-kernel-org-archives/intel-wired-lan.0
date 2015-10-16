From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 16 Oct 2015 10:57:10 -0700
Subject: [Intel-wired-lan] [next-queue v5 16/17] fm10k: TRIVIAL fix typo of
	hardware
In-Reply-To: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1445018231-3196-16-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 0cdb79e8b36e..15d8e10c2504 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -584,7 +584,7 @@ static void fm10k_configure_tx_ring(struct fm10k_intfc *interface,
 	/* store tail pointer */
 	ring->tail = &interface->uc_addr[FM10K_TDT(reg_idx)];
 
-	/* reset ntu and ntc to place SW in sync with hardwdare */
+	/* reset ntu and ntc to place SW in sync with hardware */
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
 
@@ -690,7 +690,7 @@ static void fm10k_configure_rx_ring(struct fm10k_intfc *interface,
 	/* store tail pointer */
 	ring->tail = &interface->uc_addr[FM10K_RDT(reg_idx)];
 
-	/* reset ntu and ntc to place SW in sync with hardwdare */
+	/* reset ntu and ntc to place SW in sync with hardware */
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
 	ring->next_to_alloc = 0;
-- 
2.6.1.264.gbab76a9

