Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6154DEB64D7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Jun 2023 09:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D71E081F25;
	Wed, 28 Jun 2023 09:12:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D71E081F25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687943542;
	bh=f6FDpf1jT8O2DmOLXlqDKY3fR2g263m8GNnU5eAEF24=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=x6psOPkxOZjoTPb972EFFsa+TUMu7jk9xloe7suwt/TFswdmQGjdYETi9IIZ+MThh
	 jLVjllS1rpYIRYcXhIxupLDaOdFV4ZvAMp5Ow5ZGCznxWprBGgCfA2tM0W8MSCSvaG
	 EndRXW4DUDEXh/NeFBlqw3RG8jaQ9CLAzaBbHZ/z0DmluwazXiOBJwgacoAvENGCu7
	 RwGch731wXW5oDnGJJxTiEnPxaP3WcjgeJJ1U6EdIMwiShyUg5f2bK8iU7E8BJ1XHe
	 p4tKOjWFG3VodTSeW1XVrxv3uHOPtTHOed0TcNHn4TuXIoKNe22nJjndEK5xIcP8xo
	 7JwsVlh5Q1g8w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vkIskq-wioUi; Wed, 28 Jun 2023 09:12:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C77B181F2A;
	Wed, 28 Jun 2023 09:12:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C77B181F2A
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 67EC31BF408
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jun 2023 09:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D6EB81F2A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jun 2023 09:12:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D6EB81F2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id An_tMMpdg8SS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Jun 2023 09:12:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67C3581F25
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67C3581F25
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jun 2023 09:12:19 +0000 (UTC)
From: Florian Kauer <florian.kauer@linutronix.de>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vedang Patel <vedang.patel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jithu Joseph <jithu.joseph@intel.com>,
 Andre Guedes <andre.guedes@intel.com>,
 Simon Horman <simon.horman@corigine.com>
Date: Wed, 28 Jun 2023 11:11:48 +0200
Message-Id: <20230628091148.62256-1-florian.kauer@linutronix.de>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1687943536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X0JATWY5yUrknqFueeslFGrqKTA/ehIMFyfgxm0DAko=;
 b=YT9A2pkisAHULoNDuMKgcxtJ/xLDjo8Bji2K++hZQNxvSUA9Yt1sDoySb7tQwt3nCLFUkZ
 i7qA9QV5sRrnTFoqj8oMLSZgCRsCILUuN4H3TWzwZ835PP+BwbXkusjYU9TmbtxXANKTfJ
 klzqc21STP4LUko/26fsAXqo1FBnGRxEdLWyv450KjemJzKGytKDMMc710ONfVJVVn65By
 3cVyQVB6WzZJC4MfoyIVEjgUxZXZ/C78HIICOIkxdapUWP2t7LiBXAZxvRQDpH8ZnSMCQK
 2jU5xsCh+oGfBl4+chOwBxyquamM2SCYDC/8VQxKLg7nm+m2WdwWUR6Ooz+oDg==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1687943536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X0JATWY5yUrknqFueeslFGrqKTA/ehIMFyfgxm0DAko=;
 b=OtN3jhn7DV6ojc3N9cWFAKUT7L1z6nG/35cXsR33QVH1cCOhcf5Xgc+kYT2B3SmUgaY2LR
 Xg1eWIYpRhIzVqDg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=YT9A2pki; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=OtN3jhn7
Subject: [Intel-wired-lan] [PATCH net v2] igc: Prevent garbled TX queue with
 XDP ZEROCOPY
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
Cc: netdev@vger.kernel.org, kurt@linutronix.de,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In normal operation, each populated queue item has
next_to_watch pointing to the last TX desc of the packet,
while each cleaned item has it set to 0. In particular,
next_to_use that points to the next (necessarily clean)
item to use has next_to_watch set to 0.

When the TX queue is used both by an application using
AF_XDP with ZEROCOPY as well as a second non-XDP application
generating high traffic, the queue pointers can get in
an invalid state where next_to_use points to an item
where next_to_watch is NOT set to 0.

However, the implementation assumes at several places
that this is never the case, so if it does hold,
bad things happen. In particular, within the loop inside
of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
Finally, this prevents any further transmission via
this queue and it never gets unblocked or signaled.
Secondly, if the queue is in this garbled state,
the inner loop of igc_clean_tx_ring() will never terminate,
completely hogging a CPU core.

The reason is that igc_xdp_xmit_zc() reads next_to_use
before acquiring the lock, and writing it back
(potentially unmodified) later. If it got modified
before locking, the outdated next_to_use is written
pointing to an item that was already used elsewhere
(and thus next_to_watch got written).

Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
---

v1 -> v2:
I added some more context for further clarification,
but it is also just how I interpret the code.
Also the typo is fixed and it is reverse christmas again ;-)

---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index eb4f0e562f60..1cb1df613d27 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2791,15 +2791,15 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
 	struct xdp_desc xdp_desc;
-	u16 budget;
+	u16 budget, ntu;
 
 	if (!netif_carrier_ok(ring->netdev))
 		return;
 
 	__netif_tx_lock(nq, cpu);
 
+	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
