From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Thu,  8 Mar 2018 07:26:08 -0500
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix disabling hide vlan on vf reset
Message-ID: <1520511968-20947-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If port vlan is enabled, set PFQDE.HIDE_VLAN during vf reset.

Setting only PFQDE.PFQDE during vf reset was clearing PFQDE.HIDE_VLAN.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 27a70a5..008aa07 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -831,7 +831,11 @@ static int ixgbe_vf_reset_msg(struct ixgbe_adapter *adapter, u32 vf)
 	IXGBE_WRITE_REG(hw, IXGBE_VFTE(reg_offset), reg);
 
 	/* force drop enable for all VF Rx queues */
-	ixgbe_write_qde(adapter, vf, IXGBE_QDE_ENABLE);
+	reg = IXGBE_QDE_ENABLE;
+	if (adapter->vfinfo[vf].pf_vlan)
+		reg |= IXGBE_QDE_HIDE_VLAN;
+
+	ixgbe_write_qde(adapter, vf, reg);
 
 	/* enable receive for vf */
 	reg = IXGBE_READ_REG(hw, IXGBE_VFRE(reg_offset));
-- 
2.7.5

