From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 26 Oct 2015 16:32:03 -0700
Subject: [Intel-wired-lan] [next-queue 2/6] fm10k: use ether_addr_equal
	instead of memcmp
In-Reply-To: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
References: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1445902327-6717-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When comparing MAC addresses, use ether_addr_equal instead of memcmp to
ETH_ALEN length. Found and replaced using the following sed:

 sed -e 's/memcmp\x28\(.*\), ETH_ALEN\x29/ether_addr_equal\x28\1\x29/'

Reported-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c  | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.c | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 15e67a383d27..73254b2b0a51 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1171,7 +1171,7 @@ static s32 fm10k_mbx_mac_addr(struct fm10k_hw *hw, u32 **results,
 
 	/* MAC was changed so we need reset */
 	if (is_valid_ether_addr(hw->mac.perm_addr) &&
-	    memcmp(hw->mac.perm_addr, hw->mac.addr, ETH_ALEN))
+	    ether_addr_equal(hw->mac.perm_addr, hw->mac.addr))
 		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
 
 	/* VLAN override was changed, or default VLAN changed */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index bbf0b4aef241..f45e0bad41a9 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1249,7 +1249,7 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 
 		/* block attempts to set MAC for a locked device */
 		if (is_valid_ether_addr(vf_info->mac) &&
-		    memcmp(mac, vf_info->mac, ETH_ALEN))
+		    ether_addr_equal(mac, vf_info->mac))
 			return FM10K_ERR_PARAM;
 
 		set = !(vlan & FM10K_VLAN_CLEAR);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
index 9b29d7b0377a..d6ff1e8d89fa 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
@@ -755,7 +755,7 @@ s32 fm10k_tlv_msg_test(struct fm10k_hw *hw, u32 **results,
 		err = fm10k_tlv_attr_get_mac_vlan(
 					results[FM10K_TEST_MSG_MAC_ADDR],
 					result_mac, &result_vlan);
-		if (!err && memcmp(test_mac, result_mac, ETH_ALEN))
+		if (!err && ether_addr_equal(test_mac, result_mac))
 			err = FM10K_ERR_INVALID_VALUE;
 		if (!err && test_vlan != result_vlan)
 			err = FM10K_ERR_INVALID_VALUE;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index 2af697df5abc..53345b1c29ce 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -298,7 +298,7 @@ static s32 fm10k_update_uc_addr_vf(struct fm10k_hw *hw, u16 glort,
 
 	/* verify we are not locked down on the MAC address */
 	if (is_valid_ether_addr(hw->mac.perm_addr) &&
-	    memcmp(hw->mac.perm_addr, mac, ETH_ALEN))
+	    ether_addr_equal(hw->mac.perm_addr, mac))
 		return FM10K_ERR_PARAM;
 
 	/* add bit to notify us if this is a set or clear operation */
-- 
2.6.1.264.gbab76a9

