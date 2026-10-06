Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0DDCA5FFF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 11:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94ECE80859;
	Tue,  6 Oct 2026 11:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpDtygNcV0eN; Tue,  6 Oct 2026 11:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 80E968085D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791286990;
	b=pbnS+mxlJhXu1holRVamNWcqKEFK2A7I2Tr41ijDl05XHz5x81LTVaxsSre7OvQOQD5l
	 RGYfEbwl5ZJkGIig/e/MfI0mfcu80AEEFyVuwG1VEwtx0ksruI0hm9NaSK9virDuxVMaV
	 FxuWknXflSi/SZuAOulGqafsSv/t8Hdu37O82sCTX4WKeshPbbTQpO827QrRsX+g7c4hz
	 3T3Cx7O1o1xJONoR1c761GZkmX3T8lmGhKGB1dm/uarkbpQCS7t7uMZe6vLJR1jmYfSoG
	 XoMcOJ9AeOXj/wHqqzQ3AqZIgIDylWbP4ljAF26n6VaShqUvqN3TGNeU+sUx8wGX5tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791286990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WR2i4XvWq9oewSPWo+G//NXJTqcDNLUlZ+T7UZTdU8w=;
	b=ErppUlXM+ECstJr7BTX087e0n51+mINRUhhL+TXdNuESY4vPaO19udMO9d5mYIeuP3Vh
	 TnVe3eTlzLKcnCwaJvHL1yv42g60IsM+rr64QIzJdg6KzFru27AOg1zvGK75RjuZ5R2J2
	 jSV6RHAH/LFKSgSRNbWwEpS1gzp8PxIQYg2olTrGhsGeQ4DfnmPWersta7HjqQV/dpsbc
	 ZJrizRHEyh4lx9pc0SZ81Zo51V4mvqrjZy3BsjRa12qL654nXMGjusmgCGT2c2VS9lZ1M
	 C0NFiU/6yp8zSb7dBx+4WSWJ4DtJqRTxG8ezfU+itUVLXUkJK8HHRxlRI5h/nJnMRfw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791286990;
	bh=WR2i4XvWq9oewSPWo+G//NXJTqcDNLUlZ+T7UZTdU8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s2GbQziK2LFTRSD0ZKnRYjRZiBw50D6rK92pNfsPV3rFNjt+k+7GP0zblku0b0Qt6
	 WS/csbsAkw8by7tfdpdpQUs8yN+JlZZ0rtP3zT06GAMwVbgQnGrcOxSV4nSEWk7s0q
	 YPxmr+zKBTc63NVSAuYUoofl8GhsCVh+Fwjtz6K3dR1XH/ZD1RG7XGP5GM90qIg7vj
	 LcAm6MgVEGrxm2w3d4OT8bcbck2vTC6WSVXWXXxgMJ4z9+TPDHOZSa0jq6G3zvLa90
	 sJrS/Mx3aaWI3adet3bq4vaDuNN2HPEOtK+KCKFksej6po3+q2ggrBtc6Pzi+nP55U
	 ZokRTYW4tDlpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80E968085D;
	Tue,  6 Oct 2026 11:43:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B871B32F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E46860782
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeW_ZhT2p_8F for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 11:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8200860716
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791286251;
 b=XA/O1SMztWP1uN4M7po/K1wNUQFuKEhusROkrzbffPnGTBMpTNEIdlNdDD14nlTuxzmQ
 zy+0aKGbmG6N6Z2aiFmUIX/c6L4m5rC5wogVVnIbRjrPW0sqyEUBM/LhJqty40nl4JHNN
 cHP8rH/Q8YARHnKa/ifv5zIDXUYEObQs3aTYN2RieFiVwEzkcDgRxKW2iaGzZGrr8M/Ll
 R9mbxVCeyh0oXy37sSjPxGzAhGJP1eNzvXFglusgzJHtq1t0UyumSkf3Aie1UiDQ/0Ddp
 nQkX3Ex0LuoPBCxAwekb3w00lqd7Pz1gQAEtXRIU9UlKy6HGqJUaGKN97Ps25cHnRWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791286251;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WR2i4XvWq9oewSPWo+G//NXJTqcDNLUlZ+T7UZTdU8w=;
 b=ZA0V37kS+eFwj9yrp9DOif/zHIatV/q/xkoMpUXpRqu9uwvKo9NsuF41UKzZLZNueL1L
 iT4/NJuul0lLkAD+12QL5YUMar5wUF3pOgA0txt11mUL7OCtpbhdpoOFHjxeGxE1iNn2C
 Dk/WgXrFTGLct9iXKGWKieKS33lXL2Q69UErmqsUl1hyBf9KnBu/t4IJnbDKa0rQX1ib2
 iYwL4LKdy04Wyh2Blw1JnwyyIvJ47isTj5MPjE980XZBW5DzN41ETh04p6fXThmlcWDZq
 0v+TMphbyHay6StT84ZMpPnAq42NAR2HSpgnB4AN2yJp7wvXANPGK/KPXF1abWy+Veg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=P6JT+ARV; 
 arc=none smtp.remote-ip=192.198.163.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=P6JT+ARV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8200860716
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791286251; x=1822822251;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uSXPbvmTL5Vil7RTORuGSlSrAtKzCHg57rjSeMGZ8zs=;
 b=P6JT+ARVdkR0e3AyHNMTpPvFwjwtqCoS0uLvDl0oXpmJG8hyche8fMU1
 sJDdnxfJ9829RUUlsMSsDNFc+YJCLRszbQ1rZ0Gu450QAVfyX7oY0fDz7
 aKRsIshF0KAlSzUpsILavin/pWoe8s4NSfVIi26voqe1ohlE8n3Y7tQUH
 OyOvEbZZJS1URJIadbZsWW7duUDjXXqo0gK5bwhWnjSqOPFKD11Pc+sUC
 zYVVF7TPP7C7en1QfPhBaBqvHAdJs5MTzJGZYpLqRXWBn6t6X98KORN9x
 uoyoOY1mrQAyuV2qATmHuPnMh56knbKOFXkmuglUaxZKPcfjEijIM95EI Q==;
