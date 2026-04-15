Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D729FF43821
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 14:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE4E84B6DA;
	Wed, 15 Apr 2026 14:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPM04BgcUUeJ; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D25994B795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776263335;
	bh=uaWujFJLTGPpo7w6VGd0NHUa6CrH2MRaI6NNhTf/Zag=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=57JK3xJv8odpQmi6PS8uTrCNuSbViac5FmJsNertnZE3tGZTouJJLUBsQlfRO6HBJ
	 YaWiVpHS93r3MXxxm1qmJXmY9kEkK6rjEHIXRsMjLB5Yf7KBACk7mgXOfcN3WmbO+q
	 EG7PPuzBdBL0iZoOxQJK0wsC5P2XgsC2eFEUhUYHJTpguG1jI6GK351Fz+be0qOWl6
	 eqBcrb2Db2tZqHyJ4WTiyXvNwZMlDpWWuywFO5ImP7fNWwt3cJEJrL6pJiTuYYkLmM
	 utwPkdOCwRmRy7Z0a+Qd2qmalrVAKe43jDIODx3LorDXJs/95XAxpOjKfeqIfipxwR
	 Zup6NVg+6k13A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D25994B795;
	Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AE50283
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 511A48301D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FZBmWnwz4fvN for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 14:28:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 00E4D85477
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00E4D85477
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00E4D85477
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:52 +0000 (UTC)
X-CSE-ConnectionGUID: zqMQCO8dSdWMSwMzLds/fQ==
X-CSE-MsgGUID: aY4V/0F1RJ6anHQYL6WhMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423746"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77423746"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 07:28:51 -0700
X-CSE-ConnectionGUID: 4umZa15tQv22yAIkuPCDRQ==
X-CSE-MsgGUID: DtpY65ZfSrGKTtIAJzAdfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="234467884"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:50 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Wed, 15 Apr 2026 16:28:40 +0200
Message-ID: <20260415142841.3222399-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776263333; x=1807799333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KqWXBLN1y2tBAU5MfQdxigjBV0ykVvzEk82ODCrBxvE=;
 b=WFTOA1zJr8SNk8kXL5sI0hkr6g4Mzo5GngMD/aa1RhUn8XBUQYuBManT
 EKvGO/G8V/2VUBZDn9wGVWr+omIgjbbCfuHJzYaxYDrRuMfpzIdbhL7Ho
 c3H5Zgq7c2XT8OqFpHYU4ITrZVNSFSbMyGLDAl3xR+9eTvTwOxTm2CZXl
 ZqKayf7doY84Xsw3H4eo1S7P3vBHkd4JwfRPsU2tCpNYGxnh3b3xAo3fY
 oC4+EFjq/thTGE6EROAF4ybIPm8dLgrKBeqwCLI4VMTKTy/4uO13DE2u+
 LlEHa2R0CgUeeXqA8VtU+c7wpbCCfTlo5CY0uyh+BuTinSpjzF4ADCRF5
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WFTOA1zJ
Subject: [Intel-wired-lan] [PATCH iwl-net v3 5/6] ixgbe: fix ITR value
 overflow in adaptive interrupt throttling
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

ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY,
bit 7) and a usecs delay (bits [6:0]) into an unsigned int, then
stores the combined value in ring_container->itr which is declared as
u8.  Values above 0xFF wrap on truncation, corrupting both the delay
and the mode flag on the next readback.

Keep the mode bit (IXGBE_ITR_ADAPTIVE_LATENCY) and the usec delay as
separate operands in the final store expression.  Clamp only the usecs
portion to [IXGBE_ITR_ADAPTIVE_MIN_USECS, IXGBE_ITR_ADAPTIVE_MAX_USECS]
using clamp_val() so that:
 - overflow cannot bleed into the mode bit (bit 7),
 - the delay cannot exceed 126 us (IXGBE_ITR_ADAPTIVE_MAX_USECS),
 - the delay cannot drop below 10 us (IXGBE_ITR_ADAPTIVE_MIN_USECS).

Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2 -> v3:
 - Use clamp_val() instead of min_t() to also guard the lower bound
   (IXGBE_ITR_ADAPTIVE_MIN_USECS); keep mode and delay as separate
   operands until final store; use IXGBE_ITR_ADAPTIVE_MAX_USECS (126)
   as upper bound instead of IXGBE_ITR_ADAPTIVE_LATENCY - 1 (127)
   (Simon Horman).

v1 -> v2:
 - Add proper [N/M] numbering so patchwork tracks it as part of the set;
   no code change.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 +++++++---
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..9f3ae21 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2886,11 +2886,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 				    IXGBE_ITR_ADAPTIVE_MIN_INC * 64) *
 		       IXGBE_ITR_ADAPTIVE_MIN_INC;
 		break;
 	}
 
 clear_counts:
-	/* write back value */
-	ring_container->itr = itr;
+	/* Separate mode bit (IXGBE_ITR_ADAPTIVE_LATENCY) from usec delay;
+	 * clamp delay to [MIN_USECS, MAX_USECS] before storing to prevent
+	 * u8 truncation from corrupting the mode flag or delay on readback.
+	 */
+	ring_container->itr = (itr & IXGBE_ITR_ADAPTIVE_LATENCY) |
+		clamp_val(itr & ~IXGBE_ITR_ADAPTIVE_LATENCY,
+			  IXGBE_ITR_ADAPTIVE_MIN_USECS,
+			  IXGBE_ITR_ADAPTIVE_MAX_USECS);
 
 	/* next update should occur within next jiffy */
 	ring_container->next_update = next_update + 1;
-- 
2.52.0
