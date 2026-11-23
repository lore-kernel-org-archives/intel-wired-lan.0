Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9651606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=C3fcFhAk;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=NM0GSes/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A634C607AB;
	Mon, 23 Nov 2026 16:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRA_iLN2Y1QR; Mon, 23 Nov 2026 16:24:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C267B6078D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451068;
	b=CsGPWx5swHL/JObC/nL6YjevKZUvhWKKjP3ZwPRci1BDp8yAN0vJ8o6SAQA7Juo+YJEv
	 xspsqzeuXl6uoh6UmMMlQdREABWZ1zivKSVKWZqwkKEYuktz/shnBkvwack0By4Qx0yM0
	 uj9j803K0I9pxy4p2iDCfZnjfA3F2iML74dGtEEjxmUhikcvBB80WzypH6KzpsNxw/Wzc
	 /KsagSENAcdPP0H7KJ3gazqmvSOP/UZEZwyzaa2OzANPGjNYgN1T0oZrBAy93DvJ7joQ2
	 uiCdvCVbTJQsF2ZiSBlTR/rwaohC6wOZnlNuYowA/UzgNQ/TriBNxXMvbtxXHIGsAfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QmVkY0D1iugOAnFAYa2JnBEt+O5w2UV3yLDwM6Do3wo=;
	b=CjGkunQIq3N6gxRe/vTrXA0CU0vjdLyMuc7lxrDe4KXpqYwkaL2Eh+Bi+6OQAlwiFNxQ
	 es+RvtScv4GeU8fncZW2I1UaboolxEnVYLIaKG8V77dJl6r/0zwuKuH96b4PkxEyyriDN
	 giygsohq6M9qqq6HOxYSReLtuKUwtCxXAT5QRhlfx4G4ilw31bVjwPe2NVY0sfwwd1c5H
	 ByqUkaIqx1d1HIC1V96M0JTMLtxOlLn6MjNqyn8ggDYDLOaG6Y8wEFjbnomVgIfbmawu0
	 YZQwZ2cW8D+t2igBNwffs5cwF8mveXeuGNWfpkPm1fxk9kh36t/rg/has4TUejqpTCw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451068;
	bh=QmVkY0D1iugOAnFAYa2JnBEt+O5w2UV3yLDwM6Do3wo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C3fcFhAkQjS/MWl18yXq7KTKFS27ZVPUIIkvSxsEG06XAO9hWD3jHUUfuPSrxMUfB
	 q34XtZShOD1YvdmtZLEttTV9sApDqVxiVU90J40pLA5odSTcpR6+CkBddQ3Hb6W30W
	 NvHbsrY0aJRsedNaa9amlDUDuWZB6NtKj4xFIF34TUqdZjeK3zM7juNzPm2JwSmnCF
	 wWUmSPk6yS4Qn2saR+tg0ZYJz0JldZ6Iz0GXJqal5i7huPOOUcLNAbbxYQ9tzAm8Gd
	 l9S9icc+avVW1SqQ8QolQBuRkvgQfA1ddcErp+fzPVRvScruG77rXMQWOM3jaiYuRB
	 PbhRwC3Y8BnlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C267B6078D;
	Mon, 23 Nov 2026 16:24:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 441B279D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31AEB40685
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eoO-Mox4EWxI for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 10:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 222514067D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=NM0GSes/
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 222514067D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:30 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jY1Xn55VLz8v21;
 Mon, 23 Nov 2026 10:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795427753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmVkY0D1iugOAnFAYa2JnBEt+O5w2UV3yLDwM6Do3wo=;
 b=NM0GSes//QXNxRW0kJJIfeWJbCEiU5+Bzsov5kmja9Mn1ntPLZHYOeOprqoGpVuXHEhOUS
 8BaWS1zjyuePum3Ip7KHbjCVAsTJr+Tiowj59GQEmDprmZnfJgRZb/fmr8/ZmQSHn1/IP7
 pl8lRwW9TGIxDdJUeR/39FH1eJBgIlwnFJMKevHZQGvrwr6tLrpU0UB8JAmIRDFl5ijCu9
 KxiKiYZj58KpUZ5/+/LoF5li85zAOzj4RIsyGePiA2XlV+CPHzRIYh5vULRDCmpKavuKOS
 ACBX2UwdNenb6kTx7DqPMzxpkgrnXFpUy1Q/i/VE6LZlGlVpShJD3eMqgYvmOA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:18 +0100
Subject: [PATCH iwl-net 4/5] igc: let dev_watchdog reset the adapter after
 a Tx hang
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-e1000e-tx-hang-v1-4-ecb4309942f1@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=2381;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=4g3DPsLitWHXFohTOuhHku+cbWck24n8+SNlkObQQIY=;
 b=5LDOPqcYvOa34lnT0z+fdHRrcuGJNdYPI18Z7XLjpbHMsow1VF2k6vtSBKoXoSQQL7fai7d6V
 DHCBPkgjeVmBxYqCZX4Alketx9gPPVCRPK0Ebtwy8kJOxxNfGKOHSJT
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xn55VLz8v21
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

Like e1000e and igb, igc stops the queue on every Tx hang report and
relies on dev_watchdog() to reset the adapter. Since commit
95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
every stop also writes trans_start, so the watchdog timeout can't
expire as long as the hang is reported again in time.

Since commit 8dcf2c212078 ("igc: Get rid of spurious interrupts") a
report needs an interrupt from traffic, and the adapter is reset only
if a stopped queue sees none for 5 s. The 6.1 and 6.6 stable trees have
the first commit but not the second: there the igc watchdog forces an
interrupt every two seconds and the adapter is never reset.

Stop the queue only if it isn't stopped yet.

Found by code inspection after the same problem in e1000e. Tested on an
I226-IT with the Tx queues disabled through TXDCTL and the second
commit reverted: without this change Tx never recovered in 8 of 8
tries, with it the watchdog reset the adapter after 14 to 17 s in 8 of
8. With unmodified interrupt handling Tx recovered with and without
this change.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..a2d383f79a29 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3281,8 +3281,15 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
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

