Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A5606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZWGnoNI8;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=amWI9P9X
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E535480E78;
	Mon, 23 Nov 2026 16:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pcwqsdAUak33; Mon, 23 Nov 2026 16:24:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D58480DCB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451069;
	b=hmVoT3/2Z7nF6XmrW2my/QFIB4S23HjPGT6v/fgCvjpcHjqAcHcR1cgEAlD3b2spPFVF
	 4ffEA2NHbsj9dQ4XtEGPDsASsgkwoz3r3cDal2zNgc2amUznUGJr5xKocrYvqeOTG+ka6
	 ZQoZr4YBe69LB5YuX17EWR50qbl/F1QXFAO4e3DvJLFr99DJ38iOGPVaAjim5Dp14f4O9
	 5qA20+auscwMkanIMZ5kB4Zlqz9O0jTIb9+D+2VhOe62VC80Y8Rg4hIk3r65KVPEmjq37
	 1f5ZhSUQx6cNwFSZWZtEBxMlfhExAT1tdi2JiIOZW4edE1z4Fomh5ZDOtPT0YK4B6nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WL5R4iHTKyqUmYt+PndBZojbg2VKGSQ09Viuh54Sxo0=;
	b=Q6RGd0BkMTXsbfO1UmmZVr2oxKYLJ/YGTjvPBM3oZ3yi4u9Gd4mT8qK31oSMoB3TZSI9
	 P5lRvsvuYWw/EBLl2pHTL96/vDE3exrFUexn6jZVRMwfdWdiqZyoNzlYKsLcFwlVh1fdq
	 4f2yPMgEuv66szpLI6ItEz8E88sTEOGmOus21d8TXNZ+vyhu4ey9cG/zXmUcuBykreyBY
	 bxrwlicxYBchaCtsdzk6uOmNJ+ABJe1bgzgP76lPIdD4wImpqN9ttoRLrSojDOlGFR9xH
	 /pHypIIzamGSdnOuVXMSEr1rth1EUjG09xFrZtSVtGv8m0eSsciDOHWwD60hZ9gxIwQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451069;
	bh=WL5R4iHTKyqUmYt+PndBZojbg2VKGSQ09Viuh54Sxo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWGnoNI8sCLHSdDCugt6jZ9mACpfF6t1PbGMncagnttrzeJzqv1gSB2LGthCW9Zo7
	 foakKwoMsr6qWOHiu+k5e+uA/v5IkR1pX9qxaBqxTDPM82tvTtmiy3BCrgSEvm68fj
	 M9C6tsOzdAxc5zLJdJWUOtazrWUdBKgKjjs40KW2vCPtTg8ItVpHtt4OgXnxFUMiOS
	 ibE4Dvf/bEqPENw/A4N9kq2fIrzSzRfv1/mZfp87bKkSWvXChHQSZRMZ6naWUq77jY
	 3D0hCjWU9cUI5hi1KiO0va5b/Uk304e1TyOT8SWeiJFucczz7N9HBrRGsXauUgQj5A
	 7g+5VU55nt/+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D58480DCB;
	Mon, 23 Nov 2026 16:24:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43CD5499
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34DD5606D5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9jWzYwRBRGT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 10:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22450606B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
X-Greylist: delayed 457 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 23 Nov 2026 10:03:31 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=amWI9P9X
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=lists@steffen.cc;
 receiver=<UNKNOWN> 
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22450606B0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:03:30 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jY1Xl4knzz8v0b;
 Mon, 23 Nov 2026 10:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795427751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WL5R4iHTKyqUmYt+PndBZojbg2VKGSQ09Viuh54Sxo0=;
 b=amWI9P9XuEyeCuBwnxQIFyoi8ncYSw9TlWJVNEAlyfqXk/vVFocfMitycX1MHOHQSTnH90
 IbcrvlccZYxu/4tTCr6J9w+qCqFNOF/rmE5G4zkqSi/7PdddDfKHNW26PyYcYgyRdVIlZx
 3R9DMnvPmIyPgLWs91mZ6JiqxkCevV3z3gIAJID090LgsMupNIhngFno5W+qgqmGGmA5HW
 MKJ3DEPwutcOI3X920jamimsLQKaM2NKvOrNYrgKm7yldQTWsvYhucUkQL3TI4gOHzhGTe
 49DEKSE9OiJShNDzXV1I0Md2TEECpUPVzDoU8BUe6jAsmuMuLq5Txfg2GsXuLw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:16 +0100
Subject: [PATCH iwl-net 2/5] e1000e: let dev_watchdog reset the adapter
 after a Tx hang
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-e1000e-tx-hang-v1-2-ecb4309942f1@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=2275;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=0TafWYGRwlZ53tYl0ky61zeXbqbv+riYcpx3ZxKtx6w=;
 b=AOYdFSIbp+BieMI2SYWa9+otd1iG7wrUjUfS5Aa7sESWLnTnqn3ubS/nN6QrMWA23l4RwSq8k
 DuFNoqKi3WwDOP34ESb54sDs8oBwhlGmc7oddZLtq/HDa5NsJD1VcXt
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xl4knzz8v0b
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

When e1000e detects a Tx hang it stops the queue and relies on
dev_watchdog() to call e1000_tx_timeout(), which resets the adapter.
While the hang lasts it is reported every two seconds, and every report
stops the queue again. Since commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()") netif_tx_stop_queue() also
writes trans_start, so the 5 s watchdog timeout never expires and a
hung adapter stays offline until the link is cycled by hand.

This was observed on a laptop with an I219-LM (8086:550a) running
v6.19: a Tx hang lasted 104 minutes, with 3120 hang reports and no
"NETDEV WATCHDOG" message, until the link was set down and up.

Stop the queue only if it isn't stopped yet. netif_tx_stop_queue() has
to write trans_start to close the race that commit fixed, so it is
left as it is.

Tested with error injection: setting CTRL.GIO_MASTER_DISABLE stalls
Tx. With this change, I219-LM devices (8086:15b7 and 8086:15f9) were
reachable again after 11 to 17 s in 24 of 24 tries. Without it, an
8086:15b7 device stayed offline in 8 of 8.

igb, igc and e1000 stop the queue in the same way and get the same
change in the following patches.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c..e916eba19fe0 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1144,8 +1144,12 @@ static void e1000_print_hw_hang(struct work_struct *work)
 		return;
 	}
 
-	/* Real hang detected */
-	netif_stop_queue(netdev);
+	/* Real hang detected. The hang is reported every two seconds, but
+	 * stop the queue only once: stopping it again would also restart
+	 * the Tx timeout, so dev_watchdog() would never reset the adapter.
+	 */
+	if (!netif_queue_stopped(netdev))
+		netif_stop_queue(netdev);
 
 	e1e_rphy(hw, MII_BMSR, &phy_status);
 	e1e_rphy(hw, MII_STAT1000, &phy_1000t_status);

-- 
2.56.1

