Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB6DCD37B0
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 03:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4206941459;
	Fri,  8 May 2026 03:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ePH9yu6zOnoh; Fri,  8 May 2026 03:12:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A11B441460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778209958;
	bh=g4hrBknN2hpyo8cOGKu/tdvAtFTdRy9HOD3QXsye+EA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AssDtiOc3y3QJj04nt5KmopnjpFuO0UtCtvTg/UVbo7DL6YND6h7GNO6kq3CEdH4u
	 kyv9yEVpL96g5HA/zmnQfegRoKnGesJtfSJFRF1jCc+Ch/mEP/1tam6V6zigSF1ro6
	 uTY/9yj2ngrTF3MobOMfTGWcavUtp6JdOMGYSA74Umygre45QBZnv2qA6zLaEOYLnC
	 hh1dozIs+5dE0jnKRs4v+lQAW343gBy8zLskm2zdKJkmWtHYxn47LmwC2OFLJcJAKj
	 +1LFdv3Z8ITemMuv94fkuDTgtR3iXaLmt730Mz83wgotnhYqYKavmf1qLilTs0kqbS
	 NQiaVNw+51SYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A11B441460;
	Fri,  8 May 2026 03:12:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA236272
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7939409B3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXAcRlINmqwu for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 03:12:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C94E94030E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C94E94030E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C94E94030E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:36 +0000 (UTC)
X-CSE-ConnectionGUID: ns6MP0IVQv+Rb2QyvbiSjw==
X-CSE-MsgGUID: t/5tGTXSTu6BaNSKyTWq0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027507"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="79027507"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 20:12:37 -0700
X-CSE-ConnectionGUID: ZlO2kQE9SYGyGqP1UIPL7Q==
X-CSE-MsgGUID: nCsr5/F3RrqGPXX54wiubw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="241623205"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Simon Horman <horms@kernel.org>
Date: Fri,  8 May 2026 05:12:23 +0200
Message-ID: <20260508031226.3601800-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778209957; x=1809745957;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9aq3l7pQ7Mjfw3VwJA+8Dhs6YWVZvwwIVUvAlQE2R7Q=;
 b=DbH9sH/ZEGfMM5rL90m1z8MfqCqRANZjdbfQUTHUQcam0IGtjMLu0E2K
 wCLmUVPlfkSH4PNYy+wE4roIXTnMZTUJKuZO/nSFH8l/fsMpaKcV89gdQ
 XaqKh3zPViJvSeZ3MbwqwRaES6HLWkP1aZWQaY7oU8j0dVZD7eebTGDIC
 JyCfbgO6vM/OBtU5WijF/n+2mzzv2zEw3K/G94STQeawMcvNegwhOmRzb
 dlVwtYMO1qyGQ9e8LKxf/f7mZJiY3w3Plw3g8NZw2wDDI+e1BCNweqI1n
 3s5GjPHazfHvxjZ4bSMT3lsW8r8Wd2cEaiYSKInn5JzV4x73TFnzLscxE
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DbH9sH/Z
Subject: [Intel-wired-lan] [PATCH iwl-next 5/8] ixgbe: use
 ktime_get_real_ns() in ixgbe_ptp_reset()
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

From: Jacob Keller <jacob.e.keller@intel.com>

Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
ktime_get_real_ns() in ixgbe_ptp_reset().  Using the combined helper
avoids the unnecessary intermediate ktime_t variable and makes the
intent clearer.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 6885d23..a7d1635 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1347,7 +1347,7 @@ void ixgbe_ptp_reset(struct ixgbe_adapter *adapter)
 
 	spin_lock_irqsave(&adapter->tmreg_lock, flags);
 	timecounter_init(&adapter->hw_tc, &adapter->hw_cc,
-			 ktime_to_ns(ktime_get_real()));
+			 ktime_get_real_ns());
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 
 	adapter->last_overflow_check = jiffies;
-- 
2.52.0

