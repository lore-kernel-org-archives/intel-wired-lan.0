Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071A8C54EE9
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Sep 2022 00:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B6CC40492;
	Wed, 28 Sep 2022 00:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B6CC40492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664323767;
	bh=wh5fRcvPTJYLpSwoNkxojISvk8ZvgfMXKYCIE0eH7d4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=88GzeWC7OKWJFLsPJL3kT4Pw0RDkxRfuy90lxeQ8Kj18UiDogG9W425I2nLYLc9BX
	 6mCs5tGGF+K5E1HYvl6A4m/7mUHW+thw0kGYk8mX8vsdrVHi4ewsif5FtBx3FMTXs4
	 ZpG2BlTlOsTkRNJx9J5waPXfSvW+qnqqNiCZRwoqIwOXB0UtTZ/NQ9Z0AEkB4UTMhb
	 PTMCiCUccYwKRONIQVv4v97vq0IItVcOrCxkYVVQOrUeZma+MRtq1N+C1da0LA1hEp
	 A/MpXGn+K8LNCzNyNBRvU/EzNv4N36ppn7PYuetgKo/3OJI7PO8hwpJlJefRl36ho9
	 48Gd0/Y4z7LVQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BZn99GI1ke-N; Wed, 28 Sep 2022 00:09:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 195CE4049C;
	Wed, 28 Sep 2022 00:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 195CE4049C
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E276F1BF85D
 for <intel-wired-lan@osuosl.org>; Wed, 28 Sep 2022 00:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C43F1813AB
 for <intel-wired-lan@osuosl.org>; Wed, 28 Sep 2022 00:09:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C43F1813AB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vUjB1D1OWfo0 for <intel-wired-lan@osuosl.org>;
 Wed, 28 Sep 2022 00:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7642F81380
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7642F81380
 for <intel-wired-lan@osuosl.org>; Wed, 28 Sep 2022 00:09:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 32BEC61BFE;
 Wed, 28 Sep 2022 00:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E724C433C1;
 Wed, 28 Sep 2022 00:09:20 +0000 (UTC)
Date: Tue, 27 Sep 2022 17:09:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Message-ID: <20220927170919.3a1dbcc3@kernel.org>
In-Reply-To: <20220927130656.32567-1-muhammad.husaini.zulkifli@intel.com>
References: <20220927130656.32567-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1664323760;
 bh=V7xGibmhoDUypWhgYRCEBWbRO9g/ZzfvhIAtZIlUBvU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qT0T5WjrjDD3Wup4CamyKgTnj6SzasnDN/XGmJ3LWLWPto3Tqm1+Vi4dzmPgz8n87
 wMCh7OZNgn6QL++4kA7BYFJhRbheZnIRIg892NZhakihbiCNQnZFezJPin6CZaZVt4
 /JJi0cUpemq45WHU6FKgmpuWjpwNf4WoWz5vS9EVhdl9Kk73J90nClxfVjcXzFlp2q
 M+lMFJ1jK1hhqW1co08R1mqzn+HlpBJDOFBx8nbbh2ZKPLkC+bvpYpKCmRho7V6SyL
 UK17Pi+S5q9olJ/ZV28+nOv/iWUmsCLLCY8otRtqH8KVxudBBEMOrHCC0/9Ne9GxMg
 nvtilvYY/E38Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=qT0T5Wjr
Subject: Re: [Intel-wired-lan] [PATCH v1 0/4] Add support for DMA timestamp
 for non-PTP packets
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
Cc: intel-wired-lan@osuosl.org, Richard Cochran <richardcochran@gmail.com>,
 edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net,
 noor.azura.ahmad.tarmizi@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 27 Sep 2022 21:06:52 +0800 Muhammad Husaini Zulkifli wrote:
> The HW TX timestamps created by the NIC via socket options can be
> requested using the current network timestamps generation capability of
> SOF_TIMESTAMPING_TX_HARDWARE. The most common users of this socket flag
> is PTP, however other packet applications that require tx timestamps might
> also ask for it.
> 
> The problem is that, when there is a lot of traffic, there is a high chance
> that the timestamps for a PTP packet will be lost if both PTP and Non-PTP
> packets use the same SOF TIMESTAMPING TX HARDWARE causing the tx timeout.
> 
> DMA timestamps through socket options are not currently available to
> the user. Because if the user wants to, they can configure the hwtstamp
> config option to use the new introduced DMA Time Stamp flag through the
> setsockopt().
> 
> With these additional socket options, users can continue to utilise
> HW timestamps for PTP while specifying non-PTP packets to use DMA
> timestamps if the NIC can support them.
> 
> Any socket application can be use to verify this.
> TSN Ref SW application is been used for testing by changing as below:

Very glad to see this being worked on!

High level tho, are we assuming that the existing HW timestamps are
always PTP-quality, i.e. captured when SFD crosses the RS layer, or
whatnot? I'm afraid some NICs already report PCI stamps as the HW ones.
So the existing HW stamps are conceptually of "any" type, if we want to
be 100% sure NIC actually stamps at the PHY we'd need another tx_type
to express that.

Same story on the Rx - what do you plan to do there? We'll need to
configure the filters per type, but that's likely to mean two new
filters, because the current one gives no guarantee.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
