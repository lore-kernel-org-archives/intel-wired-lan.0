From: Bruce Allan <bruce.w.allan@intel.com>
Date: Tue, 22 Dec 2015 14:55:20 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: demote BUG_ON() to
 WARN_ON() where appropriate
Message-ID: <20151222225520.141575.84032.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We don't need to crash the kernel in this instance so just warn about the
condition and play on.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index c9324c7..60a70e9 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -99,7 +99,7 @@ void fm10k_service_event_schedule(struct fm10k_intfc *interface)
 
 static void fm10k_service_event_complete(struct fm10k_intfc *interface)
 {
-	BUG_ON(!test_bit(__FM10K_SERVICE_SCHED, &interface->state));
+	WARN_ON(!test_bit(__FM10K_SERVICE_SCHED, &interface->state));
 
 	/* flush memory to make sure state is correct before next watchog */
 	smp_mb__before_atomic();

