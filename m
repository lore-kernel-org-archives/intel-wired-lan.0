Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE6606A334
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=4bIz5qpf;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=Y9ysuHnt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DECA8607B7;
	Mon, 23 Nov 2026 16:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7UC3mHy24LNy; Mon, 23 Nov 2026 16:24:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A5B5607AE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451071;
	b=pMR/lHDB0ERyt/WjneT0VM8XaBqZe4zE2R06nT80Lbk8h591vXyxwZ9fV7Y8xjD2lNvO
	 eoiYw2AyG6y4W6lTYI4NNBlTTOkgI0+Ol9n7wzp82Esy6EXE+lUJ4T0kspuO+M2dM5WR3
	 bSaeDt110Y2WXsnjWH4uWRqPMaGJTqvsFEoBTtT3/DS6N6tAcFwwQGVb56/RKEpgEOBNT
	 s4crGnZg6CfmbIB1feIMMS0kuttMJyzoqhyN5CmcaoXzB7I2vviqg6dM0tLHH73ZTvtA5
	 XCz5PHr6+OXkZLeWrQlu6Ph4clXA2xcaFlMJz+6h1l9iHqtFygbktomHcNEUb751Wxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451071;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bEpIf88Bd6lcTR9zfzufaNRnF9usrLgoYrUbzb2lfhE=;
	b=sdekgs9sZSTqZw1lZ2bh0xeTxOmLO5cUWuWWXJ/alZKz+uE7T4yd8QJ/2H++WIqaw0NN
	 6U4XKzZRxqiy58jFpCBKWRcrAzeMd1FbjyM3ZpZgjgsakUNEWvRWGjHML0SmPhE9kWWG/
	 0xufbifncf8kpAh7AOJYCSAQ0ty+M9rTLAu+8nhkt2wzEYQ3Uw4cN5QTmVrsN3QF5IqmO
	 Txung6mk11F2LCacMw5Wv0AoNemWR53bGflJI3a8cFXb/lY92e5Gp0m92T438J3Aa8vlF
	 dvE3zuN/L2jiF0WMhc3SLvjVroPyFVqtk7hc8viu2GjENNN89qK21HjRecaMI8srV3A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451071;
	bh=bEpIf88Bd6lcTR9zfzufaNRnF9usrLgoYrUbzb2lfhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4bIz5qpfybK0XnK6QhuonXhpVV1LyXVa2DvmbZ8O32M+tM8RS8EJHWUa2UMZwvl67
	 d9oP1oRDXaYyxi2Ay9lrGxslsUdE9gHNyt5gEdKqitt4d8s60ejYLAcqt5UFbTg61o
	 4F9BiAnELi/rpkjl62Pf6tikTYB0f6Uzl9LbbgO8UbP9jtswvljw6GyggCQYgHgCXs
	 8fBv7Zcxi+GMOGNf1wZnDUiOfvtzS+AQRTrLOMlBhAHom1Z8quOoypUAy0NcacZNoa
	 fjlDNyZO4HAySJllKXW20RITePr+POlp8pMJdg62aUqr7z6kvnFBrPf6AJRaubfrz3
	 2ZFKcI07WQFug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A5B5607AE;
	Mon, 23 Nov 2026 16:24:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 560BD260
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C1FA40651
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKz5uQm3pv6L for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 10:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53F1440637
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=lists@steffen.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=Y9ysuHnt
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53F1440637
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:04:13 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jY1Xm5C9dzMlgh;
 Mon, 23 Nov 2026 10:55:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795427752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEpIf88Bd6lcTR9zfzufaNRnF9usrLgoYrUbzb2lfhE=;
 b=Y9ysuHntcZr/WuV1FN7G9XOKaV9MwE9QBnxdAjOysKRf7VwR6PJxOwLKxUxpnj/7x8pBIK
 46JMRw1jfqooqNjoTNACt6vM/DtzHd5a9R8ogsc5xpZXby2xbfRxLa6p8BHBb2rP4cj1ta
 xflqulWQ7fj7Dtz20GqogRZWC/oGDqwfykV5CcGWmAcgwSqqlC4YASyRfI7OZaYFBt8EGC
 XYOfVxmUlfnugzA2QOwQCJ8wlLN86jI3L9W01ctUiDkHthslKrBicfR1xEg94mcS4qlm2n
 h0FVop07MPGcqBQs0Lv+ybypsMyZr+K3kKrV8S1bQyDsY+6nkthVM4HWLkYD0A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:17 +0100
Subject: [PATCH iwl-net 3/5] igb: let dev_watchdog reset the adapter after
 a Tx hang
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-e1000e-tx-hang-v1-3-ecb4309942f1@beckhoff.com>
References: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
In-Reply-To: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ertman <david.m.ertman@intel.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=2327;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=kUAgDpH1g5eruMkTh7j/zlD+tdNUXEhJeF4Te0NE57c=;
 b=7q9oPPB6+vOKUJdNZ/0FO9hSkalrOkgPaS/zyYRT1rxRiLlwOTPyi4s0eVSZyGv5KcFpcRD3v
 5/b1b2sdH2tCwKsEVw/OL5SezW6Xa45sNKMQDXtZprZxLD14L6Hwsrk
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xm5C9dzMlgh
X-Mailman-Approved-At: Mon, 23 Nov 2026 16:24:27 +0000
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Like e1000e, igb stops the queue on every Tx hang report and relies on
dev_watchdog() to reset the adapter. Since commit 95ecba62e2fd ("net:
fix races in netdev_tx_sent_queue()/dev_watchdog()") every stop also
writes trans_start, so the watchdog timeout can't expire as long as the
hang is reported again in time.

Until commit a22ed15c99a0 ("igb: Get rid of spurious interrupts") the
igb watchdog forced an interrupt every two seconds, so the hang was
reported every two seconds and the adapter was never reset. Since then
a report needs an interrupt from traffic, and the adapter is reset only
if a stopped queue sees none for 5 s.

Stop the queue only if it isn't stopped yet.

Found by code inspection after the same problem in e1000e. Tested on an
I210 with the Tx queues disabled through TXDCTL and that commit
reverted: without this change Tx never recovered in 8 of 8 tries, with
it the watchdog reset the adapter after 15 s in 8 of 8. With unmodified
interrupt handling Tx recovered with and without this change.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 131df3e09ba1..0aca2e70087a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8484,8 +8484,15 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 				tx_buffer->next_to_watch,
 				jiffies,
 				tx_buffer->next_to_watch->wb.status);
-			netif_stop_subqueue(tx_ring->netdev,
-					    tx_ring->queue_index);
+			/* The hang is reported again on every watchdog run,
+			 * but stop the queue only once: stopping it again
+			 * would also restart the Tx timeout, so dev_watchdog()
+			 * would never reset the adapter.
+			 */
+			if (!__netif_subqueue_stopped(tx_ring->netdev,
+						      tx_ring->queue_index))
+				netif_stop_subqueue(tx_ring->netdev,
+						    tx_ring->queue_index);
 
 			/* we are about to reset, no point in enabling stuff */
 			return true;

-- 
2.56.1

