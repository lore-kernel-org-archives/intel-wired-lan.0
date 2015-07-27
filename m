From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Mon, 27 Jul 2015 12:04:10 -0700
Subject: [Intel-wired-lan] [PATCH V2 01/12] ixgbe: Accept SFP not present
	errors on all devices
In-Reply-To: <20150727190244.104300.81756.stgit@mdrustad-wks.jf.intel.com>
References: <20150727190244.104300.81756.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150727190410.104300.88459.stgit@mdrustad-wks.jf.intel.com>
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
index f77512356dae..6c52300fecfe 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8711,8 +8711,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.reset_if_overtemp = true;
 	err = hw->mac.ops.reset_hw(hw);
 	hw->phy.reset_if_overtemp = false;
-	if (err == IXGBE_ERR_SFP_NOT_PRESENT &&
-	    hw->mac.type == ixgbe_mac_82598EB) {
+	if (err == IXGBE_ERR_SFP_NOT_PRESENT) {
 		err = 0;
 	} else if (err == IXGBE_ERR_SFP_NOT_SUPPORTED) {
 		e_dev_err("failed to load because an unsupported SFP+ or QSFP module type was detected.\n");

