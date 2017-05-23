From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 23 May 2017 14:02:23 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix writes to PFQDE
Message-ID: <20170523210223.9463.49250.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ixgbe_write_qde() was ignoring the qde parameter which resulted
in PFQDE.HIDE_VLAN not being set for X550.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index e2766da..0760bd7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -818,7 +818,7 @@ static inline void ixgbe_write_qde(struct ixgbe_adapter *adapter, u32 vf,
 		IXGBE_WRITE_FLUSH(hw);
 
 		/* indicate to hardware that we want to set drop enable */
-		reg = IXGBE_QDE_WRITE | IXGBE_QDE_ENABLE;
+		reg = IXGBE_QDE_WRITE | qde;
 		reg |= i <<  IXGBE_QDE_IDX_SHIFT;
 		IXGBE_WRITE_REG(hw, IXGBE_QDE, reg);
 	}

