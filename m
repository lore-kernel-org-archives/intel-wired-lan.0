Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AE8C43458
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jun 2026 23:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BA7E6076D;
	Tue, 30 Jun 2026 23:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Js8dNeVOYECz; Tue, 30 Jun 2026 23:45:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CB27606BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782863132;
	bh=AdwzA6i19SzfrtJWdDEr0qnujjEHOEaYqCHFRSzvJjc=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h28WoExC8TJDYAqyngrm+SGdlNEGrgs8fRCsEld0dsvP7ziffLR/tqKFZ9GSDEOXA
	 OyIfUZCu9oL4a+Z+WMoeti9IL37iy9OEKj/UmoZd0s6IZoCK0pYTraGqPVkZq9TGBU
	 rFSstX6kF4oeFVKDtgEGRojVlApcBZpsB1mV2HECWiioz5eI2IksOiTADBySE52VpM
	 EmHWEa6w5uCLLkEC0w0Eoo/CyH7Exr8Xs0SONjT6zNge73pqq8ipy0i3AgQMbgmx/q
	 9KxGpj9tDQLWtGnwVhM0F5HDQbcDV6u/v7xqYxLRftCaV74Y9hLYzx6c4/+SGXqFVI
	 hFbPy44zWmZ/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CB27606BF;
	Tue, 30 Jun 2026 23:45:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EDE81316
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 23:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFE3D83709
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 23:45:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qP9j53ioK9X1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jun 2026 23:45:30 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=joshua.a.hay@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 104BF8374F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 104BF8374F
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 104BF8374F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 23:45:29 +0000 (UTC)
X-CSE-ConnectionGUID: WwTsMJQFQWKZQirUTznaFw==
X-CSE-MsgGUID: 4B6qvi4RSyW8YkDPNopGhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="71111733"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="71111733"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 16:45:29 -0700
X-CSE-ConnectionGUID: 2jDqwQ7pTVSDiSUDqEDaPw==
X-CSE-MsgGUID: 3mr3C2r+TA6fqJv4NmV1YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="246061748"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 16:45:27 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Tue, 30 Jun 2026 16:56:19 -0700
Message-Id: <20260630235619.756633-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782863130; x=1814399130;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VVU1Aawok25MxGOIJ6dAsnFw5aNp2IWcF/0CXay64Sw=;
 b=jbTiGrGRN4HAZQ312lTFC9vvilduxzEXuN2x0KVf5PwZIHbA3CCrd3GY
 00GQ/kll5wf18voXsknXBDBQOo+TYsBrqQcasx1T6/D7AMTHFDUp+oPxD
 8Op9CrxXj8sZ0xfnlzKh5XaFn+/C1dXAZ5IxNQBFAfwOp2H+rK071T7ng
 ocDB4DeO+T35PqY79V5QygbypZCchixYTo1sOJk7AEAQj60NoHLrmcrmy
 LGy9PbWaLbrZkFnRjI0ywDK7XCZCbmoXgGnLHR8YzLXZ/cOkqa15E1x/f
 HqAeMH4p5sJSn0AuM3/7fy/N1+T4QNO2vSMVpTPvWSLD35KcfBsDtbvLM
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jbTiGrGR
Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: adjust TxQ ring count
 minimum
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

Set the TxQ ring count minimum to 128 descriptors. Any lower than this,
and the queue will stall and trigger Tx timeouts in flow based
scheduling mode. This is because next_to_clean might never be updated.

In flow based scheduling mode, next_to_clean is only updated after a
descriptor completion is processed, i.e. after the RE bit is set in the
last descriptor of a Tx packet. This will never happen with a ring size
of 64 and an IDPF_TX_SPLITQ_RE_MIN_GAP of 64. No matter what the value
of last_re is initialized/set to, the calculated gap will be at most 63
and never trigger the RE bit.

Even a ring size of 96 does not solve this. Because of how infrequent
next_to_clean is updated and how small the ring is, IDPF_DESC_UNUSED
will be much smaller on average. This increases the chance the queue
will be stopped because a multi-descriptor packet, e.g. a large LSO
packet, does not see enough resources on the ring. In this case, the
queue will trigger the stop logic. The queue permanently stalls because
there is no chance for a descriptor completion to update next_to_clean
since it is dependent on a packet being sent.

Fixes: 5f417d551324 ("idpf: replace flow scheduling buffer ring with buffer pool")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 7f9056404f64..c724d429a7aa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3097,10 +3097,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
-		/* Set the RE bit to periodically "clean" the descriptor ring.
-		 * MIN_GAP is set to MIN_RING size to ensure it will be set at
-		 * least once each time around the ring.
-		 */
+		/* Set the RE bit periodically to "clean" the descriptor ring */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
 			tx_q->txq_grp->num_completions_pending++;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..908dfa28674e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -21,7 +21,7 @@
 /* Mailbox Queue */
 #define IDPF_MAX_MBXQ				1
 
-#define IDPF_MIN_TXQ_DESC			64
+#define IDPF_MIN_TXQ_DESC			128
 #define IDPF_MIN_RXQ_DESC			64
 #define IDPF_MIN_TXQ_COMPLQ_DESC		256
 #define IDPF_MAX_QIDS				256
-- 
2.39.2

