Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068B7CD5BDE
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 May 2026 07:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C683F41F43;
	Wed, 27 May 2026 07:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wu1G0-fkMpr9; Wed, 27 May 2026 07:18:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 396C241F40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779866329;
	bh=DuNMAalZnxja8HxK5ktK0v9WcRU+Ax+UQm9e4kZHFqw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qv/rQGj3AlQpMg40r4s7OQlnG/47x5hx0mpTGJIARcLAoG1s2z3kmTp3munvk22AT
	 mDkSmYibImEPoGR3pgZstKGwmqC/i+oEUnz4WZM+G9iwqomZrzV0BHCfiM03Om5ool
	 GGvnPb75PbStZZk8pboPEpYDXFDDUpiHJR2WDbWqZttMRTYdjahPm8GflPkHCp0cLd
	 l1kDyk9BMiC26RtBalJp/MiL+iAelahp1Fv0RRlGwcXgQnD6Q8qBJwq4sCWPJHjYyP
	 PfZT6pfAbgxLSwa7Ma1AkQ2MJQPfEV6HG2Q6iIowcB8CXc3QUEp9HHbrQgytbyQkR+
	 KLKkyOvIvuO8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 396C241F40;
	Wed, 27 May 2026 07:18:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E27C23F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 07:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C4556133C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 07:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tGt34k46xWkl for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 May 2026 07:18:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6076A6133E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6076A6133E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6076A6133E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 07:18:46 +0000 (UTC)
X-CSE-ConnectionGUID: x+6ZcOnhRLKOQSSvz9Nhkw==
X-CSE-MsgGUID: 4mKD13vjTbyvMy4onQLq7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91260983"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="91260983"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 00:18:46 -0700
X-CSE-ConnectionGUID: hsX2BLHZS+S7pY7cPE9tGQ==
X-CSE-MsgGUID: r6D0S/ffRsqZibQ3aFaLPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="241992128"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 27 May 2026 00:18:45 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Wed, 27 May 2026 09:18:42 +0200
Message-ID: <20260527071842.11478-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527071842.11478-1-aleksandr.loktionov@intel.com>
References: <20260527071842.11478-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779866326; x=1811402326;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+CTprmGPljqoWj5+N2MqzJ1uOGCIXO8wPfOBg98bLsI=;
 b=nNrMy7WTO7HPAlgrNwm1TPIh0SSP6bckl1r6OZxK9/niKMJ8KDORkmIj
 lEf79snl3E94HrUzT7Yolo9XWKRI6qHczfwlx6CuL6A/wuFkp0U834XM3
 zTrY+HTHpnmAANnMO+CBJBXOTMscxc+ainpdAzC6FJRNyC/7KR5Yx/Z0T
 Qg40cOTUQYTG1SiPTVNGnZEuZ42mF6TV+dRyn7/yC/7ekZ6Hv78wpf0Tg
 cynwjr7tLzjsxn1Bl+5NdBJuvs8GW/jPylwvFxarEvNDEEQAz84efqPWy
 2+vW7fvVXXFyY3Nunyqkhh/+1040gnalmnonVn/eRHvekniCTpHCXzoUt
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nNrMy7WT
Subject: [Intel-wired-lan] [PATCH net] ice: validate FDIR action queue index
 against VF VSI queue count
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

ice_vc_fdir_parse_action() stores the VF-supplied
action->act_conf.queue.index directly into input->q_index for both
VIRTCHNL_ACTION_QUEUE and VIRTCHNL_ACTION_Q_REGION without checking
whether the index is within the bounds of the VF's VSI.  The validated
value is later programmed into the FDIR descriptor's queue index field,
which means a malicious VF can direct matched traffic to a queue index
it does not own, potentially reaching queues belonging to another VF or
the PF.

Add a bounds check against vsi->num_rxq for both action types, matching
the pattern already used elsewhere in the driver.  Also obtain the VF
VSI pointer locally so the check has access to num_rxq; add the
expected NULL guard for robustness.

Fixes: 0ce332fd62f6 ("ice: Add FDIR pattern action parser for VF")
Fixes: 346bf2504397 ("ice: Add new actions support for VF FDIR")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/fdir.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
index 4f1f344..1bc524f 100644
--- a/drivers/net/ethernet/intel/ice/virt/fdir.c
+++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
@@ -1152,6 +1152,7 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 	struct virtchnl_filter_action_set *as = &fltr->rule_cfg.action_set;
 	struct device *dev = ice_pf_to_dev(vf->pf);
 	struct ice_fdir_fltr *input = &conf->input;
+	struct ice_vsi *vsi;
 	u32 dest_num = 0;
 	u32 mark_num = 0;
 	int i;
@@ -1162,6 +1163,10 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 		return -EINVAL;
 	}
 
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -EINVAL;
+
 	for (i = 0; i < as->count; i++) {
 		struct virtchnl_filter_action *action = &as->actions[i];
 
@@ -1176,11 +1181,21 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 			break;
 		case VIRTCHNL_ACTION_QUEUE:
 			dest_num++;
+			if (action->act_conf.queue.index >= vsi->num_rxq) {
+				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
+					action->act_conf.queue.index, vf->vf_id);
+				return -EINVAL;
+			}
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
 			input->q_index = action->act_conf.queue.index;
 			break;
 		case VIRTCHNL_ACTION_Q_REGION:
 			dest_num++;
+			if (action->act_conf.queue.index >= vsi->num_rxq) {
+				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
+					action->act_conf.queue.index, vf->vf_id);
+				return -EINVAL;
+			}
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP;
 			input->q_index = action->act_conf.queue.index;
 			input->q_region = action->act_conf.queue.region;
-- 
2.52.0

