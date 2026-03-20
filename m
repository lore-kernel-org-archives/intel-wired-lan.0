Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01850FB5EA9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 05:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA8FE41C5D;
	Fri, 20 Mar 2026 05:05:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gQv8O9rwWIcX; Fri, 20 Mar 2026 05:05:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8B0B41C5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773983133;
	bh=dLkxn9fk3Y9l2n9qYw56GlJLracpssxlBgxOWg8EV54=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oFQ7e3jKYmJhAVG4fCud9F4YscihdRKEy1wDy8Nkmyh3p+8iUOH0LSrS2f/eS161W
	 DjuobQc7QWjEzYg33kPKV0mpHOFzLClkr/M6VJ8UyNAl1cUnuP73sP9wWZ+O7AtUUl
	 1TP4AfvtQwhHeAw3daTOboZrbfncV6SgbQfjRnY0iam6+Lfz14wdoC1muqjGg38YVU
	 CV8ortkQr8+J2MuRpcGNlYEGHs8vZ02PuwolRXYocOFYkRLV1dj5ZOu1kkQ+37Zdsl
	 1sZ2mAX4uRNaO+IEOLt8J1fOlbLYVo2I25oA2T9cbkQMy0JsN08N8u1u7Hqgy4SSsP
	 YFOz+49s74Ylg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8B0B41C5C;
	Fri, 20 Mar 2026 05:05:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C53331B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B699D41398
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXCh34giObEz for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 05:05:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B51E540176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B51E540176
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B51E540176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:31 +0000 (UTC)
X-CSE-ConnectionGUID: MKs0alepTk2P+8G8LQ5unw==
X-CSE-MsgGUID: dH5whT9fSVenteuW6jvvxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522700"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100522700"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 22:05:31 -0700
X-CSE-ConnectionGUID: VL+GCF4LTYi9OMCLWTHqhA==
X-CSE-MsgGUID: l8roNfj2T+WGvLsYnceymQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227307273"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:30 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>
Date: Fri, 20 Mar 2026 06:05:29 +0100
Message-ID: <20260320050529.422444-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773983132; x=1805519132;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vZiBu4ec5AGCXwkaEd7J0BaSO9yTENngMpzIttwN8Vs=;
 b=WykrsTTYD2ekdX+mBH1Jxp3E/51zd/zY8pstzl8+cuUIAbGsNhJJ+NSS
 d/+FrdqMq5sYdAZlGTkwcAD+x5lNV/9xL5+mdlnN4fTKCY8R/6nfznfPg
 6qyE0NxXKqTS3mPTxkmXHRERxAUo7ACxIoROYiZNWumy+i9NFR4b+0ziv
 86nySo8sbe9oRdAFs59LAQK2UoiNIT+ZNegInVP/2xDuNq+8UDC+MTGEN
 A8KV2M1qpXd0Zy8GwiEXmbmKaCA6AKzkiyINaNxGucrS3tPrsSDi2oDt2
 e9qLnQSGD+NMeKgTeb3LEFttZoHQB1ib3KymUCyI+ANvOo2f8smFqnman
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WykrsTTY
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: fix allocating excessive
 memory in ice_create_lag_recipe()
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

From: Marcin Szycik <marcin.szycik@intel.com>

For some reason ice_create_lag_recipe() allocates an array of 64
struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
Fix it, while also using kzalloc_obj().

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 310e8fe..70357dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2418,8 +2418,8 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
 	if (err)
 		return err;
 
-	new_rcp = kzalloc(ICE_RECIPE_LEN * ICE_MAX_NUM_RECIPES, GFP_KERNEL);
+	new_rcp = kzalloc_obj(*new_rcp, GFP_KERNEL);
 	if (!new_rcp)
 		return -ENOMEM;

 	memcpy(new_rcp, base_recipe, ICE_RECIPE_LEN);
 
