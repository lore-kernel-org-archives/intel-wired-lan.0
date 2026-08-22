Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADE3C5DF8C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0076840CA6;
	Sat, 22 Aug 2026 00:15:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gGww0xJwu0JX; Sat, 22 Aug 2026 00:15:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357709;
	bh=dCsKdBq00jZ3p98ia9bi8NBLti/xrp5/M0v620YL4es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0ax+e5OW7GnHOZY3X6UHkz8GKuSWnXlLZf1UtzbtUCNOITjiLaF39lt9+rL/s0F66
	 K79ERUVHnxh6jkJ4ZRbw/aKB8fhfq3xcRquv3oiU8DGwCFWBCwNa+QWKaOyG5Je+Pn
	 0i2cwndJrSgwdM/CMtwKYrCb2gZeXDUslYqKqZD5/k1vClPQWNqYZeNvPAWwWHgoHB
	 s0FJ0cte9n8vkztEByvfK4oiVLFg2zM9PWwicVS0kk/iT5Pe3ncXNO+zJL4O9jxBH+
	 HxRC4C4i7sQTL9TqcEd8YooGfSwUA8vsN/7/7bVT/QbnVtGf1Lig8B1zelkUPHTbnn
	 1XkcXbG1IhM/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B46440CA2;
	Sat, 22 Aug 2026 00:15:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD8EC93F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93E2540085
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGlhiXeH29tj for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LhnNJkMN
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A91940A12
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357701; x=1818893701;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=JvDzS83PBknRIEyHfPW7Gn+NwkrtMco1LDnnUlRyC3E=;
 b=LhnNJkMNJKE8lnwnUFkI0OfZkv3C45WkWC26kdISNYFYci2bW/mRHQAB
 lqBNw8QN/gJqFBlA1SiWIblkR8p6AaCAWVL7//TIh79Pg9nuPsm+XhkU2
 QNes7tPfCnI+JqGbGSW/smeOShKkeXUWKhzq3R/fmnR6CDORjHC2+rAlU
 p8m65JJx8E5QBNGaKiO1rInSvZH9ZJsnU1XIq5XULmW2Atr9ion9ku7W1
 iKvNwwKCLFX9KE2hdMtylVAuXsVI86FmbF00V/w4ph0iocT0dAu4GdT3b
 kVUYc29GBy5PqNd1KzxlUZw9f5oSRM0ZTIGmJhRmJQiVqWJrJfh1p/NV9 Q==;
X-CSE-ConnectionGUID: RQiDDrYNRkGfJi/RdRpUiQ==
X-CSE-MsgGUID: oJVOiIFiRW+YbdokyOWXFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584790"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584790"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:15:00 -0700
X-CSE-ConnectionGUID: DfP/bP5iSiG0EAxGxbRTFw==
X-CSE-MsgGUID: sFCpXLl/SC+hpTr2RLymWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836497"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:15:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:16 -0700
Subject: [PATCH iwl-net 11/12] ice: skip reading Tx ready bitmap on ports
 with no timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-11-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=JvDzS83PBknRIEyHfPW7Gn+NwkrtMco1LDnnUlRyC3E=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl7/PW999e3P11//P4w4Hskx1Fb4R2+3TKPKOO3NSo
 t/CYgG3jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACaSws7wm5X1Vfy1qH1PNrt8
 a/AqkMh9VaUppbCtsrnMbPULX43lFxgZlt02Y+Vg/OTRnzhjzunFP5+ca9HaIP335uHlyflnZb4
 XcQIA
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

On E82x devices, the interrupt for Tx timestamps are handled by the clock
owner. When an interrupt with the Tx timestamp cause is fired, the clock
owner PF iterates the list of ports and checks for timestamps across all
ports.

The existing logic reads the PHY timestamp ready bitmap before iterating
the list of in-use timestamp indexes, even for ports which have no
timestamps waiting in the software timestamp tracker. This has a
significant and measurable latency impact on reporting Tx timestamps.

Check the bitmap and exit early in the event that there are no timestamps
waiting on a port. Observant reviewers may notice that the check is done
without acquiring the lock. This is fine, as the only thread that can clear
in_use bits is the miscellaneous interrupt handler. Whether the thread sees
or fails to see a new outstanding timestamp does not affect correctness,
only determining whether or not it should do extra work.

Using the ice Tx timestamp traces, with a simple ptp4l setup the average
latency appears to be around 175 to 200 microseconds with a few outliers
taking hundreds of microseconds to be reported. With the check to skip
empty bitmaps (and thus skip reading the ready bitmap for inactive ports),
the average latency drops ~50 microseconds.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8c2dd83d8d6c..b337247c94e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -573,7 +573,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.55.0.814.gc42f45431d0f

