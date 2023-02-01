Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA1EC636CD
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Feb 2023 17:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A53F981E6C;
	Wed,  1 Feb 2023 17:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A53F981E6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675272509;
	bh=opnJ2JL3HMvu+xA09L+LySdy5wL9zyFxqiY7/ragJEw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=flkq8KPvhovQ34HJtkPhssWfQn9E9NFafBNYQF04MUDQKkoEtYjo+DE+D6j+E7bjx
	 eCfN2bc8S+A/gYU+hxI20GbhyQCOQVmYWw8FLZMYXXb6CC98Gww39iMN4eV+Clo3OW
	 tbjGx74xmj4/Icey0nMArwN7nfYb719Z3SgRYuvvprx33lQk69bRkWSJuhO8gukZyV
	 uug1yb4uZJjOJ5WpGY5xETClSE4rnaOQjV5vkPZ/c1OwvC27gi65AMi3Xo0jHuUZAD
	 c/KcS8hVLy8/IeMIa4PtXZ1IhGObcgGCgdnssPZBBriLMDXhLHlptE6sEHHWGE4fRz
	 VKniZYBxgXKhA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOxboEo5Rv50; Wed,  1 Feb 2023 17:28:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C66A81E76;
	Wed,  1 Feb 2023 17:28:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C66A81E76
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5301C1BF29F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 17:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B15060E3B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 17:28:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B15060E3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fkziq5ud37Mf for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Feb 2023 17:28:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77C1360671
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77C1360671
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 17:28:26 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1pNGu5-003ouM-8X; Wed, 01 Feb 2023 18:28:13 +0100
Date: Wed, 1 Feb 2023 18:28:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <Y9qhLbZ/kf2/buln@lunn.ch>
References: <20230201145845.2312060-1-o.rempel@pengutronix.de>
 <20230201145845.2312060-7-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230201145845.2312060-7-o.rempel@pengutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=50Bg29+w61BN/4LjQdJx9K3FafHtmhGyZO4xLMgCCDw=; b=4dZNNdOqbvAgVuwM0rvkYeUIuG
 QnIlNg47TTJW3wtfbkc2Enc2xhollGqPNXHeJBQk97U99cr/ZOqjXka3LfegjJM+BH8mcTckzLW/M
 l/kLjHe9AiwvPRNJEQaLP3K678uXLrEoIUlZzd0UP0+4o9wUfLZoReEi8fWPxdIZp1M8=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=4dZNNdOq
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 06/23] net: phy: c22:
 migrate to genphy_c45_write_eee_adv()
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

> +	/* This is optional functionality. If not supported, we may get an error
> +	 * which should be ignored.
> +	 */
> +	genphy_c45_read_eee_abilities(phydev);

Humm, philosophic discussion. Would it be better for
genphy_c45_read_eee_abilities() to silently ignore the error? Errors
like -ETIMEDOUT should probably be returned, but -EOPNOTSUPP should be
ignored.

	Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
