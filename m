From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 04 Aug 2015 13:41:14 -0700
Subject: [Intel-wired-lan] [PATCH V4 01/13] ixgbe: Accept SFP not present
	errors on all devices
In-Reply-To: <20150804204010.51606.29686.stgit@mdrustad-wks.jf.intel.com>
References: <20150804204010.51606.29686.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150804204114.51606.98370.stgit@mdrustad-wks.jf.intel.com>
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

