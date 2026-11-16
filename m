Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880B606A88B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9RdT657l;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=X8DIOU/s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FBA440694;
	Mon, 16 Nov 2026 15:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G0bYNGtaYpVu; Mon, 16 Nov 2026 15:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F4BC40708
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794843061;
	b=RCLN/xy/1Zqh8yYIdWRnGAHH5dT1/9oHuJzhzm2YWDX6FE7F56XaaNkUvWgU0Ehav+wL
	 hkNI8+biDqSDfi16k2Tmq0vNgAX7KwfjZDzYHu9TiYpDu/XfRQApizcIbli9RhfJP9XP5
	 yzs9f8/cizDb1qyl24BEuYiY8oUlZ021Sp1IrYXCahsfjshkpZWFeuFPaPSsBVkhpdt7s
	 tkGbVQcTCj3RcIXCfdd79Ul0CjcSDVhs04hXFAC+qRu+1s6ZUtbQt2sA1W6pzGcHz1AuW
	 R6Xdkp2zTyEh8IASMr/35/MREBaAeq2zR+GNW/o/ciL21+o8yFI1Pi20LQVxgBywXfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794843061;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/KvAfHc/QLMwdWXcJBMsR4GboKbodePkCw59oer/jOY=;
	b=HJxXazctZnRQy4AH1VvBL4+1rFkXkFDrhLQJX4biS3GPdItnAJ7uRrGTMddcPH7UaT/H
	 41oOTu2ZryZzo7xn8e4+GcIUH2ic3VNJPqSDuAuAH01r2jkdZ88+hXYMN2HzRCvjBa9Bo
	 Y+/YH7XSQVfUWxPtQaZ/+IPjxP62f0jeLnOlUo4oqvnXV3agjZ3z+9a+t5wecViiP4PyU
	 W6MqFbBUdWwUpfyLkrD1yGPuJpjLBhuFXeiSI05hEXZP9n6IH7W8qv8WxyIhfy4hMkloL
	 H5ep060ZgVWh2rB/X4uxjz5iDVYKy9/3N/h9b4GYjaZvKGdcbZRZHy/7aZ+t0AE+HEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b="X8DIOU/s";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794843061;
	bh=/KvAfHc/QLMwdWXcJBMsR4GboKbodePkCw59oer/jOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9RdT657l4GN8D8JUB3HgdQiZFbiLTpf3WbIYzrW2DGNTLLYJcY04DyR5KaEjXEnwZ
	 X1yMQsQJJOuZoJTLosJx9Y2el+9YoYnMq+ntKr64iywCKVH52+Bf+M+9g0BtQXDGpK
	 8EDtYeD26ckmOwEK9Q/f2F8zIlEc0N7RZzbv/1YUueKFe0anINZJFnHPv9a0Ygklvm
	 26r3XylDA5F/YdJsw9klHyO8K6LVcloSfqQyA8GT8hz/llXAtHsm4Ft7OjTUeGrsTc
	 RG0PDi/qrNFK7ql9ftxurO1+wQix2+SaPtMYxqh0txg0+U4jTlKObq8xRsJBtABriA
	 58xlx4f82JNaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F4BC40708;
	Mon, 16 Nov 2026 15:31:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A83928C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B25940705
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aa98agC49cTZ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 15:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 157534069A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::110"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::110; helo=mout-b-110.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=X8DIOU/s
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org
 [IPv6:2001:67c:2050:102:465::110])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 157534069A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jSsJT6Wm7zNlbp;
 Mon, 16 Nov 2026 16:30:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794843049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KvAfHc/QLMwdWXcJBMsR4GboKbodePkCw59oer/jOY=;
 b=X8DIOU/sKPJhcdO2Bxc1cYL7LCCupLRpR8BlauYVB/oPs+8MllRzMcVaxUVRD4I+nf0Aqw
 YmL5Hn/jEWEtHcAws8uCwJz0hYtLV3z/yRRDgRclmrxzE3FY/Rtp35Ka+r2pmt1XbWLxZF
 eeVo4Vx0X8QvtU9vOKguDtqyaOQD7/o8RKO9jAHhWINfo14OMf8QjBWYsLJFrf5PKik/El
 mxTTrjq3NbfP6wLv8Ji4Nd0q6BNJ2A1+OCt5KOUFlSl+pphf7n95YH4nsITDk7y3z62O0w
 OS121uyroT4qHPF5gza/ivPOUfRLAvWxfXD2qq7w4so7ghcMiefOObjGsyBLkA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH net v2 1/3] igb: fix RTNL assertion when resuming from runtime
 suspend
Date: Mon, 16 Nov 2026 16:30:37 +0100
Message-ID: <20261116153041.3002666-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116153041.3002666-1-antonio@mandelbit.com>
References: <20261116153041.3002666-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jSsJT6Wm7zNlbp
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
require it. An asynchronous runtime resume (e.g. after the link comes
back) then triggers "RTNL: assertion failed".

Skip them when resuming. The counts are set again on every regular open,
which happens under RTNL; the only case left out is a fallback from
MSI-X to MSI during a resume, which leaves the stack with more queues
than the device uses until the next open.

Tested with the 82576 emulated by QEMU.

Fixes: ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v2:
- keep setting the queue counts in __igb_open() after igb_request_irq(),
  only skipping them on runtime resume: setting them in igb_open()
  before the device was resumed broke the MSI-X to MSI fallback and XDP
  setup on a runtime suspended device (Sashiko)
- drop the reference to igc, which has the same ordering problem

Note: igc sets the queue counts in igc_open() before igc_request_irq(),
which can fall back to MSI, since 6f31d6b643a3 ("igc: Refactor runtime
power management flow"). We didn't have igc hardware to test a fix with,
so no igc patch is sent for now.

 drivers/net/ethernet/intel/igb/igb_main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 78f0786..4447546 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4178,16 +4178,20 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	if (err)
 		goto err_req_irq;
 
-	/* Notify the stack of the actual queue counts. */
-	err = netif_set_real_num_tx_queues(adapter->netdev,
-					   adapter->num_tx_queues);
-	if (err)
-		goto err_set_queues;
+	/* Notify the stack of the actual queue counts. This needs RTNL,
+	 * which isn't held when resuming from runtime suspend.
+	 */
+	if (!resuming) {
+		err = netif_set_real_num_tx_queues(adapter->netdev,
+						   adapter->num_tx_queues);
+		if (err)
+			goto err_set_queues;
 
-	err = netif_set_real_num_rx_queues(adapter->netdev,
-					   adapter->num_rx_queues);
-	if (err)
-		goto err_set_queues;
+		err = netif_set_real_num_rx_queues(adapter->netdev,
+						   adapter->num_rx_queues);
+		if (err)
+			goto err_set_queues;
+	}
 
 	/* From here on the code is the same as igb_up() */
 	clear_bit(__IGB_DOWN, &adapter->state);
-- 
2.56.0

