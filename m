Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F5A10BA431
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E17876128F;
	Fri, 27 Mar 2026 07:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SaaRAdEPcEN5; Fri, 27 Mar 2026 07:31:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D64361294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596660;
	bh=pzVZqQx+zNxLILb4VSF1Ne4hCQ6T4bxU06RchArOwmE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CBEok3b2y/Or1VZmMYQTyGEWY/QXlvDRRLSinjhYOjMLddJ3pFLHTM8rQztUP9FF0
	 lj21vZVndvRstxp0yNZxRMlCgQJfBIqpX12iNhjVUY6QtyLiBmdn1wz3kZL1+FtCWJ
	 LEN/hGpfLAYEHM3EkLyLWxAY191KB8S5uZhxBGYVA/7b4Uboh0wTlgnlrL4PEZGQmj
	 CGllKjeHCvqB3wjDNh4wKTJfYYGrjLUhLUPz2P0Ql8vQjsSPARpJ3UrsJrchqXlrhU
	 nEhjQG1HObuVi3A1Fg0v3UZs5Rvk4MsZvIG7DjQnM54/sZbbkFgwU/9e3fsrJ6Dkqe
	 6+rhaHjved65A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D64361294;
	Fri, 27 Mar 2026 07:31:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FC3B2D5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35F4B415BB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCixcMoE6Ppb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:30:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 892DC41598
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 892DC41598
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 892DC41598
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:57 +0000 (UTC)
X-CSE-ConnectionGUID: tnTBNAcRT4arY+F1+whqdQ==
X-CSE-MsgGUID: nQp+r11iSaaSpECWrNJFtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734323"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75734323"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:30:57 -0700
X-CSE-ConnectionGUID: kQHlWfSpQc+Hkq5bXt/UQg==
X-CSE-MsgGUID: 499SjdDKSpKu7eVmtKmEOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255740388"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri, 27 Mar 2026 08:30:41 +0100
Message-ID: <20260327073046.134085-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596657; x=1806132657;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GhyhVUi9567WvHp2hgmGCYL2GTomIqZM8EX4xHVseAk=;
 b=MwAbb/x1ZALCvKILdw95hID9WNguby7v6tiC2i5H9iYQkks4pEzYcSB2
 sPq4u3z5p+l1OJq3aHlqOtJ4jJRxx4WZ2+y6UHWzJQ1Ol+5Gth/rRyzSG
 MvNu+OmWaD400DuDZi7NejWhmzLtlidPjoUX8qY/BQcW09oCJ26UJ9Wb7
 8Q2OSlyXfhmldcGGfIrRTzMAI/0MU97EhQDVqCS+YcIcDfZ6xpSAJI5Py
 CBQozPOYxbP3ZIa47u/y1AqKCc1blZVybXCkIu1WqO6cApOx4UMzA/Sk4
 WoAns7PfLrWDOH4f2vK4biMbIQgHX7tssBxZJD85mzcphBAKonsyW2mzU
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MwAbb/x1
Subject: [Intel-wired-lan] [PATCH iwl-next] ixgbe: replace GFP_ATOMIC with
 GFP_KERNEL in ixgbe_fcoe_ddp_setup()
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

From: Sebastian Basierski <sebastianx.basierski@intel.com>

ixgbe_fcoe_ddp_setup() is always called from process context (FCoE
offload setup paths) and never from an atomic context.  Using
GFP_ATOMIC is therefore unnecessarily restrictive and wastes memory
allocator headroom that is reserved for genuine atomic callers.
Replace the dma_pool_alloc() flag with GFP_KERNEL.

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 011fda9..7fa0971 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -193,7 +193,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	}
 
 	/* alloc the udl from per cpu ddp pool */
-	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
+	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
 	if (!ddp->udl) {
 		e_err(drv, "failed allocated ddp context\n");
 		goto out_noddp_unmap;
-- 
2.52.0

