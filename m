From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Thu, 27 Jan 2022 16:40:08 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next 3/4] ice: switch: use a struct
 to pass packet template params
In-Reply-To: <20220127154009.623304-1-alexandr.lobakin@intel.com>
References: <20220127154009.623304-1-alexandr.lobakin@intel.com>
Message-ID: <20220127154009.623304-4-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_find_dummy_packet() contains a lot of boilerplate code and a
nice room for copy-paste mistakes.
Instead of passing 3 separate pointers back and forth to get packet
template (dummy) params, directly return a structure containing
them. Then, use a macro to compose compound literals and avoid code
duplication on return path.
Now, dummy packet type/name is needed only once to return a full
correct triple pkt-pkt_len-offsets, and those are all one-liners.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 173 +++++++-------------
 1 file changed, 62 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index b6b6e8f5d358..68202671a114 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -35,6 +35,20 @@ struct ice_dummy_pkt_offsets {
 	u16 offset; /* ICE_PROTOCOL_LAST indicates end of list */
 };
 
+struct ice_dummy_pkt_profile {
+	const struct ice_dummy_pkt_offsets *offsets;
+	const u8 *pkt;
+	u16 pkt_len;
+};
+
+#define ICE_PKT_PROFILE(type) ({					\
+	(struct ice_dummy_pkt_profile){					\
+		.pkt		= dummy_##type##_packet,		\
+		.pkt_len	= sizeof(dummy_##type##_packet),	\
+		.offsets	= dummy_##type##_packet_offsets,	\
+	};								\
+})
+
 static const struct ice_dummy_pkt_offsets dummy_gre_tcp_packet_offsets[] = {
 	{ ICE_MAC_OFOS,		0 },
 	{ ICE_ETYPE_OL,		12 },
@@ -5035,15 +5049,12 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
  *	   structure per protocol header
  * @lkups_cnt: number of protocols
  * @tun_type: tunnel type
- * @pkt: dummy packet to fill according to filter match criteria
- * @pkt_len: packet length of dummy packet
- * @offsets: pointer to receive the pointer to the offsets for the packet
+ *
+ * Returns the &ice_dummy_pkt_profile corresponding to these lookup params.
  */
-static void
+static struct ice_dummy_pkt_profile
 ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
-		      enum ice_sw_tunnel_type tun_type,
-		      const u8 **pkt, u16 *pkt_len,
-		      const struct ice_dummy_pkt_offsets **offsets)
+		      enum ice_sw_tunnel_type tun_type)
 {
 	bool tcp = false, udp = false, ipv6 = false, vlan = false;
 	bool ipv6_il = false;
@@ -5073,100 +5084,49 @@ ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 	}
 
 	if (tun_type == ICE_SW_TUN_NVGRE) {
-		if (tcp && ipv6_il) {
-			*pkt = dummy_gre_ipv6_tcp_packet;
-			*pkt_len = sizeof(dummy_gre_ipv6_tcp_packet);
-			*offsets = dummy_gre_ipv6_tcp_packet_offsets;
-			return;
-		}
-		if (tcp) {
-			*pkt = dummy_gre_tcp_packet;
-			*pkt_len = sizeof(dummy_gre_tcp_packet);
-			*offsets = dummy_gre_tcp_packet_offsets;
-			return;
-		}
-		if (ipv6_il) {
-			*pkt = dummy_gre_ipv6_udp_packet;
-			*pkt_len = sizeof(dummy_gre_ipv6_udp_packet);
-			*offsets = dummy_gre_ipv6_udp_packet_offsets;
-			return;
-		}
-		*pkt = dummy_gre_udp_packet;
-		*pkt_len = sizeof(dummy_gre_udp_packet);
-		*offsets = dummy_gre_udp_packet_offsets;
-		return;
+		if (tcp && ipv6_il)
+			return ICE_PKT_PROFILE(gre_ipv6_tcp);
+		else if (tcp)
+			return ICE_PKT_PROFILE(gre_tcp);
+		else if (ipv6_il)
+			return ICE_PKT_PROFILE(gre_ipv6_udp);
+		else
+			return ICE_PKT_PROFILE(gre_udp);
 	}
 
 	if (tun_type == ICE_SW_TUN_VXLAN ||
 	    tun_type == ICE_SW_TUN_GENEVE) {
-		if (tcp && ipv6_il) {
-			*pkt = dummy_udp_tun_ipv6_tcp_packet;
-			*pkt_len = sizeof(dummy_udp_tun_ipv6_tcp_packet);
-			*offsets = dummy_udp_tun_ipv6_tcp_packet_offsets;
-			return;
-		}
-		if (tcp) {
-			*pkt = dummy_udp_tun_tcp_packet;
-			*pkt_len = sizeof(dummy_udp_tun_tcp_packet);
-			*offsets = dummy_udp_tun_tcp_packet_offsets;
-			return;
-		}
-		if (ipv6_il) {
-			*pkt = dummy_udp_tun_ipv6_udp_packet;
-			*pkt_len = sizeof(dummy_udp_tun_ipv6_udp_packet);
-			*offsets = dummy_udp_tun_ipv6_udp_packet_offsets;
-			return;
-		}
-		*pkt = dummy_udp_tun_udp_packet;
-		*pkt_len = sizeof(dummy_udp_tun_udp_packet);
-		*offsets = dummy_udp_tun_udp_packet_offsets;
-		return;
+		if (tcp && ipv6_il)
+			return ICE_PKT_PROFILE(udp_tun_ipv6_tcp);
+		else if (tcp)
+			return ICE_PKT_PROFILE(udp_tun_tcp);
+		else if (ipv6_il)
+			return ICE_PKT_PROFILE(udp_tun_ipv6_udp);
+		else
+			return ICE_PKT_PROFILE(udp_tun_udp);
 	}
 
 	if (udp && !ipv6) {
-		if (vlan) {
-			*pkt = dummy_vlan_udp_packet;
-			*pkt_len = sizeof(dummy_vlan_udp_packet);
-			*offsets = dummy_vlan_udp_packet_offsets;
-			return;
-		}
-		*pkt = dummy_udp_packet;
-		*pkt_len = sizeof(dummy_udp_packet);
-		*offsets = dummy_udp_packet_offsets;
-		return;
+		if (vlan)
+			return ICE_PKT_PROFILE(vlan_udp);
+		else
+			return ICE_PKT_PROFILE(udp);
 	} else if (udp && ipv6) {
-		if (vlan) {
-			*pkt = dummy_vlan_udp_ipv6_packet;
-			*pkt_len = sizeof(dummy_vlan_udp_ipv6_packet);
-			*offsets = dummy_vlan_udp_ipv6_packet_offsets;
-			return;
-		}
-		*pkt = dummy_udp_ipv6_packet;
-		*pkt_len = sizeof(dummy_udp_ipv6_packet);
-		*offsets = dummy_udp_ipv6_packet_offsets;
-		return;
+		if (vlan)
+			return ICE_PKT_PROFILE(vlan_udp_ipv6);
+		else
+			return ICE_PKT_PROFILE(udp_ipv6);
 	} else if ((tcp && ipv6) || ipv6) {
-		if (vlan) {
-			*pkt = dummy_vlan_tcp_ipv6_packet;
-			*pkt_len = sizeof(dummy_vlan_tcp_ipv6_packet);
-			*offsets = dummy_vlan_tcp_ipv6_packet_offsets;
-			return;
-		}
-		*pkt = dummy_tcp_ipv6_packet;
-		*pkt_len = sizeof(dummy_tcp_ipv6_packet);
-		*offsets = dummy_tcp_ipv6_packet_offsets;
-		return;
+		if (vlan)
+			return ICE_PKT_PROFILE(vlan_tcp_ipv6);
+		else
+			return ICE_PKT_PROFILE(tcp_ipv6);
 	}
 
