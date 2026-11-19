Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C7606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=aFzRlnoW;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PlMc0O0C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E522280C95;
	Thu, 19 Nov 2026 15:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ItDL1IVAJEEU; Thu, 19 Nov 2026 15:24:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FC7081371
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101887;
	b=M6FHwRJenGxSmOH+awZtULqfX/dXB6NUHWH0XkljOdQpD/y/ageUYewP9SiNGyaSze/B
	 gp8CgkBfMpVXgp5hh+CpGbR7Ztpd50ab2QIW20xseo4Scm1vYP6a4vo79g4oXNIhf1ACF
	 3xWdsRZt3MtcdcqC043QsOXQcXQcfzsWFntaxUsqsOmsHa/OGhQtr/kMhLgOznTOUMBRQ
	 FXIPXKvIRkQaGws5BuP1ynUPRuMb4OnRgPV0afwZnS2VOqP8n/OYidLJoUWER1a/HQFqi
	 kkux2jdpioLJ1HWq8kTtXLnokMglaMdHXfbfp7gc8s0pa5I6WZUb66/8BCrVwrzuvBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xeAAHFS/ck3qQUCyoFr7ZlyP/1XztGil2SbSddsE5LI=;
	b=T8nxsMPVGYA5R0wh3FxVW+1GmxfY52OwHdVWyB/ImWW7TYZe4/wa+69EE8NDkIadvsLN
	 znCzs912Xr+IbOqe30Ki/csunRoOEUv1EJoGfDXIDN900MQo/9SFEiOQVG5wgPiBlqq12
	 jLAfvtKNTk8z1Y2B1m0TvpZOxF5GJb/0sGH3bHVMehNTU4V0UhTwlvym7hnkQDhCmiSZ9
	 6Vc+OT/GAls2tPyPKAXgc0tbbR2HE4xLHu6GS2je7MSMZJDD6oxvvHfAZWiipNJPDEohM
	 K2J7qtJ+/ec00AK3bUlXySaeGnGAyF8Gt5KaLjTvT+EHIjeicoOOZFrnhROPFTZrm0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795101887;
	bh=xeAAHFS/ck3qQUCyoFr7ZlyP/1XztGil2SbSddsE5LI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aFzRlnoWwnPXmFJMZY7A49hXBlji399dlYLPOitQdMX0yfTLZcVxYsTiXDDsKKEuO
	 kyW4qzV+TAC3lX/65L6JcxcDrkK3g1Vs5n0E7cd9Ed3M+QwuJITAd6MwAz+yC+zd1a
	 +brLbz9VD7qqZVl41LcNiRrCx4JqDm+2mukxNKNbJn1qBewuyiXwHKujt8VisAOEcY
	 XPkgDGNZN6vuqRFyCW5QswbFZTgtdHdWkEI/YraCm+3yU0id9FOCgMXV8bc1vtrXUy
	 uCQos9v1wLCR9WXqgL/4fITj7QmPPGhbtyV0g0viYA0QoU4xkbGI+KPhxZjH30UGif
	 QmbY1/cAST9TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FC7081371;
	Thu, 19 Nov 2026 15:24:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 725202FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63F3B60896
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZN3Leu7MJMD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:24:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BAA0260658
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PlMc0O0C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAA0260658
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795101884; x=1826637884;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kKJ5bd0jnByYNwWtTOiUgAQDxTXDC2VazM3DdgBSHhE=;
 b=PlMc0O0CTJbpCGEz/dU+RxUTh/3bAaZDgJ/MkL/Fwfitn/n8Y8PGpqvs
 NNL/ZpjlAyuXwO/cWYV2f9P6qOZ44V9glZib1RnNRsiUeJPQXePEsCgZH
 DN5013fvPi8PSZ+CPmBmLzAqxCVaNiM844U1r3FBKblvD83ifS7mmbiR1
 zew0tAGA5AglIxdSZr2sSu6dKfukiuHa0beUWccuPajIQFJ0iyN5jZumx
 Snymlr3P9ixSm5oFQ8gsDBnxRgkMhTb/mhAGrg/XWjc6KAHG98ylAWBBR
 zpSp0rvsP5lU8gT78UDqH01HWFmqRzBlULg/1XIeK9G4iJdlds0P1s+bq Q==;
X-CSE-ConnectionGUID: 6+sASaqYQHaWun19rtd6jA==
X-CSE-MsgGUID: dmQ0t+FpRwaVim3CGTS4pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3848772"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3848772"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:24:43 -0800
X-CSE-ConnectionGUID: IG7WQaalRPq3jaB2rnCWvA==
X-CSE-MsgGUID: 7arAOemRRWuqdfMq5/TfIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10358788"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Nov 2026 07:24:42 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v3 2/4] ice: validate VF FDIR queue action
Date: Thu, 19 Nov 2026 16:24:36 +0100
Message-ID: <20261119152438.3577165-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119152438.3577165-1-aleksandr.loktionov@intel.com>
References: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
 <c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com>
 <20261119152438.3577165-1-aleksandr.loktionov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_vc_fdir_parse_action() copies the VF supplied queue index straight
into the flow director programming descriptor (QINDEX), which the
hardware interprets relative to the VF's VSI, so a VF can steer
matched packets to queues beyond its own range, i.e. queues belonging
to another VF or to the PF.

For VIRTCHNL_ACTION_QUEUE reject an index that is not below the VSI's
Rx queue count; the rejected action fails the whole add request.

v2 -> v3:
 - split out from the single queue and queue-region validation
   commit of the v2 posting, one commit per Fixes tag
 - rewrap the dev_dbg() call to fit within 80 columns

Fixes: 0ce332fd62f6 ("ice: Add FDIR pattern action parser for VF")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/fdir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
index b6e3097..f3af7de 100644
--- a/drivers/net/ethernet/intel/ice/virt/fdir.c
+++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
@@ -1151,6 +1151,7 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 	struct virtchnl_filter_action_set *as = &fltr->rule_cfg.action_set;
 	struct ice_ntuple_fltr *input = &conf->input;
 	struct device *dev = ice_pf_to_dev(vf->pf);
+	struct ice_vsi *vsi;
 	u32 dest_num = 0;
 	u32 mark_num = 0;
 	int i;
@@ -1161,6 +1162,10 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 		return -EINVAL;
 	}
 
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -EINVAL;
+
 	for (i = 0; i < as->count; i++) {
 		struct virtchnl_filter_action *action = &as->actions[i];
 
@@ -1175,6 +1180,13 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 			break;
 		case VIRTCHNL_ACTION_QUEUE:
 			dest_num++;
+			if (action->act_conf.queue.index >= vsi->num_rxq) {
+				dev_dbg(dev,
+					"Invalid queue index %u for VF %d\n",
+					action->act_conf.queue.index,
+					vf->vf_id);
+				return -EINVAL;
+			}
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
 			input->q_index = action->act_conf.queue.index;
 			break;
-- 
2.56.0

