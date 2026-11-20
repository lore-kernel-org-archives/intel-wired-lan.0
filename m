Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45784606A320
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=asiKy8bE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZP1dDq4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FFAC81429;
	Fri, 20 Nov 2026 14:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxy1lumsfJpo; Fri, 20 Nov 2026 14:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5111181456
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795183479;
	b=sI4LZe6b9viXxmK8Fy+FRIOY995dGl2fAJU6ZUeK1xEsVABe0U1WwIVrMIEY0Qr97TvZ
	 ALconaN+Pn4MG4YFZ3AY299QnwNxmIBJfa/glu6VmUohabpjUM9ldKVShgICmjj+JJCEF
	 V0T8PvHzTOEJlLOpD4ZT8Ud5MxcvVvygGUPopJ+2YhG17lUf9HtzOa5bi5Q/8sZpzEb1r
	 H2nWb3v6SD+aDxpTpnsYL98Lr5QJBiBozYrzxsmUyVVrD4BcvNf3DGEx4jzt8BP0gvNBD
	 PDfctAJ7ES0XauIkAxTq8MOSDRHYbx1TiSuQ6WpMEm9Jtn0LxE9e/N3QWctxWnxP8Gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795183479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=47t4DHRlBZ3cVN0XZQsL2oUDvACQwxCoNP6eDRcx3w4=;
	b=j5oUGFzd/as5rvBAqO+1fH2ommbgnUPfKGPwa8G6/xM9baKtlQA/DFlcuHMmoKd1YTHR
	 RjE1gYEnqu/peDpOl/DXvRcRi/PKjJYobgNyWKBYTNHinp8QnxRSh+vXJETccmtRZQ9T7
	 0/NLXpt1A2yA6gFQ9dVPAKvHjbJdoSvq1WxjfOOKnsY7C9dJbALwygFphwhO5jS/7OBKA
	 3vdkAZ+hyG1Lc1pmmnFNinW5cww4dTolhh3shhkGyfEB2lWXnJ019P4iNraRIlKrkTwaB
	 OtcqUAlh8cAIfrdb1PNdBqfXpEzbl/ZhXvjGud+qxyshW3Xudg42HnSqtIfxFWyUr0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795183479;
	bh=47t4DHRlBZ3cVN0XZQsL2oUDvACQwxCoNP6eDRcx3w4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=asiKy8bEDN/ydc1P3f/rKU2TtbXpVBBryyOzrsKFr5P9QqDiF7oLQ3wZVl7PWUHaq
	 hl3YrP3uby2n4Hhy0HdbxNXJ1iEG+Gatx87ZBLoMAfSJDGTuptmqQxTR+Jda0ydw2p
	 a7whJiOyRheMct2xeCtFL8sIqEQViwAAAN9lbDury33oI0iWCui+1RGvyB55bSno+d
	 T5uLMppSIzSsjB7KIxUHV0X9f3RhQlTeiRqhx+ouhQXfNmAPVW9MHcelwZeueYufyi
	 3MautOPFbNvI/FhXC9MPHIjN/orbRIbCqRXfrjucdRGBqNFmh2tq24lEqflfFdd2QI
	 j2GUCVZsbypVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5111181456;
	Fri, 20 Nov 2026 14:04:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B1F315D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 14:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21662606CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 14:04:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DGDH8S5ZbXcU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 14:04:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 336046066C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YZP1dDq4
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 336046066C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 14:04:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD14C60D3D;
 Fri, 20 Nov 2026 14:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F301D1F000C0;
 Fri, 20 Nov 2026 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795183475;
 bh=47t4DHRlBZ3cVN0XZQsL2oUDvACQwxCoNP6eDRcx3w4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YZP1dDq4rsui/VP1UAdmYMCSd7LyEEOEGJ9WTYw5tA/tuMuUaE1viFQ4WW12RGIaE
 VfJzTbblWduLxNwgQQI7CAXVinO/WyZYanOFWiVe0lJ7oeeU7Ft69VwZNzUqXgsVBh
 Tsmy58hFyx9zu8e67ApU6vAKzIduFd197Y0ChWPJHjyfhjtxdjenhTL6NpTFm9bXUg
 +U3QkXsK+41kE119vMXYW4tlr6UhqTBbtihr9nPm1VKdDSuP1VcmIil8f2qcsza8ld
 TQK6rwjJ6WZHkFdf3TGmeJ824Qf3/w/01azBrPft1CfXWezU0+saHVFigwym79l2yU
 TrbxyanPi8Hjg==
Message-ID: <sashiko-outbox-225316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/4] igb: don't disable rings that don't exist
 when disabling an XSK pool
To: "Antonio Quartulli" <antonio@mandelbit.com>,
 intel-wired-lan@lists.osuosl.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20261119140412.163202-2-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
 <20261119140412.163202-2-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:04:34 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] igb: missing num_tx_queues check in igb_xsk_pool_disable()
  dereferences NULL
--

commit e4f6db572e101ec4f5da6fee01a7451218673315
Author: Antonio Quartulli <antonio@mandelbit.com>

igb: don't disable rings that don't exist when disabling an XSK pool

This commit checks qid against adapter->num_rx_queues in
igb_xsk_pool_disable() so rings that do not exist are not disabled or
re-enabled.

Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mande=
lbit.com/

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ether=
net/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..8ed82bb1def9a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -148,7 +148,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *=
adapter, u16 qid)
>  		return -EINVAL;
> =20
>  	rx_ring =3D adapter->rx_ring[qid];
> -	if_running =3D netif_running(adapter->netdev) && igb_xdp_is_enabled(ada=
pter);
> +	/* The stack can know more queues than the device has, e.g. after a
> +	 * fallback to fewer queues on resume: skip the rings it doesn't have.
> +	 */
> +	if_running =3D netif_running(adapter->netdev) &&
> +		     igb_xdp_is_enabled(adapter) &&
> +		     qid < adapter->num_rx_queues;
>  	if (if_running)
>  		igb_txrx_ring_disable(adapter, qid);

[Severity: Medium]
Can igb_txrx_ring_disable() still dereference a NULL adapter->tx_ring[qid]
when qid >=3D adapter->num_tx_queues?

In igb_set_interrupt_capability(), allocating SR-IOV VFs forces
adapter->num_tx_queues to 1 while leaving adapter->num_rx_queues at
adapter->rss_queues (up to 2 on 82576):

drivers/net/ethernet/intel/igb/igb_main.c:igb_set_interrupt_capability() {
	...
	adapter->num_rx_queues =3D adapter->rss_queues;
	if (adapter->vfs_allocated_count)
		adapter->num_tx_queues =3D 1;
	else
		adapter->num_tx_queues =3D adapter->rss_queues;
	...
}

Because igb_xsk_pool_enable() also only checks qid >=3D adapter->num_rx_que=
ues,
disabling a pool bound to qid 1 when SR-IOV is active passes qid <
adapter->num_rx_queues and reaches igb_txrx_ring_disable(), which
immediately dereferences adapter->tx_ring[1] (NULL).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119140412.1632=
02-1-antonio@mandelbit.com?part=3D1
