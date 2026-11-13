Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E22606E1D2
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uLVV+YKZ;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=FN5n39gl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D00ED81395;
	Fri, 13 Nov 2026 17:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wd5qjdgbtPs5; Fri, 13 Nov 2026 17:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 87ACC81360
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794589245;
	b=jSyO0tfUPA5AEFhamzl4Wa38qksYSU1rdi3RvmEGwIT+TX8DFb1ekNkKAAtD/0n2+AjD
	 ou6rJKTjCuE+OCnXoWyTDaVvXIeMP/h4sb+/fzTkQYc36y2C7Lv5VoHhZDLwMxuNj0L1J
	 wRML4mdC+MYlkHENpM8ozJSD0EPPrqmrXvpMZCLMTPZ3AjG32TKFj3T5mgbffCcqbYmA+
	 JqiaGlgXZLKadG3n/TVO4vIU4QwNY9yFN8S7b8w/3llaGFvhU28AxyJohI447A6a5LS8m
	 pOSri4odNC4Vhy7AXh3SPv6EeBW6mUWy/UB9XN5iYALFKZJoKDBQT04fhDqjGXvayQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=r1yDilK6qB0Us3n3DQsotlXwYJQ4+ehyKDqtQf7/FDs=;
	b=oHgfeMy8diSgNFW7HYkl4W3H/DU11OPBlGY7l9VCieVhbf9cyi/bNdAF8b90E7AEqAxp
	 9zJbdmvikEiFR7SiRl+H6cWZscmGPW2u4ZOaINSEgkIJQhSBCQnhxqft+Aygg5oi8jgbp
	 /TA7+Gy2ko29XinYINtR4qC+RdN+lVJ3Pb0ZasSI4ry/+IWiHbu12/Yz1NMmAPRuf2EnZ
	 YTwwiB2aLjt6MFANVATqSqG9mjXRZPdmh9D6hFaOW2A2HPl16SVB8N4slxi8Vp2L/Zsyr
	 8RXiasbkW6iNxkXDdNrmmoHYwru9WhoABM5laEavoOdOBLtuLPcOpXj4/pOCrpiNBKQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794589245;
	bh=r1yDilK6qB0Us3n3DQsotlXwYJQ4+ehyKDqtQf7/FDs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uLVV+YKZ7p+kGiq4tiRaUoK7JqRyKomgeyrpYleWSbG/5nBnJl24hvzMoTD21Ma0v
	 b8+QsJZsan6vtuSrRb9txYBiZRAMa4HN4RrOChxp3s0i6go4UKbcgRaGAsxEbIdgqA
	 DCW9vLPpwTkDybKOnrWfz+giuZlyAN8k98BDACP8hWOkpoVpYWvOR73Jk6GCYhVmQe
	 yap8UkcYSgCURAaoyYIPns6SP1+VthfwNUE2WkIIXDjxrGXY3gc3iMV0Zd/FfsUcAj
	 ssOT1CZaibG/WZPXzlxjbcK+Yq2e3I9QAq8onRynHIGPjVcYWn621EdiCGYBJ2+IQH
	 UkkF0jtACXpbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87ACC81360;
	Fri, 13 Nov 2026 17:00:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D29E428C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3A4F404B2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D692vAS68A69 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 11:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2FA31404B0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=195.10.208.42
X-Greylist: delayed 439 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 13 Nov 2026 11:06:07 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=FN5n39gl
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.42;
 helo=mout-b-112.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FA31404B0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:06:06 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jQvPv6lYNz5xyN;
 Fri, 13 Nov 2026 11:58:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794567523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=r1yDilK6qB0Us3n3DQsotlXwYJQ4+ehyKDqtQf7/FDs=;
 b=FN5n39glsRmZ8Hy5vSXpC/z7hej2XvnC2OeRTXF5nEmyUua2UvrYARCFnReM+8HUF/z0N0
 xjH+mKwM+gXu1p4Z7urvEKcVqaTVo9647PWYnQ1P1c5rrG9nTily5lv70iC1Dl82TWNpvs
 XGftQsx8ydB4PhEaQkomqkIz5oACDg4CywU2tVGkakI3uDZqmhQbo0c1mIwJtHL+WokW+L
 ca1x/XtLlKvp+Az3Ud01FldzqcY8SyppSZ86TnGNtDrvyKwQCaXFzsTJ3bvSAFdXM0pEkc
 h86wDZxZBmVB1qHxEK1M/iypiRkizsQ6kLDQN/+uKapD0U5Q+tVfxw+FAkSvyA==
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
Subject: [PATCH net 1/3] igb: fix RTNL assertion when resuming from runtime
 suspend
Date: Fri, 13 Nov 2026 11:58:31 +0100
Message-ID: <20261113105835.3821433-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jQvPv6lYNz5xyN
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:00:43 +0000
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
require it. An asynchronous runtime resume (e.g. after the link comes
back) then triggers "RTNL: assertion failed".

The queue counts only change on paths that re-open the device under
RTNL (ethtool -L, SR-IOV reconfiguration): set them in igb_open() only,
as igc does since commit 6f31d6b643a3 ("igc: Refactor runtime power
management flow").

Fixes: ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 24 +++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 78f0786..bd1185d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4178,17 +4178,6 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	if (err)
 		goto err_req_irq;
 
-	/* Notify the stack of the actual queue counts. */
-	err = netif_set_real_num_tx_queues(adapter->netdev,
-					   adapter->num_tx_queues);
-	if (err)
-		goto err_set_queues;
-
-	err = netif_set_real_num_rx_queues(adapter->netdev,
-					   adapter->num_rx_queues);
-	if (err)
-		goto err_set_queues;
-
 	/* From here on the code is the same as igb_up() */
 	clear_bit(__IGB_DOWN, &adapter->state);
 
@@ -4223,8 +4212,6 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 
 	return 0;
 
-err_set_queues:
-	igb_free_irq(adapter);
 err_req_irq:
 	igb_release_hw_control(adapter);
 	igb_power_down_link(adapter);
@@ -4241,6 +4228,17 @@ err_setup_tx:
 
 int igb_open(struct net_device *netdev)
 {
+	struct igb_adapter *adapter = netdev_priv(netdev);
+	int err;
+
+	/* Notify the stack of the actual queue counts. */
+	err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
+					adapter->num_rx_queues);
+	if (err) {
+		netdev_err(netdev, "error setting real queue count\n");
+		return err;
+	}
+
 	return __igb_open(netdev, false);
 }
 
-- 
2.56.0

