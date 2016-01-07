From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 23:10:47 -0800
Subject: [Intel-wired-lan] [next PATCH 04/11] igb: Do not factor VLANs into
	RLPML calculation
In-Reply-To: <20160107070850.13648.21033.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
Message-ID: <20160107071046.13648.85457.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The RLPML registers already take the size of VLAN headers into account when
determining the maximum packet length.  This is called out in EAS documents
for several parts including the 82576 and the i350.  As such we can drop
the addition of size to the value programmed into the RLPML registers.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |    1 -
 drivers/net/ethernet/intel/igb/igb_main.c |   43 +----------------------------
 2 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 145922ec2e0e..d557e99eab6c 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -97,7 +97,6 @@ struct vf_data_storage {
 	unsigned char vf_mac_addresses[ETH_ALEN];
 	u16 vf_mc_hashes[IGB_MAX_VF_MC_ENTRIES];
 	u16 num_vf_mc_hashes;
-	u16 vlans_enabled;
 	u32 flags;
 	unsigned long last_nack;
 	u16 pf_vlan; /* When set, guest VLAN config not allowed. */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5b200c9f7658..fd1ddc170a72 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3651,12 +3651,8 @@ static inline int igb_set_vf_rlpml(struct igb_adapter *adapter, int size,
 	struct e1000_hw *hw = &adapter->hw;
 	u32 vmolr;
 
-	/* if it isn't the PF check to see if VFs are enabled and
-	 * increase the size to support vlan tags
-	 */
-	if (vfn < adapter->vfs_allocated_count &&
-	    adapter->vf_data[vfn].vlans_enabled)
-		size += VLAN_TAG_SIZE;
+	if (size > MAX_JUMBO_FRAME_SIZE)
+		size = MAX_JUMBO_FRAME_SIZE;
 
 	vmolr = rd32(E1000_VMOLR(vfn));
 	vmolr &= ~E1000_VMOLR_RLPML_MASK;
@@ -5915,8 +5911,6 @@ static void igb_clear_vf_vfta(struct igb_adapter *adapter, u32 vf)
 
 		wr32(E1000_VLVF(i), reg);
 	}
-
-	adapter->vf_data[vf].vlans_enabled = 0;
 }
 
 static s32 igb_vlvf_set(struct igb_adapter *adapter, u32 vid, bool add, u32 vf)
@@ -5965,23 +5959,6 @@ static s32 igb_vlvf_set(struct igb_adapter *adapter, u32 vid, bool add, u32 vf)
 			reg &= ~E1000_VLVF_VLANID_MASK;
 			reg |= vid;
 			wr32(E1000_VLVF(i), reg);
-
-			/* do not modify RLPML for PF devices */
-			if (vf >= adapter->vfs_allocated_count)
-				return 0;
-
-			if (!adapter->vf_data[vf].vlans_enabled) {
-				u32 size;
-
-				reg = rd32(E1000_VMOLR(vf));
-				size = reg & E1000_VMOLR_RLPML_MASK;
-				size += 4;
-				reg &= ~E1000_VMOLR_RLPML_MASK;
-				reg |= size;
-				wr32(E1000_VMOLR(vf), reg);
-			}
-
-			adapter->vf_data[vf].vlans_enabled++;
 		}
 	} else {
 		if (i < E1000_VLVF_ARRAY_SIZE) {
@@ -5993,22 +5970,6 @@ static s32 igb_vlvf_set(struct igb_adapter *adapter, u32 vid, bool add, u32 vf)
 				igb_vfta_set(hw, vid, false);
 			}
 			wr32(E1000_VLVF(i), reg);
-
-			/* do not modify RLPML for PF devices */
-			if (vf >= adapter->vfs_allocated_count)
-				return 0;
-
-			adapter->vf_data[vf].vlans_enabled--;
-			if (!adapter->vf_data[vf].vlans_enabled) {
-				u32 size;
-
-				reg = rd32(E1000_VMOLR(vf));
-				size = reg & E1000_VMOLR_RLPML_MASK;
-				size -= 4;
-				reg &= ~E1000_VMOLR_RLPML_MASK;
-				reg |= size;
-				wr32(E1000_VMOLR(vf), reg);
-			}
 		}
 	}
 	return 0;

