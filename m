Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D1CC61DCD
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E42A56070D;
	Tue, 25 Aug 2026 22:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fyJkOlKXV_3c; Tue, 25 Aug 2026 22:55:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787698514;
	bh=zL+WsIpyUvvqv0U8Qd+h1f286LSAdmVuI/CmnNZNmAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cg+1pnjK1nDXVJmUA+YlwnmtAB/3AAMOfXNPZ8o4+pP1sJeJfURUyEkiZLCAjIdX6
	 PIbKNwr3WW91N4tXOdzZYisemeo50FAoN8KkTACJrBQaYCucKqRJKS1MoNUSAS/YhL
	 ZvRiXICyOWEVJrJSZiFey0uWq2A7zQdc+gwVfcbM0CFGTHuH4DzXSIKPDp5abPah7m
	 ByQ3+FniI0lJRn4cI5M3ntbRZsdJ/T070Rh0nuL0g5kbr6dastjE0CMeWC5I6wF2DG
	 3iybd2fVvyRyWWUWoK6+Ppf0zJ54u86cKfNI9vEYiYBDGImead1VVrx+2YEUUFV5MX
	 +SK5IcoFk0l4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56ADA6074D;
	Tue, 25 Aug 2026 22:55:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 89B17230
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 612AF60740
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCTsfo1dyNnh for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZhXkfTgP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABC646070A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787698508; x=1819234508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=qWHh36Du9B7DNvrjcUINH5z+vifLevrg3n3fwwfTHgc=;
 b=ZhXkfTgP+OoSLffn9Vui+etTCm8aLdha5qzkIu8uqqUwlOsHTpfobT1F
 lpf4VeVbosgqTHaZ4IVUHu1gvxDsvCxjMik10MiSYw0w6cPCdd3j3j3SC
 FkgeAnewdGnEHLbnO3anNbSx/B/s79tneBDWItwuT3RR3EPaigoc0/x8H
 JsYkc0eZCjg3wQqCQV8VAf2rFRpRgdGM2pr7wLfxnay75S9ol4uTGbrHZ
 hivx1tfl2p5PCKE9yaRcwnSVxQ9ubXlKqRlKQaGLDjwefZs140Tqdi9PC
 SPneLuXqQwR2ivtCtCYcMlNMvgmAXFHjC9KISiGRWjm7yf4kdNDPyOTqH g==;
X-CSE-ConnectionGUID: XpupWPIYSDiRgT4GhzsDNA==
X-CSE-MsgGUID: s1yLKF0BQOOszynlRcR7Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120441"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87120441"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:07 -0700
X-CSE-ConnectionGUID: QKIxEL3IRJqrh6pIHYstoA==
X-CSE-MsgGUID: A4w0nnH2RUqnfsfWamcQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="264789689"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:33 -0700
Subject: [PATCH iwl-net v2 09/14] ice: E825: perform a soft reset when
 starting the PHY timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-9-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=qWHh36Du9B7DNvrjcUINH5z+vifLevrg3n3fwwfTHgc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WVt2+xm8rtoP0wRTfddYCX8x/vlrE4d61FT9OtfXo
 fI2brs6SlkYxLgYZMUUWRQcQlZeN54QpvXGWQ5mDisTyBAGLk4BmIjUdkaGa+oOXi80X6yoFN8w
 59Xxx1dWnZp4Sy/VeM7HH/d0xcX3fmBkOFD6UywhsT2pYpltzwQLF79LF747GWV4f3K+cHiVUvo
 UXgA=
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
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a3a9f7ce04d2..64e18fe1176b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2120,9 +2120,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
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
@@ -2138,6 +2140,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
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

