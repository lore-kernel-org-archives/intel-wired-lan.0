From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 16:08:23 -0700
Subject: [Intel-wired-lan] [PATCH v2 02/13] ixgbe: resolve shift of negative
	value warning
In-Reply-To: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
References: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460588914-20143-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make use of GENMASK instead of open coding the equivalent operation
incorrectly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 40145d3da457..b3dd1b6903d7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3767,9 +3767,9 @@ static void ixgbe_configure_virtualization(struct ixgbe_adapter *adapter)
 	reg_offset = (VMDQ_P(0) >= 32) ? 1 : 0;
 
 	/* Enable only the PF's pool for Tx/Rx */
-	IXGBE_WRITE_REG(hw, IXGBE_VFRE(reg_offset), (~0) << vf_shift);
+	IXGBE_WRITE_REG(hw, IXGBE_VFRE(reg_offset), GENMASK(vf_shift, 31));
 	IXGBE_WRITE_REG(hw, IXGBE_VFRE(reg_offset ^ 1), reg_offset - 1);
-	IXGBE_WRITE_REG(hw, IXGBE_VFTE(reg_offset), (~0) << vf_shift);
+	IXGBE_WRITE_REG(hw, IXGBE_VFTE(reg_offset), GENMASK(vf_shift, 31));
 	IXGBE_WRITE_REG(hw, IXGBE_VFTE(reg_offset ^ 1), reg_offset - 1);
 	if (adapter->bridge_mode == BRIDGE_MODE_VEB)
 		IXGBE_WRITE_REG(hw, IXGBE_PFDTXGSWC, IXGBE_PFDTXGSWC_VT_LBEN);
-- 
2.8.1.102.ga49ec4a

