From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 15:56:31 -0700
Subject: [Intel-wired-lan] [PATCH 05/15] fm10k: add call to
	fm10k_clean_all_rx_rings in fm10k_down
In-Reply-To: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
References: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433372201-12007-5-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This prevents a memory leak in fm10k_set_ringparams. The leak occurs
because we go down, change ring parameters, and then come up. However,
fm10k_down on its own is not clearing the Rx rings. Since fm10k_up
assumes the rings are clean we basically drop the buffers and leak a
bunch of memory. Eventually we hit dirty page faults and reboot the
system. This issue does not occur elsewhere because other flows that
involve fm10k_down go through fm10k_close which immediately called
fm10k_free_all_rx_resources which properly cleans the rings.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index df9fda38bdd1..445014a49de7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1559,6 +1559,7 @@ void fm10k_down(struct fm10k_intfc *interface)
 
 	/* free any buffers still on the rings */
 	fm10k_clean_all_tx_rings(interface);
+	fm10k_clean_all_rx_rings(interface);
 }
 
 /**
-- 
2.1.0

