Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1086606A32C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=v/oMzHd8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc5nyYQU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94B8F811D8;
	Tue, 17 Nov 2026 15:31:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PnyWtFWkSFkt; Tue, 17 Nov 2026 15:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF30F811D4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794929475;
	b=JDUih9XzSBtV0VY9OA4nFdBTQTrzV5Y3hXHw9CAG+MEt95LwtabtqSWzxQKQyHhODvjK
	 R0nWn1Z23CaZ/vDi6R+/vABGCM3mcaRmsBAypXqCMPvFaNglk1K21DtcvLfIHYGCpDpSU
	 3O15lqZLcjYsT8Mp9bWrwKJQOBH3KQa0iNt8Dpz2qceHvR134LuRCARCkjf6r64rUl0ZE
	 Z39HgFG/7oPrVC2WVf8lqzonuVcWT8PnIMpkj2/0f98d+l0pE6zSegV6PG+A6uOkTJpXn
	 OX7Sl2sHDD5QnFilh6WW2/qLfEtT21qF24P2KLNiBGWiTdv4fyukVzz0fhXcBjCqjbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794929475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=s1P7GOLUv8iOSbFu5NeqLEkrh4wnhDJ65KwuPQLRocE=;
	b=ElajefE6+X0foMzmHEWFBU2Tj8GYL7jU+O2evzaD33ka/Vd2goEPVzJm8ItMcVgdIU2s
	 pSKaf4LWfxkl6hSnjJ2Z7IOVTdDm+BR3bEOzN9TsmGtzgykrhXxeswTCHPnvC/UZcCJdX
	 AO/GoBvJ+SsCuqdchzNEeQAxRpyu8aCzr7GemRTmSNbiZRveibOrAp7vt7ssyyCO5hnmB
	 qXSFvE1u1g4W/9eu9L/q/b5VDEbB2PCPDO0tT3uKcD3JItSEd0ykL+YnvCsDovuLJ/3+C
	 OV/b1YifqqqmU35wZ/JF9mFv96fDyyCzCj3QR66QAEDHZgCKJ5gAmnqFMQKQJsRhwNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794929475;
	bh=s1P7GOLUv8iOSbFu5NeqLEkrh4wnhDJ65KwuPQLRocE=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=v/oMzHd8z3eGfQJV3/+GVtYhyx6TwbwK0kQDaYnwsyuDc9cMrfyLh1ApTiZwDHddv
	 nylgilBtUj5FVd27nD8K4sAfkAM65yzEuP+Kidb8p78cv1wEraEZ1kUjTSOuikMxMY
	 ceiqYKATynxqA/dYU2gi0UJL6PR2okXgaMqd/++40Ax8OhZpapcUM8OxALhdLSbJ2D
	 ghSgkLXO8Kp60GYuzVF5SLSeWp/FCOC3mzw/WtEeEW5rer6iYoW9mI56MKYGKdSUq9
	 vpyOD7DOjvnJBXLHFoBhW5Rh03xRJ0AXnt+FZc0OtHtaJfEubbXHAFTpqcCbIS15RG
	 Sv+pvzQxEecEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF30F811D4;
	Tue, 17 Nov 2026 15:31:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 291DB70B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 15:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EEF640342
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 15:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zqope7Ml2oTS for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 15:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C72A840185
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Tc5nyYQU
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C72A840185
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 15:31:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E0F540944;
 Tue, 17 Nov 2026 15:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FF71F000C5;
 Tue, 17 Nov 2026 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794929467;
 bh=s1P7GOLUv8iOSbFu5NeqLEkrh4wnhDJ65KwuPQLRocE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Tc5nyYQUCtJComBTHDOWSEXQENDrX7mAKfmQ5JF6FilP99d2B38wXpCrO1XfTxY7q
 tq/eUsJROZXu6TRsEvPhFjp+nHf8dFqhf9eQpgjqekyC9W7ZP5D+edEqRINwNR3nLG
 jgvfwTGpWJFgOAHXR0BQhxP1qUmYxx2cIOaOT3HCpfmff36PgU38jZyD9wtaHuoaPu
 S85cr83ZsILOs936MXyDFl7fGa3Ayhnz6OX5MDFD151pSmEMNdLFgVj4ZmQ1b4JHc9
 5H56y7EPsLfSxQ7liEqYuenYt7xsfOKqPkeyXOp7SJkM16ZPMf+21nZ5seGADbc7hQ
 NS+19eiucme/g==
Message-ID: <sashiko-outbox-219079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
To: "Antonio Quartulli" <antonio@mandelbit.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261116153041.3002666-2-antonio@mandelbit.com>
References: <20261116153041.3002666-1-antonio@mandelbit.com>
 <20261116153041.3002666-2-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:31:06 +0000
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] igb: stale real queue counts after resume MSI fallback in
  __igb_open()
