Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9169BC5DF74
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 23:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2824F8113A;
	Mon, 17 Aug 2026 23:43:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TywDxeu6NCxI; Mon, 17 Aug 2026 23:43:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4002A810ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787010194;
	bh=e430kTuvXnUaGiIBaX/CrBcZEpq9l/g+Tm53CLiCmsw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kxCiQR7Qovg7/7Q1qEoZIs52TRoXf6eZ9sDR8J0DjgGxqegmqxq6LqPnfO4MAXUV0
	 CQ1xyFp5aQ5ap5DhViOrHxhHYFI62xIL6LlcCvjQppv6C07fuLnnfaXGtzSfNklRrh
	 +hgrF7fslbZm7/96HBGjNRo/tEvn2e6pxzxxmG8/wbmDP0ZnirxdDHXEroqb/ZojOg
	 aPs93w7vBKvYjWItDF8BQNduY2lG8+urfG7agKIgOeAo5/h4MiFOgj7k6yCbKU/dJj
	 69bZ4+FfWl+pO1ef9CH0qe4m5d931l/xrHTlU+HY1jfnaDZ+IKH8NKbyrqCGULHTEP
	 RKKqVFXzsdnFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4002A810ED;
	Mon, 17 Aug 2026 23:43:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C02B23F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 23:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DB2D810ED
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 23:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iG2i95NuD1p for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Aug 2026 23:43:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 55EAC810C5
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55EAC810C5
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kFYPYAff
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55EAC810C5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 23:43:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00CAD600C8;
 Mon, 17 Aug 2026 23:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B051F000E9;
 Mon, 17 Aug 2026 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787010189;
 bh=e430kTuvXnUaGiIBaX/CrBcZEpq9l/g+Tm53CLiCmsw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=kFYPYAffrEEXmiAVLqQ7LlnoddKZhZAsGrlMx2OaDYybvHHM6nsxpKb7MeZgPUpP9
 uhy+Oo+66F+lZUhvc0Y4UkmeV6E3omzCmu7xcj5NeB69I7o/QLXcRuGWnkYXQWjQ5T
 5ndtbJCjwae9yB+qd69yFGl5B/NQ4oKjUJeSOC2EXkgwubRKe69FGvldmYxp6ivK8L
 KdtDMZ0B1+8oy1JNND4wrcf0a94UHUJDAFsJCRN0+xSQe/r3LwKlyMC2GWI2XLaFax
 ppQFd7JPexfuu3TRWbAGaOtIy9Yfr5gMcHUQ9oBclGyfnWhHZDeMcaSC2tb5WTUyNe
 NYhKPGNXl5TUw==
Date: Mon, 17 Aug 2026 16:43:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20260817164308.5bf8bc87@kernel.org>
In-Reply-To: <20260814141446.90544-1-kshitiz.bartariya@zohomail.in>
References: <20260814141446.90544-1-kshitiz.bartariya@zohomail.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Intel-wired-lan] [PATCH net-next v5] ixgbe: implement
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

On Fri, 14 Aug 2026 19:44:36 +0530 Kshitiz Bartariya wrote:
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring = READ_ONCE(adapter->rx_ring[idx]);
> +	u64 bytes, packets, alloc_rx_page_failed, alloc_rx_buff_failed,
> +		csum_err;
> +	unsigned int start;
> +
> +	if (ring) {
> +		do {
> +			start = u64_stats_fetch_begin(&ring->syncp);
> +			bytes = ring->stats.bytes;
> +			packets = ring->stats.packets;
> +			alloc_rx_page_failed =
> +				ring->rx_stats.alloc_rx_page_failed;
> +			alloc_rx_buff_failed =
> +				ring->rx_stats.alloc_rx_buff_failed;
> +			csum_err = ring->rx_stats.csum_err;
> +		} while (u64_stats_fetch_retry(&ring->syncp, start));
> +	}
> +
> +	stats->bytes = bytes;

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9772:6: warning: variable 'bytes' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
-- 
pw-not: cr
