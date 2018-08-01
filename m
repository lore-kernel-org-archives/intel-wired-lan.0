From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 31 Jul 2018 20:47:25 -0700
Subject: [Intel-wired-lan] [PATCH v3 09/13] ice: Set VLAN flags correctly
In-Reply-To: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
References: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180801034729.3864-10-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Set the ICE_AQ_VSI_PVLAN_MODE_ALL bit to allow the driver to add a VLAN
tag to all packets it sends.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3eff1d2d1543..989d5fc4d410 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3775,6 +3775,9 @@ static int ice_vsi_manage_vlan_stripping(struct ice_vsi *vsi, bool ena)
 		ctxt.info.port_vlan_flags = ICE_AQ_VSI_PVLAN_EMOD_NOTHING;
 	}
 
+	/* Allow all packets untagged/tagged */
+	ctxt.info.port_vlan_flags |= ICE_AQ_VSI_PVLAN_MODE_ALL;
+
 	ctxt.info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID);
 	ctxt.vsi_num = vsi->vsi_num;
 
-- 
2.17.1

