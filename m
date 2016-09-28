From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 28 Sep 2016 15:36:38 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle previously-freed
	msix_entries
Message-ID: <147510219815.65927.11331530245019014313.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The msix_entries memory can be freed by a previous suspend or
remove, so don't crash on close when it isn't there.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bd93d823cc25..f6f18ca35fb7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3070,6 +3070,9 @@ static void ixgbe_free_irq(struct ixgbe_adapter *adapter)
 		return;
 	}
 
+	if (!adapter->msix_entries)
+		return;
+
 	for (vector = 0; vector < adapter->num_q_vectors; vector++) {
 		struct ixgbe_q_vector *q_vector = adapter->q_vector[vector];
 		struct msix_entry *entry = &adapter->msix_entries[vector];

