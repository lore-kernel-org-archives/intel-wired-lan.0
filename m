From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 17 Jul 2015 15:22:23 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: Accept SFP not present errors
	on all devices
In-Reply-To: <20150717222130.123580.2307.stgit@mdrustad-wks.jf.intel.com>
References: <20150717222130.123580.2307.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150717222223.123580.98126.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When an SFP not present error is returned by the reset_hw method,
accept it and go on, since an SFP can still be inserted. Previously
it was only accepted for 82598 devices.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 935fce78d844..f2e2da65fd88 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8698,8 +8698,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.reset_if_overtemp = true;
 	err = hw->mac.ops.reset_hw(hw);
 	hw->phy.reset_if_overtemp = false;
-	if (err == IXGBE_ERR_SFP_NOT_PRESENT &&
-	    hw->mac.type == ixgbe_mac_82598EB) {
+	if (err == IXGBE_ERR_SFP_NOT_PRESENT) {
 		err = 0;
 	} else if (err == IXGBE_ERR_SFP_NOT_SUPPORTED) {
 		e_dev_err("failed to load because an unsupported SFP+ or QSFP module type was detected.\n");

