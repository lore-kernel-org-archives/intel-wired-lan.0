Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB77FF8875
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Apr 2026 12:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93DC984C7C;
	Thu, 30 Apr 2026 12:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWHLD7Rb7ZmN; Thu, 30 Apr 2026 12:26:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB25A84C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777551972;
	bh=4id/lOwh7NwuwvlTVWlbNddlFuJkU03x6d3smL9Ujwk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c1oGfeRTjC/Mq5X8VCHE+6pCydoy5qm7EJqnSz9HuOC7zw+E2GoTVX2zA7H8pdFnq
	 ARPHKDKyF+d4ljYRVrkbUViye0dle8JdLi/KJGqxf5WtVxhSglpAmRgpgf78AoPqq/
	 am2YRMHDg5oXENa7NLrKhSPCKr44BsL8mQz9vx6obu5YEINhBkzMMTVdQnry1DnK6F
	 09LCgsIBqL08upDDb1BMX9IcjXlYghT4aq7yeH+LDc5gUuzSequs4Z6QSPnyXz5adM
	 zsbJi7nJSHMCxxEXV80551Y6F+m9A9mwnnQeCorsCpOmnBZ3RqpzN12L63QTNuAl+z
	 sXHjP8Wwd8qHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB25A84C74;
	Thu, 30 Apr 2026 12:26:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 36B6418F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28C724073C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ukUd6l0D463 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Apr 2026 12:26:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1CE41403D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CE41403D6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CE41403D6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 12:26:09 +0000 (UTC)
X-CSE-ConnectionGUID: Tj9n+SsLTnKEaWOL0VdupA==
X-CSE-MsgGUID: /WFFfXdTTrKd5swrr6K12A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78689190"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78689190"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 05:26:09 -0700
X-CSE-ConnectionGUID: 7kFlS1XZQzWuF31ND2ZbkA==
X-CSE-MsgGUID: TQq6O933TXaYRN5tKBHDjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="233538433"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa006.jf.intel.com with ESMTP; 30 Apr 2026 05:26:08 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Thu, 30 Apr 2026 14:26:00 +0200
Message-ID: <20260430122602.126722-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777551969; x=1809087969;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iMyBM89b2seTFG8wKFYplgNuifzMOqRBwqYX3WhqWOE=;
 b=l4Uynsl/p4DItv2+ucCAlT4nqgRQHVDm1zALqYYL/9FmgDRQDZsDftBO
 oLQeyAzO8wX8gCD7wCt3CWvnv1scLXnN+wwWH3n9PyI44EfJQl4Vam/Gt
 T93qD8JtMdihJ8HZL4J7tQZrOph1VoZ+uYbixlk3LwFVWJHcvf8nmfBAZ
 i6UtLGLKx5aPeZKaBUOgbHUvuCii171BAzQ/uo28jiGjW4qbUFFAu8LeW
 Vv2hIm0OmEz3/uX4koTUhKA5YVL6WNkQJMZ2cDCzzgI+XUURTJddpksHv
 qndUAmmXE++hkLj3RZWKPj+VJHE4h4j4uHxFEiYpaO9yi/viJxR200ANu
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=l4Uynsl/
Subject: [Intel-wired-lan] [PATCH 3/5] ice: add correct handling of SMA/u.FL
 states
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

The ICE_SMA2_UFL2_RX_DIS bit name is wrong: the bit is active high
(setting it *enables* RX for u.FL2 / SMA2), not active low.  Rename
it to ICE_SMA2_UFL2_RX_EN and invert the use sites in ice_dpll.c so
that enabling the u.FL2 pin clears the bit (as it used to do) and
disabling sets it.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 6 +++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 62f75701d..7e8bb63 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -672,7 +672,7 @@ ice_dpll_sw_pins_update(struct ice_pf *pf)
 		p->active = false;
 
 	p = &d->ufl[ICE_DPLL_PIN_SW_2_IDX];
-	p->active = (data & ICE_SMA2_DIR_EN) && !(data & ICE_SMA2_UFL2_RX_DIS);
+	p->active = (data & ICE_SMA2_DIR_EN) && !(data & ICE_SMA2_UFL2_RX_EN);
 	d->sma_data = data;
 
 	return 0;
@@ -1264,10 +1264,10 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	case ICE_DPLL_PIN_SW_2_IDX:
 		if (state == DPLL_PIN_STATE_SELECTABLE) {
 			data |= ICE_SMA2_DIR_EN;
-			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_UFL2_RX_EN;
 			enable = true;
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
-			data |= ICE_SMA2_UFL2_RX_DIS;
+			data |= ICE_SMA2_UFL2_RX_EN;
 			enable = false;
 		} else {
 			goto unlock;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index c1aa408..278d757 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -655,12 +655,12 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 /* SMA controller pin control */
 #define ICE_SMA1_DIR_EN		BIT(4)
 #define ICE_SMA1_TX_EN		BIT(5)
-#define ICE_SMA2_UFL2_RX_DIS	BIT(3)
+#define ICE_SMA2_UFL2_RX_EN	BIT(3)
 #define ICE_SMA2_DIR_EN		BIT(6)
 #define ICE_SMA2_TX_EN		BIT(7)
 
 #define ICE_SMA1_MASK		(ICE_SMA1_DIR_EN | ICE_SMA1_TX_EN)
-#define ICE_SMA2_MASK		(ICE_SMA2_UFL2_RX_DIS | ICE_SMA2_DIR_EN | \
+#define ICE_SMA2_MASK		(ICE_SMA2_UFL2_RX_EN | ICE_SMA2_DIR_EN | \
 				 ICE_SMA2_TX_EN)
 #define ICE_SMA2_INACTIVE_MASK	(ICE_SMA2_DIR_EN | ICE_SMA2_TX_EN)
 #define ICE_ALL_SMA_MASK	(ICE_SMA1_MASK | ICE_SMA2_MASK)
-- 
2.52.0

