Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AE5ECAAD3
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Sep 2022 13:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D951160593;
	Wed, 14 Sep 2022 13:39:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D951160593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663162761;
	bh=OGXpoWduSFnO0JJ/uk3xCWJCqMmRWGFivFvYWMX1308=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=jMGQdrEUaPwYQaYwSl+kw6IS4bmjDFWgMQ+iIkM+QRFyBkAOkOZxlMVPWedrJ1+cY
	 54Kcuhe7mWK1u58U9Vc7cB21uY1yYnRSWMeHdh97RnWhbvjJSm1aPgEIA533I71WB/
	 7hDivfs8y4eBJ/eua2gQuVkz0yaxa6In2PZr8qdD1sataThY1LX9thiNf6Z+4FWbQr
	 gb4Ah35XKQItTaJH/K/pUTlmyga83PTiM3F//UJRkyNXY2Yts/CHMqv1tQUYvZP5PY
	 aCf7oRiU3iyGQefdiDKCtlMoVpgNm3cLW5hlLujAYEvcKJX4UNUFiWk1TI/pWsEE1M
	 yXPBXYjF9xx9w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ARwdNj5bJpjh; Wed, 14 Sep 2022 13:39:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5D5A60BB2;
	Wed, 14 Sep 2022 13:39:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5D5A60BB2
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 555B11BF3BA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Sep 2022 13:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C79B60BB2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Sep 2022 13:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C79B60BB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fhGNR_OxhBX0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Sep 2022 13:39:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1B0160593
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1B0160593
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Sep 2022 13:39:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="296020137"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; d="scan'208";a="296020137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2022 06:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; d="scan'208";a="647394903"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orsmga008.jf.intel.com with ESMTP; 14 Sep 2022 06:39:15 -0700
From: Mateusz Palczewski <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 14 Sep 2022 15:39:13 +0200
Message-Id: <20220914133913.489614-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663162757; x=1694698757;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1E8WCrKrAbzpjGvRirjwQNiAurwk1FCk1fekNiePb4U=;
 b=Aa9LbGNYFhOe/eDL2Cok6ISlokXFZ62JxEDTXZH2dHjnr8unzLhX6H6O
 VHqV4oHFJ6zuK41nYu98mC4ueNGulr91wdpcue0APFrYUHM2fZugzEt/F
 xCdCilACOrMUgLpkfA9NV8p0gnZwx69VsBWnqdKYy76q3n/TFX/4M4ssR
 Bjo0m+DA+kd0JhxQGmv5pRZx/CTivSVHQZ8fRYIw+n5ITeGEngvefjvFv
 YcPzfxJXToaNyfWd90z6mEb+gAplaySX1PnGNMYtL4BHmTFIqgqM+QIsd
 Nkz7clTw0V0v9SqCf+ccZudxWTwacSO0l/63S973J3wzsMjsYZ9+3IUwy
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Aa9LbGNY
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix bad page state
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Norbert Zulinski <norbertx.zulinski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Norbert Zulinski <norbertx.zulinski@intel.com>

Fix bad page state, free inappropriate page in handling dummy
descriptor. iavf_build_skb now has to check not only if rx_buffer is
NULL but also if size is zero, same thing in iavf_clean_rx_irq.
Without this patch driver would free page that will be used
by napi_build_skb.

Fixes: a9f49e006030 ("iavf: Fix handling of dummy receive descriptors")
Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 4c3f3f419110..18b6a702a1d6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1393,7 +1393,7 @@ static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
 #endif
 	struct sk_buff *skb;
 
-	if (!rx_buffer)
+	if (!rx_buffer || !size)
 		return NULL;
 	/* prefetch first cache line of first page */
 	va = page_address(rx_buffer->page) + rx_buffer->page_offset;
@@ -1551,7 +1551,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_buff_failed++;
-			if (rx_buffer)
+			if (rx_buffer && size)
 				rx_buffer->pagecnt_bias++;
 			break;
 		}
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
