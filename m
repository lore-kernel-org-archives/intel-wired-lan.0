Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7FFC982E6
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 691EE60E9A;
	Fri, 18 Sep 2026 13:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S08aiheB3jz6; Fri, 18 Sep 2026 13:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9301D60E8A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738404;
	b=Oh4iGgNXZPm1Yh9y5xsY2BEjPloWMQFDrFrU6mlwkZbJzFlOG8CxkplYbCcwLBiazZsG
	 wCmz0NVpgUyfny00eqOkM3/TIysWjT7Ljp0MzT9mVOGNO11Sm7KnKN5WEWCwkhXF2GtJr
	 RnLUfZvgZytEjn9saUJ102n9PxHXYQ5ld4mH2nYxrOTk27TM9hS4ZfpldadTfCdOPAAtu
	 tbzZEg0Jl5tIul4kzq3cCtwL211W5spEg4giXGUphCf6e8ptt1nWWp7efiOPTVOYaE+J/
	 lr1o4MeHmnLD6pBU/Ggh8AUFpW80qJ4wo9UkTwL59CpQoeb6Sj4dDl1CQJzNTKMyyeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vXbmmz0hiMSU4KcJTy6DmJ6fhF4YWgzOY4DaCUKftJM=;
	b=cuzUB1i5Xzghl00h7+anujwk88O8om3vMc+ShxJ6wve9F9QCU1iKcquEr+9wDOA15yd3
	 JiCUlQaLxZ6f27ULPx7bG6es/QTtLYrQl6h91f0FRZ3evF6IrvQIcdM2a0K8xYQ1cROPX
	 M02qemzOrWuGIIa/YTtIDgL4L01kUfrOdySanamPQwZrj20TNWkQ5ZLH5MnXetd5YO8hg
	 4IliwlGAMOeZJbwMsvNv5R+vORAKDs2oiG+mAuN6gMTncKPENccDUV+bmBD1cJmqO5sU7
	 vgGBKEQ8mVYH1SIWOHKEjK5vCCl60CAtwMJjPWdoQ4ZeWUv4ydO0yHkP8UlqrWb5ogA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jNrIv6lX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738404;
	bh=vXbmmz0hiMSU4KcJTy6DmJ6fhF4YWgzOY4DaCUKftJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5qrjIKl/uVQoUsPpqvppzwr2ckB8smTbk76mJEPZ7WpeTqxITUrT3e1odEUXQ/sa
	 VPiFnme2SuHamqdoNxoEwoaN96PXIxiCZwg/abOLmTwaT7qOtl7jmmHdAk41jo3RTG
	 0sWKVAgHGfaxxMuSYdnn/q0bbrW6lP2HHA6xaDbgkvd5yOoRrYWoBx2zfn3aEfNgl9
	 fxv+WDLCkPj8sQM6yHkxkCGAqFd5CH+Wt8MtUeXdsgw0FYY2h9jNVF+bPnehEhH3BF
	 abChm5vSQ40UyBKemlkZgLQLEw+gpNtDCMcf7HyZ9dGES/6rC2V0pcdyOLX7QgFtCE
	 Fj89F8fBiRXpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9301D60E8A;
	Fri, 18 Sep 2026 13:33:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E17E6279
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF3F060E09
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MA5JtmT9wIOi for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:33:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1DDC960E5F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738402;
 b=BC3clvWexQYyidwULRHbB2rT7tEASOqiKysd3QKFt0O+JUdJkK/L5QY7dDxWMIJoGVKO
 Tgat/Uc7MWTGLTQcIqie8IOQRU9LKYxfr7dWDaPc9do9Aecv7rN+4MSp9M9ZKCMHxGM/w
 uQdlN2XeltRZEfRbOmdzJkptZ5WByfOfXnMyBVr5hojLm8ub86IIIbTWg8YyVtJdPG1eH
 gw5+fyC1cBF2mc5doWkwTnAjATjAq9luPpKBagerB1ukjLubj5K4CKnG2t+YhdAm+6wF0
 j3dc3FGnV7MaPKMjBqeD+zQVLpGJ2TQ7St2vjXAFwTf7gbtF+4wfrIYK1twhsIzx9mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738402;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=vXbmmz0hiMSU4KcJTy6DmJ6fhF4YWgzOY4DaCUKftJM=;
 b=kWT01HxBlCZ0R/OqkAUELVCatu2nQjOInN0VCKhsRNF88cN+yjGc6NqWyFgq6gw7kix/
 aQnk7f7OfyZdfhXW676P7NfmsLpuwqkkF0cNwmEOtULe5NniSnR9MbZojHTZoI/84FW0V
 LSqr4F8Kp6qK+VqRSsNiJKVfOXFK3ICboXLEJpJBpQ574FGVwDwiMnOV1iaXWCldVU6PZ
 140udJ5Sa51kQl9ayWKjbcK1Th72xknHFAU1WxHC24QeNmk8I+meaN5/5MEH4VZ+MDlEe
 bSiEy49vFA2irGb7h0NxOsvsAbnIr8FpscQ/KHAV3ZHHrG5WZo1LVlPNcMPKOn2kYMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jNrIv6lX; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jNrIv6lX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DDC960E5F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738402; x=1821274402;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kf9aY7QSDRzrm+l0yxbXYgb/bQwvAoaDc2QxP7217fE=;
 b=jNrIv6lX/cIQeCxzAYnpRfY+nO2crRAxSM1BfM7rSiz8thtzO3oaLyDj
 V5nAYgu/nVX9qe5nwQq5NcW8yDjIQXZkOkZmGTcqidY01q6IgD6MTu7Ll
 HjW8yDiLiLO33NwcQ5V+PeaLuAhy64SAJBN+TTHGVP/IDep9h6U+ZDjkl
 b/Yqzny+1bI5AKGxLhob6nb6rCTQ/1ss9YpeDzAi0N6Gsx+dtlhVtirsT
 +AVhIIXEnLP0zxfeIVF+7mUFqjbcbZZeSSocKFNszXbJ1ELDzmUy442u+
 U2Vp3ZVhCsq5gy7/5BMrscmjO2CZCWtgjvDogOMiPQdTeOohIsL/5w64K w==;
X-CSE-ConnectionGUID: rSryzSQaTnmifeiyJyBBzA==
X-CSE-MsgGUID: vnmkAMRITFemm5yJDd1wAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100840878"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100840878"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:33:22 -0700
X-CSE-ConnectionGUID: ZCxT48LHQ0eo+lIyUImQPA==
X-CSE-MsgGUID: AqdK15czQlyimMh4f1cJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270717965"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 2/4] ixgbe: add ixgbe_container_is_rx() helper and
 refine RX adaptive ITR
Date: Fri, 18 Sep 2026 15:33:14 +0200
Message-ID: <20260918133317.4169815-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
References: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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

