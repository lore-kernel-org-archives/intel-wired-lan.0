Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F9CC4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Dec 2022 11:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D53840B59;
	Wed, 21 Dec 2022 11:54:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D53840B59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671623647;
	bh=5q8Jx0RCvetMATsWuZMwio6ec79x1f62yKZFQPsIjAA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SBMDxk/4F+3t8aKBik+LYSZrQGU1z7YkE3S58pqqQD3eRD0vRdtFkHqSe+zYZsnbU
	 Z7kVZYcmvrT7BBhmndO23dCyjck1zMjRzkHr/WP3mEXdYqiXk9twfp2AB5Y8YrOPQa
	 KuSrtLq+kqOqfPC+E9TU7h73wCNFbMTFovK5Lxxm4EX3GdGbKIuqCyXJnp95hOKNUx
	 S09mrMug1Nsb1bBLhPWPBuEhxMeJ5Xr3lLm1TAb373QRQqK+wEYrJU2G4HqWUJDvN+
	 lS6j1t5R4kWFlmGgZ3CD+zysCuztdXqZswTf0njqVmfmihzTQn4lOLQcYCf8+QjdZv
	 DCLE1oSWzSH7g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0oIqMrf9voN; Wed, 21 Dec 2022 11:54:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE43E40B88;
	Wed, 21 Dec 2022 11:54:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE43E40B88
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 084AA1BF616
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 11:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4D8D81F3C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 11:54:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4D8D81F3C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SLUpqp646yHq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Dec 2022 11:54:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1F2D81F25
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1F2D81F25
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Dec 2022 11:54:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="321766150"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; d="scan'208";a="321766150"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2022 03:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="714799348"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; d="scan'208";a="714799348"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by fmsmga008.fm.intel.com with ESMTP; 21 Dec 2022 03:53:59 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 21 Dec 2022 12:38:14 +0100
Message-Id: <20221221113822.12858-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221221113822.12858-1-michal.swiatkowski@linux.intel.com>
References: <20221221113822.12858-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671623642; x=1703159642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RGhxY1WcWjeK9Ck3s1XWaiH0nTPWhb8gwqUkEEZ9TeY=;
 b=jtWr+w6DpCYdqQ1GCfylotfYxe9m4IzqEz0KE4u20MlT9clpvxPxAa32
 Mb6Ur0dnaI2jJpW/et4dlrBF8TBkPk6Z34GsVPPt0UHB2L+0HH63x3PAR
 FUmQ0JAWL7CYmbe0tJpotS4rEyyx7u6SunR3VH1Ll1o52cj70YAcTmsJc
 SlSe5lbYwdBX3qxiD6YGgmcxLsba8crQC8vU8Vl3buvDBooifvSFcaezd
 B89Aa7MsV4O27HE2gNhrORxjBCm+QVUqqvf4/4otFg9j1TfXY17vkx01g
 FCTKgx4iudhE61SgjpmaNzn7awz7vXnZsLWAFoP4Htp6hHxd7e5bguv9L
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jtWr+w6D
Subject: [Intel-wired-lan] [PATCH net-next v3 02/10] ice: alloc id for RDMA
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
Cc: mustafa.ismail@intel.com, benjamin.mikailenko@intel.com,
 jesse.brandeburg@intel.com, leszek.kaliszczuk@intel.com,
 przemyslaw.kitszel@intel.com, shiraz.saleem@intel.com
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
index 579d2a433ea1..e6bc2285071e 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -6,7 +6,7 @@
 #include "ice_lib.h"
 #include "ice_dcb_lib.h"
 
-static DEFINE_IDA(ice_aux_ida);
+static DEFINE_XARRAY_ALLOC1(ice_aux_id);
 
 /**
  * ice_get_auxiliary_drv - retrieve iidc_auxiliary_drv struct
@@ -349,8 +349,9 @@ int ice_init_rdma(struct ice_pf *pf)
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
@@ -371,7 +372,7 @@ int ice_init_rdma(struct ice_pf *pf)
 	ice_free_rdma_qvector(pf);
 err_reserve_rdma_qvector:
 	pf->adev = NULL;
-	ida_free(&ice_aux_ida, pf->aux_idx);
+	xa_erase(&ice_aux_id, pf->aux_idx);
 	return ret;
 }
 
@@ -386,5 +387,5 @@ void ice_deinit_rdma(struct ice_pf *pf)
 
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
