Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8266AC5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 152DA60AE6;
	Sat, 22 Aug 2026 00:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqKDVeg8nZZM; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357703;
	bh=+4RyQ800aw7OlgRFbJVxbUHhVfSB/O1bQ+0BGGnnjGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lPjXAZtSgFcMl2vGz8NPFJPtUyO841M89lk9zRL/44vwhaahe6u5zrtPSUDpJuUqr
	 JXQ3kP46wQJOZKaC2ozzsSrdD83XQ3ZGcdgSnqMWpwaFhw0uIlfAZdFGS0mw1zJo61
	 3C/LfnDd6UX6nt1zQK6xDiQ3EfDWs5WNPR1tTR1sYuhqYyo04gQrQLIrnlQL5BmXus
	 A38diflb7g896bw5P1U6crTqSGN4wHeBDJQCMmPWnxQST1eHBZtQQG/ksDc957EmUX
	 DzQZa8BY14ebhSCS9LA87q/2QsjHCZxiL+5mM0wPO4sInLLDnBVCLWMgbPogsaySHV
	 6DErlvvmL7MhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9CED60AB9;
	Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0B9893F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B734C81323
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F3qHS9DCjUU0 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PBY0uHuS
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF9468132A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357700; x=1818893700;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=L6wFLgo75OBbsTVRHSFdNT6sYdqsXUqea1hudqbm/Kw=;
 b=PBY0uHuStfkNOwoe2zpWRIDHohI6Z6Vu8DBeMvfdEviz0lZpxzXXOF6m
 XN4XGBnoyOnFwN3s5rNqJsdKwSBtz64eRN5C2pAqRr05L7UQflxzg8sXy
 JabygMg43MR/WjrX60WA2RnuVYdCoTtJRFw+YwembDZSCFoYaZXIrn4si
 Nq0yKd1Gsn4LIXBEqNm9EKA+IScgCR6auRzbSl6Fjt+l8YyzZeOelcAOM
 c+f9DPtyOdY9KSPe2e4CTvErcLi7fe+/kegw4+K5p1mZ69rAZ1+gxQQu6
 FawwMdrzrJDR3UDOBjhkoB3HhjcrWOHCShYML5yBI31FyeT6tJalV6yX3 w==;
X-CSE-ConnectionGUID: O+/aJtF1SDWbr/9Li6QwLg==
X-CSE-MsgGUID: HZt1gijdTFiYXYUeZ4jgow==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584776"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584776"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:59 -0700
X-CSE-ConnectionGUID: VtHKTQ6rSneGnyx1Eu0mpw==
X-CSE-MsgGUID: 9Ypcah5xS8qMhOexfQdBdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836481"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:12 -0700
Subject: [PATCH iwl-net 07/12] ice: E825: perform a soft reset when
 starting the PHY timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-7-9d0731eb4858@intel.com>
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
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=L6wFLgo75OBbsTVRHSFdNT6sYdqsXUqea1hudqbm/Kw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl78uONZu+zn5bquRlODDdQWzxNvZbjBeq/voVXV5k
 qKXiElcRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABPZvIbhv1eA0/41v6Nj2ydt
 7HKPmnPn8JUUw6+cs7+ar3NXb1X1qmL4p+W741Ou3an4zHOtn/aY7vD9GpamaMaYP3/fJsegx1/
 FGAE=
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

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
has been completely reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index b7d217ac31f3..10e973876608 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2119,9 +2119,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2137,6 +2139,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	err = ice_stop_phy_timer_eth56g(hw, port, false);
 	if (err)
 		return err;

-- 
2.55.0.814.gc42f45431d0f

