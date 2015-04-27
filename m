From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:15 -0400
Subject: [Intel-wired-lan] [net-next S5 08/15] i40e: un-disable VF after
	reset
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When a VF is disabled, there is no way for it to recover until either
the PF driver is reloaded or SR-IOV is disabled and enabled. To correct
this, enable the VF after a successful reset.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I9e0788476c4d53d5407961b503febdfff2b8a7c6
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 008ab29..b639510 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -832,6 +832,7 @@ complete_reset:
 	i40e_alloc_vf_res(vf);
 	i40e_enable_vf_mappings(vf);
 	set_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states);
+	clear_bit(I40E_VF_STAT_DISABLED, &vf->vf_states);
 
 	/* tell the VF the reset is done */
 	wr32(hw, I40E_VFGEN_RSTAT1(vf->vf_id), I40E_VFR_VFACTIVE);
-- 
1.9.3

