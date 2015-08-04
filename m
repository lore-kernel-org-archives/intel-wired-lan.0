From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 04 Aug 2015 13:42:11 -0700
Subject: [Intel-wired-lan] [PATCH V4 12/13] ixgbe: Allow SFP+ on more than
	82598 and 82599
In-Reply-To: <20150804204010.51606.29686.stgit@mdrustad-wks.jf.intel.com>
References: <20150804204010.51606.29686.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150804204211.51606.22636.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since SFP+ can be used with some X550 devices, permit them to be
detected.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 615ca764e110..5b83ad6bf48a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1224,7 +1224,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 			hw->phy.sfp_type = ixgbe_sfp_type_lr;
 		else
 			hw->phy.sfp_type = ixgbe_sfp_type_unknown;
-	} else if (hw->mac.type == ixgbe_mac_82599EB) {
+	} else {
 		if (cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE) {
 			if (hw->bus.lan_id == 0)
 				hw->phy.sfp_type =

