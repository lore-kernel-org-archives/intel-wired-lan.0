Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8148ACD3427
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 03:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57AD34144E;
	Fri,  8 May 2026 03:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ad8O3UcmNJkG; Fri,  8 May 2026 03:12:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3EF641450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778209962;
	bh=ana1K21wqOyYBD38NqY4DLEEioCig1M2YENndvror/8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=orpk7hXFDrYnD3rDyth03/mWIxmIdjgB3bBKhivmF3w7I4RY24fBAuZxI0Wj1dc1H
	 2/rBAOeYdHVaDCViFEg2fl/WW2UQA2+Jbq6gZdRvyk/XPilkGR94eO7Hq7Bv7kYprm
	 K/BvObyembP8c9WIqYMKH6GlVv/b96N7n1kEPfmahHDpaxpcRV0Tmqz9YZEeFzYVzd
	 h1F19Gzktd1hZ8oSubja2AaFHMmDhHySGo/PgmhnTT3vu7179Y1/irK8PkMRRHv0xm
	 ufGVB++VesK6nanEaQzoTBsAAar1Dmafu/1aZ968bKdY2wLIfNTAul195PweKdcqkQ
	 MmUK0Pe0NAYTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3EF641450;
	Fri,  8 May 2026 03:12:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C64F272
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3280A409B3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fw_2fiIauLLK for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 03:12:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 899364030E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 899364030E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 899364030E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:39 +0000 (UTC)
X-CSE-ConnectionGUID: d1OTbJtGQSGYRffgIQR1yA==
X-CSE-MsgGUID: gYXASs73S/CeKzecdfvTHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027520"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="79027520"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 20:12:39 -0700
X-CSE-ConnectionGUID: OZ8l68wTRnSuHmKWn7WR2Q==
X-CSE-MsgGUID: LfYGDbFNQwKeHE7SAfbYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="241623218"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri,  8 May 2026 05:12:25 +0200
Message-ID: <20260508031226.3601800-8-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778209960; x=1809745960;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eC/N+PKSldiwuiYBHXeNZDIr7XUuCPxaNishs9wb0RI=;
 b=mIsLoWxVSz9QcU3mG6A4QI926Z/H7je4EQd2m4D1Eb+O6iBQmpSLeA0R
 lIcjfyjMpuk5dLrBR9C4jvUszku8ewmQIj0cS0vHbGPAu0TB2YSR2bBH0
 FZy7SOImC/sRJcccGDEWA6HPrHI8V7vFj/+3a3mzu2ed6QVKlS6Cv3WUi
 7G9zJfCDpivB2E6BnBcL7TAOuLPl0mSGoEmHPeqbo7z9ad6D9PYDQKCLN
 g022rW/5YpHgHPS7/xZbUrfIzCDoxGsw8s+CKikeljmNY6bADUDR+wSTV
 7m0gM+SjV29LyhEHWDi/IRQikwyA4n9gAFkg/unmKqDH7Dnv4ltT9FRtJ
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mIsLoWxV
Subject: [Intel-wired-lan] [PATCH iwl-next 7/8] ixgbe: limit ITR decrease in
 latency mode to prevent ACK overdrive
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index aea76b3..ba7b013 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2888,6 +2888,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
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
+		itr = max_t(unsigned int, itr,
+			    ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC);
+
 clear_counts:
 	/* write back value */
 	ring_container->itr = itr;
-- 
2.52.0

