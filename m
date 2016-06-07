From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  7 Jun 2016 16:08:57 -0700
Subject: [Intel-wired-lan] [PATCH v2 13/18] fm10k: enable bus master after
	every reset
In-Reply-To: <20160607230902.5457-1-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
Message-ID: <20160607230902.5457-14-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If an FLR occurs, VF devices will be knocked out of bus master mode, and
the driver will be unable to recover from the reset properly, resulting
in malicious driver events and an infinite reset loop. In the normal
case, the bus master mode will already be enabled and this call will
essentially be a no-op. Since we're doing this every reset, it is
possible we could remove the other calls to pci_set_master() but it
seems not harmful to just leave them in place.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index b02361c42705..5e40460b041d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -174,6 +174,8 @@ static int fm10k_handle_reset(struct fm10k_intfc *interface)
 
 	rtnl_lock();
 
+	pci_set_master(interface->pdev);
+
 	/* reset and initialize the hardware so it is in a known state */
 	err = hw->mac.ops.reset_hw(hw);
 	if (err) {
-- 
2.9.0.rc1.405.g81f467e

