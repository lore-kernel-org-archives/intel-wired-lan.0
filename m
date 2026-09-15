Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391B7C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12C37809E7;
	Tue, 15 Sep 2026 12:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S4RXEorYZi3g; Tue, 15 Sep 2026 12:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 620CD80CF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476946;
	b=JcEBOJLNnWwLhojMVPeogQEZxMdvzDWK7iIB3IcYz8jJ778N8bsfL4EQBkY/PbeF1USN
	 UnCZo4wSzg8W1vCtGHGh6ZwCEB5zaT+GyxW+TOp0fWJ5Nes1B6tn1/98m4xVCB5VlReFf
	 MO7e8fNpcutkDdzyLk0HtaoeVufhYZtP5lQXj1Hs3rZT+WbsRMtZ4Q5xyszUHtvnj8slE
	 eAeWRq2EAJHREdc5y+LfxJlDeQKanYPZTw8O8MuGUcaD592taHCN9T+31Y3FunP0z6L0l
	 035DjGnIDgbxkXXiMVioOlUDg3tgkr7/pBs2IUnkNi1g/n6CGXuiwIOhuu3ed3YFl0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NkC9NFLqoTg7NUh4aa7TjjvrEWky7a3Lv92qeejf9sw=;
	b=BxlJkP75aVT/fEKeno8XwALMbJeN/Q0n1kpNmSiB8AdZNqFbbSHMYftQrq7PsTG7ctTe
	 HtYXcdDpswL8XPPoWtIotGPhRzQrd48KlAjCWJdhUtk8M2QEKEX+qqcC4jQnjLQdViqdv
	 Zmz/q2e4v7spf0cxdKnc1M6oW27d4HNyLQuIfHfc1gBHGTCVH66nQuNFecxdnfKku1JaL
	 +hwRHyLCH10WvkOW98ynI8gTBTNUUZfhHVrdQAJIJTSYxh38tqRaA/6V/z90OjvTe5Ir9
	 5CiUM7LrEyqZkA4MLTVYQh7qruvc0Oo50dQvjNyaXyOxKPgGOWw4duEd3ylaIfm6Q4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476946;
	bh=NkC9NFLqoTg7NUh4aa7TjjvrEWky7a3Lv92qeejf9sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SimZsHk0SY6N2sf+qM7RCCBz5xM7fK8xSxGACjGG5lauINzt/EYUI75MZ/v/Heivr
	 JRyLY8XH7oLMF2yQu86GrJxPGY5t5Dgq0e6Gi2AU4/BX+3eOvUAWAKVjiiGLNYTlZy
	 ax2IrVUQzElQYLbLB59SiSLJ6WgOjgdQU0C50sFAsIkeeg5Cxt9vxmaML4iCgD4vL6
	 pzyHb9v/gwHUiJSGv4wUzVa5YMVpbz6yeI6ZwRvt2MLCaLFzXr4ADQ4LMqrCUbEnE9
	 YmQ1RLjH0nIWWgieLAUIvDD1tSQ12ZH9v+Cc73loRZ0/Pow3Kldxm393um2w9YUEvs
	 1kXqG+CxQQYNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 620CD80CF0;
	Tue, 15 Sep 2026 12:55:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1448C259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 066EA4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zaudqMI005J1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2C1A44002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476943;
 b=M3z8B93bB+9U4eNLDlKdiuHbJuCettZXGqeOLx52gVAdNOF8UeuP7mHcQ3D/dEhWN5X/
 DDXToWNvOyE0jIL5IuvOmOeKsEyjeKoKHiIol8ChGdENxmLeEh5PoAaD12qWpc8Ux1W+R
 l2GzmkSqehE6Qn8uDhtXZjIsC8I+36TKA4GTTVoHMuIaZdHyXCknQFOJBhaeIS/i+SdgO
 yxuPUObe0219rhiGPTsBm3RtQcKluMkv1RhUUBSv9+n2K18M9f728Za5tsdHYI6HhatFo
 YyOGK3eZKAiMar1WimS2Jwia5y4VTVxcPqu9rWC9n3KJK+b39AEl6N99zLjF2khFPWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476943;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NkC9NFLqoTg7NUh4aa7TjjvrEWky7a3Lv92qeejf9sw=;
 b=oZWODNRzhhI8oA8BCzg60TlUuulLgRIx6DNx5W/u8+6HZW9m3IAu+cgJmG8yymBQQ8zL
 E/KDL4H2Wk0B750Euw5ArxIwdfw1p7DnVfllTCvizEFGgLsA2kLtRFM5ck2MGLc1W8ZXy
 nQx4exg3PmzgNv6Ax3nASzNKk2PQMU712CTUp9kJxxrsD2zPCrr05XIYcOxUG7EbhZ4Pz
 ChvWXroY6+p/SdRZeTNwX46BkJ0NMI0XEyi2L83EpIU/5XlDZJfAtjR0qkT5WyTiRtCUH
 IL/dW3w2WADzJFpR5XirhchCkPUbRzTPSB8umoh8853Ogl3739U/njX5hkOK8ZdhR2g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Lgk9C33m; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Lgk9C33m
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C1A44002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476943; x=1821012943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2QMvi8X6HL6xA7TDdFrFvAc8tDQJHCt+PjUS7CwKGHM=;
 b=Lgk9C33mF/hmtTgbXpDItafW9RNKfOEx1/xJ8tR5ZZbYSZwQQK/913tL
 YfI6PcU2ayMGl8Zd5Z661vTff2x4QbdQ0umB5yacmXGflbroAd4RAud7U
 9o9mYPs5qWSpZi3PCXFXagC4f1BM+fzadgOhEhdMJ9XfeSIxyBEdVAR/x
 5PldLloNM7P/o4hFUGn48mnc2tfu3RlUeX7GLXQENdz5pKEnjA8n3S/NX
 PZmBlgC2MQTlBReO3QUvHCLRkEqqyok8NeSC656T9wzbDappPqcCIJYIA
 TyE6wyUYrvq1DmHtqggnbjO3J6uSHkjJ4U9Wiv50ldCWuWtY8W0KLlRiE A==;
