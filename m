Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79116C982DF
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AAA760DD9;
	Fri, 18 Sep 2026 13:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFV0bP5VH4zj; Fri, 18 Sep 2026 13:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B011160E18
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738403;
	b=L8OqlifdWORHiAkEr+tymKxrmkBXjK8x4G81i93AZ8ewIvrlqE1F45E++qK04Jdo1XnK
	 p/w5H4LVN+5HlnbyDYoVp90H5pk0GPtsFWyk6h7Fm7aXCb3IX13JLwDvZhVkx4imdbuxh
	 ZYV4VMQDQMgY33bwN8fqXnhv+49i+NX6boNfG/BFdyEpvgYy+jantIG+GfWaeYuWPhM5p
	 7VzMRH/9nIASVUodaH876A1yU3JPi/mPyYGFqrJpsZ5DZ3JNqlZmlHpZw7YYDGVeCyrVG
	 iGUVYoYYU5W7AGZiRY84moApnHmWgvfpswG07rDsgA3GGRHMIFA7liTFbPAj0YptAeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=upucqhcrR8QwBJdfNt2CSn+BJB3GEwjM0V1oXlTYAio=;
	b=KPxWYOI18j1TUyOpCx2gra1UV5HQV7IkVJCyeg/6St7OsPvP3s4wf8ErWEpiCXcbnQH1
	 aREqjjYQlCPWzFpnCb+wJFDN0T9m8jZWagFX5eNxk/sU7N3LgLTjtEMX1Adb6rcW2Rb6N
	 4H/vv8v0/DmO/XxOp8EOb7bwOOJ3V8AVazw0lUHLK6nbOR8/jT5xLqSYaZVDpKEtkyzvZ
	 Hr70hLPgY2qxnRElTRcOI8Xg7t/UyatWGW1BGiWKD9WQcpIMIAqEBPcT3ZfhA1GDo+Kja
	 DscJBZyMVm/EnXqhQHJduAKdBfKYDb3F1RKWZCg8rltdTvffvsl1md4Lfety4vTsqdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MMNrGRmT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738403;
	bh=upucqhcrR8QwBJdfNt2CSn+BJB3GEwjM0V1oXlTYAio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zyjkVRWoO8vHcIxKUBtxIFm5VdMNP8GiLf2MHnev1sR0oyEFazt+V3aHiQsy/T92z
	 2ZRQYJawbjURqsAx2Ek7oQATo4iZSmrPEKg8zIYAvrfdoLuCZ7o8Dctyd1v3+64Syi
	 mpJSj+LsxTpsuYRUCvxIIiq1dUd9PxJbr3Wd5WkYRyT+y3t1XeCxM4W2+23b8sQlYo
	 HEPACHCAL57mX/68rcjsLNhJXtAcnAn22SiKfbhj1p07/SBkwMP2GqCzO9WSgnj5iT
	 FXh4TD9cyTsN4m1SZnoilPzdGoLhHyp5HRurE3ZAb/1C9EeunK3Cs1feA1JghtA9oI
	 VK4f2oaBOLrRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B011160E18;
	Fri, 18 Sep 2026 13:33:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 33D61224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19F0960E18
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncxvm6FkuXO5 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:33:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7F99860E09
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738400;
 b=CvetdX6rDg4z4ZLuH4cyyr8uHmordOR1GZICi/s7CyI9ipTniv3WjkLwweUXp+Hty2Y5
 FehckAZTKrNImzdYYPpPUAgdLWoU4qQZ6p56L4bQfPXgP2B1hNJUsKUpEaSGkGPw1bXO2
 ciIlT4LAVsS3Reyfqa2fbkHSo+Kzhr3uWFxNJ7TbCkmQglQoYVwr5ZoAtPt+f02T8Nz7i
 n2iBryKyQdcLHvvb+OVUp1edyTNyrYPvsYTHbTw4b7j6EpIsllH+eTl+ProLzyTntBlOo
 Do0J79P2mZ8aXLGelEUWcxmQVzZh56lfAp5RdUN6MEwjEoMkqjAn4KoD/bLWKt+5TNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738400;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=upucqhcrR8QwBJdfNt2CSn+BJB3GEwjM0V1oXlTYAio=;
 b=RXrpj1keop0BQY5fwPzPbn7GTOHetqniecYTQdGbm7bXOxWuxyNZURaRWHUEgllTIn8e
 5gnyhRl9TqkxvCUsZj5ebCEyvk7FR/MWD9k75NLq/zlzYn4yVqRYFXjKOyTI4SmMdplGf
 9emWutqTJeaTGARRvjI3IfFJIYTiNgX4f2FgaCkHWoPxrA+ISczHGBmcByT821UTlfWff
 Kf6F79ZCX+w4K3tatfM/vBvx/kf4YiclTDHrdfsGKTBa7E3bmcLt8+1+6cTYWjlrLXGJd
 ilT26ppVorIZLKbz16Nf2eZDPn1baaakEVhnxKiHhnyin1RBZnhejlKyq9deU/2epEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MMNrGRmT; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MMNrGRmT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F99860E09
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738400; x=1821274400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pMriqRWop9RRBaxFqNlEj6k2sISo5ki9t7sSSotR/PM=;
 b=MMNrGRmTUuNFgN960sLGTm78U0sX/tY4Swx0IKHCVLWZ1kgLfkUBJt2O
 BcmQHo1K+NOCTdMb/ZeHOYtICfehMBjxzN2mvzOn9TVd3ll06/TSN8RMD
 z+jpxSJ466yZGyeVsMCaxCufdnf+o5gRygYZh/F7rnWShlEgzo6m7wjA0
 cSVtxo/vgIg17OBrnHsH4cGxxJzJ3OfZKUzsONsO0pQs3Gz7sw/+0WvoR
 +8dDsUal5K1sMLJ58vnLRwx085kYxSn51qg4NOHaRSBEYinKJxqrok2Zv
 ujC3VZAQr7n2w9GHXOv9m2EHRCaCX0qBR2yaIJREAoQLseLPGbaGRMSrk A==;
X-CSE-ConnectionGUID: CODSLHmcR5OxgrkGIv2m+Q==
X-CSE-MsgGUID: bdp0r3s8QJ2pMrDU88UdBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100840876"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100840876"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:33:20 -0700
X-CSE-ConnectionGUID: UX2ng1vHSlGT0mhMPseRAQ==
X-CSE-MsgGUID: Fxz136FOTai9xYvPBAc6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270717952"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:19 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to
 prevent RX starvation
Date: Fri, 18 Sep 2026 15:33:13 +0200
Message-ID: <20260918133317.4169815-2-aleksandr.loktionov@intel.com>
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

At the current maximum of 126 us the minimum bulk-mode interrupt rate
is ~7936 interrupts/s.  Under sustained full-line-rate bulk RX traffic
this is low enough that descriptor ring starvation can occur before the
next interrupt fires.

Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us.  This raises the
minimum rate to ~11905 interrupts/s (~12K ints/s), providing enough
headroom to drain the ring before it wraps.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 9b82175..1a7fd90 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -475,7 +475,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 
 #define IXGBE_ITR_ADAPTIVE_MIN_INC	2
 #define IXGBE_ITR_ADAPTIVE_MIN_USECS	10
-#define IXGBE_ITR_ADAPTIVE_MAX_USECS	126
+#define IXGBE_ITR_ADAPTIVE_MAX_USECS	84
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
 
-- 
2.52.0

