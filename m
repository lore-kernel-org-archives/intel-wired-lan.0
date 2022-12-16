Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE60C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Dec 2022 20:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD2574198D;
	Fri, 16 Dec 2022 20:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD2574198D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671221239;
	bh=JPNpzzixvUZeJ207wCT/2002Sm5VNgjpDIuBgzLPmdg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=D8paFs2EhGTRfQR0+BG6Y5dMnyLjMBOT1CNQoW6H3r0ItUKAlZIrAIhNSIGUX5SYe
	 x93YYsmpi3xotCcaIT2LDHYyepueBCdCz4b23jkawnDMEMTNo5AGlCIAK+TWJCZ9jS
	 wywdHJ4EtiqSB04N08XlHHb9WaywztHe8xL7HLAH4Rmp1UKFZ4OQtXbtdBzvUODC/r
	 LBCxx9+SELqvVpwSgrlwp9WBcGz4ZlRUsb5HIXoYUBGnT14NqOjFF8ZtIXNDOMyAgL
	 PFbPIV1oUbSyAfPV47FYCYTpO9zdyto/fFe5Hh2X9pABcvwdKwwIQNXp5JiGvGrZuw
	 HL1zH70m8ed1A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jy4uUTQCODKu; Fri, 16 Dec 2022 20:07:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E92F41976;
	Fri, 16 Dec 2022 20:07:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E92F41976
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 206A11BF2A7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 20:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1B8341900
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 20:07:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1B8341900
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9d98YD2F2nYk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Dec 2022 20:07:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D62F419C3
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D62F419C3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 20:07:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="320932436"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; d="scan'208";a="320932436"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2022 12:07:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="682385368"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; d="scan'208";a="682385368"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2022 12:07:08 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 16 Dec 2022 12:06:57 -0800
Message-Id: <20221216200658.59833-4-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221216200658.59833-1-jesse.brandeburg@intel.com>
References: <20221216200658.59833-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671221229; x=1702757229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yyJvVwdH5tOSZ2+Jko+GnH4KH1ZFynH7znhOACo1dgE=;
 b=kWCq9PFhlqxdTlppZm4ZV2m15vimKawpVQdzpe68zJ6WltSkii88/c5M
 CoH3sg9QQNj03+/3ZiCEuaQ6bIP5QQyWZmbFqHC+qiKNhIiZO723ZT3iX
 ZQwobzXiaAfVydhPn4itmqoAoHFuZrpW0qy2DmWsx0aSoM2wm83ckWYlh
 IshxHUa++HdIK4kj+9dWGTmu46gCrnLrOnH6AVNN4zf+eVULFOIwX1yjR
 +cjFiYqZ1mfWEsa1W7jkBLcKGmB4bvBq2kTd6PLj/3cRXLHziMRHUQOh5
 CF3FjdSdZYzj8EY8uAl8RCRoHnd7wsRzwPdaXF4Bu9GPIX/kI7mUYxxma
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kWCq9PFh
Subject: [Intel-wired-lan] [PATCH net-next v1 3/4] virtchnl: do structure
 hardening
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The virtchnl interface can have a bunch of "soft" defined structures
hardened by using explicit sizes for declarations, and then referring to
the enum type that uses them in a comment. None of these changes should
change any of the structure sizes.

