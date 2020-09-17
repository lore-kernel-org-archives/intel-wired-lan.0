From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 17 Sep 2020 13:13:37 -0700
Subject: [Intel-wired-lan] [PATCH S53 05/15] ice: Set trusted VF as default
 VSI when setting allmulti on
In-Reply-To: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
Message-ID: <20200917201347.81570-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the PF will only set a trusted VF as the default VSI when it
requests FLAG_VF_UNICAST_PROMISC over VIRTCHNL. However, when
FLAG_VF_MULTICAST_PROMISC is set it's expected that the trusted VF will
see multicast packets that don't have a matching destination MAC in the
devices internal switch. Fix this by setting the trusted VF as the
default VSI if either FLAG_VF_UNICAST_PROMISC or
FLAG_VF_MULTICAST_PROMISC is set.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 35ed71694d44..0478d8892f80 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2382,7 +2382,7 @@ static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 	}
 
 	if (!test_bit(ICE_FLAG_VF_TRUE_PROMISC_ENA, pf->flags)) {
-		bool set_dflt_vsi = !!(info->flags & FLAG_VF_UNICAST_PROMISC);
+		bool set_dflt_vsi = alluni || allmulti;
 
 		if (set_dflt_vsi && !ice_is_dflt_vsi_in_use(pf->first_sw))
 			/* only attempt to set the default forwarding VSI if
-- 
2.20.1