-	if (vlan) {
-		*pkt = dummy_vlan_tcp_packet;
-		*pkt_len = sizeof(dummy_vlan_tcp_packet);
-		*offsets = dummy_vlan_tcp_packet_offsets;
-	} else {
-		*pkt = dummy_tcp_packet;
-		*pkt_len = sizeof(dummy_tcp_packet);
-		*offsets = dummy_tcp_packet_offsets;
-	}
+	if (vlan)
+		return ICE_PKT_PROFILE(vlan_tcp);
+
+	return ICE_PKT_PROFILE(tcp);
 }
 
 /**
@@ -5176,15 +5136,12 @@ ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
  *	   structure per protocol header
  * @lkups_cnt: number of protocols
  * @s_rule: stores rule information from the match criteria
- * @dummy_pkt: dummy packet to fill according to filter match criteria
- * @pkt_len: packet length of dummy packet
- * @offsets: offset info for the dummy packet
+ * @profile: dummy packet profile (the template, its size and header offsets)
  */
 static int
 ice_fill_adv_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 			  struct ice_aqc_sw_rules_elem *s_rule,
-			  const u8 *dummy_pkt, u16 pkt_len,
-			  const struct ice_dummy_pkt_offsets *offsets)
+			  const struct ice_dummy_pkt_profile *profile)
 {
 	u8 *pkt;
 	u16 i;
@@ -5194,9 +5151,10 @@ ice_fill_adv_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 	 */
 	pkt = s_rule->pdata.lkup_tx_rx.hdr;
 
-	memcpy(pkt, dummy_pkt, pkt_len);
+	memcpy(pkt, profile->pkt, profile->pkt_len);
 
 	for (i = 0; i < lkups_cnt; i++) {
+		const struct ice_dummy_pkt_offsets *offsets = profile->offsets;
 		enum ice_protocol_type type;
 		u16 offset = 0, len = 0, j;
 		bool found = false;
@@ -5277,7 +5235,7 @@ ice_fill_adv_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 		}
 	}
 
