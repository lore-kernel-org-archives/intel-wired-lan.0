From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:02 -0800
Subject: [Intel-wired-lan] [PATCH S15 02/14] ice: enable VF admin queue
 interrupts
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The VPINT_MBX_CTL register array must be programmed to enable VF admin
queue interrupts. Without this, VFs never get interrupts on vector 0,
and some VF drivers will fail to init.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  | 2 ++
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 24255ff64ab0..af6f32358363 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -178,6 +178,8 @@
 #define VPINT_ALLOC_PCI_LAST_S			12
 #define VPINT_ALLOC_PCI_LAST_M			ICE_M(0x7FF, 12)
 #define VPINT_ALLOC_PCI_VALID_M			BIT(31)
+#define VPINT_MBX_CTL(_VSI)			(0x0016A000 + ((_VSI) * 4))
+#define VPINT_MBX_CTL_CAUSE_ENA_M		BIT(30)
 #define GLLAN_RCTL_0				0x002941F8
 #define QRX_CONTEXT(_i, _QRX)			(0x00280000 + ((_i) * 8192 + (_QRX) * 4))
 #define QRX_CTRL(_QRX)				(0x00120000 + ((_QRX) * 4))
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index e2517ab696e9..7a4f86ad8149 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -604,6 +604,10 @@ static void ice_ena_vf_mappings(struct ice_vf *vf)
 		wr32(hw, GLINT_VECT2FUNC(v), reg);
 	}
 
+	/* Map mailbox interrupt. We put an explicit 0 here to remind us that
+	 * VF admin queue interrupts will go to VF MSI-X vector 0.
+	 */
+	wr32(hw, VPINT_MBX_CTL(abs_vf_id), VPINT_MBX_CTL_CAUSE_ENA_M | 0);
 	/* set regardless of mapping mode */
 	wr32(hw, VPLAN_TXQ_MAPENA(vf->vf_id), VPLAN_TXQ_MAPENA_TX_ENA_M);
 
-- 
2.14.5

