From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Feb 2020 10:15:03 -0800
Subject: [Intel-wired-lan] [PATCH S40 13/15] ice: Use EOPNOTSUPP instead of
 ENOTSUPP
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <20200227181505.61720-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Using ENOTSUPP almost always results in some bizarre error message to
be printed in userspace. This is likely because ENOTSUPP was defined for
the NFS protocol (as per a comment in include/linux/errno.h). Use
EOPNOTSUPP instead.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.h         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 5fb457479060..1aac440f199b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1404,7 +1404,7 @@ static int ice_pci_sriov_ena(struct ice_pf *pf, int num_vfs)
 	if (num_vfs > pf->num_vfs_supported) {
 		dev_err(dev, "Can't enable %d VFs, max VFs supported is %d\n",
 			num_vfs, pf->num_vfs_supported);
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	dev_info(dev, "Allocating %d VFs\n", num_vfs);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.h b/drivers/net/ethernet/intel/ice/ice_xsk.h
index 3479e1de98fe..8a4ba7c6d549 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.h
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.h
@@ -24,7 +24,7 @@ ice_xsk_umem_setup(struct ice_vsi __always_unused *vsi,
 		   struct xdp_umem __always_unused *umem,
 		   u16 __always_unused qid)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline void
@@ -63,7 +63,7 @@ static inline int
 ice_xsk_wakeup(struct net_device __always_unused *netdev,
 	       u32 __always_unused queue_id, u32 __always_unused flags)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 #define ice_xsk_clean_rx_ring(rx_ring) do {} while (0)
-- 
2.20.1

