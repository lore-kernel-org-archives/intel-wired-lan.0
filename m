Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7DEC982E9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EE2860EBA;
	Fri, 18 Sep 2026 13:33:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pcxWJ6zgspU; Fri, 18 Sep 2026 13:33:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6831860E66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738407;
	b=RNYz7kCVmq2u2BfUaOLVS1GmYDbMe6B5osKYFyk15EAMm25vrt1XclXL3ELzwQAHdxjS
	 MO69iRPkfxmGZCVzuAzeBJ7qyJRQq5vhsTJngyWpjPMXuI15wgRN/RksXytjcW6OpxVSX
	 zpjX+nSbWcC2L0e6BB6DhflwB8XjlbuFlmIyL+5TmlKyrHBlFBozQYjOznLkIUR39JREg
	 drxltHLm2OpKm8OXcknstqAmDWfKOYsYdeOAawNeHQwZ7VC41PNqU10MEbuIFY0rNAcDQ
	 2jSuHu/1JdgQpjy+fshS5KXrljMyoVa07fHkLi++aIFiBnjuPdmqdTLPwr2e+C0bV5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EXGP4hJz8y8SstGQYzwyN6Gv3e+Yi+oxa2/ESHlJfpI=;
	b=RkhYU5eG3d/roygDUovkUzbNTUGJlGyDVMS+hDWJXlvFT9GVMMHj1qhkRSqTk/Z7zxS7
	 4oO1c2twscQjOgusDcdvLDEJsQpziIuioxWq16mfAXiNll+izHwxomWPA7Kcxt05fcRDN
	 651xNYG2+TS8Yz/nAp88nRE7X76dWKiPoF2w6QuzOQk8wloIaDAqXY2CWiD8g8AzelVnD
	 WD6fzfQiZ5iTA0U+PgBIMzZgGfB9oz20ENKFMcF2SQaLrEhGJo+WyYmuifx1ncJdVMckD
	 UPk0HtIiOXifajQ1+ggm/yltFQqFzdxfpEQKp60ucGIqrCpUeEKqgZH1+59Nt0nzERg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WVSe3cG7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738407;
	bh=EXGP4hJz8y8SstGQYzwyN6Gv3e+Yi+oxa2/ESHlJfpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ufC3kRNNrdSgw3olCb/a6ZZzXbmc8JmhOSXeMscPzikH80+O2oY8piTH3CF2FVDho
	 7o26TKf/0c0NTuplOoPeb9A/An448Gmb3Hp28AJrZNlAVoDmzTL7/3Y0u+2ieaLhoA
	 pWoWIktdeGm1rvayFErWFpD8dwVda428P+KMMFLTMY5Tb8XFrKeHaGZ4+Jh91++/ws
	 5QVQkH7uAvMBs+cGvVSLnAYx3uEeoLun0SuIzFlwUMymYfLBZ2dv0fiEsxbBMvzhxa
	 PYYA8xpMXfqqfSCDJQQtpjAndA4xUtXGzP8ataet8vfkYFkJ6Je/WZc7pmZIuJTDxo
	 jljnOBXbxTEtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6831860E66;
	Fri, 18 Sep 2026 13:33:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C3F17224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AAB8A60E9C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4p27kPogdEDr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E4B7160E09
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738405;
 b=b1lbmb5oRfRkWGA/ahadxXnUgl9fLg1vpqgpCmE9hu6hQM25FVd6iQPcLMixyZNnjiJm
 oK8T30cO8o2cqhxt1+Snf6437UOouRH71x7wCMvodFfmXQ4ZEJ29TpK/FNEwOJM66HbIl
 tasPqo//Fk9uuDiQhC6y+JgOX0TPwABntpB/LnAe9CUw3r1gKq2VGBX774Iq5QcANRwfZ
 TYBEJz2LFy5PgA26iyQmOQdA3iNZ+WDbWI4+kVdMPk2LFYCl91e7il4JkPEDua4ZeZ2+b
 /JIL3NiKDOzqxwov3VtXGGrMpLO5iUYM9S+x+AxpQIQDzJgW5gQmLPWIyeV0w2U6f5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738405;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EXGP4hJz8y8SstGQYzwyN6Gv3e+Yi+oxa2/ESHlJfpI=;
 b=m//kke2Gx/Dqk5ET0m5UORUaGaga5YYK9XciZ4nWsPmpJAkBByCQOYc//Cr50iiPOxNQ
 e+DYGCsBRaZiqYS6HoxfrloIfFQJlC/i6Tq9eQk2px3oIJXdEB+sCbIqcrVDKBbCkcZJn
 A4djqNHoZFgc0r5tuPJuR1+PKcn4wKbSu+hnR9jdAFpsF5MmecPvw2IUqXzvx9gsDsNyd
 Wmkr82jXUWAvLUx4/uOi45zDaNLRI42xDpSnh4CCKv2pS4uC13iaazTIzF5C8cp5Lt93D
 CgqgL0N2BrYQXyOpnr1y25PcuYcDi9c2L2MEuoXLrAyWF8UKg95ohHinglAnkLrO2Xg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WVSe3cG7; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WVSe3cG7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4B7160E09
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738405; x=1821274405;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lGVnIQv9TtpdjxowxbaaH8QKjUMRQwGbViMg10Lb1h4=;
 b=WVSe3cG7b2265Oyif1xdxw90cHzxADW9bQHNaQXy8H3Iqx86KAw10iFU
 xCTjo30g/NBFrhqX9SHcZnf+w6n5xFEv5WSXod3ezSSVWuZFoi6EG+y7X
 mMaQDJVrGG/o/IVGHKb88A+Pv1vNAMbXCHu+tgLZ49gc46eq95EV95B1d
 qfkbbcTiX6tpENedKryKJQaNza4USk1EoXZPM6kRlKWJ/ug2NZMP9EXk9
 emwjlx4bK0n620BntwbHb+xCqbETH/mxus95sOjJ/eAJ9l1WwtQ0UpRd3
 7frb0SHU/WKLPBw/EEzbLsU1PeO9ILRIYDjMGw72FVoUuvkm4M+sB5ZFo Q==;
