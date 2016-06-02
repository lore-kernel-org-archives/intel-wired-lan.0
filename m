From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 01 Jun 2016 18:59:44 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix spoofed packets with macvlans
Message-ID: <20160602015944.28731.47045.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When setting spoofing both vlan and mac need to be set together.
This change resolves an issue where mac-vlans on the VF fail to pass
traffic due to spoofed packets.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 398d7a9..40687e5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -954,6 +954,7 @@ static int ixgbe_set_vf_macvlan_msg(struct ixgbe_adapter *adapter,
 			struct ixgbe_hw *hw = &adapter->hw;
 
 			hw->mac.ops.set_mac_anti_spoofing(hw, false, vf);
+			hw->mac.ops.set_vlan_anti_spoofing(hw, false, vf);
 		}
 	}
 