-	s_rule->pdata.lkup_tx_rx.hdr_len = cpu_to_le16(pkt_len);
+	s_rule->pdata.lkup_tx_rx.hdr_len = cpu_to_le16(profile->pkt_len);
 
 	return 0;
 }
@@ -5500,12 +5458,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		 struct ice_rule_query_data *added_entry)
 {
 	struct ice_adv_fltr_mgmt_list_entry *m_entry, *adv_fltr = NULL;
-	u16 rid = 0, i, pkt_len, rule_buf_sz, vsi_handle;
-	const struct ice_dummy_pkt_offsets *pkt_offsets;
 	struct ice_aqc_sw_rules_elem *s_rule = NULL;
+	u16 rid = 0, i, rule_buf_sz, vsi_handle;
+	struct ice_dummy_pkt_profile profile;
 	struct list_head *rule_head;
 	struct ice_switch_info *sw;
-	const u8 *pkt = NULL;
 	u16 word_cnt;
 	u32 act = 0;
 	int status;
@@ -5533,13 +5490,8 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	if (!word_cnt || word_cnt > ICE_MAX_CHAIN_WORDS)
 		return -EINVAL;
 
-	/* make sure that we can locate a dummy packet */
-	ice_find_dummy_packet(lkups, lkups_cnt, rinfo->tun_type, &pkt, &pkt_len,
-			      &pkt_offsets);
-	if (!pkt) {
-		status = -EINVAL;
-		goto err_ice_add_adv_rule;
-	}
+	/* locate a dummy packet */
+	profile = ice_find_dummy_packet(lkups, lkups_cnt, rinfo->tun_type);
 
 	if (!(rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI ||
 	      rinfo->sw_act.fltr_act == ICE_FWD_TO_Q ||
@@ -5580,7 +5532,7 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		}
 		return status;
 	}
-	rule_buf_sz = ICE_SW_RULE_RX_TX_NO_HDR_SIZE + pkt_len;
+	rule_buf_sz = ICE_SW_RULE_RX_TX_NO_HDR_SIZE + profile.pkt_len;
 	s_rule = kzalloc(rule_buf_sz, GFP_KERNEL);
 	if (!s_rule)
 		return -ENOMEM;
@@ -5640,8 +5592,7 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	s_rule->pdata.lkup_tx_rx.recipe_id = cpu_to_le16(rid);
 	s_rule->pdata.lkup_tx_rx.act = cpu_to_le32(act);
 
-	status = ice_fill_adv_dummy_packet(lkups, lkups_cnt, s_rule, pkt,
-					   pkt_len, pkt_offsets);
+	status = ice_fill_adv_dummy_packet(lkups, lkups_cnt, s_rule, &profile);
 	if (status)
 		goto err_ice_add_adv_rule;
 
@@ -5649,7 +5600,7 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	    rinfo->tun_type != ICE_SW_TUN_AND_NON_TUN) {
 		status = ice_fill_adv_packet_tun(hw, rinfo->tun_type,
 						 s_rule->pdata.lkup_tx_rx.hdr,
-						 pkt_offsets);
+						 profile.offsets);
 		if (status)
 			goto err_ice_add_adv_rule;
 	}
-- 
2.34.1

