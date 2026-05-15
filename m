Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA444CD4F3C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 May 2026 19:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A785584663;
	Fri, 15 May 2026 19:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lyk3m99ltXEq; Fri, 15 May 2026 19:04:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB0F784664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778871868;
	bh=it6igKY4qrJSpTkvyk0lUrw+wOK84Nrlw0QVHK9iASU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bzt6w6zOGy/RNBQPwI7/zaCSErtzzsAx5CYWo0Wr5cGUe7tkvPl4IxXemVJZKVx6b
	 lqHe1vVpKFJePzXC/idayQYILJM4I3npQMQ1z7wam5EKZ4jh4vuGZzZRGUU7Nv4Xjc
	 LPUm7zq6vdT4h9D1ZtjWF+B2fZ6Jp0vf2/okz0yW1QGpJo0otUsX3h8yQ4b/5tu1jc
	 I9hPNfE1yY+bj1mChsse0/EFdJ2zGnyjxE7d8yuCdT59t37DDcI5LOr5p7tf/OhtOk
	 7u7n7GcZdeuLvylNqo84So50jiddZ7v/jnHzYcjx7IjZH7G3b2eJat+42PaIrU4EyR
	 RFCcmLG88Casg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB0F784664;
	Fri, 15 May 2026 19:04:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DEDA45B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73C0240FD2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5_sWiL305ak for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 May 2026 19:04:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9733440FB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9733440FB9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9733440FB9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:26 +0000 (UTC)
X-CSE-ConnectionGUID: szJTd4yTSOuezo1IlsA7BQ==
X-CSE-MsgGUID: i/ZYl0vfTmGpNlOV8eiiFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79725710"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; d="scan'208";a="79725710"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 12:04:26 -0700
X-CSE-ConnectionGUID: Su3c0a8XREq15JaTI2zyKg==
X-CSE-MsgGUID: 2ZgFqH7BRuajeK2M+Fr8qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; d="scan'208";a="238895636"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa009.jf.intel.com with ESMTP; 15 May 2026 12:04:25 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Date: Fri, 15 May 2026 21:04:17 +0200
Message-ID: <20260515090000.5112345-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
References: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778871867; x=1810407867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G7MmTf1h+5LioLTjjvjCKQN7jxTwWDeJLS/XSkZaGHM=;
 b=MvkjCTnqQbiwKoz89WwkplQpqP77hIQEDyBtI0zMguynNft2sspo4lly
 3OgjPqUKK6E45CcgTlfG/RIBtBuzNwJ4L9+GgvoBe7Mk3AQ9fHLMks49R
 IoI0GYFszpMu9XQJ+rTarmDt1TLjMu/jmKFL/ChbkTgIXxL333AJkWKwt
 Wwr9Sft5bX+lgxuICSjgsqg7aTiJPHp/b6YA1e9FjbUTIxWnWtitQHvlK
 bllLFWBzvwv91fMHA7bGlJKuWYSh0oVlI0TxyW3lZWxwWUXF7KRNjfiki
 sa5hCrboD7FEDoiiOdccavoTOyVifFidgh/Hfolz8PjuSHceYdQskcm+5
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MvkjCTnq
Subject: [Intel-wired-lan] [PATCH iwl-net v5 4/4] ixgbe: fix integer
 overflow and wrong bit position in ixgbe_validate_rtr()
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

Two bugs in the same loop in ixgbe_validate_rtr():

1. The 3-bit traffic-class field was extracted by shifting a u32 and
   assigning the result directly to a u8.  For user priority 0 this is
   harmless; for UP[5..7] the shift leaves bits [15..21] in the u32
   which are then silently truncated when stored in u8.  Mask with
   IXGBE_RTRUP2TC_UP_MASK before the assignment so only the intended
   3 bits are kept.

2. When clearing an out-of-bounds entry the mask was always shifted by
   the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
   which loop iteration was being processed.  This means only UP1 (bit
   position 3) was ever cleared; UP0,2..7 (positions 0, 6, 9, ..., 21)
   were left unreset, so invalid TC mappings persisted in hardware and
   could mis-steer received packets to the wrong traffic class.
   Use i * IXGBE_RTRUP2TC_UP_SHIFT to target the correct 3-bit field
   for each iteration.

Swap the operand order in the mask expression to place the constant
on the right per kernel coding style (noted by David Laight).

Fixes: 8b1c0b24d9af ("ixgbe: configure minimal packet buffers to support TC")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2 -> v3:
 - Correct Fixes: tag to 8b1c0b24d9af ("ixgbe: configure minimal packet
   buffers to support TC") -- the previously used e7589eab9291 predates
   the buggy code path (Simon Horman); add Reviewed-by: Simon Horman.

v1 -> v2:
 - Add Fixes: tag; reroute to iwl-net (wrong bit positions cause packet
   mis-steering); swap to (reg >> ...) & MASK operand order per David
   Laight.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..c9e4f12 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9772,11 +9772,12 @@ static void ixgbe_validate_rtr(struct ixgbe_adapter *adapter, u8 tc)
 	rsave = reg;
 
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
-		u8 up2tc = reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT);
+		u8 up2tc = (reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT)) &
+			   IXGBE_RTRUP2TC_UP_MASK;
 
 		/* If up2tc is out of bounds default to zero */
 		if (up2tc > tc)
-			reg &= ~(0x7 << IXGBE_RTRUP2TC_UP_SHIFT);
+			reg &= ~(IXGBE_RTRUP2TC_UP_MASK << (i * IXGBE_RTRUP2TC_UP_SHIFT));
 	}
 
 	if (reg != rsave)
-- 
2.52.0