Also, remove a duplicate line in a switch statement and let two cases
uses the same code.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 include/linux/avf/virtchnl.h | 48 ++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 2e685aa37688..5c630c818370 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -214,7 +214,9 @@ enum virtchnl_vsi_type {
 struct virtchnl_vsi_resource {
 	u16 vsi_id;
 	u16 num_queue_pairs;
-	enum virtchnl_vsi_type vsi_type;
+
+	/* see enum virtchnl_vsi_type */
+	s32 vsi_type;
 	u16 qset_handle;
 	u8 default_mac_addr[ETH_ALEN];
 };
@@ -303,7 +305,9 @@ struct virtchnl_rxq_info {
 	u8 rxdid;
 	u8 pad1[2];
 	u64 dma_ring_addr;
-	enum virtchnl_rx_hsplit rx_split_pos; /* deprecated with AVF 1.0 */
+
+	/* see enum virtchnl_rx_hsplit; deprecated with AVF 1.0 */
+	s32 rx_split_pos;
 	u32 pad2;
 };
 
@@ -955,8 +959,12 @@ enum virtchnl_flow_type {
 struct virtchnl_filter {
 	union	virtchnl_flow_spec data;
 	union	virtchnl_flow_spec mask;
-	enum	virtchnl_flow_type flow_type;
-	enum	virtchnl_action action;
+
+	/* see enum virtchnl_flow_type */
+	s32	flow_type;
+
+	/* see enum virtchnl_action */
+	s32	action;
 	u32	action_meta;
 	u8	field_flags;
 	u8	pad[3];
@@ -984,7 +992,8 @@ enum virtchnl_event_codes {
 #define PF_EVENT_SEVERITY_CERTAIN_DOOM	255
 
 struct virtchnl_pf_event {
-	enum virtchnl_event_codes event;
+	/* see enum virtchnl_event_codes */
+	s32 event;
 	union {
 		/* If the PF driver does not support the new speed reporting
 		 * capabilities then use link_event else use link_event_adv to
@@ -997,6 +1006,7 @@ struct virtchnl_pf_event {
 		struct {
 			enum virtchnl_link_speed link_speed;
 			bool link_status;
+			u8 pad[3];
 		} link_event;
 		struct {
 			/* link_speed provided in Mbps */
@@ -1006,7 +1016,7 @@ struct virtchnl_pf_event {
 		} link_event_adv;
 	} event_data;
 
-	int severity;
+	s32 severity;
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_pf_event);
@@ -1097,7 +1107,7 @@ enum virtchnl_rss_algorithm {
 #define VIRTCHNL_GET_PROTO_HDR_TYPE(hdr) \
 	(((hdr)->type) >> PROTO_HDR_SHIFT)
 #define VIRTCHNL_TEST_PROTO_HDR_TYPE(hdr, val) \
-	((hdr)->type == ((val) >> PROTO_HDR_SHIFT))
+	((hdr)->type == ((s32)((val) >> PROTO_HDR_SHIFT)))
 #define VIRTCHNL_TEST_PROTO_HDR(hdr, val) \
 	(VIRTCHNL_TEST_PROTO_HDR_TYPE((hdr), (val)) && \
 	 VIRTCHNL_TEST_PROTO_HDR_FIELD((hdr), (val)))
@@ -1193,7 +1203,8 @@ enum virtchnl_proto_hdr_field {
 };
 
 struct virtchnl_proto_hdr {
-	enum virtchnl_proto_hdr_type type;
+	/* see enum virtchnl_proto_hdr_type */
+	s32 type;
 	u32 field_selector; /* a bit mask to select field for header type */
 	u8 buffer[64];
 	/**
@@ -1223,15 +1234,18 @@ VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
 
 struct virtchnl_rss_cfg {
 	struct virtchnl_proto_hdrs proto_hdrs;	   /* protocol headers */
-	enum virtchnl_rss_algorithm rss_algorithm; /* RSS algorithm type */
-	u8 reserved[128];			   /* reserve for future */
+
+	/* see enum virtchnl_rss_algorithm; rss algorithm type */
+	s32 rss_algorithm;
+	u8 reserved[128];                          /* reserve for future */
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(2444, virtchnl_rss_cfg);
 
 /* action configuration for FDIR */
 struct virtchnl_filter_action {
-	enum virtchnl_action type;
+	/* see enum virtchnl_action type */
+	s32 type;
 	union {
 		/* used for queue and qgroup action */
 		struct {
@@ -1319,7 +1333,9 @@ struct virtchnl_fdir_add {
 	u16 validate_only; /* INPUT */
 	u32 flow_id;       /* OUTPUT */
 	struct virtchnl_fdir_rule rule_cfg; /* INPUT */
-	enum virtchnl_fdir_prgm_status status; /* OUTPUT */
+
+	/* see enum virtchnl_fdir_prgm_status; OUTPUT */
+	s32 status;
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(2616, virtchnl_fdir_add);
@@ -1332,7 +1348,9 @@ struct virtchnl_fdir_del {
 	u16 vsi_id;  /* INPUT */
 	u16 pad;
 	u32 flow_id; /* INPUT */
-	enum virtchnl_fdir_prgm_status status; /* OUTPUT */
+
+	/* see enum virtchnl_fdir_prgm_status; OUTPUT */
+	s32 status;
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
@@ -1351,7 +1369,7 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 			    u8 *msg, u16 msglen)
 {
 	bool err_msg_format = false;
-	int valid_len = 0;
+	u32 valid_len = 0;
 
 	/* Validate message length. */
 	switch (v_opcode) {
@@ -1492,8 +1510,6 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_DISABLE_CHANNELS:
 		break;
 	case VIRTCHNL_OP_ADD_CLOUD_FILTER:
-		valid_len = sizeof(struct virtchnl_filter);
-		break;
 	case VIRTCHNL_OP_DEL_CLOUD_FILTER:
 		valid_len = sizeof(struct virtchnl_filter);
 		break;
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
