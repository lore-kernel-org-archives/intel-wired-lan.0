Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CA2C5DF94
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EFE4409AD;
	Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TowbnXVuDx3b; Sat, 22 Aug 2026 00:15:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357706;
	bh=GVtujIQSxYv+k/YUBr/lwDoOKL1Bh93j1h71b0ldNiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j6jCyAkOhYkQalzNJ9B5hlQd++wFJXZGCaK1XT+ZN8EuFQbsQ9bH8vEwi48+NQcgc
	 37fW2Lve/mSjSc3gv1Em6HYKIANp3Y6ropX9X6CvMe4s8XlvxrC4FAoPnsfOgXwwzw
	 XhtVeuSd9f7clcjMUnGmV7qjqZLPVlYNzL5wee7Nc7yX5cx6dTqjJRNAkTa4qoKnHa
	 Z2lf1tBO8J5YKI5nVNne65+6rrN037+uYz1h/mjBL1XUQbTnYt0iCSEU9Ww8FxDNE7
	 hWzDmz86/1YfuDSxr+8wlVhNbD0do57QYOthPE0gFy0GKS9CvvOSiSue3RhX0VeWdP
	 9qLy3o7GbOPIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7284A409AC;
	Sat, 22 Aug 2026 00:15:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84B004C4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7270381323
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kh4gdvRF6mTN for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KXcpqKb9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1F1D81312
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357699; x=1818893699;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=5eZvQaW2XLQ33MmDw+tyy8L38wPLaGjF22CO10SuBzQ=;
 b=KXcpqKb9O2PZTn0utolsuKpxQDaB+LEEDtpJqGbkKuFFGxGfEynakcvl
 BNPL6cvz6M6udytahdSiTY2ryT6GIqb3Uaavv7GqGe32gNqOv4CTAs1l9
 MViL6TyQvjBNsViJHeGUCBzeR3yeJmjJJK5ZOiM+rliTBbvpKC+ObBlW0
 Ai51FqzTlDMI9V/EtaPBcS8BX6o88sP2MHUm1XpL1mGZoqwkwnMtJng1p
 cm+A6QXAru3BO77NDq6rYeYbwkzPnN4rEEkHx+AFm87CnPu/cI0/PvxcL
 xQUqoW2SnVT6+yHhfLkt9k4RMvIj0nGt5JfxjJ6n2khfNnY/0E/8njJ7h Q==;
X-CSE-ConnectionGUID: EPzaASWGRZC/kk489CqP5g==
X-CSE-MsgGUID: NQrl4KojR2uyJ23qsAx1ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584766"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584766"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:58 -0700
X-CSE-ConnectionGUID: 2ur6FEYBRiWBzqqvYWZ11w==
X-CSE-MsgGUID: UhabILBcS3+nYuiEyqbKgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836472"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:58 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:10 -0700
Subject: [PATCH iwl-net 05/12] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-5-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=5eZvQaW2XLQ33MmDw+tyy8L38wPLaGjF22CO10SuBzQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl79yKrfP9TS7tZxlQ/0CLsPaOrfQ9ofy5w+1X2n5X
 rbc5FNSRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABPx2MrIsK9Kf863c2UlIiUC
 L9oPVkzw1/zgss3y0TrDstSOvzclPRkZJuokvf5TkNIf9HDn9lu7HjqktV645Pbk6Kuw6wfV6xz
 vMAIA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

The ice_stop_phy_timer_eth56g() function is called by the driver for E825
devices to ensure that the PHY timer has been stopped. The equivalent
function for older E822 devices performed many steps. However, on E825 it
only clears the PHY_REG_TX_OFFSET_READY and PHY_REG_RX_OFFSET_READY bits to
indicate to HW that it should no longer treat the PHY offset as valid.

When PHY_REG_TX_OFFSET_READY is cleared, the hardware still captures Tx
timestamps, but it no longer sets the valid bit for these timestamps. This
sounds reasonable at first glance. However, this results in the internal
outstanding timestamp counter becoming out of sync.

When capturing a timestamp, hardware increments its internal counter and
sets the associated "ready" bit in the timestamp memory status. Then it
compares the timestamp count to the threshold to determine if it should
trigger an interrupt to the MAC.

Upon reading the timestamp hardware is supposed to decrement the counter,
clear the valid bit, and clear the associated bit from the memory status
register. However, it only performs these steps *if* the valid bit is set.

Since the valid bit is not set while PHY_REG_TX_OFFSET_READY is clear, the
timestamp counter is not decremented and the memory status is not cleared.
This leaves the counter out-of-sync until a PHY soft reset.

According to the hardware engineers, the PHY_REG_TX_OFFSET_READY bit has no
other effects. It only controls whether hardware captures timestamps with
the valid bit set or not. Since capturing timestamps with the valid bit
clear is problematic, they recommend simply not clearing
PHY_REG_TX_OFFSET_READY.

Note that the PHY_REG_RX_OFFSET_READY performs a similar task. However,
clearing it is fine as there is no associated timestamp counter on the Rx
side. Receive timestamps are simply inserted into the descriptor. Clearing
this register clears the valid bit for timestamps until we complete
calibration and re-enable the register.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Suggested-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..d48eb3c61823 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2115,10 +2115,6 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
 {
 	int err;
 
-	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 0);
-	if (err)
-		return err;
-
 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);
 	if (err)
 		return err;

-- 
2.55.0.814.gc42f45431d0f

