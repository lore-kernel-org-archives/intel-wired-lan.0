Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED46606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TtVbrE+G;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OV+zbnEk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D11560658;
	Thu, 19 Nov 2026 15:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aEeZVqFYLL2b; Thu, 19 Nov 2026 15:24:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B41360686
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101886;
	b=DwOocL6j6wD5wsCNlVixegZ3N3GV3UIDaLZ8tfuKP0oeAQsTiZlttYlpoTjXA6WP9ZOL
	 /tLfSnX9ebWf8SCG1rYysKn2mBuoLY3TSyJge9u6B+4/Qnuw3MS1dB2U6p+WQpBpj4G6y
	 AKl1TH/AqEu+CxS9Jas37vAijk/jfTeD18PmCcVwGDfzniHJvZrNptZ6d2iYJVppwKza7
	 ZFH8ym5O+eljxz1iLlBKltg6H80ID1OXF9fy2xei6YGdOaWbHGa2PTWMgKeynjaUfl1pc
	 itd21DTWhreGHMGhR2Et362g/eVyE12eQ3qI7yIFZ7NYWtauQ2PtZWDgP5wgf7FiF1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0Fr0GZh58oFDLjuaWSgx5S9sOIQupBeHTX0CvteZ9tQ=;
	b=rXmOTRkLT5C3ZTKY9nHa0Jc0nmPZsrIKWopAmlY6C0uHUWCHKyl2ZAox7VNZ+DJDcKLE
	 fvJANDxxYDLxiyPcI8WUdgNmtpsIqOVVcEHmD1ArCPzyJCuDcZ1YCl9IM069U6AwAdiyx
	 EtvXRoS4dFaevWQJdu7R3b7VBfQdDPn6Rcspqaa3GJZjqgBtenrTHQEU1Pux1BgcukWuT
	 bBIAp4KyrAYOODXTFN4cHXtqGW0vBAwE6/L7pDwwMGgQlCrt9MQzvmlNVp68q6x+w0i9T
	 I2Bfam6fsweQfLCcny95HYxbx41/q3VpyONO6S7q/UrpQNH3521SNUxEt/DkdPrYvAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795101886;
	bh=0Fr0GZh58oFDLjuaWSgx5S9sOIQupBeHTX0CvteZ9tQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TtVbrE+GYFnsKFmskDkDSYJTeMCOwpPwRZ81gO/hhQmczuBAlFd5bjg4JqyRl2/A8
	 4JweHw09p1ivkc0YWenYn8H/8unmlHv5+k1ARDnJ/fdkLEoIj/SytnM8VQD8+7wAar
	 ccKYd0b1fp10Uh2MN3PV4nawIfyBmIvT5KtH2UQ9WLwIav7cv5TYGJ5V990OXt8Uhd
	 rgB1+wtwI2ax3abFRsacnEv3Y79lOnLgidlphAXpRdEMIWmJlA4zxQ0CRGlCdu+tlu
	 qNUjD+1mZ37134Gd9m1pKFqJZOue1znO0+NFGqYLPq4BigRRb39xH3U1nr3MobtrH9
	 Iwse924LPPlCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B41360686;
	Thu, 19 Nov 2026 15:24:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AA9B1E7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 211C14055A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAR6KJv7ONcD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:24:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 09E6040596
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OV+zbnEk
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09E6040596
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795101882; x=1826637882;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gi/pO6c2Wjk5JyJw8I6JY1d1CgwQPxaQXVRJ2Ul9B34=;
 b=OV+zbnEk5Eq8J4weOX1NELd67ppJszGoD0HASMiNCOnRTvgIXMypWz1m
 IO//5/uHNidwrmdM2l3R03U4nSXP3uO4eFUD/YpCx/yktKpD90ixw6KUM
 QuGDDvRCamQyNIsWJ4f6NyZcDjsb21JbPV6krUlTOU8govM14yI464NxY
 4ZBzEqEwrgDvbSfMQlYDUgEgeBWN89eyl1z/2gfuUEzIbJJoEucNewg9E
 xShBMZNSMrdQB9WxROkj9M89V/WGhEc/MGSTeyQ8r8g5k2r3hbeyQJy6V
 M1t1WCE46io0XcHNf+BquEDwpl84NJpQphg0y1QQz0WcFaoJ10GRVAnmN g==;
X-CSE-ConnectionGUID: lO5TDMgeRm2ddPmI2UTuCA==
X-CSE-MsgGUID: exRxwX62RFW9Vg2lbtninw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3848770"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3848770"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:24:42 -0800
X-CSE-ConnectionGUID: J3+WSRoxQnCPDGEDuXKlzA==
X-CSE-MsgGUID: JUE7klweQHGmRGpDcH704w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10358785"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Nov 2026 07:24:41 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v3 1/4] ice: free VF FDIR raw flow data with the
 filter conf
Date: Thu, 19 Nov 2026 16:24:35 +0100
Message-ID: <20261119152438.3577165-2-aleksandr.loktionov@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_vc_fdir_parse_raw() stores the raw flow buffer and the parser
profile in the filter conf, but the conf is freed in several
places without releasing those allocations.