X-CSE-ConnectionGUID: MYHpiIElRpmjZ8KS42qnaw==
X-CSE-MsgGUID: aGc/iv6bShaUdUpVwxyt/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100840881"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100840881"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:33:25 -0700
X-CSE-ConnectionGUID: zBUIBspHSQWmHgiqL3WHCg==
X-CSE-MsgGUID: Ucbo1cRqTXm8oqK9pU4tzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270717993"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:23 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 4/4] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS
 constant
Date: Fri, 18 Sep 2026 15:33:16 +0200
Message-ID: <20260918133317.4169815-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
References: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
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

ixgbe_set_itr() clears the mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
with the open-coded complement expression ~IXGBE_ITR_ADAPTIVE_LATENCY.
This is equivalent to keeping only bits [6:0], i.e. the usecs sub-field.

Add IXGBE_ITR_ADAPTIVE_MASK_USECS = IXGBE_ITR_ADAPTIVE_LATENCY - 1 =
0x7F to name this mask explicitly and replace the open-coded AND-NOT
operation with the cleaner AND form.  The two expressions are
arithmetically identical; the change improves readability.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 1a7fd90..594ccb2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -478,6 +478,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 #define IXGBE_ITR_ADAPTIVE_MAX_USECS	84
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
+#define IXGBE_ITR_ADAPTIVE_MASK_USECS	(IXGBE_ITR_ADAPTIVE_LATENCY - 1)
 
 struct ixgbe_ring_container {
 	struct ixgbe_ring *ring;	/* pointer to linked list of rings */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7fb2ab4..8d3627c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2962,7 +2962,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_vector)
 	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
 
 	/* Clear latency flag if set, shift into correct position */
-	new_itr &= ~IXGBE_ITR_ADAPTIVE_LATENCY;
+	new_itr &= IXGBE_ITR_ADAPTIVE_MASK_USECS;
 	new_itr <<= 2;
 
 	if (new_itr != q_vector->itr) {
-- 
2.52.0

