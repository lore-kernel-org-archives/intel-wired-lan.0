Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A080FCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 11:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 558F240500;
	Tue,  6 Oct 2026 11:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id exdaY5awc5Hz; Tue,  6 Oct 2026 11:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73566404FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791286989;
	b=GUjGyMPFe05lGmFOeA/yOfsBgMseNkLyyBw+sxvLj0iY59lv98yZXe1NGh+pxbHERbFb
	 zcWCy3E9uBTyCG7JfYlR3sNr8f0mgufAAFVEn6lpNOzwwfbPPPxb30eJVTm0qf7J9B7D8
	 1ZvZRkJtWtLqTELrXhn9QXoXaTqsoGXTmfV2igKbzCI7S+4ZOuoe9lrMO95h/q9gYzlwR
	 mMTJLEXkXHQ3o1OLAVAqSUywojP+H/ucMlYHZl4+Mukdd6X24BYzQtauY7qQgHPuSJaTG
	 rJZXe6Br3JKwotM2I8ebV0NiZ3EIlDFAvKSbnnDbRsaM7zwejmGFWpjzv4IWs9Cu1mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791286989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E2dxbiqZsmOX24/CL3AzYC3sBleX40bNMJFODwQmelQ=;
	b=VUV46sDu6BtywbGaWsJtyFrJQikTpl+r4dYFQxX3xyBZL+UyMoNApVQQ65QdcDhHdWb5
	 zsFq3sxfu1CuVbJjZ9U7UI2yic0Bx1hLPwhDaazJkPYH7YHL5QWFT+EiKqTrME3WR05EM
	 hb2yetr2IYnYEPOCaTYMgtaXycDYorj8z9y4OTzhLuKgY5KcSJwtNNM1M0DAmdvMRpXTR
	 t9jilxxU/GImATpvyNnSs/d7F6WyfLEaWll3sGlK+oA6Jg2Wut4wjmsuoIttN84p0ayL9
	 G3IZGy3ltMAyfVJ1n45/V6yERIMagvSSWh0re0grNlYTvCV/nwD0udhptkjhe4o+7tA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791286989;
	bh=E2dxbiqZsmOX24/CL3AzYC3sBleX40bNMJFODwQmelQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=17OYmOiuqU3jNv6lzyjST6rO9tWjuqyertAhD74tqyeRWZAnisMCndtXOQeZ3DT8I
	 SbAseE2vdgPsVQ0ss/RU5raZEtZROoyxjStjDwjAzvdttApqagrYsp5qfLwEL00wzF
	 D/Gcsvh50tGQmREGtISlpwSLdlWK3CP/bcyEE3Bd08zUNR5r+UmlJdZTkwwIM2Bltb
	 U0ownvx1r1wsoQQr18cH3Wnf4xPJhj6fO+2CGBiJ+hofxg3PktfIfm0GCFpwDUJNi8
	 UN/tnTvSMh0GYfSLyRWRyY6fyKMGY5RsfVjBLjEMwjb/l/f7GZFQPB64CieFtbx/L6
	 Qhez/VwuyWMHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73566404FF;
	Tue,  6 Oct 2026 11:43:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C854075
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B946360778
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SPGY6nPNsPkr for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 11:30:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8BC0560782
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791286250;
 b=oHvD6+emfaa8JLjPFJtl7THYKOyaytArByfdYqw88xBr/fKtIyI0jvGCyKvP0TAN4Diz
 8SlN2e7ydn4u4RCuYFJlyqhcFmhDCA3iJszf3WVGcivdAcnCVSBB8zj7MGTIktBcDUOOn
 4EG17yFU6vqbzqE8KZdgB2hg76+v14+p6eeUb1BwPrptBwItLxtrlM/ZCPTTdGWGU30zf
 yZw3A31zEc4OkQqRsU3ayAhr+ejU0s4a8+kbe1ggcS3cDMNFXbDx5CpsZMueq4YYZCIvN
 ae4510pi12YcjIeoBtvNZnWjLs5K3OU84/NhXOQD1IrVHK6JNCRBi1sBPaz1+8Nv4yA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791286250;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=E2dxbiqZsmOX24/CL3AzYC3sBleX40bNMJFODwQmelQ=;
 b=l+zcJthOHyFeAFug8o/PFlucrdQLvkcldEdKfqdkYBPMXBFgkndNAaOTj4uDh0E+Rryk
 51UkyGMVAKT2cfzrN0zoIoXJGVJuZ4l4HT/0vESrfNn5gIcU1O1xL+CH1oe94chfv8vg5
 ueOejiJwPDZA8u2CCGC2vh3mmmp1FnDfGZWwk8fk/SDcZ5ZWSx4/3YsVHN1ZfSH34DDIo
 iZOaiiZeIRdJ/MsfExKqLP852tIl0yDFN6ihnKEP2sIff+COjNKtWGndF72rHaMs1zQPv
 XqbWjytOA7U8UMjqrI2gVvRmWr/3XGL9+l6AEyJJGxHKTI1tpJH2c3BbZNJtMqIJO/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="ZBd/EjkV"; 
 arc=none smtp.remote-ip=192.198.163.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZBd/EjkV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BC0560782
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791286250; x=1822822250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YUnH8Kql59rafrUiLtEpruD6VPrzhVhQeuA4+su8e2Y=;
 b=ZBd/EjkV6Udj42HvYJrn0XG/AIuAX6L50lz7x/IwJXD9dLiSW80ka0uy
 RUCMmuujmlPyUA1R+rgnhJcY8U8nT5XHTbhtaEU72VS97TVshMlpm2JTW
 lOaD0tO5xlb7lVkEc9aKU5ppVq59joTNpkp41KOU+N83D/ypfiHSqZOAo
 ER0fbk+Gdf2GcKOnm4tEP6bfHdGQFwfD2op9RO/P7e/eY+AA2FYuw6fJ3
 UBliiKRk+tE6zG9BiaojPWm1F6VDXcR3ciRwCDxLez2xi5TnkHLwKY7P/
 5XASGQB55OUptyBS25kU9R9NQzL9+obn0ycARo7yFam3rXrmPYnVar/UO A==;
