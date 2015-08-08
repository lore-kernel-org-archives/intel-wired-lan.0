From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:19:14 -0700
Subject: [Intel-wired-lan] [PATCH V5 18/19] ixgbe: Update
 ixgbe_disable_pcie_master flow for X550*
In-Reply-To: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150808231914.94784.69679.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch skips the PCI transactions pending check in
ixgbe_disable_pcie_master. This is done to addresses a known HW
issue where the PCI transactions pending bit sticks high when there
are pending transactions. HW engineering instructed to workaround
this issue by wait and then continue with our reset flow.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 09bbdd262a43..aa5c6d06cf04 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2476,6 +2476,9 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	hw_dbg(hw, "GIO Master Disable bit didn't clear - requesting resets\n");
 	hw->mac.flags |= IXGBE_FLAGS_DOUBLE_RESET_REQUIRED;
 
+	if (hw->mac.type >= ixgbe_mac_X550)
+		return 0;
+
 	/*
 	 * Before proceeding, make sure that the PCIe block does not have
 	 * transactions pending.

