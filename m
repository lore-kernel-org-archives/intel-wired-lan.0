From: Jonathan Toppins <jtoppins@cumulusnetworks.com>
Date: Fri, 10 Apr 2015 16:03:37 -0700
Subject: [Intel-wired-lan] [PATCH v1 net-next 2/3] igb: move initialization
	of link properties before igb_sw_init
In-Reply-To: <1428707018-6405-1-git-send-email-jtoppins@cumulusnetworks.com>
References: <1428707018-6405-1-git-send-email-jtoppins@cumulusnetworks.com>
Message-ID: <1428707018-6405-2-git-send-email-jtoppins@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is required otherwise the driver may experience a NULL ptr
dereference if CONFIG_PCI_IOV is set to yes.

Since the code can follow the flow on init (driver insmod):
	hw->mac.autoneg = false; (this is not set it is its default)
	igb_probe()
	+- igb_sw_init()
	    +- igb_probe_vfs()
	        +- igb_pci_enable_sriov()
	            +- igb_sriov_reinit()
	               +- igb_reset()
	                  trimmed path is the same see call path for
	                  igb_reset below
	+- hw->mac.autoneg = true;
	+- igb_reset()

	/* igb_reset() call chain */
	igb_reset()
	+- hw->mac.ops.init_hw() == igb_init_hw_82575
	   +- igb_setup_link()
	      +- hw->mac.ops.setup_physical_interface() ==
	           igb_setup_copper_link_82575()
	         +- igb_setup_copper_link()
	            +- possible NULL dereference

Pseudo code from igb_setup_copper_link():
	if (hw->mac.autoneg) {
	    /* setup link */
	} else {
	    hw->phy.ops.force_speed_duplex(hw);  // <-- NULL deref here
	}

Since the way the current code is designed the driver will call
igb_setup_copper_link twice if SRIOV is configured to be enabled. The
call will occur once with autoneg == false and the second
time autoneg == true. Since the decision to call the function pointer
(hw->phy.ops.force_speed_duplex) is predicated on autoneg being set
correctly move the setting of these parameters to as early as possible
in the probe function.

Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index bb467bb..720b785 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2328,6 +2328,14 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_sw_init;
 
+	/* Initialize link properties that are user-changeable */
+	adapter->fc_autoneg = true;
+	hw->mac.autoneg = true;
+	hw->phy.autoneg_advertised = 0x2f;
+
+	hw->fc.requested_mode = e1000_fc_default;
+	hw->fc.current_mode = e1000_fc_default;
+
 	/* setup the private structure */
 	err = igb_sw_init(adapter);
 	if (err)
@@ -2449,14 +2457,6 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->reset_task, igb_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igb_watchdog_task);
 
-	/* Initialize link properties that are user-changeable */
-	adapter->fc_autoneg = true;
-	hw->mac.autoneg = true;
-	hw->phy.autoneg_advertised = 0x2f;
-
-	hw->fc.requested_mode = e1000_fc_default;
-	hw->fc.current_mode = e1000_fc_default;
-
 	igb_validate_mdi_setting(hw);
 
 	/* By default, support wake on port A */
-- 
1.7.10.4