X-CSE-ConnectionGUID: l4oHrndkQQyJHJqcnnYF/Q==
X-CSE-MsgGUID: PxhGlNPkQx69/06Hi80dLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="27713"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="27713"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:30:51 -0700
X-CSE-ConnectionGUID: IsWobg5BSCaG019E01gyGA==
X-CSE-MsgGUID: WTKAaEQ9QzipREWECSyMKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280370491"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 04:30:50 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 2/2] ice: allow matching on no_frag ip packets
Date: Tue,  6 Oct 2026 12:47:04 +0200
Message-ID: <20261006104704.3584666-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261006104704.3584666-1-michal.swiatkowski@linux.intel.com>
References: <20261006104704.3584666-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

There is a metadata flag telling whether a packet is fragmented. It
covers both ipv4 and ipv6 fragments. Use it to offload the "not
fragmented" case.

Offloading the fragmented case isn't that simple, as it needs changes
in the training packets. For ipv4 a bit has to be set in the header,
but for ipv6 an additional header is needed. A packet fragmented like
that results in an incorrect parser result for L4 matching. Because of
that, leave only support for no_frag.

The flag is set for a fragment in either the outer or the inner header
and there is no way to tell the two apart. Reject the match on
tunneled filters then, so that there is always one IP header.
PFCP is excluded from that, as it is considered non-tunneled and its
headers aren't swapped.

Non-tunneled filters are programmed with ICE_NON_TUN, so encapsulated
traffic is matched by tunnel profiles only and can't reach these rules.

Example tc command:
$ tc filter add dev ens786f1r1 ingress protocol ip prio 1 flower \
    src_mac 0a:7a:c1:6b:8e:1c \
    dst_mac be:9d:68:58:51:d8 \
    ip_flags nofrag \
    skip_sw \
    action mirred egress redirect dev ens786f1r0

OVS in default mode is adding this kind of filter, so without this
match the ip flows weren't offloaded to HW. With this change, running
iperf traffic between OVS bridge ports results in offloading all
packets.

