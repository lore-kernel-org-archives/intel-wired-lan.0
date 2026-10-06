Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABEFCA6004
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3576880DAF;
	Tue,  6 Oct 2026 14:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dhDUgN0uXMEN; Tue,  6 Oct 2026 14:41:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9271D80DB9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297716;
	b=e0yKFh+qDOOmyhHcmsgkJoYpBHlnGYu+6g3JGZmzIhvLUYKJjnWu1Gsm4Utreu6/U9Gj
	 YcMUPTmVTUHJfU4XswgDb2fCu3JitGc0Acpp+4PZ+LVEJSyaJb0FUoz2RKxMizahGmOn8
	 ous6nJnNU8L9b9m8xc7ueIDVKuGW9/kYOOt2o6YKMKqL/YF+qEnJqLDKtADqPZ8s/ofC6
	 DiEBdLuTTOnWEmLJFhtly4se6xkg9ueaV8E4JCfyciNKHJbCEQmumwxTMiiwaF/UaansU
	 t9IED6TaIKRfKK4a7Z3oYs3rTTkLO6PlAJiUCDVCQkX63jlhkDj6ASwq1zA2q+/DR4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297716;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dKImS9WZ8y3Sg4FP6w5PmIxUKmjpNq6mkhjU0iCIGVM=;
	b=orr5fZY0jb/JWXaCA3/25ANhbi3xCYzkvvIJk1B7jOmkggun7C8oDAvd7GPZUS8KXDW9
	 Q5i47BzMHsAQEIF/17Z09Wvx783c1K6TxChm4BvGqMk7NjiXEuc9ksbxT3IDGqU0l8sq3
	 MPvVKhHWEn5ozgY21TFar/bkKrTjGh48Dw4QbE9zoHqfDnx7N/lSjDIWHV/v2qVGNINbC
	 uLsUWEj7Z38RtBQopOGSmGB9lPVDa4RTVSxP8Hl/L5sq9K5iIhW63ZUnClOBGezIjlCob
	 8DO2euYjTo4DHzThjo80yOMaoGTE4vrWYs2NIxHL+EBWLA+a+9P2MyWE23vXkJUvSWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297716;
	bh=dKImS9WZ8y3Sg4FP6w5PmIxUKmjpNq6mkhjU0iCIGVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4JuQdz4t1FK6+4DAwXy8/RQB3MIorXMGfrWFGZbdJqvLZJy0H68eV160v4RDdwjRN
	 32QJATO6Fuj4FysqdI5w/eEbumaz+SrEdeTu4dDBD5Ym+xpmMGyF+n0cLey+YSGfSt
	 s+57eKZPm7DTAQRuZszuzVoJjQ34zbtRtvb42fdTWjzTB6U43B6CcziPOMHCULa478
	 I4N9V2tjFKqx0DpiG+zoMY6VVWPT+01NKT8Y7PnV1Hms0OH6f9jk7WrrCWldLM142A
	 aeyDjWdF6oTHJxJ0IP1gs01Yl3dZA8zyCG/1BYlM+e0SSMBvSgARGlZ1EQzK94eaFF
	 YcwbGrqHg920g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9271D80DB9;
	Tue,  6 Oct 2026 14:41:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBD89356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB50A60653
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b345MJYpbEhu for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C9686062D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297626;
 b=GyEK4uIBPJW5VitGTrjAu8R2uiHaGrlI7dBJaspbzCFWm3IdX5RJjSvBg29hJXtaei9q
 s1uNbAw1dHfcCLDWOX/uOU4Mune0Kbv8JEZ9tqE5x7lXQGIJKa7+fsk8uzr6QvUDozFZ6
 jELXS7yyVur+pkRYKGBWnRWGxyzyby46RfCkGXsWp5K1gsGNPLfTOTqQ0MVg2drLoaZdr
 P468cQ4FjOyFrdNh9JFKyRzXHj5r1dfXBcFpNjG0WahFqwWtDodsX3Q57cnUeC5kaMjZr
 qgMYqxqiTZwI2zGnzZsd1ATmp4C9VONyweaFf0/MJE7aUyRa8ZCFW/dfY6qhAJlnLdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297626;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=dKImS9WZ8y3Sg4FP6w5PmIxUKmjpNq6mkhjU0iCIGVM=;
 b=rEhjBmI455derjiXLy2X2Lt1AZMc1vxVQUdMz3vrCcWVGO4zZUhddYOoqldvl7ukSdNq
 K2Wn//7sXB41yoayJcV62nioTNnM/yAKZIX6Zr7ug+/lo/D5RSREF8d0tytPWRbWwBwdO
 dZ6c1Ata+WzpxHhsZIOIs1DoKQ/YcOAc82Nx3xpfUTfU4fVRj8k6GsQCIEEaASkuh5gwN
 O3+xgxCUJJvhEsUwdGYR1KoJc4lqnQ1eigm1xGRwgymbMBpcej9PnwWU4EmJdcb0qWgmU
 hdEaFOdeuBVKZ9G6vuncpTTzSaw0KQwQrz8N3m7wJyOVLHCyg0fl/8bcfglJsYXjIiw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Va2UHCXn; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Va2UHCXn
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C9686062D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297626; x=1822833626;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fg4DszYZejNRh+9b6ukAelAbv6k4YTm7IVEZOOVM414=;
 b=Va2UHCXnGIul3nhUA9wQC1CF+By6XXSeI1CobikFMEJkF5wQag30R3LY
 W1oH9nS2vqswM9xrH/rjAZPy4MgDJGdlnnwEN8Y3C8avBCpCEAbDyBsCB
 7UU0ofeDChOAB7vEYkkiFJ8Ncd/7vHCYdyQUCWj/TKKaGNqZVbgwhbc/d
 PkTXfK7cQ7MmFqZMvFO07FQCxIcQU6V7vA1M8LLJBJns4TCmVz6vW4QDJ
 RzCfUmJ5TOfe4+o24EPDTE1ImoHAYgkDDgldgA//knY6kgD8PzMqERQ4a
 nXMJZoEX48Pd4fjp88l3k10hG+0BSi9uuarqdzORF9ex9XwMxZskT8A/l g==;
X-CSE-ConnectionGUID: 529mI4cAQO6B3JIFr7xxUg==
X-CSE-MsgGUID: sESNCsGNQe6vymuJr+DM6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108363424"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="108363424"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:40:26 -0700
X-CSE-ConnectionGUID: zr3BfKZ2QYKvBbhPi2B8Yw==
X-CSE-MsgGUID: 3mScUlllRM+i3mhylFQSBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="315187498"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 06 Oct 2026 07:40:25 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 3/4] ixgbe: limit ITR decrease in latency mode to
 prevent ACK overdrive
Date: Tue,  6 Oct 2026 16:40:17 +0200
Message-ID: <20261006144018.2885932-4-aleksandr.loktionov@intel.com>
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

When operating in latency mode and the computed ITR is lower than the
current setting, the algorithm can reduce the interrupt rate too
aggressively in a single step.  For a TCP workload this means the ACK
stream (a latency-sensitive, low-packet-rate workload) can drive the
moderation down to very high interrupt rates, starving CPU time from the
sender side.

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
index 5b88943..3325eec 100644
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
 	/* Separate mode bit (IXGBE_ITR_ADAPTIVE_LATENCY) from usec delay;
 	 * clamp delay to [MIN_USECS, MAX_USECS] before storing to prevent
-- 
2.52.0

