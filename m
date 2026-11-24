Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B4606A6B1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=BOyztZiN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7V5uZrC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6F24405A7;
	Tue, 24 Nov 2026 21:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yYzINk-yX67q; Tue, 24 Nov 2026 21:38:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 98C26405BD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795556330;
	b=kmkq5u1rwIDSwfTeR/IMaZbc3kXx6vFoOINjnVBL00StfqcZ2+iyQZscXjZqFiO6zh0u
	 WR7qEhHnQT0V1TsvdCvTFg8nnfiD62DrVY3DliJ8RepSQeiwzcT31lbULP1dOymJLf/WQ
	 IEIyC5x4CGZmVOSvC0HcsOCsw7NgANsb5y79kM/fTfIv/w0h1B62uFg1ToGVbb1y6g/fw
	 amm1t4N2SrCHVYEhrIZbsxtSGXs9Ysp++TSvmNTylq+M+0BYPrY820Hp9ME5RlfSxk/B5
	 cH2eevQiyT0U49xfWVR+EXpj2P6bchKfh2NyrZENWgggP1x3tb2CFdFWIt3Dl67rXew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795556330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T4ujcwTXv4aKkxDzI3Lgu2BX9IseB8k8Wnrt4WDlNMA=;
	b=SUkvgWS2py+K+z2BT0iiHWNrq6bL24fpaHfm5pWbjjddKHm2uhL0y9FJmFICAtRKBhZP
	 SnKyilOTjkUNigFbDq7g78UcCMjWaTog5tc4i2Fq8gwnxgQlgKf32yxXX0FNMEBdAR3YJ
	 L6AbBOqkGHiOv2FS7/QS1xwN4U6R5L9mBtLIfw18sFaUEtJYHM/ZIsT3j92g5Q1wXBaEe
	 xHpy+yTsY8tL2eVyeo8yYpzdQihM/ZfLKt5HZgFA3LUHVVhh5n2Dl3oWT4f8EF+oYJ2pm
	 3RUcENJ/FoGMiAPISEgz4OIxdZnr+/wXG87b+MTJSv+Qm+INz+7jRPu/VgL6yz//+wg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795556330;
	bh=T4ujcwTXv4aKkxDzI3Lgu2BX9IseB8k8Wnrt4WDlNMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BOyztZiNjk+zK9sfkenYQ5+XWdfCWlFFCrBV9ogeBuRLbwTVnhk8CKfbnQ3TPRHLR
	 9TgW/A1sCsvJX7OX0Cj06xG7qw4jp85C2kQgPgso0RVcRQCfSQY4BHWF/BOX+V5VJ7
	 0fqlL9o5zkeoEn8nnLwtsY02svCFfzf77//USxSe8bLh8lyNSaeEH1hS3FrK+mJP16
	 Jel2EVeJd/dXdjyeSTG6fTRjLw7557z7blNuNbQoWyEAmjWKq1/+p66KVTg350D9VJ
	 gMH0r9k4ZuNf1rXEVGvWO0N6HZ8JFijdoQYKAy/w44jo+/W3R8VWIVYXwBgVdOHlUw
	 StDk+nKZnPqzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98C26405BD;
	Tue, 24 Nov 2026 21:38:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D030A2F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C23AA60675
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kIjTzUluZRt3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 21:38:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E0FE605E9
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=c7V5uZrC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E0FE605E9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A2516022C;
 Tue, 24 Nov 2026 21:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DD91F000E1;
 Tue, 24 Nov 2026 21:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795556324;
 bh=T4ujcwTXv4aKkxDzI3Lgu2BX9IseB8k8Wnrt4WDlNMA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=c7V5uZrC0CvuG3jk6tu82MuBPX9sRdAtVEkl5S5f82txbE6407XOivxh3o4ynhV9t
 1FV2ZiMGDtigmioVvp5ipyR7JHbQzdtsCyU8qKYpoplcKLwKpQr6aey62ZWXk8lWjE
 D6kAApGknpAbhpvF+Xy0O/RgxxA0jhm5cQGAriBLTiP9DkiLgy+AVmuMeGp+hzmXX3
 Csx3jscUVDgema04S8Tey5bZvyKp2XQNc3Fcf9glDqxzBAXqeCIiqr3lUoih75+iMD
 O45udHrEjDfL1Uy0d3rPAWuLEmn6a2StOo7MSoAXZOkVHmlyZyGuttJ0QiQeq7yQW2
 m8VmXOJT+LNAg==
