From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:10 -0800
Subject: [Intel-wired-lan] [next PATCH S57 04/11] i40evf: free rings in
	remove function
In-Reply-To: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1481586257-28872-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When the i40evf_remove() calls netdev close, the device doesn't actually
close - it schedules the work for the watchdog to perform. Since we're
stopping the watchdog, this work doesn't get done. However, we're
resetting the part, so we can free resources after the reset request has
gone through. This plugs a memory leak.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Id5335dcaf76ce00d2a4c3d26e9faf711d7f051cf
---
Testing Hints : Load/unload test

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 920c1cb..5673dbd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2871,7 +2871,8 @@ static void i40evf_remove(struct pci_dev *pdev)
 		i40evf_request_reset(adapter);
 		msleep(50);
 	}
-
+	i40evf_free_all_tx_resources(adapter);
+	i40evf_free_all_rx_resources(adapter);
 	i40evf_misc_irq_disable(adapter);
 	i40evf_free_misc_irq(adapter);
 	i40evf_reset_interrupt_capability(adapter);
-- 
2.4.11

