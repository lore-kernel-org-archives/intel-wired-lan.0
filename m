From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 31 Mar 2021 14:17:04 -0700
Subject: [Intel-wired-lan] [PATCH S58 09/13] ice: Set vsi->vf_id as
 ICE_INVAL_VFID for non VF VSI types
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <20210331211708.55205-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the vsi->vf_id is set only for ICE_VSI_VF and it's left as 0
for all other VSI types. This is confusing and could be problematic
since 0 is a valid vf_id. Fix this by always setting non VF VSI types to
ICE_INVAL_VFID.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4e93005686a4..c379b4ddffbd 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -158,7 +158,8 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi, u16 vf_id)
 
 	if (vsi->type == ICE_VSI_VF)
 		vsi->vf_id = vf_id;
-
+	else
+		vsi->vf_id = ICE_INVAL_VFID;
 	switch (vsi->type) {
 	case ICE_VSI_PF:
 		vsi->alloc_txq = min3(pf->num_lan_msix,
-- 
2.20.1

