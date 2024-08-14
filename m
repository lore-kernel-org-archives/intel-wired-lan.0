Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA396C52D7B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Aug 2024 15:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98434402AF;
	Wed, 14 Aug 2024 15:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9-ToCwqJxW5; Wed, 14 Aug 2024 15:09:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83C29403D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723648165;
	bh=AtZCPfsQSYgxkQGUCYHmU4nJTO7phyxbKInji8uXu8g=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Hqv762pFTvPAVJqyG/+jdw0BLj8VPRPLsMkpG7uegeypzwoA4vWDPECtQwkDPSy/T
	 0zfv3iSVQAlWEZ5If/kzIWfopYUtEJmeyeiPtfiW2HPW9+HzyncHQRi+W4ZX1vVU4A
	 8k5EslPuk5mcyok0L7Dz/D/jF6uFYuP7qEZzHIDvOve9Jfl3Wh25RwiUdzW95Bid0K
	 4VpnXZosARr+5eVP8bcYSeXXFAoZvLIaQDRM4xpsFn3ol/ML1IUICfRFHy6oAIwLQl
	 PwqN0ndlTdAElYTAxsBUDkWmbGOybaGQ1af8E6nV0TE7XgdqFsodUFgrF3oCv/H6ET
	 0p37XYDSFuLrw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83C29403D4;
	Wed, 14 Aug 2024 15:09:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 498541BF588
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 15:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3355C402AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 15:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iU9jtEfPb7GW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Aug 2024 15:09:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1B11F403D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B11F403D4
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B11F403D4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 15:09:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5D431CE10C5;
 Wed, 14 Aug 2024 15:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEF7C116B1;
 Wed, 14 Aug 2024 15:09:16 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:09:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Message-ID: <20240814080915.005cb9ac@kernel.org>
In-Reply-To: <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240813171710.599d3f01@kernel.org>
 <ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
 <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1723648157;
 bh=XhIk/ivJe9y/rFLSzxxGWtrccGrpo6Zo1KfaOrHUh0A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=flUVwimzH7kKJ075Wx5f8LVKW0LbSvueMiSoq5G5rJqfot7EoqUHkR1LLhfURHmMk
 DyXOdkM1A02mYqsd4Cp6ASe3m7jug9VLitb45786NlXmKdtU70AIVjYr8v9AEyl+m9
 OHgfhQLoM6YtXLYcr3vLLfidluRpUNHW1TOu4Uf45W/OQyTaqu7S4E/iZ0EG+wWe4d
 bFKaKLyv1tOyfvKiFRGb+ssQusYjc9iVKWfwue5tDOtllx0PrFuZ9U6J3mIaHK/cyE
 fmgAhdNFmXVPt6dcepm2Q2HjyB+NPX8aZsHejMNwJEe7PaxszKgtLhdwUGtqI3d/eh
 L8aNgZbB1NdMA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=flUVwimz
Subject: Re: [Intel-wired-lan] [RFC net-next 0/6] Cleanup IRQ affinity
 checks in several drivers
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Ziwei Xiao <ziweixiao@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Leon Romanovsky <leon@kernel.org>, "open
 list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, "moderated list:INTEL
 ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Willem de Bruijn <willemb@google.com>, Yishai Hadas <yishaih@nvidia.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 14 Aug 2024 13:12:08 +0100 Joe Damato wrote:
> Actually... how about a slightly different approach, which caches
> the affinity mask in the core?

I was gonna say :)

>   0. Extend napi struct to have a struct cpumask * field
> 
>   1. extend netif_napi_set_irq to:
>     a. store the IRQ number in the napi struct (as you suggested)
>     b. call irq_get_effective_affinity_mask to store the mask in the
>        napi struct
>     c. set up generic affinity_notify.notify and
>        affinity_notify.release callbacks to update the in core mask
>        when it changes

This part I'm not an export on.

>   2. add napi_affinity_no_change which now takes a napi_struct
> 
>   3. cleanup all 5 drivers:
>     a. add calls to netif_napi_set_irq for all 5 (I think no RTNL
>        is needed, so I think this would be straight forward?)
>     b. remove all affinity_mask caching code in 4 of 5 drivers
>     c. update all 5 drivers to call napi_affinity_no_change in poll
> 
> Then ... anyone who adds support for netif_napi_set_irq to their
> driver in the future gets automatic support in-core for
> caching/updating of the mask? And in the future netdev-genl could
> dump the mask since its in-core?
> 
> I'll mess around with that locally to see how it looks, but let me
> know if that sounds like a better overall approach.

Could we even handle this directly as part of __napi_poll(),
once the driver gives core all of the relevant pieces of information ?
