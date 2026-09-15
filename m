Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2E5C88E53
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B122605E0;
	Tue, 15 Sep 2026 12:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0G5HxTdBiSO; Tue, 15 Sep 2026 12:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 842166074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476944;
	b=cP3C18CSM1k/7QV1LcZDGA+0ARQEo/69dIfKCDoxFJTw1TBGaMRIg5nxkWKMCcQA44Y1
	 3gdOnnQwE/tlWmOXYwiYtu2g/vGMDFVvZQwUxhvzuX8SrtaQaBKxmTNUUxoJ2iWI9Obkn
	 xN7JS+nwpKL9uNffEtmXQAYPCVuy3ZPErhFzfDbcjNmGI+H9i+qKwvgUx/RYH7ggM4Vv+
	 T3rv801w3UNtK1w+O8z6nWgKKZ+LD5ss88OCLkd213q15KX7tXLJPmP3gffKBQ6WaWxB1
	 qqpIYesG6TdFF2tfiBsjPdiMK/+W089XGxsdRcMzWm/umi9YHfVbEoGeOQMoFw27tqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Rdgp/qI5dobO9KXD83DA6QEKvCWrfN6QZpZI2t7NY3o=;
	b=g16nLP0CYBl8tBJ0K6k88BBW/5ZkziZL6TqTfo0nsISYG24qSfyeYIUhJUiYmn7ypOn5
	 ZsBHqv7oTYRW3vwlRyE0a5jzbmFCO857PA9j5+EYFvFzfTZEmGlbBZMQlqNjHNtzvselA
	 K4GS0JNJHZgIRXXZi9Mzaf23iAITdpUr7BV8ZMTtDqg+WMLhwtD/BJJSQEj+DYPvI/Poy
	 JVmZbZgMy84LRfSRhgF+9hTTTGesbeRslr8OPpdlJ2EcYd0+Exdp+9UxduqlAcXliycfX
	 okKj7dWoMpIQni/3+YDgejIU/ul7bzsXJP3SL8GgnjO70O1I4EAW80LMeBzJM2Ulvvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476944;
	bh=Rdgp/qI5dobO9KXD83DA6QEKvCWrfN6QZpZI2t7NY3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Eg3vsKrTJEeEP+lqlUzLMmgXOLmIb2znRRm9/kO7Zqf8MLIBTtRiUhBFqPRu79Wcj
	 xXJpzJFkwvMSeXbVtH8MBtrAjqvm6AVsShjzhN16RiUoyZyHrnbS4jeL1kopLgpJDR
	 0wfNcEEK5Tr99lvarIXmoRtqytgsFlKnQxK1M4IVFa5inUzyh7ZFDkT/EgMBXp+GSi
	 GmCoof83EDhbVnHXTIbYi/Fyo9nbZ1+PjEEb1sckS3PeOOR9o9J8ZdmxHv+6dRKUuH
	 HbxRLB1Mj6dxaBlsNoGuguJ3FaURP/irc8IWtvCTrk26OP4vVHgdFIwLBnZltpevvy
	 Ko+vUnSwNjyBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 842166074D;
	Tue, 15 Sep 2026 12:55:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69DEC259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C19C4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzkUM1sYymsj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B74B94002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476941;
 b=JsBea1giEshaNTB71FePMO93Jwufz+nCnw09S46J4LMnskIwZbfNvHPldmi5vz2vQeMT
 sGLboBw2uYrQMTuxK9gGlsbcRZopybetEeRjfUN4qtRGI11z2BGHb9/brJzXAd8Cv4fzW
 4Qhvi1K74ux5u7CIYV8nOB56U/+MFTj6B/HxDtsL3tNvmTAslscVhGUl77bBknqzhdMGV
 E3VE0qBuQ8e4F+lgkwlpgWKcnV347mdXaKJJbPkuTSD8gaaalB7h7RVfUe/GgJazLOpDw
 tStz9qHMnpE50qZjf16mcAac+Nb6CpqBl2qwmRJr81Aslrq75dWigAZzyHTIKsHtl6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476941;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Rdgp/qI5dobO9KXD83DA6QEKvCWrfN6QZpZI2t7NY3o=;
 b=Hbe8Npt7llcoITwdvQvx9OpxiYWb5ku2v4h3BvQKgxx2yLgNuprS/PvVK0ORgTBlFZNm
 vNjBcrZeqOmHki8PIoVdW9oqwV/B00PpTNDrKaEQeYSuxeNbUezqEAXxJCwfS9U6OGWgw
 71a4+07tZSkQQTXQC/mHbUsTMalFBJN+AinkhBTIXDOrvGFqLX5iDvF1rfbI7o8j4RnI7
 eW5rKMdSj6/QYnn6IQdK0qoi28uuvVlTSeTS9NDNUAuww+7AlKKsiJJRc5Lnso21AWyhe
 MYU3wH1jQPwWGchNcHPYMXklEyaRLx/8wEC9GR1JRY5luEPscfAMPqKKr3uIYWKl1Hw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nn97w85M; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nn97w85M
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B74B94002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476942; x=1821012942;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tDUir5n0cojiGdZCBkMQYJ8ICGb6dImsb7j6dxNI/D0=;
 b=nn97w85MWtt2DQ916OEGlebiM8d3SUzS7XlHiaJcrAGrafg3f10nWN+Z
 v2TIb0sbTLmtcCte+NT5UBP74BSeBueU3SAUdb8Y02oLgqEg4k8oEHxEO
 5JZDVECaCwj3yh6R4qesUoxxvJflgEwgfNonueLdYO/pRvOFJsC9Atxwn
 dtOSXY/kvTXj/u8iJZxWdsicF7W7vMc44vHko+AhA3wuJ49NhSW6r6AVs
 30QgXerOAeJjxL3KIVPaXfvbvKhwT/zurjVNyYgTbkps3LCAKnY+nrsuH
 KIblmRZmuL0oCyGeFHWQ7ipkd6qMRAFrEoPwrkc4CjpV0GyDb1ZaWdbyC g==;
X-CSE-ConnectionGUID: NRmQ3VRAR9i9MUzVgeY8UA==
X-CSE-MsgGUID: xb/EyjJRRWWxgnvdO/oGag==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853121"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853121"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:41 -0700
X-CSE-ConnectionGUID: OGFKUvL1SQSpw76CizHwOQ==
X-CSE-MsgGUID: SwFl9AVURzmVCXXWXfs6kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225220"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:41 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to
 prevent RX starvation
Date: Tue, 15 Sep 2026 14:55:35 +0200
Message-ID: <20260915125538.3975870-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
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