Subject: Re: [PATCH net v4 1/4] igb: don't touch rings that don't exist when
 disabling an XSK pool
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 21:38:43 +0000
Message-ID: <179555632368.3135.16785834510606239982@kernel.org>
In-Reply-To: <20261120210134.133238-2-antonio@mandelbit.com>
References: <20261120210134.133238-2-antonio@mandelbit.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `qid < adapter->num_rx_queues` guard in
  igb_xsk_pool_disable() (and `qid < adapter->num_tx_queues` in…

Pre-existing issues:
- [High] igb_txrx_ring_disable() and igb_txrx_ring_enable() in
  drivers/net/ethernet/intel/igb/igb_xsk.c only stop and restart…
- [High] On error, igb_xsk_pool_disable() returns early with the queue
  half torn down.

--

igb: don't touch rings that don't exist when disabling an XSK pool

This commit makes igb_txrx_ring_disable() and igb_txrx_ring_enable() skip
the Tx ring when qid is not below num_tx_queues. It also makes
igb_xsk_pool_disable() skip the ring teardown when qid is not below
num_rx_queues. The goal is to stop passing a NULL ring when the stack
knows about more queues than the device has, for example on 82576 with
VFs or after an MSI fallback on resume.

Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..3b4212a9521e0 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -31,15 +31,22 @@ static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
>  	return 0;
>  }
>  
> +/* With VFs, the device has a single Tx queue but can have more Rx queues */
> +static struct igb_ring *igb_xsk_tx_ring(struct igb_adapter *adapter, u16 qid)
> +{
> +	return qid < adapter->num_tx_queues ? adapter->tx_ring[qid] : NULL;
> +}
> +

[ ... ]

> @@ -47,24 +54,27 @@ static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
>  	/* Rx/Tx share the same napi context. */
>  	napi_disable(&rx_ring->q_vector->napi);
>  
> -	igb_clean_tx_ring(tx_ring);
> +	if (tx_ring) {
> +		igb_clean_tx_ring(tx_ring);
> +		memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does the "Rx/Tx share the
same napi context" assumption always hold here?

igb_set_flag_queue_pairs() only sets IGB_FLAG_QUEUE_PAIRS in some cases:

	if (adapter->rss_queues > (max_rss_queues / 2))
		adapter->flags |= IGB_FLAG_QUEUE_PAIRS;
	else
		adapter->flags &= ~IGB_FLAG_QUEUE_PAIRS;

Without the flag, igb_alloc_q_vectors() gives each Rx ring its own vector.
The Tx rings then sit on separate Tx-only vectors, each with its own NAPI.
Examples are an i350 or 82576 without VFs on a machine with 4 or fewer
CPUs, or an i210 with 2 queues. The comment in igb_xsk_wakeup() in this
same file says the NAPI is only shared "If IGB_FLAG_QUEUE_PAIRS is
active".

In that setup, napi_disable(&rx_ring->q_vector->napi) leaves the Tx
ring's NAPI running. It can still be scheduled by late write-back
interrupts or by the watchdog's EICS kick. igb_poll() on that vector
then does:

	if (q_vector->tx.ring)
		clean_complete = igb_clean_tx_irq(q_vector, budget);

Also, igb_clean_tx_irq() does not check IGB_RING_FLAG_TX_DISABLED.

Can igb_clean_tx_irq() and igb_clean_tx_ring() then walk the same entries
from tx_ring->next_to_clean at the same time? Neither one clears
tx_buffer->skb or xdpf. So napi_consume_skb() or xdp_return_frame() on
one side, and dev_kfree_skb_any() or xdp_return_frame() on the other,
could free the same skb or xdp_frame twice.

igb_clean_tx_irq() could also write back a stale next_to_clean after
igb_clean_tx_ring() has reset it to 0. igb_configure_tx_ring() in
igb_txrx_ring_enable() does not reset that index. It does memset
tx_buffer_info and rewrite TDH/TDT while the Tx NAPI may still be
polling.

The patch keeps this flow for every qid that has a Tx ring.

[ ... ]

> @@ -148,7 +158,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
>  		return -EINVAL;
>  
>  	rx_ring = adapter->rx_ring[qid];
> -	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	/* The stack can know more queues than the device has, e.g. after a
> +	 * fallback to fewer queues on resume: skip the rings it doesn't have.
> +	 */
> +	if_running = netif_running(adapter->netdev) &&
> +		     igb_xdp_is_enabled(adapter) &&
> +		     qid < adapter->num_rx_queues;

[Severity: High]
Is this check enough for the resume case named in the comment?

The check reads num_rx_queues under RTNL, but __igb_resume() rebuilds that
state without RTNL. It calls igb_init_interrupt_scheme() before
rtnl_lock(), and for runtime PM it never takes RTNL. Inside that call,
igb_set_interrupt_capability() publishes:

	adapter->num_rx_queues = adapter->rss_queues;

This happens before igb_alloc_q_vectors() fills in adapter->rx_ring[i]
and adapter->tx_ring[i]. Suspend had already set those to NULL through
igb_free_q_vectors(). netif_running() stays true across suspend, and
adapter->xdp_prog is kept.

Suppose an XSK pool teardown runs under RTNL while a runtime resume is in
progress on pm_wq. The teardown could come from closing a zero-copy
socket, or from xp_release_deferred(). Could it see qid < num_rx_queues
while adapter->rx_ring[qid] is still NULL? If so, igb_txrx_ring_disable()
would dereference NULL:

	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);

