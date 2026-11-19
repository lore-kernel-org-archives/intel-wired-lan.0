Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4424606A32A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LQ0dVKEu;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=MOBe5Kq+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2B1140577;
	Thu, 19 Nov 2026 14:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ok4Wa-aQUkZX; Thu, 19 Nov 2026 14:04:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8DFB405B7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097069;
	b=bUNg4cli7BvClqUMa96QHVwAznibNK4Hok5N6CIUynYd8bvYGtwEIvxEkv4AeQo7/OWe
	 gy8ne9Z90kpIPVmbwZFvvEPF24V7hSKNJxl3X5fEjnjzxXM+zniqu+mR/KTfQ49Dn6qfD
	 2s6lUZ9NriP6VsBsJPF3L9enNyVqIlGLOo0Svh3UnViuiPgNuQIM+QBB90EkmUo9UvkcK
	 ueZT/VXlBft5vLXKWfFABsZ8pofOkbdo1MroHATlU3uaXLhg0SlUSVpQcDB1u5BL+p03X
	 GfV1nf6/SBtY5I/jTt2DsjPmTtoFB5vkWLan5UEXoZ2G7VOZUQYBHtd0KcfZow8RExA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xYY+5HYcpNDrOfdei6j2b8H2Y6Y1Y5HfYq8ATs9GwvY=;
	b=aCgl+EDKeBasUvOjfskgKclTyIvEcSjmdywXVvWcUN+qwXu4AH+lVreyutNKXa4gywYe
	 B+Bpb6PZiSMEfOFHcLCUUYix2bszcWSRrz6+GbMRkkz/wvBOmVc6vxeYDfxCpziouznLJ
	 s+nO+QbTb+sxgLwHvp0EoDup90BOh39l4i/oadAVihf/CeIh115tLZnvG1sriAXXo+ZnZ
	 uGAKOaLWApHUUKa5PFv/w8R9tjqjXOXDgnv4Hb9q+89ntENqs4WWZs8FUIZRJlT6olQ52
	 9zjLOU2Uc973hu4FvOU/8Vgq42IRZuNHHubAciZ2GPxa3DdwS1KzjbjrCf+McITUABA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=MOBe5Kq+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097069;
	bh=xYY+5HYcpNDrOfdei6j2b8H2Y6Y1Y5HfYq8ATs9GwvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQ0dVKEudfEYzSE+jT2ArKkJirfPxePkTK+tX/0Ng5fYa9EVQPfUv6YhjC26eBos3
	 /otPvLRIm0myTWlK8rwIM+wb7Hd1zXfnjLTfvoQofHso1x57WNTwc6i/nMOTdc8VCT
	 alvhxes6teb8dc57HyYZQDUN4Qv+JHgS861W0y4kabkImJ4tKAjb6SCuZhPQV1qC4t
	 RwLWWcGw4ClzLYfhEKhn/0UoDUCHIn8Degm8kFjcNUTdJ8KjppDiA/e55qlDTNtGPs
	 jH9dOi0BUhpEV3WF8REPILPmtKPj6b3xp8MIdjj3lL6eIGed1g0Fbb/p9+1Hem5qbo
	 ZBRteahM4fAGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8DFB405B7;
	Thu, 19 Nov 2026 14:04:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E2FBA22B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C923640555
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M50PKtK2KuwA for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:04:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65FFF4055A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::210"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::210; helo=mout-b-210.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=MOBe5Kq+
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org
 [IPv6:2001:67c:2050:102:465::210])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 65FFF4055A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:23 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jVgFH6qWZzFqsh;
 Thu, 19 Nov 2026 15:04:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795097059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYY+5HYcpNDrOfdei6j2b8H2Y6Y1Y5HfYq8ATs9GwvY=;
 b=MOBe5Kq+9i67JBIuH4JepPP8x9ydZ9f+9oenk5G9dddPi/wLCoTf7EzLwBnp9iLdeBOOU6
 sFvP3Yrv9lz71QhKDuxrdx94QZOsfERRjzOuWC5oCmJXj46sxz3bTaavHYl8UU+QYDpQH/
 xCikJ6XUxYRyFTAAubWmUaUfDweOjFxpzbjV24CzPR3DC062qYiznuj0kGOGeutVjbf/g1
 NRJuqc6hPUnvE8zcRiPJ0M2/8XRok5RU0izhNw+Y5rikPo0pIXoh7ncs+y8JL9JZEtm6Ko
 8hGNNiB+mmesCNbZBTA8XvVXnTHoZNQNN0FObx0z/CT/SA6RjvEBJAeimpOnwg==
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
Subject: [PATCH net v3 1/4] igb: don't disable rings that don't exist when
 disabling an XSK pool
Date: Thu, 19 Nov 2026 15:04:07 +0100
Message-ID: <20261119140412.163202-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140412.163202-1-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jVgFH6qWZzFqsh
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

xsk_get_pool_from_qid() checks the queue id against the stack's real
queue counts, which can be higher than the number of rings the device
has, e.g. after igb falls back from MSI-X to MSI on resume. Disabling
the pool of such a queue then passes a NULL ring to
igb_txrx_ring_disable().

Only disable and re-enable the rings the device has, as
igb_xsk_pool_enable() and igb_xsk_wakeup() already check.

Compile-tested only: the XSK pool path isn't reachable with the QEMU
82576 setup used for the rest of the series.

Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Cc: stable@vger.kernel.org # 6.14+
Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v3: new patch.

 drivers/net/ethernet/intel/igb/igb_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index ce4a7b5..8ed82bb 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -148,7 +148,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
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

