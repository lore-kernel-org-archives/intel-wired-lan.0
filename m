Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B561310FC456
	for <intel-wired-lan@archiver.kernel.org>; Thu,  9 Apr 2026 00:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 603DC406F0;
	Thu,  9 Apr 2026 00:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ooLjUb4mjzCG; Thu,  9 Apr 2026 00:45:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDDE64070F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775695508;
	bh=fh2RT04a1qE4AdjGEhrjiAI4NtAoE435wHmxjKkMiWM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1E/7j1C9A563933Xe6uduL/ZL8j+S+da1OoGH/VHV7ChqN5xZRVknbvcqf2TzX3n
	 UQFee4euIqLX4ION5ZlSzt4KX/ha1Sa4Ra7pun8CtBuYKqg1O9Y/8AEA2vsBOyd92H
	 NmAITZLOhm49aAq8IId2RvCReSJmUDDrjCydeDKy/r198hd002qRDHKKPpDqSI+Orx
	 oJBeXUI4vctRj97khFfKNgF4mFxnt0bv41NTTw8bp1LWe26zyv3LVR3UJATOpYwtK7
	 So9LOKnh1WSx6QvGtJUNe8YbxOgtU6GlGXvxLboeu/MeM7vnZX+DJiYhaeMGJWMDLb
	 CaRzZsTBH3/ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDDE64070F;
	Thu,  9 Apr 2026 00:45:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A0F62C7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Apr 2026 00:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BF92406F0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Apr 2026 00:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehfLo37FSqDF for <intel-wired-lan@lists.osuosl.org>;
 Thu,  9 Apr 2026 00:45:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7D0504064E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D0504064E
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D0504064E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Apr 2026 00:45:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 98269444C0;
 Thu,  9 Apr 2026 00:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7781C19421;
 Thu,  9 Apr 2026 00:45:04 +0000 (UTC)
Date: Wed, 8 Apr 2026 17:45:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org
Message-ID: <20260408174504.17210f78@kernel.org>
In-Reply-To: <0815f1eb4b60faa653ea703e420395b724d05216.1775648513.git.pabeni@redhat.com>
References: <cover.1775648513.git.pabeni@redhat.com>
 <0815f1eb4b60faa653ea703e420395b724d05216.1775648513.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775695505;
 bh=yKPYnKdH6B2V81W24pAJpsyTt+fFkWrquiwbGfT6igE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hMAMHib3bR4GWd9vMtRvPlmGJZmi1vzYPXO8sa7qzqs9ZxnCx7gaZVqftnQTbllZn
 6cFlCVWSIaYW5NEn+YWcEwL1fcg85Ye7lK6ByD+th7IfRm+Ap8r/PP8JaF7T7wCyJ3
 SUk56fPyMEu7QXxe69UPAaaE5zpvc5k0Sgitx8KYo+SoYdZC8bXQGyAdZ5JIX2H6Yb
 +z9MU8X/8v/cjXNMaM/pAWKx6bgtFBhRPHafUA9EzZZRL2cCzWilXH1c8iEtQY3V29
 4rByjybIrhD/afsXGg/iSgIys8Y2UuvI7ykZ67qX7MjpUChsFVEGq5V+M1czy5N7WI
 aRCpSBK/6UDCw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hMAMHib3
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/2] i40e: implement basic
 per-queue stats
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

On Wed,  8 Apr 2026 13:43:45 +0200 Paolo Abeni wrote:
> +static void i40e_get_queue_stats_tx(struct net_device *dev, int idx,
> +				    struct netdev_queue_stats_tx *tx)
> +{
> +	struct i40e_netdev_priv *np = netdev_priv(dev);
> +	struct i40e_vsi *vsi = np->vsi;
> +	struct i40e_ring *tx_ring;
> +
> +	rcu_read_lock();
> +	tx_ring = READ_ONCE(vsi->tx_rings[idx]);
> +	if (!tx_ring)
> +		goto out;
> +
> +	i40e_zero_tx_ring_stats(tx);
> +	i40e_add_tx_ring_stats(tx_ring, tx);
> +
> +	if (i40e_enabled_xdp_vsi(vsi)) {
> +		tx_ring = READ_ONCE(vsi->xdp_rings[idx]);
> +		if (tx_ring)
> +			i40e_add_tx_ring_stats(tx_ring, tx);

If XDP Tx happens on dedicated queues it should be added to base,
not to the stats of the "stack" queue. This is in anticipation of
XDP being its own queue type one day, we'll then isolate those
out of base. Ripping the out of TX could cause regressions.

> +	}
> +
> +out:
> +	rcu_read_unlock();
> +}
> +
> +static void i40e_get_base_stats(struct net_device *dev,
> +				struct netdev_queue_stats_rx *rx,
> +				struct netdev_queue_stats_tx *tx)
> +{
> +	struct i40e_netdev_priv *np = netdev_priv(dev);
> +	struct i40e_vsi *vsi = np->vsi;
> +
> +	tx->bytes = vsi->tx_bytes;
> +	tx->packets = vsi->tx_packets;
> +	tx->wake = vsi->tx_restart_base;
> +	tx->stop = vsi->tx_stopped_base;
> +	tx->hw_drops = vsi->tx_busy_base;
> +
> +	rx->bytes = vsi->rx_bytes;
> +	rx->packets = vsi->rx_packets;
> +}
