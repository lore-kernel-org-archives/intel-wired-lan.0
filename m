From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:28 -0700
Subject: [Intel-wired-lan] [PATCH net-next 08/15] iavf: restore MSI state on
 reset
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If the PF experiences an FLR, the VF's MSI and MSI-X configuration will
be conveniently and silently removed in the process. When this happens,
reset recovery will appear to complete normally but no traffic will
pass. The netdev watchdog will helpfully notify everyone of this issue.

To prevent such public embarrassment, restore MSI configuration at every
reset. For normal resets, this will do no harm, but for VF resets
resulting from a PF FLR, this will keep the VF working.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 06db563a6190..2c639c7ebd1b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2183,6 +2183,7 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 
 	pci_set_master(adapter->pdev);
+	pci_restore_msi_state(adapter->pdev);
 
 	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
 		dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
-- 
2.20.1

