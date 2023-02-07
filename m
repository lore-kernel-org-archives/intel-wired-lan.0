Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC94C05027
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Feb 2023 00:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA995811F8;
	Tue,  7 Feb 2023 00:46:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA995811F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675730773;
	bh=yeFlW44higshFYS9sU3hXwvYt2dwQpZafuPR1ehW69w=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CoyyQ9WCBzc5vSG0aD+Ki/Xf3qENib0sBuBvlb840HgtFj/YgxQxiRJXDCtq2U3SQ
	 YjGnfqfM3ccFs3zTFC4BjB9FEooUbGJAOsz3dFX5Qdsodt9ZD0eo0mTA1GE7lAaucl
	 kLG4sF6TtvqYij/NtaQNPJXsipGAq9EPFGSEog56Lx1HvwfqRrw5/YEna8hl5VOsUj
	 cvNQYUwzFip/XwFvQYQjZl4aSD/Sq8s1jb6Oc/uzrgUwA6LKdLFSE56PD2PuUFW4RQ
	 b6RQa/a1GPssbVp6lSphBbhjgzz6yMXrhBkElEAbeUEB0HBPx2TI82V5PqK4XrbXqX
	 w5JztJeauTMZA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJHNkevlBzS1; Tue,  7 Feb 2023 00:46:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E035A81213;
	Tue,  7 Feb 2023 00:46:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E035A81213
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 426651BF96B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Feb 2023 00:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 287CE4175B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Feb 2023 00:46:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 287CE4175B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mf9V5GTh5C6e for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Feb 2023 00:46:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E02B4175E
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E02B4175E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Feb 2023 00:46:10 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1pPC7R-004Fhu-6u; Tue, 07 Feb 2023 01:45:57 +0100
Date: Tue, 7 Feb 2023 01:45:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <Y+GfRU1uAxnAgNQY@lunn.ch>
References: <20230206135050.3237952-1-o.rempel@pengutronix.de>
 <20230206135050.3237952-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230206135050.3237952-4-o.rempel@pengutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=jlJZFXK63ljlcbUHkeYIW6a7TuIzpnde8zdqpTdl/jk=; b=Yr2EaFOw8wICtE3OGCU6SXMSIp
 2eoRseLg/ZqU1cACxeJKTsq67iTie84jEt33nmaia/d1MCZ490wPerK8mwwJlcjchgj9sKSbcd6eE
 a7t1dBj1CCH/5PlbkRh8NVevt5nFjTYPyotwNDw1KVv7pQzBHi/XxVyTJs814WhsgJtc=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=Yr2EaFOw
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 03/23] net: phy: micrel:
 add ksz9477_get_features()
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
Cc: Woojung Huh <woojung.huh@microchip.com>, Arun.Ramadoss@microchip.com,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
 UNGLinuxDriver@microchip.com, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
 kernel@pengutronix.de, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Feb 06, 2023 at 02:50:30PM +0100, Oleksij Rempel wrote:
> KSZ8563R, which has same PHYID as KSZ9477 family, will change "EEE control
> and capability 1" (Register 3.20) content depending on configuration of
> "EEE advertisement 1" (Register 7.60). Changes on the 7.60 will affect
> 3.20 register.
> 
> So, instead of depending on register 3.20, driver should set supported_eee.
> 
> Proper supported_eee configuration is needed to make use of generic
> PHY c45 set/get_eee functions provided by next patches.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
