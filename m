From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 04 May 2016 15:01:27 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: use correct mask when enabling
	sriov
Message-ID: <20160504220127.3998.27301.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Swap the parameters in GENMASK in order to generate the correct mask.

This change fixes Tx hangs when enabling SRIOV.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c965b60..311910b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3767,9 +3767,9 @@ static void ixgbe_configure_virtualization(struct ixgbe_adapter *adapter)
 	reg_offset = (VMDQ_P(0) >= 32) ? 1 : 0;
 
 	/* Enable only the PF's pool for Tx/Rx */
-	IXGBE_WRITE_REG(hw, IXGBE_VFRE(reg_offset), GENMASK(vf_shift, 31));
+	IXGBE_WRITE_REG(hw, IXGBE_VFRE(reg_offset), GENMASK(31, vf_shift));
 	IXGBE_WRITE_REG(hw, IXGBE_VFRE(reg_offset ^ 1), reg_offset - 1);
-	IXGBE_WRITE_REG(hw, IXGBE_VFTE(reg_offset), GENMASK(vf_shift, 31));
+	IXGBE_WRITE_REG(hw, IXGBE_VFTE(reg_offset), GENMASK(31, vf_shift));
 	IXGBE_WRITE_REG(hw, IXGBE_VFTE(reg_offset ^ 1), reg_offset - 1);
 	if (adapter->bridge_mode == BRIDGE_MODE_VEB)
 		IXGBE_WRITE_REG(hw, IXGBE_PFDTXGSWC, IXGBE_PFDTXGSWC_VT_LBEN);