Free conf->pkt_buf and conf->prof together with the conf in
ice_vc_fdir_free_conf() and use it in every place that frees a
filter conf.

This addresses the pkt_buf/prof leak raised on the October series
thread:

Link: https://lore.kernel.org/intel-wired-lan/20261013144435.1406126-1-aleksandr.loktionov@intel.com/
Link: https://lore.kernel.org/intel-wired-lan/c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com/

v2 -> v3:
 - new patch: free the raw flow buffer and parser profile on the
   add error path, as requested on the v2 thread
 - also free the raw flow buffers in ice_vc_fdir_flush_entry()
   (leaked on every VF reset / teardown)
 - free the raw flow data on the remaining paths that free a
   filter conf: the validate-only add path, and the add and
   delete post-processing success and error paths
 - fix a double free of the parser profile: the parse error path
   freed conf->prof but left the pointer set, so the add error
   path freed it again

Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/fdir.c | 29 +++++++++++++++++-----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
index aeddb91..b6e3097 100644
--- a/drivers/net/ethernet/intel/ice/virt/fdir.c
+++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
@@ -898,6 +898,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 
 err_parser_profile_init:
 	kfree(conf->prof);
+	conf->prof = NULL;
 err_parser_destroy:
 	ice_parser_destroy(psr);
 err_mem_alloc:
@@ -1358,6 +1359,22 @@ ice_vc_fdir_lookup_entry(struct ice_vf *vf, u32 id)
 	return idr_find(&vf->fdir.fdir_rule_idr, id);
 }
 
+/**
+ * ice_vc_fdir_free_conf - free a FDIR filter conf and its raw flow data
+ * @dev: pointer to the device
+ * @conf: FDIR configuration for each filter
+ *
+ * conf->pkt_buf and conf->prof are only set for raw (parser) filters by
+ * ice_vc_fdir_parse_raw(); kfree(NULL) is a no-op for the other filters.
+ */
+static void
+ice_vc_fdir_free_conf(struct device *dev, struct virtchnl_fdir_fltr_conf *conf)
+{
+	kfree(conf->pkt_buf);
+	kfree(conf->prof);
+	devm_kfree(dev, conf);
+}
+
 /**
  * ice_vc_fdir_flush_entry - remove all FDIR conf entry
  * @vf: pointer to the VF info
@@ -1371,7 +1388,7 @@ static void ice_vc_fdir_flush_entry(struct ice_vf *vf)
 				 &vf->fdir.fdir_rule_list, fltr_node) {
 		conf = to_fltr_conf_from_desc(desc);
 		list_del(&desc->fltr_node);
-		devm_kfree(ice_pf_to_dev(vf->pf), conf);
+		ice_vc_fdir_free_conf(ice_pf_to_dev(vf->pf), conf);
 	}
 }
 
@@ -1718,7 +1735,7 @@ ice_vc_add_fdir_fltr_post(struct ice_vf *vf, struct ice_vf_fdir_ctx *ctx,
 	if (resp)
 		resp->status = status;
 	ice_vc_fdir_remove_entry(vf, conf, conf->flow_id);
-	devm_kfree(dev, conf);
+	ice_vc_fdir_free_conf(dev, conf);
 
 	ret = ice_vc_send_msg_to_vf(vf, ctx->v_opcode, v_ret,
 				    (u8 *)resp, len);
@@ -1777,14 +1794,14 @@ ice_vc_del_fdir_fltr_post(struct ice_vf *vf, struct ice_vf_fdir_ctx *ctx,
 		vf->vf_id, conf->flow_id,
 		(ctx->v_opcode == VIRTCHNL_OP_ADD_FDIR_FILTER) ?
 		"add" : "del");
-	devm_kfree(dev, conf);
+	ice_vc_fdir_free_conf(dev, conf);
 	return ret;
 
 err_exit:
 	if (resp)
 		resp->status = status;
 	if (success)
-		devm_kfree(dev, conf);
+		ice_vc_fdir_free_conf(dev, conf);
 
 	ret = ice_vc_send_msg_to_vf(vf, ctx->v_opcode, v_ret,
 				    (u8 *)resp, len);
@@ -2152,7 +2169,7 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	if (fltr->validate_only) {
 		v_ret = VIRTCHNL_STATUS_SUCCESS;
 		stat->status = VIRTCHNL_FDIR_SUCCESS;
-		devm_kfree(dev, conf);
+		ice_vc_fdir_free_conf(dev, conf);
 		ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ADD_FDIR_FILTER,
 					    v_ret, (u8 *)stat, len);
 		goto exit;
@@ -2219,7 +2236,7 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 err_rem_entry:
 	ice_vc_fdir_remove_entry(vf, conf, conf->flow_id);
 err_free_conf:
-	devm_kfree(dev, conf);
+	ice_vc_fdir_free_conf(dev, conf);
 err_exit:
 	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ADD_FDIR_FILTER, v_ret,
 				    (u8 *)stat, len);
-- 
2.56.0

