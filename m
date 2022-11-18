Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E67C433FE
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Nov 2022 03:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BA158209E;
	Fri, 18 Nov 2022 03:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BA158209E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668742588;
	bh=gTXqZkmokzcuNfzpJZjGFfxjco3G6xjq3AkKvkqvkV0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=o93aFni/FaUHkd7toRpTvyg2VpJZAF6GKqGGsgx0ZKWO+sQ8uLslExalXtGZHbKBA
	 8EYl49lA4GDhFo/hw1BnBQoUXHzqykqzMAJt0MMsg03b/r+HdoQN7m5pewYMUia2Dh
	 LU+DjXP9UhC/uu97GxQOWlMMxxPVAkfnq3FM2yGnxo75pwYDKQXZ6ehMVf07Qpw0dA
	 YmLsqSpUgPZtpbWoCKM0oQPCs/qBh6o9cVA8T4t5Z4pB7LMveZAGG/dpEYd1epLyJC
	 fBWAfC3skMm9msFK4qfP66PWtxVcIy3C865eMWKz+UE0fxinKg//vghMKox/Jh6nF9
	 RP5VCodMbCBBw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QdwPFd-RaSxc; Fri, 18 Nov 2022 03:36:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4027C820A0;
	Fri, 18 Nov 2022 03:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4027C820A0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id DD2F41BF8A8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Nov 2022 03:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C37F1418E6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Nov 2022 03:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C37F1418E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ye2RyAdeGb_u for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Nov 2022 03:36:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACEE44179B
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACEE44179B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Nov 2022 03:36:24 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B1AE3B82207;
 Fri, 18 Nov 2022 03:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7352AC433C1;
 Fri, 18 Nov 2022 03:36:19 +0000 (UTC)
Date: Thu, 17 Nov 2022 19:36:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Message-ID: <20221117193618.2cd47268@kernel.org>
In-Reply-To: <Y3ZxqAq3bR7jYc3H@unreal>
References: <Y3OCHLiCzOUKLlHa@unreal> <Y3OcAJBfzgggVll9@localhost.localdomain>
 <Y3PS9e9MJEZo++z5@unreal>
 <be2954f2-e09c-d2ef-c84a-67b8e6fc3967@intel.com>
 <Y3R9iAMtkk8zGyaC@unreal> <Y3TR1At4In5Q98OG@localhost.localdomain>
 <Y3UlD499Yxj77vh3@unreal> <Y3YWkT/lMmYU5T+3@localhost.localdomain>
 <Y3Ye4kwmtPrl33VW@unreal> <Y3Y5phsWzatdnwok@localhost.localdomain>
 <Y3ZxqAq3bR7jYc3H@unreal>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1668742580;
 bh=K5aDIe2SlBtdw1FEkWSbLjXw0euK3i24cnforADV39A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aAaps6knSbkcdj6Nyouj1Mz46EOtiuVFbb0GTuc3XTJvS3EFQeW6rcVG/xgUlS6UI
 kMz4nYDnGFhsfeQkzBmPHaYr/T01bY8/1MkLZzBYmNShJghgJcL2mMbRceGpkvxrRW
 ZIHZnsYOk7D0d2TVinkhZqfHM4EZHm6MAskCeNEHfHR0QYuRQqWWr5Mf8Z3sfM46Vx
 I7FuvR61SoikI5SMrBG1RvotdL6cTSZvuazjiPj7u1Sys1uVC5BKgr/D9Vnhv7AXbG
 wc5xZyDjeRNh9kNf5+pdLdgFXkfi2xAsJXVpyxeinzXC7jeJhqXQ5dEfmtM55/aGxL
 sgE5+osQjF+Tw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=aAaps6kn
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/13] resource management
 using devlink reload
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
Cc: Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
 jiri@nvidia.com, leszek.kaliszczuk@intel.com, przemyslaw.kitszel@intel.com,
 edumazet@google.com, mustafa.ismail@intel.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, shiraz.saleem@intel.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 17 Nov 2022 19:38:48 +0200 Leon Romanovsky wrote:
> I don't think that management of PCI specific parameters in devlink is
> right idea. PCI has his own subsystem with rules and assumptions, netdev
> shouldn't mangle them.

Not netdev, devlink, which covers netdev, RDMA and others.

> In MSI-X case, this even more troublesome as users
> sees these values through lspci without driver attached to it.

I'm no PCI expert either but FWIW to me the patch set seems reasonable.
Whether management FW policies are configured via core PCI sysfs or
subsystem-specific-ish APIs is a toss up. Adding Bjorn and please CC him
on the next rev.

Link to the series:
https://lore.kernel.org/all/20221114125755.13659-1-michal.swiatkowski@linux.intel.com/
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
