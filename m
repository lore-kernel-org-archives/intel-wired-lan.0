From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  3 Sep 2019 01:31:04 -0700
Subject: [Intel-wired-lan] [PATCH S28 v2 5/9] ice: update Tx context struct
In-Reply-To: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
Message-ID: <20190903083108.19593-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ashish Shah <ashish.n.shah@intel.com>

Add internal usage flag, bit 91 as described in spec.
Update width of internal queue state to 122 also as described in spec.

Signed-off-by: Ashish Shah <ashish.n.shah@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c    | 3 ++-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9492cd34b09d..e8397e5b6267 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1132,6 +1132,7 @@ const struct ice_ctx_ele ice_tlan_ctx_info[] = {
 	ICE_CTX_STORE(ice_tlan_ctx, vmvf_type,			2,	78),
 	ICE_CTX_STORE(ice_tlan_ctx, src_vsi,			10,	80),
 	ICE_CTX_STORE(ice_tlan_ctx, tsyn_ena,			1,	90),
+	ICE_CTX_STORE(ice_tlan_ctx, internal_usage_flag,	1,	91),
 	ICE_CTX_STORE(ice_tlan_ctx, alt_vlan,			1,	92),
 	ICE_CTX_STORE(ice_tlan_ctx, cpuid,			8,	93),
 	ICE_CTX_STORE(ice_tlan_ctx, wb_mode,			1,	101),
@@ -1150,7 +1151,7 @@ const struct ice_ctx_ele ice_tlan_ctx_info[] = {
 	ICE_CTX_STORE(ice_tlan_ctx, drop_ena,			1,	165),
 	ICE_CTX_STORE(ice_tlan_ctx, cache_prof_idx,		2,	166),
 	ICE_CTX_STORE(ice_tlan_ctx, pkt_shaper_prof_idx,	3,	168),
-	ICE_CTX_STORE(ice_tlan_ctx, int_q_state,		110,	171),
+	ICE_CTX_STORE(ice_tlan_ctx, int_q_state,		122,	171),
 	{ 0 }
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 57ea6811fe2c..2aac8f13daeb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -428,6 +428,7 @@ struct ice_tlan_ctx {
 #define ICE_TLAN_CTX_VMVF_TYPE_PF	2
 	u16 src_vsi;
 	u8 tsyn_ena;
+	u8 internal_usage_flag;
 	u8 alt_vlan;
 	u16 cpuid;		/* bigger than needed, see above for reason */
 	u8 wb_mode;
-- 
2.20.1

