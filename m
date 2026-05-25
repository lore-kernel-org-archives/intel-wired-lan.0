Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF34CD5BC9
	for <intel-wired-lan@archiver.kernel.org>; Mon, 25 May 2026 15:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5379606E5;
	Mon, 25 May 2026 15:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XE3X1rCxoQIM; Mon, 25 May 2026 15:54:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CCD6600CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779724441;
	bh=kGB2IjjY/lLYpORY+kbNYtc6z1sLvuONsL5JAewsROc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGItLHB5EDxPYwoNBL8+KhzOYPjft8sIUe4JGdYqxiqgs+0CX5qXfTWuAT7POWAZN
	 OebSFkmOTbUisaT7ooPoI6WhqfkUjL3Cif4VDHBqHcnklZRy9soO/Ic2wNPD5Vj/39
	 1aaYvMRedO+edLf0ulqxBaYvEfeNjauXjYopH92sD3rKMRSL6Wb7BHwwyKvibgwKDR
	 Sc7pb25eLfGZHmtjunMxVQZ9LHPcls1n8hPxtLxr6t6WsjMTCLir3ZWrh8Eyy1GBQX
	 7Rf05ACLgZnn4d9SrTTk6NjP38076fBCc5sqqT5fJVTToJOxUcXeIyCy1adiCIhgUg
	 glqBaF3Hh7kjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CCD6600CB;
	Mon, 25 May 2026 15:54:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D6D0297
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 15:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 032858132E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 15:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sy0MqaLY3cB2 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 25 May 2026 15:53:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5172A8132C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5172A8132C
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5172A8132C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 15:53:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3582600AF;
 Mon, 25 May 2026 15:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322A91F000E9;
 Mon, 25 May 2026 15:53:57 +0000 (UTC)
Date: Mon, 25 May 2026 08:53:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20260525085356.5c336491@kernel.org>
In-Reply-To: <20260523144022.36484-1-kshitiz.bartariya@zohomail.in>
References: <20260523144022.36484-1-kshitiz.bartariya@zohomail.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1779724437;
 bh=kGB2IjjY/lLYpORY+kbNYtc6z1sLvuONsL5JAewsROc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=MNH/IEaUoTwzJLyjyJS6GH/nLlkQY24j4gMimV1HNsLY2dwuydam1qB1FbdL9y0G+
 JoJFJpj4PuOUeO4he8vm9Qmqy59RNEHOJKehflS22810zQIg8ddAtl0D8AlRElmxna
 h69pacODwcncQlpgmeINbqHEn47kWubbvFlyNscmx/vnnySMMOZ38P+ixkbVD5fx8X
 QeXMayBIA73BMwarR8wJmdyMdGgmEYP1q3bvhP1UkuIYlWHpMY1bow3CCpvj28SaMX
 sMatPs5dNRS5qOVsAUGjNlbB0yiccdOU7ItN4RxEqi7G2zuY8e3dEmpNI+iVhWTMgY
 2lIXmHByHOFUQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MNH/IEaU
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: implement
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

On Sat, 23 May 2026 20:10:16 +0530 Kshitiz Bartariya wrote:
> The following counters are filled:
> 
>  - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
> 
>  - csum_bad: maps directly to csum_err, which is incremented for both
>    IP header and L4 checksum errors in ixgbe_rx_checksum().
> 
>  - hw_gro_packets and hw_gro_wire_packets: filled only when RSC
>    is enabled on the ring

ixgbe does not advertise hw_gro in netdev features,
how can it report related stats..

> Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 2646ee6f295f..f40309f6c72b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9740,6 +9740,34 @@ static void ixgbe_get_stats64(struct net_device *netdev,
>  	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
>  }
>  
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring;
> +
> +	if (idx >= adapter->num_rx_queues)
> +		return;
> +
> +	ring = adapter->rx_ring[idx];
> +	if (!ring)
> +		return;

Are these checks really necessary? core already checks against
real_num_rx_queues