--

commit 6c8e67bb8e01233489112f0bf629f1764d87d2c6
Author: Antonio Quartulli <antonio@mandelbit.com>

igb: fix RTNL assertion when resuming from runtime suspend

This commit skips calling netif_set_real_num_tx_queues() and
netif_set_real_num_rx_queues() in __igb_open() when resuming is true to
avoid triggering an RTNL assertion during runtime resume.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index 131df3e09ba14..bf8acac72b324 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4178,16 +4178,20 @@ static int __igb_open(struct net_device *netdev, =
bool resuming)
>  	if (err)
>  		goto err_req_irq;
> =20
> -	/* Notify the stack of the actual queue counts. */
> -	err =3D netif_set_real_num_tx_queues(adapter->netdev,
> -					   adapter->num_tx_queues);
> -	if (err)
> -		goto err_set_queues;
> +	/* Notify the stack of the actual queue counts. This needs RTNL,
> +	 * which isn't held when resuming from runtime suspend.
> +	 */
> +	if (!resuming) {
> +		err =3D netif_set_real_num_tx_queues(adapter->netdev,
> +						   adapter->num_tx_queues);
> +		if (err)
> +			goto err_set_queues;
> =20
> -	err =3D netif_set_real_num_rx_queues(adapter->netdev,
> -					   adapter->num_rx_queues);
> -	if (err)
> -		goto err_set_queues;
> +		err =3D netif_set_real_num_rx_queues(adapter->netdev,
> +						   adapter->num_rx_queues);
> +		if (err)
> +			goto err_set_queues;
> +	}
> =20
>  	/* From here on the code is the same as igb_up() */
>  	clear_bit(__IGB_DOWN, &adapter->state);

[Severity: Medium]
Can leaving netdev->real_num_tx_queues and netdev->real_num_rx_queues stale
when MSI-X falls back to MSI during resume cause concurrent unlocked TX on
adapter->tx_ring[0] and a NULL pointer dereference in igb_xsk_pool_disable(=
)?

During suspend, __igb_shutdown() -> igb_clear_interrupt_scheme() frees all
q_vectors and clears adapter->tx_ring[] and adapter->rx_ring[].  If MSI-X
allocation fails on resume (including system resume via igb_resume() ->
__igb_resume(dev, false), which already holds rtnl_lock() but still passes
resuming =3D true), the driver falls back to MSI with adapter->num_tx_queues
and adapter->num_rx_queues set to 1, allocating only index 0 while
netdev->real_num_tx_queues and netdev->real_num_rx_queues remain at N > 1.

In the TX path, the stack selects subqueues across 0 .. real_num_tx_queues =
- 1,
each serialized only by its own netdev->_tx[q]._xmit_lock, but
igb_tx_queue_mapping() folds all of them onto adapter->tx_ring[0]:

drivers/net/ethernet/intel/igb/igb_main.c:igb_tx_queue_mapping() {
	unsigned int r_idx =3D skb->queue_mapping;

	if (r_idx >=3D adapter->num_tx_queues)
		r_idx =3D r_idx % adapter->num_tx_queues;

	return adapter->tx_ring[r_idx];
}

CPU0 (subqueue 0)                 CPU1 (subqueue 1)
netdev_start_xmit()               netdev_start_xmit()
  HARD_TX_LOCK(dev, txq0)           HARD_TX_LOCK(dev, txq1)
  igb_xmit_frame()                  igb_xmit_frame()
    igb_tx_queue_mapping()            igb_tx_queue_mapping()
      -> adapter->tx_ring[0]            -> adapter->tx_ring[0]
    igb_xmit_frame_ring(tx_ring[0])   igb_xmit_frame_ring(tx_ring[0])
      first =3D &tx_ring->                first =3D &tx_ring->
        tx_buffer_info[next_to_use]       tx_buffer_info[next_to_use]
                                          <-- concurrent ring corruption

Multiple CPUs transmitting on different subqueues concurrently run
igb_xmit_frame_ring() and igb_tx_map() on adapter->tx_ring[0], corrupting
tx_ring->next_to_use, tx_buffer_info, hardware descriptors, and BQL state.

In addition, igb_xsk_pool_disable() checks xsk_get_pool_from_qid(), which
validates qid against real_num_rx_queues and real_num_tx_queues; disabling =
an
AF_XDP pool bound to qid >=3D 1 after a resume fallback passes qid to
igb_txrx_ring_disable(), dereferencing NULL adapter->tx_ring[qid] and
adapter->rx_ring[qid].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116153041.3002=
666-1-antonio@mandelbit.com?part=3D1
