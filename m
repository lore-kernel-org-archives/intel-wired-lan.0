Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AB9CD343F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 May 2026 19:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 496A9616C8;
	Fri, 15 May 2026 19:04:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GyegCpX3qcO9; Fri, 15 May 2026 19:04:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB9CF616CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778871863;
	bh=OcZDITMIuszZw8Rk9/XENma4MVinhqEcJqCy5y9ZdC0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1vWY1U9NTBJ3hkWcwrGSa+Mr18jzSMXsLMx0MJhbLr0QpYvmTN7E1ANgvJwBW7BvY
	 KikRYyrO3APWBxz/4j46jgFlH0t+UDiMQGoB5U+3scPKaWDu/2cjjLtJZkSzbqZSme
	 vS/kiFlyD1qNjcLg5QVCA6FUfiT2tPJDQyQLtjHo3QTjyzyCyHqcT4hYflpi6p7V0a
	 mAf96psk9NQ2k3JKjD3hOqGaEWfm1m1JU9OliF9X3gGI+rXL1I7z0TniO4iqCiFE3A
	 wp+YYfYjnlIJY/8TilCiwv8oZrNEuWBV5wQ/dYTHrK3SdyoDIH7xgMKbymIJaAA27a
	 oV0g9i1hGA6rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB9CF616CA;
	Fri, 15 May 2026 19:04:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2849645B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E63240FB9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOLz5_XIsEXV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 May 2026 19:04:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 60D2840FD2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60D2840FD2
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60D2840FD2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:21 +0000 (UTC)
X-CSE-ConnectionGUID: Ox18NXrPSIO4LwJPzptwpg==
X-CSE-MsgGUID: Q2zECTzURyKamsUY8yXlCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79725697"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; d="scan'208";a="79725697"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 12:04:21 -0700
X-CSE-ConnectionGUID: V++jsmtkTIO+5h1SVIVAUg==
X-CSE-MsgGUID: 0/3cyI3xQiKauoJoCHYrww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; d="scan'208";a="238895624"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa009.jf.intel.com with ESMTP; 15 May 2026 12:04:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 15 May 2026 21:04:14 +0200
Message-ID: <20260515090000.5112345-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
References: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778871861; x=1810407861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GUF4ORCJjHX1uOeyka72W243jz1bbjHEIX86BDqtL08=;
 b=dQwo2b3OQJACYtk0mcsXbLLnbW/J4xr+p9clkKPm1G+Ce5TMlM+Lfj8b
 +tmX2Gn5mkOSwt2P91Ew/TBShen3Bb1z/bfu/JJvXrj0l4N0kUhTiXAdV
 6MtWN72kZlHc5nEL+S7NIr7thuF3EQS4CFaYmWY/fXA8p6/zya3vH5zqh
 tJNvfYF8li3/zT7j8yC1B83ww2BJlcFF6knczR+PNBJbboAeZxWM5Phgl
 cJgUAYyH28Tnv+HUtHVaH7I9abOhikHZ2mruq4cIfq8tgnhxuymk1NavQ
 x4mU03/8oRsk+FfAsCZqkX0a+VUX2aFMUbuwAxlOIXIRdNlh25omOKLHZ
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dQwo2b3O
Subject: [Intel-wired-lan] [PATCH iwl-net v5 1/4] ixgbe: fix SWFW semaphore
 timeout for X550 family
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

According to FW documentation, the most time-consuming FW operation is
Shadow RAM (SR) dump which takes up to 3.2 seconds.  For X550 family
devices the module-update FW command can take over 4.5 s.  The default
semaphore loop runs 200 iterations with a 5 ms sleep each, giving a
maximum wait of 1 s -- not "200 ms" as previously stated in error.
This is insufficient for X550 family FW update operations and causes
spurious EBUSY failures.

Extend the SW/FW semaphore timeout from 1 s to 5 s (1000 iterations x
5 ms) for all three X550 variants: ixgbe_mac_X550, ixgbe_mac_X550EM_x,
and ixgbe_mac_x550em_a.  All three share the same FW and exhibit the
same worst-case latency.  Use three explicit mac.type comparisons rather
than a range check so future MAC additions are not inadvertently
captured.

The timeout variable is set immediately before the loop so the intent
is clear, with an inline comment stating the resulting maximum delay.

Fixes: 030eaece2d77 ("ixgbe: Add x550 SW/FW semaphore support")
Suggested-by: Soumen Karmakar <soumen.karmakar@intel.com>
Suggested-by: Marta Plantykow <marta.a.plantykow@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
v2 -> v3:
 - Add Reviewed-by: Simon Horman, Reviewed-by: Jacob Keller; no code
   change (Jacob suggested read_poll_timeout() but accepted as-is).

v1 -> v2:
 - Squash with 0015 (X550EM extension); fix commit message ("200ms" was
   wrong, actual default is 1 s); replace >= / <= range check with three
   explicit mac.type == comparisons per Tony Nguyen.

 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index e67e2fe..a3c8f51 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -577,6 +577,15 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 
 	swmask |= swi2c_mask;
 	fwmask |= swi2c_mask << 2;
+	/* Extend to 5 s (1000 x 5 ms) for X550 family; default is 1 s
+	 * (200 x 5 ms).  FW SR-dump takes up to 3.2 s; module-update up
+	 * to 4.5 s.
+	 */
+	if (hw->mac.type == ixgbe_mac_X550 ||
+	    hw->mac.type == ixgbe_mac_X550EM_x ||
+	    hw->mac.type == ixgbe_mac_x550em_a)
+		timeout = 1000;
+
 	for (i = 0; i < timeout; i++) {
 		/* SW NVM semaphore bit is used for access to all
 		 * SW_FW_SYNC bits (not just NVM)
-- 
2.52.0
