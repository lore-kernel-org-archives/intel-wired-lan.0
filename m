Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991F7CD6E79
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Jun 2026 18:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D0B3423E0;
	Mon,  8 Jun 2026 18:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNTZpUZ-VsRZ; Mon,  8 Jun 2026 18:47:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD996422CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780944462;
	bh=lyf/y2u1bO4hUmn6dQhfqSR5sYdLExgnJf82uOJss00=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a2xEg7t6AJFXZGP5/dCSciyqOCEi2gtBCapb9xbB55Ipt1YzVmgNKrxOfzvswNfrq
	 jufNiyit1V1oSZEMIdp+GaIHQpBw1nhVNhPPdWO4HpaREp7dWhRI6J9ZZ6epFY7B/I
	 H76mbEeCyXOZmKHFwKmlEeHAJQA00ZZXJx0giXo7vu6aWC+94GnMOI6IG8a++DVFeA
	 yA9RWLRfv7/adb2pY6WeRa0q80fZALz5Euuntxoj6vufQDYnKQuWpR3K22b3eO4VEe
	 HE8BtrscGY+7qh3/2WPmLWrH2vxiDH06QkuNzk9WOxbea3Ut/vzKMGTmNJTF7Y5EMF
	 mjrFEfQ5xihDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD996422CA;
	Mon,  8 Jun 2026 18:47:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C416190
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jun 2026 18:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E53561C55
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jun 2026 18:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smf7-kfpL1cV for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Jun 2026 18:47:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 01C6261C53
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01C6261C53
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01C6261C53
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jun 2026 18:47:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74DCC60098;
 Mon,  8 Jun 2026 18:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B251F00893;
 Mon,  8 Jun 2026 18:47:35 +0000 (UTC)
Date: Mon, 8 Jun 2026 19:47:33 +0100
From: Simon Horman <horms@kernel.org>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
 piotr.kwapulinski@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20260608184733.GJ3920875@horms.kernel.org>
References: <20260603174857.78666-1-kshitiz.bartariya@zohomail.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603174857.78666-1-kshitiz.bartariya@zohomail.in>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1780944458;
 bh=lyf/y2u1bO4hUmn6dQhfqSR5sYdLExgnJf82uOJss00=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iSV5nJDm4y9J2F7I06C098oJYHO5v1Ymc7DeaoT/wkUoGAU3LYd1mCNeowCzdhya+
 cBPW3IKjvuS0yx1YbAS9tt02rHjznUMYJB/oSmDfKx/xCThhe2UdtwBwu3h1FFwDpp
 dRIDJvkc1Ra2COgc7pqBAoeIIf7EtuJ+BA8yf+21Za3HnTs4+3SBd+YlomYKF/iwU0
 tjNZKNYB2W45ZrelRYj4SBokZZlmz4ELPjdhHqDruNGS5sey2s9NJRdQkcKdJW77Ho
 zqNeHjWrJAtNdVLjxFmBb6VIW4Qb7BXoxFokf2OSbwY4p+9ExYYiT+BogjPiyc75Ak
 uA0HpE0Hx9+Yw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iSV5nJDm
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ixgbe: implement
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

On Wed, Jun 03, 2026 at 11:18:51PM +0530, Kshitiz Bartariya wrote:
> Hook into the netdev_stat_ops interface to expose per RX queue
> statistics through the netdev generic netlink API.
> 
> The following counters are filled:
> 
>  - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
> 
>  - csum_bad: maps directly to csum_err, which is incremented for both
>    IP header and L4 checksum errors in ixgbe_rx_checksum().
> 
> The new per-queue stats can be observed with:
>   $ ynltool qstats show scope queue
> 
> Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
> ---
> v2:
>  Amended commit message with command to get RX queue stats as 
> suggested by Jedrzej Jagielski.
> 
> v1: https://lore.kernel.org/lkml/20260602100932.21838-1-kshitiz.bartariya@zohomail.in/
> 
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Hi Kshitiz,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that.
