From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:52 -0800
Subject: [Intel-wired-lan] [next PATCH S25 12/16] i40evf: enable bus master
	after reset
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-13-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If the VF is reset via VFLR, the device will be knocked out of bus
master mode, and the driver will fail to recover from the reset. Fix
this by enabling bus mastering after every reset. In a non-VFLR case,
the bus master bit will not be disabled, and this call will have no effect.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Id515859ac7a691db478222228add6d149e96801a
---
Testing-Hints:
Initiate a VFLR using "setpci -s <pci location of VF> CAP_EXP+8.W=8000"

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 5b88123..9b38051 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1837,6 +1837,7 @@ static void i40evf_reset_task(struct work_struct *work)
 			break;
 		msleep(I40EVF_RESET_WAIT_MS);
 	}
+	pci_set_master(adapter->pdev);
 	/* extra wait to make sure minimum wait is met */
 	msleep(I40EVF_RESET_WAIT_MS);
 	if (i == I40EVF_RESET_WAIT_COUNT) {
-- 
2.1.0