X-CSE-ConnectionGUID: oqbUUaU6QsKQHd9jDvjMJQ==
X-CSE-MsgGUID: qVinYVDiT8KLdkH9VKvYEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853124"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853124"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:43 -0700
X-CSE-ConnectionGUID: uylKX8vRTyCW61DLTtLpoQ==
X-CSE-MsgGUID: JcuOGJ16RaKxV22hzFIm5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225228"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:42 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 2/4] ixgbe: add ixgbe_container_is_rx() helper and
 refine RX adaptive ITR
Date: Tue, 15 Sep 2026 14:55:36 +0200
Message-ID: <20260915125538.3975870-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Alexander Duyck <alexander.h.duyck@intel.com>

Add an ixgbe_container_is_rx() helper to cleanly distinguish RX from TX
ring containers inside ixgbe_update_itr().

Refine the RX-specific latency-detection path:

 - Replace the shared "packets < 4 or bytes < 9000" threshold with an
   RX-specific check of "1..23 packets and bytes < 12112".  When that
   condition holds, target 8x the observed byte count in the next
   interval by computing avg_wire_size = (bytes + packets * 24) * 2,
   clamped to [2560, 12800], and jumping directly to the speed-based
   ITR calculation.  This provides finer-grained control over low-rate
   RX latency workloads without affecting TX.

 - Remove the separate "no packets" special-case block.  When packets
   is 0 it falls into the "< 48" branch.  The mode-tracking logic in
   that branch is extended: fewer than 8 packets forces latency mode;
   8..47 packets preserves the current mode.  This replaces the old
   unconditional "add LATENCY flag from ring_container->itr" carried
   over from the removed block.

 - Remove the adjust_by_size label and the associated "halve
   avg_wire_size in latency mode" step.  The Rx latency path now
   pre-calculates avg_wire_size independently and the bulk path no
   longer needs the halving to compensate for incorrect thresholds.
   Rename the jump target to adjust_for_speed to reflect its purpose.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 67 ++++++++++---------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f918564..ddc18e1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2711,6 +2711,12 @@ static void ixgbe_configure_msix(struct ixgbe_adapter *adapter)
 	IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIAC, mask);
 }
 
