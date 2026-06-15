Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64425CD98DA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Jun 2026 11:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BF0C606A5;
	Mon, 15 Jun 2026 11:58:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuAU3O_xWq1U; Mon, 15 Jun 2026 11:58:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A3806088B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781524709;
	bh=AxorqoSl7GNbTaT4GN1VoPJxbHSXX4/2W2cvV0NxdmI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wKbXLjrCxdLRaWccXNSh0fWkLTCXiQ22NnMlHaSjHz3J0oKJEYTUt7Qn9HY2PZdgL
	 B0P0MbAcgjyInI7YJZWsIrC/5Xkn34OtuApaXDpZi6F8XkUSY+O4Ja2DpCtkDx2WnJ
	 iE02Gn5QZ+kUcAZUanjjN9OZHvFWnMg2+AyV21gv3jqNehiggOzY1K4JvnsHHGSVtN
	 bpaniNIGWavOxDETXakunzcNREBnNIzdApjQ3nHx5lkN7YEEprQm3aC6xKYXWZKULm
	 Wwrf2Fw5bPVmOImpNjSJqcVo642XShjKOFVuG0sEMOA0xii+UiDWRsxXURvxvpXNUG
	 Gz2mWBZxfkRmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A3806088B;
	Mon, 15 Jun 2026 11:58:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29E212B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 11:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1383582419
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 11:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApeVNKBtNcGz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 Jun 2026 11:58:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4141B823CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4141B823CF
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4141B823CF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 11:58:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C826443D2E;
 Mon, 15 Jun 2026 11:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2179F1F00A3A;
 Mon, 15 Jun 2026 11:58:23 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: intel-wired-lan@osuosl.org
Cc: Simon Horman <horms@kernel.org>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jedrzej.jagielski@intel.com, kshitiz.bartariya@zohomail.in,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 12:58:06 +0100
Message-ID: <20260615115806.756776-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613091231.26601-1-kshitiz.bartariya@zohomail.in>
References: <20260613091231.26601-1-kshitiz.bartariya@zohomail.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1781524706;
 bh=AxorqoSl7GNbTaT4GN1VoPJxbHSXX4/2W2cvV0NxdmI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=biM2fV1+UuD+NY7cxKRo/9UUMZ1aCXvK64Gz25xP6S3TwYCDzANwAFgUhoZF14eEE
 25i9a+FX9LcYzZDT6d44wwqV/xQ9a0U0yd9xBtOJ1mnOMxvn5WWD8hQ8YRd4mPfxXH
 28Mq6CKsW0V0JlR+4Kw7m+mLHgzbIS9BAudpQFyNKDYLM8x02jaAORHzv68zSBdbBp
 0lJVWBq2CajnnVjRffQ550Q5cNqQZUebLfD1J6F39Jduo7TD69WVc5rkZ5HZlFJWAc
 tLWbUS2lw4h2QXFRWA4vYLjj2ZHN8Z2ebRmBJlEB9DykYfOCJsIh53j1Bo4qSLrokR
 IyDll7VS220SQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=biM2fV1+
Subject: Re: [Intel-wired-lan] [PATCH net-next v4] ixgbe: implement
 get_queue_stats_rx
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
ixgbe: implement get_queue_stats_rx

This patch wires ixgbe into the netdev_stat_ops interface so that per-RX
queue counters (bytes, packets, alloc_fail, csum_bad) are exported
through the netdev generic netlink API.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index bc16e4c93fd4..67844e25af23 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9759,6 +9759,30 @@ static void ixgbe_get_stats64(struct net_device *netdev,
>  	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
>  }
>  
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring = adapter->rx_ring[idx];
> +

[High]
Can adapter->rx_ring[idx] be observed NULL here?

Elsewhere in the same driver, this slot is treated as nullable. The
writer side uses WRITE_ONCE() in both directions, for example in
ixgbe_free_q_vector():

    WRITE_ONCE(adapter->rx_ring[ring->queue_index], NULL);

and the existing readers in ixgbe_main.c pair that with READ_ONCE() and
a NULL guard, e.g. ixgbe_get_stats64():

    struct ixgbe_ring *ring = READ_ONCE(adapter->rx_ring[i]);
    if (ring) {
        ...
    }

and ixgbe_update_stats():

    struct ixgbe_ring *rx_ring = READ_ONCE(adapter->rx_ring[i]);
    if (!rx_ring)
        continue;

If a userspace caller issues a per-queue qstats request while the driver
is reconfiguring queues (e.g. ixgbe_clear_interrupt_scheme() /
ixgbe_init_interrupt_scheme() during reset), would a plain dereference
here oops?

Should this callback follow the same READ_ONCE() plus NULL-skip pattern
used in ixgbe_get_stats64() and ixgbe_update_stats()?

> +	stats->bytes = ring->stats.bytes;
> +	stats->packets = ring->stats.packets;

[Medium]
Should these 64-bit reads be wrapped in a u64_stats_sync read section?

The writer side, ixgbe_update_rx_ring_stats(), updates these counters
under ring->syncp:

    u64_stats_update_begin(&rx_ring->syncp);
    rx_ring->stats.packets += total_packets;
    rx_ring->stats.bytes += total_bytes;
    u64_stats_update_end(&rx_ring->syncp);

and the syncp is initialized at probe (u64_stats_init() on ring->syncp).
ixgbe_get_stats64() in this same file already mirrors that on the read
side:

    do {
        start = u64_stats_fetch_begin(&ring->syncp);
        packets = ring->stats.packets;
        bytes   = ring->stats.bytes;
    } while (u64_stats_fetch_retry(&ring->syncp, start));

On 32-bit kernels a 64-bit load is not atomic, so without the fetch
loop can the values returned to userspace be torn (high half from one
update, low half from another)?

> +	stats->alloc_fail = ring->rx_stats.alloc_rx_page_failed +
> +			    ring->rx_stats.alloc_rx_buff_failed;
> +	stats->csum_bad = ring->rx_stats.csum_err;
> +}
> +

[ ... ]