X-CSE-ConnectionGUID: eIafPec/QeSEJ7fIF2WXYg==
X-CSE-MsgGUID: rCNTuOhGS8qE01ebs5iUcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="27711"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="27711"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:30:50 -0700
X-CSE-ConnectionGUID: W/FrJcyoSAWNklYbKcj6/w==
X-CSE-MsgGUID: Omf/7L6fRAizCoMRpbOcjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280370485"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 04:30:49 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 1/2] ice: extend tc flags field to u64
Date: Tue,  6 Oct 2026 12:47:03 +0200
Message-ID: <20261006104704.3584666-2-michal.swiatkowski@linux.intel.com>
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

There is no more space for tc flags. Change u32 to u64. Use BIT_ULL
instead of BIT.

Assisted-by: Copilot:claude-opus-5
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 16 ++---
 drivers/net/ethernet/intel/ice/ice_tc_lib.h | 66 ++++++++++-----------
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ff2d6d4f942a..005fb77ef7fd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8973,7 +8973,7 @@ static void ice_rem_all_chnl_fltrs(struct ice_pf *pf)
 		} else if (fltr->dest_vsi) {
 			/* update advanced switch filter count */
 			if (fltr->dest_vsi->type == ICE_VSI_CHNL) {
-				u32 flags = fltr->flags;
+				u64 flags = fltr->flags;
 
 				fltr->dest_vsi->num_chnl_fltr--;
 				if (flags & (ICE_TC_FLWR_FIELD_DST_MAC |
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 628b2184df00..560d939b2008 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -16,7 +16,7 @@
  *
  * Return: lookup count based on TC flower input for a switch filter.
  */
-static int ice_tc_count_lkups(u32 flags, struct ice_tc_flower_fltr *fltr)
+static int ice_tc_count_lkups(u64 flags, struct ice_tc_flower_fltr *fltr)
 {
 	int lkups_cnt = 1; /* 0th lookup is metadata */
 
@@ -182,7 +182,7 @@ static u16 ice_check_supported_vlan_tpid(u16 vlan_tpid)
 }
 
 static int
-ice_tc_fill_tunnel_outer(u32 flags, struct ice_tc_flower_fltr *fltr,
+ice_tc_fill_tunnel_outer(u64 flags, struct ice_tc_flower_fltr *fltr,
 			 struct ice_adv_lkup_elem *list, int i)
 {
 	struct ice_tc_flower_lyr_2_4_hdrs *hdr = &fltr->outer_headers;
@@ -369,7 +369,7 @@ ice_tc_fill_tunnel_outer(u32 flags, struct ice_tc_flower_fltr *fltr,
  * advance filter in hardware.
  */
 static int
-ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
+ice_tc_fill_rules(struct ice_hw *hw, u64 flags,
 		  struct ice_tc_flower_fltr *tc_fltr,
 		  struct ice_adv_lkup_elem *list,
 		  struct ice_adv_rule_info *rule_info,
@@ -932,7 +932,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	struct ice_rule_query_data rule_added;
 	struct ice_hw *hw = &vsi->back->hw;
 	struct ice_adv_lkup_elem *list;
-	u32 flags = fltr->flags;
+	u64 flags = fltr->flags;
 	int lkups_cnt;
 	int ret;
 	int i;
@@ -1161,7 +1161,7 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 	struct ice_adv_lkup_elem *list;
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
-	u32 flags = tc_fltr->flags;
+	u64 flags = tc_fltr->flags;
 	struct ice_vsi *dest_vsi;
 	struct device *dev;
 	u16 lkups_cnt = 0;
@@ -1279,19 +1279,19 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 	}
 	switch (tc_fltr->action.fltr_act) {
 	case ICE_FWD_TO_VSI:
-		dev_dbg(dev, "added switch rule (lkups_cnt %u, flags 0x%x), action is forward to TC %u, rid %u, rule_id %u, vsi_idx %u\n",
+		dev_dbg(dev, "added switch rule (lkups_cnt %u, flags 0x%llx), action is forward to TC %u, rid %u, rule_id %u, vsi_idx %u\n",
 			lkups_cnt, flags,
 			tc_fltr->action.fwd.tc.tc_class, rule_added.rid,
 			rule_added.rule_id, rule_added.vsi_handle);
 		break;
 	case ICE_FWD_TO_Q:
-		dev_dbg(dev, "added switch rule (lkups_cnt %u, flags 0x%x), action is forward to queue: %u (HW queue %u)     , rid %u, rule_id %u\n",
+		dev_dbg(dev, "added switch rule (lkups_cnt %u, flags 0x%llx), action is forward to queue: %u (HW queue %u)     , rid %u, rule_id %u\n",
 			lkups_cnt, flags, tc_fltr->action.fwd.q.queue,
 			tc_fltr->action.fwd.q.hw_queue, rule_added.rid,
 			rule_added.rule_id);
 		break;
 	case ICE_DROP_PACKET:
-		dev_dbg(dev, "added switch rule (lkups_cnt %u, flags 0x%x), action is drop, rid %u, rule_id %u\n",
+		dev_dbg(dev, "added switch rule (lkups_cnt %u, flags 0x%llx), action is drop, rid %u, rule_id %u\n",
 			lkups_cnt, flags, rule_added.rid, rule_added.rule_id);
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 47444b7dadd2..234cc9bafc41 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -7,38 +7,38 @@
 #include <linux/bits.h>
 #include <net/pfcp.h>
 
-#define ICE_TC_FLWR_FIELD_DST_MAC		BIT(0)
-#define ICE_TC_FLWR_FIELD_SRC_MAC		BIT(1)
-#define ICE_TC_FLWR_FIELD_VLAN			BIT(2)
-#define ICE_TC_FLWR_FIELD_DEST_IPV4		BIT(3)
-#define ICE_TC_FLWR_FIELD_SRC_IPV4		BIT(4)
-#define ICE_TC_FLWR_FIELD_DEST_IPV6		BIT(5)
-#define ICE_TC_FLWR_FIELD_SRC_IPV6		BIT(6)
-#define ICE_TC_FLWR_FIELD_DEST_L4_PORT		BIT(7)
-#define ICE_TC_FLWR_FIELD_SRC_L4_PORT		BIT(8)
-#define ICE_TC_FLWR_FIELD_TENANT_ID		BIT(9)
-#define ICE_TC_FLWR_FIELD_ENC_DEST_IPV4		BIT(10)
-#define ICE_TC_FLWR_FIELD_ENC_SRC_IPV4		BIT(11)
-#define ICE_TC_FLWR_FIELD_ENC_DEST_IPV6		BIT(12)
-#define ICE_TC_FLWR_FIELD_ENC_SRC_IPV6		BIT(13)
-#define ICE_TC_FLWR_FIELD_ENC_DEST_L4_PORT	BIT(14)
-#define ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT	BIT(15)
-#define ICE_TC_FLWR_FIELD_ENC_DST_MAC		BIT(16)
-#define ICE_TC_FLWR_FIELD_ETH_TYPE_ID		BIT(17)
-#define ICE_TC_FLWR_FIELD_GTP_OPTS		BIT(18)
-#define ICE_TC_FLWR_FIELD_CVLAN			BIT(19)
-#define ICE_TC_FLWR_FIELD_PPPOE_SESSID		BIT(20)
-#define ICE_TC_FLWR_FIELD_PPP_PROTO		BIT(21)
-#define ICE_TC_FLWR_FIELD_IP_TOS		BIT(22)
-#define ICE_TC_FLWR_FIELD_IP_TTL		BIT(23)
-#define ICE_TC_FLWR_FIELD_ENC_IP_TOS		BIT(24)
-#define ICE_TC_FLWR_FIELD_ENC_IP_TTL		BIT(25)
-#define ICE_TC_FLWR_FIELD_L2TPV3_SESSID		BIT(26)
-#define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT(27)
-#define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
-#define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
-#define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT(30)
-#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(31)
+#define ICE_TC_FLWR_FIELD_DST_MAC		BIT_ULL(0)
+#define ICE_TC_FLWR_FIELD_SRC_MAC		BIT_ULL(1)
+#define ICE_TC_FLWR_FIELD_VLAN			BIT_ULL(2)
+#define ICE_TC_FLWR_FIELD_DEST_IPV4		BIT_ULL(3)
+#define ICE_TC_FLWR_FIELD_SRC_IPV4		BIT_ULL(4)
+#define ICE_TC_FLWR_FIELD_DEST_IPV6		BIT_ULL(5)
+#define ICE_TC_FLWR_FIELD_SRC_IPV6		BIT_ULL(6)
+#define ICE_TC_FLWR_FIELD_DEST_L4_PORT		BIT_ULL(7)
+#define ICE_TC_FLWR_FIELD_SRC_L4_PORT		BIT_ULL(8)
+#define ICE_TC_FLWR_FIELD_TENANT_ID		BIT_ULL(9)
+#define ICE_TC_FLWR_FIELD_ENC_DEST_IPV4		BIT_ULL(10)
+#define ICE_TC_FLWR_FIELD_ENC_SRC_IPV4		BIT_ULL(11)
+#define ICE_TC_FLWR_FIELD_ENC_DEST_IPV6		BIT_ULL(12)
+#define ICE_TC_FLWR_FIELD_ENC_SRC_IPV6		BIT_ULL(13)
+#define ICE_TC_FLWR_FIELD_ENC_DEST_L4_PORT	BIT_ULL(14)
+#define ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT	BIT_ULL(15)
+#define ICE_TC_FLWR_FIELD_ENC_DST_MAC		BIT_ULL(16)
+#define ICE_TC_FLWR_FIELD_ETH_TYPE_ID		BIT_ULL(17)
+#define ICE_TC_FLWR_FIELD_GTP_OPTS		BIT_ULL(18)
+#define ICE_TC_FLWR_FIELD_CVLAN			BIT_ULL(19)
+#define ICE_TC_FLWR_FIELD_PPPOE_SESSID		BIT_ULL(20)
+#define ICE_TC_FLWR_FIELD_PPP_PROTO		BIT_ULL(21)
+#define ICE_TC_FLWR_FIELD_IP_TOS		BIT_ULL(22)
+#define ICE_TC_FLWR_FIELD_IP_TTL		BIT_ULL(23)
+#define ICE_TC_FLWR_FIELD_ENC_IP_TOS		BIT_ULL(24)
+#define ICE_TC_FLWR_FIELD_ENC_IP_TTL		BIT_ULL(25)
+#define ICE_TC_FLWR_FIELD_L2TPV3_SESSID		BIT_ULL(26)
+#define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT_ULL(27)
+#define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT_ULL(28)
+#define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT_ULL(29)
+#define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT_ULL(30)
+#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT_ULL(31)
 
 #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
 
@@ -189,7 +189,7 @@ struct ice_tc_flower_fltr {
 	struct gtp_pdu_session_info gtp_pdu_info_masks;
 	struct pfcp_metadata pfcp_meta_keys;
 	struct pfcp_metadata pfcp_meta_masks;
-	u32 flags;
+	u64 flags;
 	u8 tunnel_type;
 	struct ice_tc_flower_action	action;
 
-- 
2.49.0

