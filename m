From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  1 Jun 2017 15:40:39 -0700
Subject: [Intel-wired-lan] [PATCH 03/15] fm10k: avoid possible truncation of
	q_vector->name
In-Reply-To: <20170601224051.6106-1-jacob.e.keller@intel.com>
References: <20170601224051.6106-1-jacob.e.keller@intel.com>
Message-ID: <20170601224051.6106-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

New versions of GCC since version 7 began warning about possible
truncation of calls to snprintf. We can fix this and avoid false
positives. First, we should pass the full buffer size to snprintf,
because it guarantees a NULL character as part of its passed length, so
passing len-1 is simply wasting a byte of possible storage.

Second, if we make the ri and ti variables unsigned, the compiler is
able to correctly reason that the value never gets larger than 256, so
it doesn't need to warn about the full space required to print a signed
integer.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 3e26d27ad213..80b18f2479b4 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1544,7 +1544,7 @@ int fm10k_qv_request_irq(struct fm10k_intfc *interface)
 	struct net_device *dev = interface->netdev;
 	struct fm10k_hw *hw = &interface->hw;
 	struct msix_entry *entry;
-	int ri = 0, ti = 0;
+	unsigned int ri = 0, ti = 0;
 	int vector, err;
 
 	entry = &interface->msix_entries[NON_Q_VECTORS(hw)];
@@ -1554,15 +1554,15 @@ int fm10k_qv_request_irq(struct fm10k_intfc *interface)
 
 		/* name the vector */
 		if (q_vector->tx.count && q_vector->rx.count) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-TxRx-%d", dev->name, ri++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "%s-TxRx-%u", dev->name, ri++);
 			ti++;
 		} else if (q_vector->rx.count) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-rx-%d", dev->name, ri++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "%s-rx-%u", dev->name, ri++);
 		} else if (q_vector->tx.count) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-tx-%d", dev->name, ti++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "%s-tx-%u", dev->name, ti++);
 		} else {
 			/* skip this unused q_vector */
 			continue;
-- 
2.13.0.598.gf927b9495246

