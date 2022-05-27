From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Fri, 27 May 2022 13:51:31 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: disable stripping in default VSI
 ctx
Message-ID: <20220527115131.7413-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In case when driver is in eswitch mode, having VLAN stripping enabled
causes failure in communication. All VLAN configuration commands are
blocked, because of that VF driver can't disable VLAN stripping at
initialization. It leads to the situation when VLAN stripping on VF VSI
is on, but in kernel it is off.

To prevent this, set VLAN stripping to disabled in VSI initialization.
It doesn't break other usecases, because it is set according to kernel
settings.

Fixes: f09901aa554a ("ice: remove VLAN representor specific ops")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 70961c0343e7..b28fb8eacffb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -887,6 +887,9 @@ static void ice_set_dflt_vsi_ctx(struct ice_hw *hw, struct ice_vsi_ctx *ctxt)
 			(ICE_AQ_VSI_OUTER_TAG_VLAN_8100 <<
 			 ICE_AQ_VSI_OUTER_TAG_TYPE_S) &
 			ICE_AQ_VSI_OUTER_TAG_TYPE_M;
+		ctxt->info.outer_vlan_flags |=
+			FIELD_PREP(ICE_AQ_VSI_OUTER_VLAN_EMODE_M,
+				   ICE_AQ_VSI_OUTER_VLAN_EMODE_NOTHING);
 	}
 	/* Have 1:1 UP mapping for both ingress/egress tables */
 	table |= ICE_UP_TABLE_TRANSLATE(0, 0);
-- 
2.35.1

