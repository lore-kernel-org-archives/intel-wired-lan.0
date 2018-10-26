From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:36 -0700
Subject: [Intel-wired-lan] [PATCH S9 04/15] ice: Destroy scheduler tree in
 reset path
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

The scheduler tree is is always rebuilt during reset. The existing code
adds new scheduler nodes for queues but may not clean up earlier nodes.
This patch removed the old scheduler tree during reset before it is
rebuilt.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 597005f39919..53685a66125b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2551,6 +2551,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi)
 		return -EINVAL;
 
 	pf = vsi->back;
+	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
 	ice_vsi_free_q_vectors(vsi);
 	ice_free_res(vsi->back->sw_irq_tracker, vsi->sw_base_vector, vsi->idx);
 	ice_free_res(vsi->back->hw_irq_tracker, vsi->hw_base_vector, vsi->idx);
-- 
2.14.3

