Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310521073CB4
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 13:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08BD040EB4;
	Wed,  8 Apr 2026 13:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4Bw-dbPSbq6; Wed,  8 Apr 2026 13:12:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47DC540EF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775653946;
	bh=fePrukWCaxAlNPDm+teJPRoawh5G3xRlDpw+4zygEjA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKcf8xh5qcNTUFiN6YHxBmPSRlaGlBvEkUCmwgPwF0tykrrnhTztuaPl3m6rrym8i
	 w0xGBS1TPF/ES4RibHDI1vZS/XSnaZ6G+H4ZnkKbAn9fwzlqboaJQOBQvF19vwanTf
	 8Gnx8eb6CbNegzWUGufBTKD2X3bpeEXPDKdIn3gjrXzztr6BZnE4aXmZOaJnv1yQfk
	 WEIWGJ008KnDro7/kdgwPxCJtEdfolb58yGtg5B4iLkHyOtEhX9rUJeqnl0qB8jrwH
	 xfRQ+0jP33JNDgcKQzd17Df1HyJ12fRqVYD3dfZu8Xe8clQDgZyBg+HCaRp0VAgV/K
	 09i7j1aV3TN0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47DC540EF1;
	Wed,  8 Apr 2026 13:12:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96B932C7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D32840EF8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FH2qnwnd76yA for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 13:12:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6989E40EC1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6989E40EC1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6989E40EC1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:12:23 +0000 (UTC)
X-CSE-ConnectionGUID: UR6cP9p8RMyfbyiuNejz/A==
X-CSE-MsgGUID: ASbHpyiqRmOaHpj0XSNsZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087269"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="102087269"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 06:12:23 -0700
X-CSE-ConnectionGUID: uGebgpyLTTCyRtx2CoLyKA==
X-CSE-MsgGUID: ycuKtKWZTu6GfRk2TxbdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="228715079"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:22 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Wed,  8 Apr 2026 15:12:11 +0200
Message-ID: <20260408131216.2662245-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775653943; x=1807189943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0eZTH5jLMaLPvyw05d6AwXy0c332K5yiwSJKtS18gg0=;
 b=SSaOFx5He0LUVnu3K3U/877T2LuxZrFgjXt2kNP6XEbvIrK8c+LQRTRE
 OZxwLE/2Wnaqe9T1kdx0o854GY4slSPdV5nGcFhVIVvN2pbCgwEJWZoCb
 OGoiwpW7bwibOsxWLlbJ6ehrspVknZ8paJJDxtbt+Edg8JISfQirPQAUd
 eGCB0E6wo175Y2wTsMzoWljBm+AK7T3ibQa+T3ucuWomAd4hZ0MWYqeRd
 7t0uJPUM0Newa1s2GkFsJ58mo8orP691yIfeSjYLGENFMDqb4k9mMYZ5u
 01IU435iCODZYYCOi6NZwMYdbFybxmW55X8PDmnqWiUEXeNXsQ/cLTsQs
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SSaOFx5H
Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/8] ixgbe: limit ITR decrease
 in latency mode to prevent ACK overdrive
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

From: Alexander Duyck <alexander.h.duyck@intel.com>

When operating in latency mode and the computed ITR is lower than the
current setting, the algorithm can reduce the interrupt rate too
aggressively in a single step.  For a TCP workload this means the ACK
stream (a latency-sensitive, low-packet-rate workload) can drive the
moderation down to very high interrupt rates, starving CPU time from
the sender side.

After the speed-based ITR calculation is complete, check whether the
result is in latency mode and would decrease below the current setting.
If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us)
per update.  This ensures the number of interrupts grows by no more
than 2x per adjustment step for latency-class workloads, dialling in
smoothly rather than overshooting.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Split from monolithic ITR cleanup; this patch only adds the 2 us
   per-step decrease limit for latency-mode workloads.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index b3f4a72..d7c5e83 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2888,6 +2888,16 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		break;
 	}
 
+	/* In the case of a latency specific workload only allow us to
+	 * reduce the ITR by at most 2us. By doing this we should dial
+	 * in so that our number of interrupts is no more than 2x the number
+	 * of packets for the least busy workload. So for example in the case
+	 * of a TCP workload the ACK packets being received would set the
+	 * interrupt rate as they are a latency specific workload.
+	 */
+	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
+		itr = ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC;
+
 clear_counts:
 	/* write back value */
 	ring_container->itr = itr;
-- 
2.52.0
