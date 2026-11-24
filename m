Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E098606A333
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2/6iTqAf;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=xQiy7P8g
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 830696065C;
	Tue, 24 Nov 2026 23:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jmPQLv-0jutb; Tue, 24 Nov 2026 23:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC2D1606F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564661;
	b=Ts3uodDCnN7tvnlyNfqr9OD/CzyfR8wZEpFCW0s2pj5+25gwMrKq/+4QvdBFmnmwGo86
	 ACPc+cB5LSCWXMJeUsbz2pOZ2n5qfcRBczzHB77prBYYuuyyEGRaiaw8l5bK+UHfmdKVE
	 +kgNdsKTQI9W59qFxg+GTCe1pFEX+UD8gKqHzAY6iGHES7dD/BtAAIOtQZ2gJ63QlZsAM
	 J38E1xDGJZv3a1PBZW0Izv3gAwe2I8XGHmezmEpWmrUp1cx+ZU+GIhifHEpbUA41DRr+4
	 jJRsFOvyqUW1il37IbmISvSb35q3KyeNTA5bsRKWHL+4VtjsSyRxQwQdvrfCV/ydIig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9VpiGZ7WG7bx1DDt1j46FiRlj7cMHZfLWxa1c7xGJTc=;
	b=OcUhE5T1F8feqyWYPQbUvvhDhAX+671JaWKAOvRXYalScmoYHlCwqMs7riA18aBfWNyq
	 zLlxyFWiZ8RwOFBIKXCXOLEK/HMFiiCFhgxhJwSY/iePM5wtViJCZnci39qWXtAwwV3vr
	 3kPRgrsHRuUDUMYrtcL5U5MjiiPySjG74DwmWJD1NEaaPijOQgUWWGvlYe4PZJdYwyFNR
	 0Z1KYDjroS6R8zFCisLeYSAV3ImJsx/nx2Une8CeTC3TSGBWUiXxsNdBwytdtV6GUO6EB
	 hSc2/AWJyynFQip7rufsJZqQY5+kLGNhiDw/yDX4Z3wYVpDJ+BHk+LzSQr3iXQ21PGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=none header.from=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=xQiy7P8g;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564661;
	bh=9VpiGZ7WG7bx1DDt1j46FiRlj7cMHZfLWxa1c7xGJTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2/6iTqAfGU9UHs9ijw9deqlIkQGhkirhGFTx6pASsnR9+72wogqyF3nskyVA7XGzG
	 W5DFdlxHXtx5P+wRtsIo9Kf7Nd5ASa8Nm6gW6zbfh8BKDKcRDRq6vpsc1OWzsXYIJ+
	 1Bkz9QoN4qxA4KuS/CKYm+QYHs5g0vso7tY5KLyLtPxkvbbCQmSb3bY0tTRGdVLIon
	 jErqTKfWk4+IU1C/10NdLvQqwzqhXNyVxMC7oR7yLD09f1uYH3nXIDsEgUqcl51pal
	 hW20KW3ljoBIARM95Ztmbq6GtafraSq6MbvDw/mwmR7K7PIADht2qcRX7PlR4mlSBU
	 7LOArujxxcIRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC2D1606F6;
	Tue, 24 Nov 2026 23:57:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D647632D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8213606F6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cl2WzpldJGpg for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:57:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F08D6065C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=195.10.208.61
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.61;
 helo=mout-b-201.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=xQiy7P8g
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F08D6065C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:36 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jZ09T0nkLzLmZJ;
 Wed, 25 Nov 2026 00:57:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VpiGZ7WG7bx1DDt1j46FiRlj7cMHZfLWxa1c7xGJTc=;
 b=xQiy7P8glsO5WbcKOZTPZSCf4H1GxUrWDgfAKdAHW9pwaM5pepd5c8NwZyo06bhspw74wF
 0Sl9e1+hVijYh07g8SbMhad3Tv9YvAdkQoJYB0VIfjWIf6VZq8pb3aSw79z/4E4XuAkmAO
 SQcpWRUnhoksXAe4QSODlsHNVo+bsMAkzePE3LNCB3rJiekc4aC2/sV3ofAqjZlih0nyLN
 Sb33zY3xLMTKdEDwuynJu9r97hrpcX5q91+WEN52V3804L5EvfSLoot1XEcfq4egxaP4RM
 YwOO0nr3wQgjFgh+Cdd+lqfehWx6vpHEJP8i6qxZ8kIz/+8brnECn9O/w/sweg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Janis Edvarts Lacis <janislacis06@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v5 1/6] igb: don't touch rings that don't exist when
 disabling an XSK pool
