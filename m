Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3461C5479D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Jan 2023 11:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41546418B7;
	Wed, 11 Jan 2023 11:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41546418B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673435157;
	bh=835obYBSxoweCh/f5KegX7pFo6fG3BlsXZBZxJDiCUg=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=D1JEaN2P/B+u8rMqPYTCbxUUr5E6TKXUtp65+E+Y3u9LcUJ2fVK+bf+vEckSFUQhf
	 vuEm+ySpajO8NV3FiCOa8RFOudwzaBd87Du4AF1nFm/ZfKrHNZ2otWAhXaxBoIqDMa
	 G6/4o6tmRNwEyhj+LSsUDJjNrHmIzv9uOYl5eGAfsjNN0dhO0Tan5nHYYR50M9OL0d
	 ySZWtFfwWld+NImw+dA17XGcuiQITRfNxLkBrKXSzYmUtEnOeC9Ly7VOrb8Lcbx0Xn
	 fURmLh+iuSOsRwV4L04Nqm8L0u1Ws90tVcFd0W53eB+KKNjjwzMG7QFsBpE/oPCtJZ
	 9jNJBfeL+6TmA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdKf_d6THJZy; Wed, 11 Jan 2023 11:05:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 119FD418BE;
	Wed, 11 Jan 2023 11:05:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 119FD418BE
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2D9F21BF5A2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jan 2023 11:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 014BF40104
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jan 2023 11:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 014BF40104
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jen4024Vb7yl for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Jan 2023 11:05:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CD9C400B9
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CD9C400B9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jan 2023 11:05:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311195295"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; d="scan'208";a="311195295"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2023 03:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607314992"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; d="scan'208";a="607314992"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by orsmga003.jf.intel.com with ESMTP; 11 Jan 2023 03:05:47 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 11 Jan 2023 11:36:30 +0100
Message-Id: <20230111103630.17629-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673435153; x=1704971153;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X166XJ5Ew7CZtnkWnELJKWex4h0qJBzLTNXnxepF/qg=;
 b=H1AFPtrAStfi8oUo8qfjVAatqp3Dt5rowMq0IKKXQzhpUqDPzuHPnA5Y
 QeV6lK3+N5G8JNMDuK/EVZj4k+2rZm/1byBfY/F/rsDLNCWgjM05xIeJk
 hGwFFIa1W7Z6Mzaeqh4euzjhX3aAHwK3/U++qhln8yN0YSoeUZVB7KAly
 ASa9Q4nVmgtFVSX7E9CYm0w3ZyYFVVeV1NPCNDAleL3xSuhCOK7zV8QKM
 asXOYeYIT3Qw0J7BT6ETxPD39xR4y6TB1RkRfDcqEefYPWZpEf/+HJwup
 w8xBlGlSFEToWVsFFVm3QfMVWMfp45RpuWp4tBTTOr1KylSJls8kPPq1N
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=H1AFPtrA
Subject: [Intel-wired-lan] [PATCH] ice: memory leak in
 ice_vsi_alloc_stat_arrays
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
Cc: anthony.l.nguyen@intel.com, error27@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fix memory leak by checking if stats were already allocated before
allocating new one.

Previously it was completely broken, because new allocated value was
checked instead of previous one.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
Should be squashed with commit eace2cbe7f5f
("ice: split ice_vsi_setup into smaller functions")
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index a09cb4ac39e4..04f31a83e327 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -558,14 +558,14 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
 	if (!pf->vsi_stats)
 		return -ENOENT;
 
+	if (pf->vsi_stats[vsi->idx])
+	/* realloc will happen in rebuild path */
+		return 0;
+
 	vsi_stat = kzalloc(sizeof(*vsi_stat), GFP_KERNEL);
 	if (!vsi_stat)
 		return -ENOMEM;
 
-	if (vsi_stat->tx_ring_stats && vsi_stat->rx_ring_stats)
-	/* realloc will happen in rebuild path */
-		return 0;
-
 	vsi_stat->tx_ring_stats =
 		kcalloc(vsi->alloc_txq, sizeof(*vsi_stat->tx_ring_stats),
 			GFP_KERNEL);
-- 
2.36.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
