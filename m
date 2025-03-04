Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AC4C021B8
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Mar 2025 11:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5348360B05;
	Tue,  4 Mar 2025 11:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgx4IKIhOiN3; Tue,  4 Mar 2025 11:09:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4BEB60671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1741086580;
	bh=7rEu/vLKtsUS6gV4V3fmSpmjwKw/YFaA9zMfno5WKiw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OS5QHixN+AdwVQy68ViSJVYd3/oOQMhUk60nsJeG+MV1hlvMiy1+KVfEgxQiDh6iP
	 URfK7EqgkSBCMmHrJBFvkIiJ3zjCI3GnkSrZq1IM4WbW2svHpEICLWaz16lAfeiAPU
	 oL9YG+XvR1QM4mwNSz6gXeyoRXFaVb6aL/IysK0cKpi+qRXcazynXaxApL3IPFLQu5
	 P5wlqtCFcOoBuoJ6BOrjufdV4KlfrZinKnf6SCyOaqHuZojaSbnZsS6lpSQ0WGXlTu
	 Bdd/O9CuGUyiHlBZr28s8OI1YtLCvYZBcgphnA9AVQs0FnkH5a7A1OYhsUEGFt4p7U
	 58fPdx/UioRYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4BEB60671;
	Tue,  4 Mar 2025 11:09:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 457E6C5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Mar 2025 11:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29F1C40111
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Mar 2025 11:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 43R88ETDtM1I for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Mar 2025 11:09:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=martyna.szapar-mudlaw@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 302D7402BB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 302D7402BB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 302D7402BB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Mar 2025 11:09:38 +0000 (UTC)
X-CSE-ConnectionGUID: Z/P4LPGET3yRsmuFm5ERKQ==
X-CSE-MsgGUID: oeWiGjZ6RqGEifc1kK/ROw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41247085"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="41247085"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 03:09:37 -0800
X-CSE-ConnectionGUID: kAA3rgkLQay6ZsN+609Kog==
X-CSE-MsgGUID: 8wuO6+UZS+mHJOFQEucJ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="118341573"
Received: from enterprise.igk.intel.com ([10.102.20.175])
 by fmviesa007.fm.intel.com with ESMTP; 04 Mar 2025 03:09:36 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Date: Tue,  4 Mar 2025 12:08:36 +0100
Message-ID: <20250304110833.95997-9-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741086578; x=1772622578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qiOP6gb3TLfVUmI4JgcMNTSV7pK1WOQuDIMIDiHkvH8=;
 b=b3V1gDd3aZOotawktw0aDvG58z0Bxedx+RPoHPKbGO+BEvnvXkw9/GG1
 RPegoiI2tPUeRU5WctnAO185K0YWU5d/W1z4j9SuLzXdTe+NHMGl11bAi
 JTOBd1k0TaWFqxDrZd5cseEdhA6j9Y9ifOKjSoh+tv3WwU6VXcHsXZ0qR
 zndSi7iP+hBE97ys9KNnW5JbzDdT5fiatj0n6nXN01/xl9iRQeCPL7qKi
 0CpVzA49GJfUUeHxZA+axpGHkbq4LZalLCr15c0jLC4TGzfLKv1gH+llQ
 qsov9j1ffElt6PN/vULwYBm0NpK2yIZIGKi7D6qWxiaz0+r/LEUn4ywab
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=b3V1gDd3
Subject: [Intel-wired-lan] [iwl-net v3 5/5] ice: fix using untrusted value
 of pkt_len in ice_vc_fdir_parse_raw()
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

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Fix using the untrusted value of proto->raw.pkt_len in function
ice_vc_fdir_parse_raw() by verifying if it does not exceed the
VIRTCHNL_MAX_SIZE_RAW_PACKET value.

Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 14e3f0f89c78..9be4bd717512 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -832,21 +832,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		      struct virtchnl_proto_hdrs *proto,
 		      struct virtchnl_fdir_fltr_conf *conf)
 {
-	u8 *pkt_buf, *msk_buf __free(kfree);
+	u8 *pkt_buf, *msk_buf __free(kfree) = NULL;
 	struct ice_parser_result rslt;
 	struct ice_pf *pf = vf->pf;
+	u16 pkt_len, udp_port = 0;
 	struct ice_parser *psr;
 	int status = -ENOMEM;
 	struct ice_hw *hw;
-	u16 udp_port = 0;
 
-	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
-	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
+	pkt_len = proto->raw.pkt_len;
+
+	if (!pkt_len || pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
+		return -EINVAL;
+
+	pkt_buf = kzalloc(pkt_len, GFP_KERNEL);
+	msk_buf = kzalloc(pkt_len, GFP_KERNEL);
+
 	if (!pkt_buf || !msk_buf)
 		goto err_mem_alloc;
 
-	memcpy(pkt_buf, proto->raw.spec, proto->raw.pkt_len);
-	memcpy(msk_buf, proto->raw.mask, proto->raw.pkt_len);
+	memcpy(pkt_buf, proto->raw.spec, pkt_len);
+	memcpy(msk_buf, proto->raw.mask, pkt_len);
 
 	hw = &pf->hw;
 
@@ -862,7 +868,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	if (ice_get_open_tunnel_port(hw, &udp_port, TNL_VXLAN))
 		ice_parser_vxlan_tunnel_set(psr, udp_port, true);
 
-	status = ice_parser_run(psr, pkt_buf, proto->raw.pkt_len, &rslt);
+	status = ice_parser_run(psr, pkt_buf, pkt_len, &rslt);
 	if (status)
 		goto err_parser_destroy;
 
@@ -876,7 +882,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	}
 
 	status = ice_parser_profile_init(&rslt, pkt_buf, msk_buf,
-					 proto->raw.pkt_len, ICE_BLK_FD,
+					 pkt_len, ICE_BLK_FD,
 					 conf->prof);
 	if (status)
 		goto err_parser_profile_init;
@@ -885,7 +891,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		ice_parser_profile_dump(hw, conf->prof);
 
 	/* Store raw flow info into @conf */
-	conf->pkt_len = proto->raw.pkt_len;
+	conf->pkt_len = pkt_len;
 	conf->pkt_buf = pkt_buf;
 	conf->parser_ena = true;
 
-- 
2.47.0

