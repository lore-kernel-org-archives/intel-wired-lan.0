Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36D9C4332F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Dec 2022 11:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E1F08134E;
	Mon, 12 Dec 2022 11:32:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E1F08134E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670844778;
	bh=6h3vyZ3fx29AE6gz2sc23FSjO55M0/pIgn/5xYU/3e4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=O7EHDiS/D+byz3aM9QyU9dFnk0ootSP0eZXnHHSPFFDqPH6U7mSIvCbHBZHq3TH94
	 fLnsTrGeL9+Gci3zb26IHOXUzy+i51XorpxVUC9MsEWVMJg4lmvue7mT3U9RH9fdM7
	 4gyGMztdJO7vW7Y1niUTFiC8QVGlkS6FH/wMPiTF3HXGw1q1Y3KpM35kjkTx9qSpVQ
	 kxnNCtMjl2U7kwhKjXWzvuCtgGxBJaWMszB1mA9dCXy1zGn/3ffOnlcXWAH8CF1UNc
	 L1lWc/waBK/aYTTf8B3vIXti5cwtYpXNvobZ90ntYc2BXjbQS1Gs9sK7oTMK6d9Xhk
	 b25xKMW+KiwPg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0WmE1TDt9W69; Mon, 12 Dec 2022 11:32:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5F4481353;
	Mon, 12 Dec 2022 11:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5F4481353
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1ACDA1BF2B6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Dec 2022 11:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0328C81353
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Dec 2022 11:32:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0328C81353
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6r41-QovyOz9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Dec 2022 11:32:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B13C8134E
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B13C8134E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Dec 2022 11:32:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="317861440"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; d="scan'208";a="317861440"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2022 03:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="893459697"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; d="scan'208";a="893459697"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by fmsmga006.fm.intel.com with ESMTP; 12 Dec 2022 03:32:51 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 12 Dec 2022 12:16:37 +0100
Message-Id: <20221212111645.1198680-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221212111645.1198680-1-michal.swiatkowski@linux.intel.com>
References: <20221212111645.1198680-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670844775; x=1702380775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hQRjRJRxu6zvKZ+KBQHMEO2sO57BiWQYMINIf++VJxo=;
 b=k+qKDPO2hHNJFSybnak5CsdFXWFpLpVDl74zJGejRg48MHgi9N1W1QLh
 FQyAk/uTPANyIc2YjkUfiP7Gc/7ldNfZzum//+IevXIbuPTmRm3aiPttK
 tik6rtKifOlQw41mk5mIpWAG3MG2hR2qg6JM4Ge3V1wfpjy+WycO/1jbJ
 rCb6/N60M8PrHZK3zwP5AgYQzD1p6GqOVE6HGH3blVi6Y2Zuhknwfnlqc
 2jNtfc+pCw6U5a0IzEaeVqsfPalxa92TIJHAevt+ThSGJzFUvWVJYPyul
 kydTSW5YqfM0PMFkT7Smsof4SCyIlqEKuwBurwy9j1KRC/oK7pmDTxTxM
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=k+qKDPO2
Subject: [Intel-wired-lan] [PATCH net-next v1 02/10] ice: alloc id for RDMA
 using xa_array
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
Cc: mustafa.ismail@intel.com, leon@kernel.org, benjamin.mikailenko@intel.com,
 jesse.brandeburg@intel.com, leszek.kaliszczuk@intel.com, kuba@kernel.org,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, shiraz.saleem@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Use xa_array instead of deprecated ida to alloc id for RDMA aux driver.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_idc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 2148e49679b1..36f6d34d5cb5 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -6,7 +6,7 @@
 #include "ice_lib.h"
 #include "ice_dcb_lib.h"
 
-static DEFINE_IDA(ice_aux_ida);
+static DEFINE_XARRAY_ALLOC1(ice_aux_id);
 
 /**
  * ice_get_auxiliary_drv - retrieve iidc_auxiliary_drv struct
@@ -352,8 +352,9 @@ int ice_init_rdma(struct ice_pf *pf)
 		return 0;
 	}
 
-	pf->aux_idx = ida_alloc(&ice_aux_ida, GFP_KERNEL);
-	if (pf->aux_idx < 0) {
+	ret = xa_alloc(&ice_aux_id, &pf->aux_idx, NULL, XA_LIMIT(1, INT_MAX),
+		       GFP_KERNEL);
+	if (ret) {
 		dev_err(dev, "Failed to allocate device ID for AUX driver\n");
 		return -ENOMEM;
 	}
@@ -374,7 +375,7 @@ int ice_init_rdma(struct ice_pf *pf)
 	ice_free_rdma_qvector(pf);
 err_reserve_rdma_qvector:
 	pf->adev = NULL;
-	ida_free(&ice_aux_ida, pf->aux_idx);
+	xa_erase(&ice_aux_id, pf->aux_idx);
 	return ret;
 }
 
@@ -389,5 +390,5 @@ void ice_deinit_rdma(struct ice_pf *pf)
 
 	ice_unplug_aux_dev(pf);
 	ice_free_rdma_qvector(pf);
-	ida_free(&ice_aux_ida, pf->aux_idx);
+	xa_erase(&ice_aux_id, pf->aux_idx);
 }
-- 
2.36.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
