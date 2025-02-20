Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAB3C021B1
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Feb 2025 15:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 672A383B63;
	Thu, 20 Feb 2025 15:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lz3LEdg2EqEH; Thu, 20 Feb 2025 15:06:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE58A83B4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740063970;
	bh=OQlr7vaXJFJ3d7bqttB0+rwf0A5pL7UpavKV8hqmv/I=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CnjLRoYUEfMgNYzK/kLX+i9WJlPD4wgCGg2BokPZEfX2lFhHv9yD+534KxpllTuDd
	 VPDdDyvrLZvUE7N1/5gl6y6SMcxArEi2PpFPw7MDAU9UJ7KT7XtP6u8xNPdGA9a4QC
	 fgXZFL0s+62FXtamw4Y7pmRae06QFLnyTYWeClONH54pPebUqdy7s4gPo++nSFzS6g
	 ONqwJfAqNHwIv7PFi5MtXwfWjz0UEPloQI29TuyjMoc70FgriJhELqE58q4R8JE10I
	 p1Z/V7nAs/1UYBeHAmYEDnft39J5Y8jIleab/7bPHYyIzacAVFjZBOb8f5z7Tw506Q
	 CFGqib39cGkCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE58A83B4A;
	Thu, 20 Feb 2025 15:06:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1A84D92
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 15:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC3F860AD9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 15:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycOJ8gFo0Z8f for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Feb 2025 15:06:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=martyna.szapar-mudlaw@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 427F9608D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 427F9608D3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 427F9608D3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 15:06:06 +0000 (UTC)
X-CSE-ConnectionGUID: MzMDQVqqTqK960FJ2h4W2A==
X-CSE-MsgGUID: c8/apl2nRLi0BNaK1GtQ1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40966330"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="40966330"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 07:06:07 -0800
X-CSE-ConnectionGUID: GlqfI6puRCq6MSxpErXl4Q==
X-CSE-MsgGUID: pQiNB5hEQuOp/dG/+HOrWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="152257748"
Received: from enterprise.igk.intel.com ([10.102.20.175])
 by orviesa001.jf.intel.com with ESMTP; 20 Feb 2025 07:06:05 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Thu, 20 Feb 2025 16:04:40 +0100
Message-ID: <20250220150438.352642-3-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740063968; x=1771599968;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N8pSyv8OVgoNMKzhCWhIHqDZt2cLj11E5ZpGKsek5sM=;
 b=mxTRHH5crt0eBzZFfa5Eiye+9FsfVrFdU2cVdMyzZnBwGRckh3cXYynz
 uxqzBGVk+G+7XebffN4ljnr6BvYyqBAivY0nvTZ5h66D40Kw1w3P69xqS
 W6qvqtMNpAVzu7Z4k6sC0kD/jYE7/OSkTdO7cCHOetQoCtJ6tlvZbzkwc
 wjU8Kl+SkGzgUTejBXM4lDFGHu2qRJYBJqUIpgRjobPS3jbR73L2iGEhn
 X87NlZPS4nq7gODG1v+Vnvkh57Orii4dmepCQT8It7ExaK/XJBY8C5rqI
 S17z1aFCC3oECc0aIC101fTGS+bLR3MN59R2G3m6pgdqjswpKnCTyRhcc
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mxTRHH5c
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix fwlog after driver reinit
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

Fix an issue when firmware logging stops after devlink reload action
driver_reinit or driver reset. Fix it by restoring fw logging when
it was previously registered before these events.
Restoring fw logging in these cases was faultily removed with new
debugfs fw logging implementation.
Failure to init fw logging is not a critical error so it is safely
ignored.

Fixes: 73671c3162c8 ("ice: enable FW logging")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a03e1819e6d5..6d6873003bcb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5151,6 +5151,13 @@ int ice_load(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
+	if (pf->hw.fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
+		err = ice_fwlog_register(&pf->hw);
+		if (err)
+			pf->hw.fwlog_cfg.options &=
+				~ICE_FWLOG_OPTION_IS_REGISTERED;
+	}
+
 	vsi = ice_get_main_vsi(pf);
 
 	/* init channel list */
@@ -7701,6 +7708,13 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_init_ctrlq;
 	}
 
+	if (hw->fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
+		err = ice_fwlog_register(hw);
+		if (err)
+			hw->fwlog_cfg.options &=
+				~ICE_FWLOG_OPTION_IS_REGISTERED;
+	}
+
 	/* if DDP was previously loaded successfully */
 	if (!ice_is_safe_mode(pf)) {
 		/* reload the SW DB of filter tables */
-- 
2.47.0

