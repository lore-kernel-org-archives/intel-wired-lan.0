Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3DFCA6001
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77C5B40557;
	Tue,  6 Oct 2026 14:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BAWJI4ZNKRaF; Tue,  6 Oct 2026 14:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9D385405FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297715;
	b=kpugnRMupvJG1tevq5EhsFISUYQ1OqWmR2gujUDNl78BbtB14yoSbmXWvk1iFVTyuuyo
	 FyeX8ZYmMdVYLZMKv7vxnuENxSS/1+bpEjkcrcRgFHZHyQIHhihNje6Fr0DDaADrZNcV1
	 LhOEZrGuUID18Ppdaj/WZ3PMRWbt68EY77IjbTaHN0kJjvyC0mJn9ku9x1iJvWo5jovkd
	 IlDV4RI3g11kodCPRpLySwSHJvUqST70TdzIloCOG7Q/xKnrPxNFGKdoV9chU6MT4v4ZZ
	 xBvf9e26EHKjc2YFrAVSikNX4xhLKtPURvQEX/fh2utEVUNDAwJOIKum4FG5jnFQmpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297715;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FVOdy69cLkvxeljT2LkMe6UZgmkCfVBlw1bvHc1OS3g=;
	b=G1BHd7AWtJyNeZyhvg/k5K4/eH8/IMQ4fo2+/OpzuE2vZoaPaLIUCl0vLfjmESIEoDrd
	 3MAwvkc+Ia17sYsgU0A8dy0p0mlvP4E6ZtdQzrU+gmnp9B2kLM13P2VdY1qUdPB6haOSR
	 MDBYcJVvAscjG+HCvhuXgfkf30N0P53G4TjjGq34TBxjSeQ12uyYfARHmFuibuZ0utoZE
	 n6eCEYKme+YPqTSp/obO8Z9hzwEdwAi2x146ZmJHWSNJnBl0q6UVB47t4Rppq15BfQQT5
	 2LC2ed1zLfWssIJQonU0+VvlvzELy2EXNTtDwDAcGoSNZv1ZaGtLn4K6Mk2XkY91/zA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297715;
	bh=FVOdy69cLkvxeljT2LkMe6UZgmkCfVBlw1bvHc1OS3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3e00P1sNGFKSAv9j1IFMHKLBUFEfNK5X5tKIzAnEc69H3TMAuOHGiUjQF1SC/Rry
	 wmiGPsr7LFI3CqhI0o+VG0A65y7L4urLqC2hGLPlapBDtAQahJDwI6ep7M8aI/kwIx
	 O0s3PmQ/vcFlL0dgtVyN2U3/nP4RuuMgH30GW5lYL5TAFpyiSbQPbIhcwzyJJ19yJV
	 9z4qGZcYoB04jbSzTuK3L5f/LvY4QOrDPDgzUmgZFcdhuDESb0i8kUSVPCwKEVoHEr
	 NKQ/973TT6PFzUj+Oe8C3ElGV32Sz6OwX0hdQmx4KyYQiG8LHJ3BFHR1dftPPYOd7z
	 AGc49gmBBjX5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D385405FB;
	Tue,  6 Oct 2026 14:41:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9889317
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19288605D0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NYQc1SEJePm for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AF11460653
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297626;
 b=gSg92xOzHM/ToeUxq5xOCqYLqKCcoGv8uEhVGwN5Dcw+3xcMG2Pnv+FWsDLeLuy1zIc4
 x7v6899rzsTk/TzPTGthBMzy4q+/gweilzrAStdseorSNm26gyyvjDXeMjova7O3N733v
 BpsCtMoQf726QNoOx80fDlOdBxNfrUuiFpyHLVBNCIVO9j8f0CsjVnTw8Ot+FGcMHO7HB
 z6wIxxDkzVVgvryVcl4PSCh2xG+T6nPNGC/5gjro/U60PStVwlOd8XZgW5QU0fjJXd0d+
 j94LVp2yaUfFcqIjBxdpW3LdVraMEwBUy/F1XxhbtZbeMPvSe1vAf+xI5QIA7C2uzJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297626;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=FVOdy69cLkvxeljT2LkMe6UZgmkCfVBlw1bvHc1OS3g=;
 b=ogSXcNrRugxXSeA5+e0wUMr0Aw5g7eYYZ4HNQUfiL+JtAxUHX+Icwsso2HJLRbi2QjKB
 Bc40VeZ0y/D9vRmNiakjpbdzSEMdnddAPqtxkMfZdTnnPVclldm0vx4UVbvMJl1sd+nmd
 AAwRxpF1YEvQz/RwvmIuE/8tp8JxnKzVACVJx4A/srxzmoXM+kazamHG+6HDOE9DPFkX9
 DiXlOPcT+xfMb6/jtiXraipnK/OhP2uKCN2b1Sd12mwGTLb0pz7ZDtNvy5wNWMdiP2bIr
 FWjm442d97fhyIxonP6+KWowFRB4qmUe52ToffBBsEWmvtLwo+udd4ezICDVy9od4DA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aUA9dkjh; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aUA9dkjh
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF11460653
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297625; x=1822833625;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9LLaWrAHj50WxIipV38pwXQxS5Srg3wE8G2V2YcR6C0=;
 b=aUA9dkjhYmxmVILLufU7V8dmYOKVgQxIJQQVlEzw3Q27fqdCm6qXyRj0
 BZSJyzLaiSkQaljGAFJbWytCEROt7mm9Gae3Yj7T0UA1O5DorBeVTI3X1
 3LtYGZEHHhUHkvIXiR3Cg1Q6GN+7GMjKqNs8fFPudgHGGnNLXFnuW1Rbv
 il8w6B95i0tYE0jSo1oEgLfUwhcvXH/e3lpt47eOeuVkfV4mwrkn8DIzC
 kXGOx1HvyC71zLAI4KcXAvJ4GEkw/dkZb1wog+lqamQhVgnXnXZy/hZvW
 UYKdFQyhWF/bwIYPF4UhMIniOo9c1h0+L8QhGs4ry9alp/lqrNVI3jjlH A==;
X-CSE-ConnectionGUID: 9xT6OXUWT5WqbFuY2uz6eg==
X-CSE-MsgGUID: nexO9zMNScmmQt6++l4OJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108363420"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="108363420"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:40:25 -0700
X-CSE-ConnectionGUID: ZkNlVjkBQW+lB8Zx/NfYjQ==
X-CSE-MsgGUID: Ah3CQfduSK2habMTVSXeoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="315187486"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 06 Oct 2026 07:40:23 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 2/4] ixgbe: add ixgbe_container_is_rx() helper and
 refine RX adaptive ITR
Date: Tue,  6 Oct 2026 16:40:16 +0200
Message-ID: <20261006144018.2885932-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
References: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
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
index a219590..5b88943 100644
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

