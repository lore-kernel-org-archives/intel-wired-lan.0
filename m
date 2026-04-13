Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22943EBFD0E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 07:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAD0F61AE0;
	Mon, 13 Apr 2026 07:30:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4KoCwcPxq6jl; Mon, 13 Apr 2026 07:30:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B84BB60E5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776065444;
	bh=og/j4TlreguYXD0yr+cs+2W41woIQoHjAvJTaNm6lq0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YZmx036ljEXRoam1J9ZQNPuLO8muPILk1hJRaN8OcHrKyui5hVibITfZUPaxsJQ3A
	 jUulSh052ctbLl2xwG2lcJgedqjHnLCpWQoUywDcphK6DjZdRWaT7teOR12CjB6Sr0
	 ATlLC0tGsLPjXWuTWDaN8PBcv9mYHJihsBtTiOSC4tXvGIC7EufPI5XU3IbwFkHXJn
	 CF8R5Lwk4zpYVGDJgoo6br6NvmiUD1jpxIj/YonAkVZtCXw1bohg//pIXTNm3MZ6Hc
	 zPfqjO+FwrybCJzHrdr5XPs+nE7s3uMbHxNV7Kh7K2/JkQX4NtdUIz3JWiEDo2yqJ3
	 vaEqUUDjIg5dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B84BB60E5C;
	Mon, 13 Apr 2026 07:30:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C03A7237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 07:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B24B9840F9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 07:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 577uCap7j9iE for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 07:30:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A43478238D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A43478238D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A43478238D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 07:30:41 +0000 (UTC)
X-CSE-ConnectionGUID: SdV2vwpNR32v4Hgr3bFnYw==
X-CSE-MsgGUID: NkS5jx9tSIG1jn/YTzbkHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80876627"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="80876627"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 00:30:41 -0700
X-CSE-ConnectionGUID: 9TDA8Ro9Qaeqerei148juA==
X-CSE-MsgGUID: 6nEkX4/dQ3elTlU7VBScrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="267700541"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 13 Apr 2026 00:30:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Mon, 13 Apr 2026 09:30:32 +0200
Message-ID: <20260413073035.4082204-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776065442; x=1807601442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q2VxeAv+3WTmb5fk+gyYvqLE3UVXnKyqFELWxysd6/o=;
 b=PhYKpovcCTH+pY3u+nGuwDcBbnrzUypatvBXDsPv9KcoUMQLzTweHKLp
 I47Uq7Skq5rYaIOjAlVWLGVcBFCUQmuSQC7OL+RDE5ZfuMqZTzOy9hxmr
 XYtEQGZT+u44pPdhsgzqTGijD94IcjTJwJwBKLOupQMncRW8EFOiatZGa
 NRPhfjIf/relLaTSZiq2uuDrxBghP0KDrAy3ql0jVNdjbJomc081ljzb/
 G95hE5WbOPWp0cSGw0j2PJZAuFHDhynVH8y2s178fBSHawy/XwgFPY2ou
 qeSvUnCKmhfQx156BqVPUt00o13Yc/u/5r1QtA6QXAO/1JAAYgHdDszOL
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PhYKpovc
Subject: [Intel-wired-lan] [PATCH iwl-net 2/5] iavf: fix error path in
 iavf_request_misc_irq
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

From: Piotr Gardocki <piotrx.gardocki@intel.com>

When request_irq() fails the interrupt vector was not registered for
the driver. Calling free_irq() on a vector that was never successfully
requested triggers a kernel warning. Drop the erroneous free_irq()
call from the error path.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001a..ab5f5adc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -587,7 +587,6 @@ static int iavf_request_misc_irq(struct iavf_adapter *adapter)
 		dev_err(&adapter->pdev->dev,
 			"request_irq for %s failed: %d\n",
 			adapter->misc_vector_name, err);
-		free_irq(adapter->msix_entries[0].vector, netdev);
 	}
 	return err;
 }
-- 
2.52.0