+static bool ixgbe_container_is_rx(struct ixgbe_q_vector *q_vector,
+				  struct ixgbe_ring_container *rc)
+{
+	return &q_vector->rx == rc;
+}
+
 /**
  * ixgbe_update_itr - update the dynamic ITR value based on statistics
  * @q_vector: structure containing interrupt and ring information
@@ -2747,35 +2753,24 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		goto clear_counts;
 
 	packets = ring_container->total_packets;
-
-	/* We have no packets to actually measure against. This means
-	 * either one of the other queues on this vector is active or
-	 * we are a Tx queue doing TSO with too high of an interrupt rate.
-	 *
-	 * When this occurs just tick up our delay by the minimum value
-	 * and hope that this extra delay will prevent us from being called
-	 * without any work on our queue.
-	 */
-	if (!packets) {
-		itr = (q_vector->itr >> 2) + IXGBE_ITR_ADAPTIVE_MIN_INC;
-		if (itr > IXGBE_ITR_ADAPTIVE_MAX_USECS)
-			itr = IXGBE_ITR_ADAPTIVE_MAX_USECS;
-		itr += ring_container->itr & IXGBE_ITR_ADAPTIVE_LATENCY;
-		goto clear_counts;
-	}
-
 	bytes = ring_container->total_bytes;
 
-	/* If packets are less than 4 or bytes are less than 9000 assume
-	 * insufficient data to use bulk rate limiting approach. We are
-	 * likely latency driven.
-	 */
-	if (packets < 4 && bytes < 9000) {
-		itr = IXGBE_ITR_ADAPTIVE_LATENCY;
-		goto adjust_by_size;
+	if (ixgbe_container_is_rx(q_vector, ring_container)) {
+		/* If Rx and there are 1 to 23 packets and bytes are less than
+		 * 12112 assume insufficient data to use bulk rate limiting
+		 * approach. Instead we will focus on simply trying to target
+		 * receiving 8 times as much data in the next interrupt.
+		 */
+		if (packets && packets < 24 && bytes < 12112) {
+			itr = IXGBE_ITR_ADAPTIVE_LATENCY;
+			avg_wire_size = (bytes + packets * 24) * 2;
+			avg_wire_size = clamp_t(unsigned int,
+						avg_wire_size, 2560, 12800);
+			goto adjust_for_speed;
+		}
 	}
 
-	/* Between 4 and 48 we can assume that our current interrupt delay
+	/* Less than 48 packets we can assume that our current interrupt delay
 	 * is only slightly too low. As such we should increase it by a small
 	 * fixed amount.
 	 */
@@ -2783,6 +2778,20 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		itr = (q_vector->itr >> 2) + IXGBE_ITR_ADAPTIVE_MIN_INC;
 		if (itr > IXGBE_ITR_ADAPTIVE_MAX_USECS)
 			itr = IXGBE_ITR_ADAPTIVE_MAX_USECS;
+
+		/* If sample size is 0 - 7 we should probably switch
+		 * to latency mode instead of trying to control
+		 * things as though we are in bulk.
+		 *
+		 * Otherwise if the number of packets is less than 48
+		 * we should maintain whatever mode we are currently
+		 * in. The range between 8 and 48 is the cross-over
+		 * point between latency and bulk traffic.
+		 */
+		if (packets < 8)
+			itr += IXGBE_ITR_ADAPTIVE_LATENCY;
+		else
+			itr += ring_container->itr & IXGBE_ITR_ADAPTIVE_LATENCY;
 		goto clear_counts;
 	}
 
@@ -2813,7 +2822,6 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 	 */
 	itr = IXGBE_ITR_ADAPTIVE_BULK;
 
-adjust_by_size:
 	/* If packet counts are 256 or greater we can assume we have a gross
 	 * overestimation of what the rate should be. Instead of trying to fine
 	 * tune it just use the formula below to try and dial in an exact value
@@ -2856,12 +2864,7 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		avg_wire_size = 32256;
 	}
 
-	/* If we are in low latency mode half our delay which doubles the rate
-	 * to somewhere between 100K to 16K ints/sec
-	 */
-	if (itr & IXGBE_ITR_ADAPTIVE_LATENCY)
-		avg_wire_size >>= 1;
-
+adjust_for_speed:
 	/* Resultant value is 256 times larger than it needs to be. This
 	 * gives us room to adjust the value as needed to either increase
 	 * or decrease the value based on link speeds of 10G, 2.5G, 1G, etc.
-- 
2.52.0

