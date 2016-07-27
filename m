From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 27 Jul 2016 12:02:31 -0700
Subject: [Intel-wired-lan] [next PATCH S40-V2 02/12] i40e/i40evf: Reset vlan
	filter count when resetting
In-Reply-To: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469646161-30024-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

When we do a reset, all the vlan filters get added again. Therefore we also
want to reset the vlan count to 0 or we quickly run out of filters.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I459f26851e22204dc8b8999928ad87cde8170119
---
Testing Hints: Make sure that you don't run out of filters when doing
multiple resets.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 6fcbf76..0fa050a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -992,6 +992,7 @@ complete_reset:
 		set_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states);
 		clear_bit(I40E_VF_STAT_DISABLED, &vf->vf_states);
 		i40e_notify_client_of_vf_reset(pf, abs_vf_id);
+		vf->num_vlan = 0;
 	}
 	/* tell the VF the reset is done */
 	wr32(hw, I40E_VFGEN_RSTAT1(vf->vf_id), I40E_VFR_VFACTIVE);
-- 
2.4.11

