Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DD7C35FF8
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Mar 2025 10:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24C82407E1;
	Tue, 18 Mar 2025 10:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rohzQwFVA3pZ; Tue, 18 Mar 2025 10:39:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 464AE4070C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1742294396;
	bh=DG9FwWDdzCcDwdPAanNITZd6r7bnBIThE7IAa5oh1xw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E/QTCQ1J0bzw28XC8kK0fGJoVSfphpKUmJJfKqpa0MCqwu6oAkKHegFwGtgef+QbX
	 0vmYiY1oYBT3+e4bLnEbbrDLWpWmN5raRy+rfrCqVHTrZQyfShftBOyi9+9d60uNE/
	 u2FueOvHl9s3+cIS8W6pLtH8+/J2werLHku7xtLY/mlQcMjsfCteS/xL9SmO24+7SZ
	 RFXw2fAfXY3Fl5r/HbM5PRpFQTXIGa3ZtF3sgfn1dtCjn+LHIiqc1H1xwWFy7a+YhX
	 I0//nyo+QtKjmj9chuLomf8zrC9nAx7PC2g4CSYxkGvJkxdtgr/RcPInlqFFYdONqH
	 SFI+/NuB5kBRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 464AE4070C;
	Tue, 18 Mar 2025 10:39:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4889C950
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Mar 2025 10:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C84660B85
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Mar 2025 10:39:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RnogcPi9UC2O for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Mar 2025 10:39:54 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A4C0D6076B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4C0D6076B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4C0D6076B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Mar 2025 10:39:53 +0000 (UTC)
X-CSE-ConnectionGUID: MeLssLavS7uy8ZONJo0hjg==
X-CSE-MsgGUID: AdMoyCzvTsG+udhvanKUXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43295033"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="43295033"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 03:39:53 -0700
X-CSE-ConnectionGUID: j0MwY1m6QvSPiiQVsQkf/g==
X-CSE-MsgGUID: wX3EbzFqQrqhPlKP/f5UVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="122047734"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
 by fmviesa006.fm.intel.com with ESMTP; 18 Mar 2025 03:39:52 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com
Date: Tue, 18 Mar 2025 11:39:51 +0100
Message-ID: <20250318103951.2601636-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742294393; x=1773830393;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=v9loGqs5oqOSFLPJVsGTnWQYg5/NeYAjmDHJiRvYrFE=;
 b=ZwZ1ktMoVmxqf/upnWq5HzKByTeKkxZiB+sLUPJWlT9Xs+gIHF/peazu
 nuTp+4xiekXbivY2kttJ5jksP5M8VGDvROgDBt1bSUspcoQ+0H61mPgUi
 eDySDF4ku1oURorLxPAe1zwV4qo3j8GvpFP1S6Pke7ErbhNd4r0K0nP+f
 tPY1OiCBqSXe8Frt97AoeFQjPSuJDhqcIUgVPiokBrxO1QGskXwCj3+cj
 q7gRkWlhxMc24dPfRUm8NbL19r6C0YvfJSGDBucliTMXXdeXdo8+BuyFx
 8M5mdjTDBYZA2NuXDXZuR307JxN5owa3nZOdWC8KD7qs34gew9K+V4pab
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZwZ1ktMo
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: initialize bitmap for
 storing MDD events
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

Uninitialized bitmap is sent to function which is only setting
corresponding bits when MDD event occurs. Heaving random values in this
bitmap leads to showing MDD events when there is no such events. Fix it
by setting bitmap to all zeroes before calling handle_mdd() function.

Fixes: 61cb1bcf7e2a ("ixgbe: check for MDD events")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
To be squashed with 61cb1bcf7e2a ("ixgbe: check for MDD events").
The changes are only on dev-queue. There is a bug found by validation.
Tony, if you prefer I can send whole series with this fix in. Up to you.
Thanks
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 8a1fc7f06007..bd9a054d7d94 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1374,6 +1374,7 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter)
 		return false;
 
 	/* Did we have a malicious event */
+	bitmap_zero(vf_bitmap, 64);
 	hw->mac.ops.handle_mdd(hw, vf_bitmap);
 
 	/* Log any blocked queues and release lock */
-- 
2.42.0