Date: Wed, 25 Nov 2026 00:57:16 +0100
Message-ID: <20261124235723.1135808-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ09T0nkLzLmZJ
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

xsk_get_pool_from_qid() checks the queue id against the stack's real
queue counts, which can be higher than the number of rings the device
has: on 82576, enabling VFs leaves a single Tx queue while keeping two
Rx queues, and igb can fall back from MSI-X to MSI with a single queue
on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
before enabling VFs, then passes a NULL Tx ring to
igb_txrx_ring_disable().

Only disable and re-enable the rings the device has: skip the queue if
it has no Rx ring, and only the Tx part if it has no Tx ring, so that
an Rx ring using the pool still stops using it. This also stops a NULL
dereference when the socket is closed while the device is runtime
suspended, which frees its rings.

Tested with the 82576 emulated by QEMU and a zero-copy AF_XDP socket on
queue 1: closing it after enabling a VF no longer oopses and the Rx ring
no longer references the pool afterwards (checked with a debug print, as
QEMU doesn't spread traffic over the PF queues with VFs), and without
VFs queue 1 keeps receiving after the close. Not run under KASAN.

Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Cc: stable@vger.kernel.org # 6.14+
Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: the message also mentions the runtime suspended case (no code
changes)
v4: also handle queues with an Rx but no Tx ring, as with VFs (Sashiko):
tear down the Rx ring and skip only the Tx part; tested with a
zero-copy AF_XDP socket; subject was "don't disable rings that don't exist
..."
v3: new patch.

 drivers/net/ethernet/intel/igb/igb_xsk.c | 37 +++++++++++++++++-------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index ce4a7b5..3b4212a 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -31,15 +31,22 @@ static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
 	return 0;
 }
 
+/* With VFs, the device has a single Tx queue but can have more Rx queues */
+static struct igb_ring *igb_xsk_tx_ring(struct igb_adapter *adapter, u16 qid)
+{
+	return qid < adapter->num_tx_queues ? adapter->tx_ring[qid] : NULL;
+}
+
 static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
 {
-	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *tx_ring = igb_xsk_tx_ring(adapter, qid);
 	struct igb_ring *rx_ring = adapter->rx_ring[qid];
 	struct e1000_hw *hw = &adapter->hw;
 
-	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
-
-	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
+	if (tx_ring) {
+		set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+		wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
+	}
 	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
 
 	synchronize_net();
@@ -47,24 +54,27 @@ static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
 	/* Rx/Tx share the same napi context. */
 	napi_disable(&rx_ring->q_vector->napi);
 
-	igb_clean_tx_ring(tx_ring);
+	if (tx_ring) {
+		igb_clean_tx_ring(tx_ring);
+		memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
+	}
 	igb_clean_rx_ring(rx_ring);
-
 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
-	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
 }
 
 static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
 {
-	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *tx_ring = igb_xsk_tx_ring(adapter, qid);
 	struct igb_ring *rx_ring = adapter->rx_ring[qid];
 
-	igb_configure_tx_ring(adapter, tx_ring);
+	if (tx_ring)
+		igb_configure_tx_ring(adapter, tx_ring);
 	igb_configure_rx_ring(adapter, rx_ring);
 
 	synchronize_net();
 
-	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+	if (tx_ring)
+		clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
 
 	/* call igb_desc_unused which always leaves
 	 * at least 1 descriptor unused to make sure
@@ -148,7 +158,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
 		return -EINVAL;
 
 	rx_ring = adapter->rx_ring[qid];
-	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	/* The stack can know more queues than the device has, e.g. after a
+	 * fallback to fewer queues on resume: skip the rings it doesn't have.
+	 */
+	if_running = netif_running(adapter->netdev) &&
+		     igb_xdp_is_enabled(adapter) &&
+		     qid < adapter->num_rx_queues;
 	if (if_running)
 		igb_txrx_ring_disable(adapter, qid);
 
-- 
2.56.1

