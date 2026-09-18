Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6201EC982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33A6560E18;
	Fri, 18 Sep 2026 13:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qf1zeQ6WMSOV; Fri, 18 Sep 2026 13:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 95BAA60E8A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738405;
	b=AjR4guVJsSqZSApXKtGeYEuURp2+pvkYUXUdVmh5hCMhdVk34Jd2UioqYQ4aVa/aUWfz
	 rF3Vf7p782MXZ/D7nNTYmTpZg0ebua40tA/dHjwH20pIIvtJhdEBhUGd0pC9WhWx3R3yt
	 +thwSfJQWmZ/rP6h47gXLIpH1PfK4NERQI15D+LN1MuNkAC5S1Qkr+82Q9eBiTks0P8TJ
	 xU+CLKacUo9oIoCLRGb2VgtQ9AyOUtsWzttjhjAyMHgMLVw54+AOM5c2cKoH8+4AANB3c
	 akMURjEEWHLQHNd2w6VkbzK8sn8t3hHs4k6YKFSCth4Dq9utLX7hpWg3I7Tsj2RDMIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Wd9MP4YXepWdtvoc29AfaDUlY5m/GLgg0cCoPIc/Tdw=;
	b=dsPuKsaWc8ynYLeDTz1pH9acNk+GN1cF6iwbV4eAJh62fgCdojcJHP/tNKJhOL0yroJH
	 W+5g8RTwfXmkIbdsbEMZhoh7neZLHD5npQ08ctjVQiy1o4QbEpMZRdSBemwTSwiNonrHn
	 4lfE2GFhwusC2iFV+xNyDHhjCEAPZxyow2fctAuq1wBI6VglG0E7qTV3wtHRAbsWuHk9u
	 SvevvMmu0b4aJGLk/ZDMjJHRn70ognRx8sw5WFFz92zS+IJRNEJaHP7iTOzD7XcCA4GOK
	 NIM3Nytk85ztoVcQe8BAvSkCTv6/wq9OjjiRGPzpZ4blAOgGz2AaFPh1hnZGQgHp6VQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nzRihYjX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738405;
	bh=Wd9MP4YXepWdtvoc29AfaDUlY5m/GLgg0cCoPIc/Tdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=emlgJj2euH7ZsEnGB2xquSy71TAKrSQATv2d7kejP4FZHU3ny66LqqRXfYFo9t5W6
	 i/kXSwR8VIUzJ8IQMjo+mBvMuXPpAiKImVlAniGgzc6BoLPCktJ2eVoXrD3b/pQQgq
	 kAHf+5pBsOXfmlZ6sYQ8wmQO1k00NICzxcjtfiIRPmUPiluELn0/Lad+tS0vnv3+VH
	 c7xQH2ZkibzAGX9uThRQNTp5n/MTJ27sbJOPkwW0TLYWMRm3zRWfAi+DbFdLzRXAMq
	 ggVfblr/5k3iLYj+yb+3194tEtfIAnasUQecYHhL66F69IY96ZN41nKUIky1rfOzW/
	 1t+Xf8QSMHqpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95BAA60E8A;
	Fri, 18 Sep 2026 13:33:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B7D5224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D11460DD9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wDjFHe__f9DZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 77E1A60E09
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738403;
 b=ZBw6ZJqoYVde6qN/8P/dGAfbwTIHNCeFPW1GmNfoqHcczaLtoN2Q+EqugOZJBZ3t8M2D
 CVFA/efqwoxKAFz6d7Dm11sqc9oeaFPr5Xou2A2tPFPakXlH4C94zLbZpMAeuzqPYjrpL
 ilSbEP8uqTaeKfgMFo76bU0w+AiFFuw1siptSoGk6VobLHv4aT8mftahIr5bBamBv8nRi
 lplr73dV2c/B9Ir/ggDG9nHm1OpAgWeYbkxa2hJx0JJjT6SzXQK4DEnkJfnm3vEFZ/m2y
 GtvBK+3rCpo6hlvqBkNUbquTkz4rycvhxNilCKr+OdPmwUKLx5eVP1rZ2dMXWv+wY2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738403;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Wd9MP4YXepWdtvoc29AfaDUlY5m/GLgg0cCoPIc/Tdw=;
 b=QHMBf9xbucVrCKBi288j5DCKMSQJV9OMHJw5kziwtnmiACfOB/GHVHCyhhZ0L0CZaTSt
 VK4zS0iokuSoGmX88eyRCO3tOOS7PsS1+VafR72H5PGosHQ2EXb1XsCB8HxQyfwdGcUrk
 vvLbvSSZdV6t5bJ/g3Kpl9jxuz86ppkWQWxj+5PfLV+dJKHWjo4uDVFHogTs/ARi++hoH
 X1TLrhGn8dc+iBedTSLm5nCoZiPajpUVknGuEnujqD+pRZ12Hrwz6M47XsV/2Qqh1tvos
 0Es5jNPQm29X8/W3wMxxNxDqO+PXQuNixFTGYJZScmpy5WRFIicqbF5qEuMI4aJzehA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nzRihYjX; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nzRihYjX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77E1A60E09
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738403; x=1821274403;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nynaKHxpqFdUNf2h5qjJM7ve6b5QrdSZLCT6fYbUo7I=;
 b=nzRihYjXrv5KfEUSHkoo2nWYzH6V2LhmLI9PCMikorKCNVi7mylZDpFo
 7tBVzTFDEptAZEFjteqNnmjd8PLSnqShhFSzG/whhaoMAJZV2Xpd0rR8T
 eA3grlXNwI8+SGI7FXJkWZ56GiZakCbNWhCSh7nMcD7jydUGcYVAddROC
 rAgs3A9mJOwtDB6VjR8eprP2o+BHDpLjb7flD4YFZ69r9mcqcoTLsUW23
 z7HSZxClxSoaLkYp3zcEiLo85bs+MXfaPq1qfCPntuWeudlsoq/Gqkk/m
 j0JeLKARsNO+Ajv5S/x19GCWOsakTJsOh7CFsXLHLb05WQTEgBHHmxNtG g==;
X-CSE-ConnectionGUID: IhvdjjyeQXWdZ/0kWaglSw==
X-CSE-MsgGUID: hOxKFG/ZQi+ZlKDEA312yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100840880"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100840880"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:33:23 -0700
X-CSE-ConnectionGUID: nCtVX0dJQ6CitHw723+ZWg==
X-CSE-MsgGUID: w/5vG2qKR1yG3wWF5eULIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270717981"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:22 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 3/4] ixgbe: limit ITR decrease in latency mode to
 prevent ACK overdrive
Date: Fri, 18 Sep 2026 15:33:15 +0200
Message-ID: <20260918133317.4169815-4-aleksandr.loktionov@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ddc18e1..7fb2ab4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2891,6 +2891,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
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

