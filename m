From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 22 Jul 2016 16:00:37 -0700
Subject: [Intel-wired-lan] [PATCH v1] fm10k: remove unnecessary extra
	parenthesis around ((~value))
Message-ID: <20160722230037.5128-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 4bb352e3039b..59dc13f3f321 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -133,7 +133,7 @@ static void fm10k_detach_subtask(struct fm10k_intfc *interface)
 	/* check the real address space to see if we've recovered */
 	hw_addr = READ_ONCE(interface->uc_addr);
 	value = readl(hw_addr);
-	if ((~value)) {
+	if (~value) {
 		interface->hw.hw_addr = interface->uc_addr;
 		netif_device_attach(netdev);
 		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
-- 
2.9.0.rc1.405.g81f467e