The num_tx_queues and tx_ring[] read in igb_xsk_tx_ring() has the same
race.

There is also a slightly later window where the ring exists but its NAPI
has not been enabled yet. Would napi_disable() then spin while holding
RTNL and the netdev lock? Meanwhile, __igb_open() in the resume path
would be waiting for the netdev lock in napi_enable() (runtime PM) or for
RTNL (system resume).

The later patches in this series ("igb: fix RTNL assertion when resuming
from runtime suspend" and "igb: link queues to NAPIs under RTNL after
runtime resume") still leave igb_init_interrupt_scheme() outside RTNL. So
this race seems to remain at the end of the series.

>  	if (if_running)
>  		igb_txrx_ring_disable(adapter, qid);
>  

[Severity: High]
This is a pre-existing issue, but the error path just after this hunk in
igb_xsk_pool_disable() returns with the queue half torn down:

	xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);

	if (if_running) {
		err = igb_realloc_rx_buffer_info(rx_ring, false);
		if (err)
			return err;

		igb_txrx_ring_enable(adapter, qid);
	}

If the vmalloc() in igb_realloc_rx_buffer_info() fails,
igb_txrx_ring_enable() is never called. That leaves:

- the Rx q_vector NAPI disabled
- IGB_RING_FLAG_TX_DISABLED set
- rx_ring->xsk_pool and tx_ring->xsk_pool pointing at the pool that is
  about to be freed
- rx_buffer_info_zc still attached to the ring

Can the next igb_down() then hang? It can come from close, reset, an XDP
program change or suspend. igb_down() calls napi_disable() on every
q_vector, and napi_disable_locked() never exits on a NAPI that is already
disabled:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

This loop runs with RTNL and the netdev lock held.

Without queue pairs, the Tx NAPI keeps running. Could it read the stale
tx_ring->xsk_pool through igb_clean_tx_irq() after the pool is freed?

igb_xsk_pool_enable() has the same pattern. When
igb_realloc_rx_buffer_info(rx_ring, true) fails, it unmaps the DMA and
returns with the rings stopped and the NAPI disabled.

With this patch, the Rx-only teardown also goes through this error path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120210134.133238-1-antonio%40mandelbit.com
