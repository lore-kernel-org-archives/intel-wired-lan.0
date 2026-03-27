Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C0610BA431
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A5F86129B;
	Fri, 27 Mar 2026 07:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X51Vd7M8nSOu; Fri, 27 Mar 2026 07:31:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5CDB61290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596666;
	bh=CxYJVqZcs+SuXUcMuDXP7eY085xAwR1Qp50LOdQ/NiU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dy+jPIoKb2bQHeNqWJGsMlK90+UC9QA0QKl9qgZcajq9cpEGKXY+5WgSp6vqlIj6e
	 KnIvH8W8yH3hcAb49ULiQrBTsMgErKYoJmq+jVWZrb+r21VcmSrFLdcVE7H9a18P2M
	 kEWZ7TdaDgl3M8zeeFReZRzVu63JuS+HC7dUu5LKtOghr9hWgVF6w1l/XcmxUNaiL7
	 SNBwm2sd9iuYnDyTixE2n2nh2jI1zAfkZKPl4SRRGh52KbdOyb7SrC9txebUys5pIx
	 IyjFQb9E0r3vS7+fYv2MMMFCHCe7+fniI9XLuEJdaU1Mdw4+17mGKWnlaW1S9dtqS/
	 DRKS31P+C0zAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5CDB61290;
	Fri, 27 Mar 2026 07:31:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 559CF249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C206415BB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZoNB7AevEAtx for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:31:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4F02E41598
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F02E41598
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F02E41598
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:31:03 +0000 (UTC)
X-CSE-ConnectionGUID: vkOlKlJoSCW8VWeNIk/IZg==
X-CSE-MsgGUID: GdOxrSltRRij8PohC6j5hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734333"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75734333"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:31:03 -0700
X-CSE-ConnectionGUID: iwt7FBKaQt+b0OKEi/VAiA==
X-CSE-MsgGUID: 7qbuhTliSaiKAsw4i5HMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255740432"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:31:02 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri, 27 Mar 2026 08:30:45 +0100
Message-ID: <20260327073046.134085-11-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596663; x=1806132663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yOMRZi0/3SiDel76zDrsB6VaNT3oaM/8FJKDjA+kZU0=;
 b=VbO0fJbfXNqIWI1PB7iiygScdKHm/8HBotFnK7sGam988QeY3/nK+lw3
 hJdKxK/0EEeP9gxFfHgLxK6ccwpmQ3K9GG8zggoC0szh2Fs4cY1CBQzI9
 UJfO7bS6vISXqWANUIOPUonViRPV9vLvMfdkhXFaBTkEmWpF6YMwktEi7
 yqHmtgkG9nrmgZJyHZuOSAUHlfASafpNfgjUqEGJvdXxLMfM8gjZaw72u
 70yBQK82xtALhATOsh6x4/l2u/Qt5srqOT2UdnfZBkAd2nLto20t/lmQd
 1da5A43jcW4MD9Ij1imvLBkU75wnuQQ4UTCOeiyO1g++faqli13RI2huM
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VbO0fJbf
Subject: [Intel-wired-lan] [PATCH iwl-next] ixgbe: fix ITR value overflow in
 adaptive interrupt throttling
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

ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
and a usecs delay (bits [6:0]) into an unsigned int, then stores it in
ring_container->itr which is u8.  Values above 0xFF wrap, corrupting both
the delay and the mode-flag on the next readback.

Separate the mode bits from the usecs sub-field; clamp only the latter to
[0, IXGBE_ITR_ADAPTIVE_LATENCY - 1] via min_t(unsigned int, ...) so
overflow cannot bleed into bit 7.  Add a WARN_ONCE() when the raw usecs
value exceeds U8_MAX so out-of-range ITR computations are visible in
dmesg during development and testing.

Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1885fe8..4d53bd63 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2901,8 +2901,12 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
 		itr = ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC;
 clear_counts:
-	/* write back value */
-	ring_container->itr = itr;
+	WARN_ONCE((itr & ~IXGBE_ITR_ADAPTIVE_LATENCY) > U8_MAX,
+		  "ITR value %u exceeds U8_MAX, clamping\n", itr);
+
+	ring_container->itr = (itr & IXGBE_ITR_ADAPTIVE_LATENCY) |
+		min_t(unsigned int, itr & ~IXGBE_ITR_ADAPTIVE_LATENCY,
+		      IXGBE_ITR_ADAPTIVE_LATENCY - 1);
 
 	/* next update should occur within next jiffy */
 	ring_container->next_update = next_update + 1;
-- 
2.52.0

