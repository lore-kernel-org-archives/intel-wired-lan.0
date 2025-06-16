Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B991C71136
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Jun 2025 19:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EEC5809B9;
	Mon, 16 Jun 2025 19:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zPT4v33dVT1e; Mon, 16 Jun 2025 19:03:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D703080977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1750100582;
	bh=C3nnJ6oQlD2ATaLqTA6oRPsA/tHUx1YHfphzrgtRO4Q=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zTiwWhbS358UmR0fqBafv+U6l3HVUR+YxAIgEPD4FdruH0b85CbE//b+epUedeGAw
	 0LpX8rpJm4gxZ5H0xxY70wDLxe2enUkovZEEoq+mo25h5hVAgu8bhwt7rLuA4JaJDP
	 z9wisTyatMuH7QBZhit1el17ABbQO+Wro3Vy8/028YpDqTT51KJQmuVbRdahnNL2Kk
	 Eq4VM6LUNBgtiuMsBUDD8fUUCxIbZnB0ak2L7WuOYNbIEdn5jPmUXOJ5DT96GhF9+B
	 dMXVHzhSzmlI9AAuo1i67raOXgqMWuv8ZU5l9KKd8ErvsW21NzDNzbIku3HtKlNiQj
	 pc3DxFq6KKXEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D703080977;
	Mon, 16 Jun 2025 19:03:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DEA116B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jun 2025 19:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96A48808BC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jun 2025 19:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3NCW3mNO9Od5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Jun 2025 19:02:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=david.m.ertman@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E890C8087F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E890C8087F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E890C8087F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jun 2025 19:02:57 +0000 (UTC)
X-CSE-ConnectionGUID: 0kppWz7iT0e59CpeUlruRg==
X-CSE-MsgGUID: b/6rfJDOT7+2dfyGUQifSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52122667"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="52122667"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 12:02:56 -0700
X-CSE-ConnectionGUID: PauuD7dzRsOXWSpuT/qfZQ==
X-CSE-MsgGUID: +JAzt4KpTtWG0MAl6fnvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="153513101"
Received: from dmert-mdev.jf.intel.com ([10.166.5.145])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 12:02:56 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Mon, 16 Jun 2025 13:03:17 +0200
Message-ID: <20250616110323.788970-3-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616110323.788970-1-david.m.ertman@intel.com>
References: <20250616110323.788970-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750100578; x=1781636578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z2es/tY4Vv86xArJxnQz8mDZrDjH7nKpNM4N584f5TE=;
 b=WK1J4WHcEJMQPjlvI9ilmDJfISDZ5Optk+GVJLQQqzEc93mr98pTN6dy
 Dpgw+Ji3QqCani96tjTLLtg6i0ReZWMpBIdqlEpNFcs5vc7oEZr81pB7/
 JzYXAfAEw2ZVmG6FcChuUc3fNR/sRKvdbO+2Kfkr6cvA56v1+ks2HkSmn
 JCfIeToSUVQOHeGexSPge4CCyXFKNbn+7f58ZkYwKP03KVPvkAv/gzTxK
 nNSSKLPkCsANN+nINo+LGeVT6n1tEgy6a4npcNRBRGDlQrhctRq6kAL+I
 JeOQMBiK6Gbsm4TznApfWHMVeY7xrxhMec5Jp0AiKQTyRTjCD01qzWyFS
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WK1J4WHc
Subject: [Intel-wired-lan] [PATCH iwl-next v4 2/8] [PATCH iwl-next v3 2/8]
 ice: replace u8 elements with bool where
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

appropriate

In preparation for the new LAG functionality implementation, there are
a couple of existing LAG elements of the capabilities struct that should
be bool instead of u8.  Since we are adding a new element to this struct
that should also be a bool, fix the existing LAG u8 in this patch and
eliminate !! operators where possible.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_type.h   | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f7fd0a2451de..29a02a0348b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2219,10 +2219,10 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 			  caps->reset_restrict_support);
 		break;
 	case ICE_AQC_CAPS_FW_LAG_SUPPORT:
-		caps->roce_lag = !!(number & ICE_AQC_BIT_ROCEV2_LAG);
+		caps->roce_lag = number & ICE_AQC_BIT_ROCEV2_LAG;
 		ice_debug(hw, ICE_DBG_INIT, "%s: roce_lag = %u\n",
 			  prefix, caps->roce_lag);
-		caps->sriov_lag = !!(number & ICE_AQC_BIT_SRIOV_LAG);
+		caps->sriov_lag = number & ICE_AQC_BIT_SRIOV_LAG;
 		ice_debug(hw, ICE_DBG_INIT, "%s: sriov_lag = %u\n",
 			  prefix, caps->sriov_lag);
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 3d68f465952d..e40ea754f91b 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -293,8 +293,9 @@ struct ice_hw_common_caps {
 	u8 dcb;
 	u8 ieee_1588;
 	u8 rdma;
-	u8 roce_lag;
-	u8 sriov_lag;
+
+	bool roce_lag;
+	bool sriov_lag;
 
 	bool nvm_update_pending_nvm;
 	bool nvm_update_pending_orom;
-- 
2.49.0

