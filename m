Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03610C7113C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Aug 2023 12:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9EE4840004;
	Fri, 18 Aug 2023 12:24:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EE4840004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692361470;
	bh=kVhIsSR3jqI4zQQ3kpRKavhYY1G9XuS/BhneQFlweug=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=xqNl1bLd1GmEmGZxdGN0OUufJVWNp5dkSfxZXhfV1+0vG9jtdPWa7kN/3ks5tv0RP
	 OpLfiOsxSubr8ihv37nAhSh0+BKukBMUiVt5ZO2WAVHBZkzQGCc7DSlkPSQVHAyVYh
	 OZe8ScrjZNGrtdOmhmTvegEF9yI8QtvfFem90kinN7gz79YB6Pi3q+JjC2gf+VpQAR
	 cA5IJ1ZOrHG/9HFJJSKHKtE3beBA8waupa62g+KxuEOTs2hvPhcjn9YqDMZF//b5ck
	 bomH6Tn9+zct7mtxQdL4z5geU8JoHuZeJ+2O8GyUQDjVkDOLMs0aokl3MNdEyiiJ8D
	 r+UTzz2q2A/tQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wyt2AsVZuVva; Fri, 18 Aug 2023 12:24:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B847C405E1;
	Fri, 18 Aug 2023 12:24:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B847C405E1
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 486CB1BF362
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 12:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2097283955
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 12:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2097283955
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KtX2Zzulb9Rt for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Aug 2023 12:24:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74860833A0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 12:24:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74860833A0
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="373069972"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; d="scan'208";a="373069972"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 05:24:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="764547983"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; d="scan'208";a="764547983"
Received: from unknown (HELO ocsbesrhlrepo01.amr.corp.intel.com)
 ([10.237.94.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 05:24:25 -0700
From: Radoslaw Tyl <radoslawx.tyl@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 18 Aug 2023 14:23:54 +0200
Message-Id: <20230818122354.70099-1-radoslawx.tyl@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692361467; x=1723897467;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oYzP06ElBfJBgSCCNiwv/K7j/O6dMZBDNnNeXEHWJC8=;
 b=PeJ0jvP1wjhgYXj3IC9C/X/Rfc2wuhe/r16C4dGFsOuq9lYdbNCp9tOl
 Yjtu7Ba6YdNIlT4dFhVKEpMY/tO0uy4EM6dKYe85sBhcpCzOwCp5Y54GF
 rJ6pu05OqViI4tcSWTm1cDUe2DqAHikIp6SawUos84nHd5ABoxYmRucoE
 ZYoIOeN5hPEABHsqcfpdAMhZb+I1autZYjwINI9WuIh8ugTO0DnbGTxDg
 DSLz5mMSxU/xsWSej3rj2okvlwaYb7yWGpbb50ANTeynnoFa5Z70CBYLh
 XKQJrqEp94B6FbtSphGmCvZmKhZh0WrEwQmY+toz5MvSGtmDSKNYI8Qww
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PeJ0jvP1
Subject: [Intel-wired-lan] [PATCH iwl-net] igb: set max size RX buffer when
 store bad packet is enabled
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
Cc: Radoslaw Tyl <radoslawx.tyl@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Increase the RX buffer size to 3K when the SBP bit is on. The size of
the RX buffer determines the number of pages allocated which may not
be sufficient for receive frames larger than the set MTU size.

Fixes: 89eaefb61dc9 ("igb: Support RX-ALL feature flag.")
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2293ae78f711..134a607ea3fe 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4814,6 +4814,8 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 				  struct igb_ring *rx_ring)
 {
+	struct e1000_hw *hw = &adapter->hw;
+
 	/* set build_skb and buffer size flags */
 	clear_ring_build_skb_enabled(rx_ring);
 	clear_ring_uses_large_buffer(rx_ring);
@@ -4824,10 +4826,9 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 	set_ring_build_skb_enabled(rx_ring);
 
 #if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-		return;
-
-	set_ring_uses_large_buffer(rx_ring);
+	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
+		set_ring_uses_large_buffer(rx_ring);
 #endif
 }
 
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
