From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 29 Jul 2019 02:04:45 -0700
Subject: [Intel-wired-lan] [PATCH S24 v2 03/12] ice: Don't call
 synchronize_irq() for VF's from the host
In-Reply-To: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
Message-ID: <20190729090454.5501-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we will call synchronize_irq() from the host for VF's. This is
not correct, so don't allow it.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 6b5882c49004..42645c074691 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2837,6 +2837,10 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
 
 	ice_flush(hw);
 
+	/* don't call synchronize_irq() for VF's from the host */
+	if (vsi->type == ICE_VSI_VF)
+		return;
+
 	ice_for_each_q_vector(vsi, i)
 		synchronize_irq(pf->msix_entries[i + base].vector);
 }
-- 
2.20.1