Assisted-by: Copilot:claude-opus-5
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../ethernet/intel/ice/ice_protocol_type.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |  7 ++++
 drivers/net/ethernet/intel/ice/ice_switch.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 35 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |  1 +
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index 725167d557a8..3a3b66a8ec1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -356,6 +356,7 @@ struct ice_nvgre_hdr {
 #define ICE_PKT_TUNNEL_MAC	BIT(6)
 #define ICE_PKT_TUNNEL_VLAN	BIT(7)
 #define ICE_PKT_TUNNEL_MASK	(ICE_PKT_TUNNEL_MAC | ICE_PKT_TUNNEL_VLAN)
+#define ICE_PKT_IS_FRAG		BIT(8)
 
 /* MDID 22
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 4daee252e2a6..060a271be0f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6009,6 +6009,13 @@ void ice_rule_add_direction_metadata(struct ice_adv_lkup_elem *lkup)
 		cpu_to_be16(ICE_PKT_FROM_NETWORK);
 }
 
+void ice_rule_add_nofrag_metadata(struct ice_adv_lkup_elem *lkup)
+{
+	lkup->type = ICE_HW_METADATA;
+	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_MDID21] |=
+		cpu_to_be16(ICE_PKT_IS_FRAG);
+}
+
 void ice_rule_add_vlan_metadata(struct ice_adv_lkup_elem *lkup)
 {
 	lkup->type = ICE_HW_METADATA;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 671d7a5f359f..b282c476d6b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -347,6 +347,7 @@ int ice_share_res(struct ice_hw *hw, u16 type, u8 shared, u16 res_id);
 /* Switch/bridge related commands */
 void ice_rule_add_tunnel_metadata(struct ice_adv_lkup_elem *lkup);
 void ice_rule_add_direction_metadata(struct ice_adv_lkup_elem *lkup);
+void ice_rule_add_nofrag_metadata(struct ice_adv_lkup_elem *lkup);
 void ice_rule_add_vlan_metadata(struct ice_adv_lkup_elem *lkup);
 void ice_rule_add_src_vsi_metadata(struct ice_adv_lkup_elem *lkup);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 560d939b2008..d90a9b52cd5b 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -24,6 +24,7 @@ static int ice_tc_count_lkups(u64 flags, struct ice_tc_flower_fltr *fltr)
 	 * - Direction flag (always present)
 	 * - ICE_TC_FLWR_FIELD_VLAN_TPID (present if specified)
 	 * - Tunnel flag (present if tunnel)
+	 * - ICE_TC_FLWR_FIELD_NOFRAG (present if specified)
 	 */
 	if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS)
 		lkups_cnt++;
@@ -385,6 +386,9 @@ ice_tc_fill_rules(struct ice_hw *hw, u64 flags,
 	/* Always add direction metadata */
 	ice_rule_add_direction_metadata(&list[ICE_TC_METADATA_LKUP_IDX]);
 
+	if (flags & ICE_TC_FLWR_FIELD_NOFRAG)
+		ice_rule_add_nofrag_metadata(&list[ICE_TC_METADATA_LKUP_IDX]);
+
 	if (tc_fltr->direction == ICE_ESWITCH_FLTR_EGRESS) {
 		ice_rule_add_src_vsi_metadata(&list[i]);
 		i++;
@@ -1876,9 +1880,36 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 
 		addr_type = match.key->addr_type;
 
-		if (flow_rule_has_control_flags(match.mask->flags,
-						fltr->extack))
+		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT,
+						     match.mask->flags,
+						     fltr->extack))
 			return -EOPNOTSUPP;
+
+		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
+			/* HW can only match on the "not fragmented" metadata
+			 * flag, there is no way to match fragments.
+			 */
+			if (match.key->flags & FLOW_DIS_IS_FRAGMENT) {
+				NL_SET_ERR_MSG_MOD(fltr->extack,
+						   "Match on fragmented packets is not supported");
+				return -EOPNOTSUPP;
+			}
+
+			/* The metadata flag is set for a fragment in either
+			 * the outer or the inner header, without a way to
+			 * tell which one. Allow the match only when there is
+			 * one IP header and one ip_flags, so the meaning is
+			 * unambiguous. PFCP is considered non-tunneled.
+			 */
+			if (fltr->tunnel_type != TNL_LAST &&
+			    fltr->tunnel_type != TNL_PFCP) {
+				NL_SET_ERR_MSG_MOD(fltr->extack,
+						   "Match on fragmentation of tunneled packets is not supported");
+				return -EOPNOTSUPP;
+			}
+
+			fltr->flags |= ICE_TC_FLWR_FIELD_NOFRAG;
+		}
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 234cc9bafc41..326358cc5884 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -39,6 +39,7 @@
 #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT_ULL(29)
 #define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT_ULL(30)
 #define ICE_TC_FLWR_FIELD_IP_PROTO		BIT_ULL(31)
+#define ICE_TC_FLWR_FIELD_NOFRAG		BIT_ULL(32)
 
 #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
 
-- 
2.49.0

