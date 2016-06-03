From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  3 Jun 2016 15:42:11 -0700
Subject: [Intel-wired-lan] [PATCH v1 01/18] fm10k: no need to continue in
	fm10k_down if __FM10K_DOWN already set
In-Reply-To: <20160603224228.10192-1-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
Message-ID: <20160603224228.10192-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Return early from fm10k_down() when we are already down, since that
means another thread is either already finished or has started going
down, so shouldn't conflict with them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index e05aca9bef0e..610c313610c8 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1601,7 +1601,8 @@ void fm10k_down(struct fm10k_intfc *interface)
 	int err;
 
 	/* signal that we are down to the interrupt handler and service task */
-	set_bit(__FM10K_DOWN, &interface->state);
+	if (test_and_set_bit(__FM10K_DOWN, &interface->state))
+		return;
 
 	/* call carrier off first to avoid false dev_watchdog timeouts */
 	netif_carrier_off(netdev);
-- 
2.8.2.820.gd1c5f70

