Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A14C38142
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Feb 2023 17:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EC1860E37;
	Wed,  1 Feb 2023 17:20:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EC1860E37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675272038;
	bh=449DKiP8T4vV8gUsNJeXMbGmHJ8y3jZ+/6pVXooFTKw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=4m6c5X4/AA3UTr1Cze0MTiI8rJKPyLCOs3n7chvXaDSec+jw+amPjykyS9tDkeeVg
	 KgMuxA7GP8dx6c6kBzl/9qXmoKYeijVdqQfbofJCfF+NyedYBfhpfV6ZRDW99Jaj39
	 qh0FdObNDOlnsP8n8ToebZ1H4noojCsEe12zF9JhM0A5QfVIbJd5YeLkj/qYlGP5tj
	 zlqXbpo7IDAs/oMfhLyt7E5m+x+HuBwIcjHLQ1Xxi9eF/R8xcx3a7EfG23EZkWYLYT
	 3E6dOpir0MceDPrMPIEB+rf1rDE3aHaUnreovSo8nT76L+P6oO3wAsHuvStZQfUGlN
	 Jk6lnZtm/Ni3w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0G10M_GjDgD6; Wed,  1 Feb 2023 17:20:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BEBF60E3B;
	Wed,  1 Feb 2023 17:20:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BEBF60E3B
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8F78E1BF29F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 17:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61AA360E3B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 17:20:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61AA360E3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QJ8SMUG_eBW4 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Feb 2023 17:20:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9E9C60E37
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9E9C60E37
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 17:20:34 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1pNGmU-003osR-Sg; Wed, 01 Feb 2023 18:20:22 +0100
Date: Wed, 1 Feb 2023 18:20:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <Y9qfVpfWCc5W60VT@lunn.ch>
References: <20230201145845.2312060-1-o.rempel@pengutronix.de>
 <20230201145845.2312060-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230201145845.2312060-6-o.rempel@pengutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=HmmxRzyOM8pg21rswSew0JvvkISMUe9e3G3lAQoi40I=; b=1K/3bxzuuHR2szabm/YZgNejdk
 S/qzEaggkbukabJz7V/43osvJC7VQlTTussq1p/Ggd6FZwL0UC0svbwI9aSWdu+3HQvFl3DCDXj+A
 CwzGh/QUIYOSIm2b+q7gqRQ5bxKKMKo8s12wxpe6fFEtwzQV1dtKfAO0iJWHxMhgv/UU=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=1K/3bxzu
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 05/23] net: phy: add
 genphy_c45_ethtool_get/set_eee() support
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

On Wed, Feb 01, 2023 at 03:58:27PM +0100, Oleksij Rempel wrote:
> Add replacement for phy_ethtool_get/set_eee() functions.
> 
> Current phy_ethtool_get/set_eee() implementation is great and it is
> possible to make it even better:
> - this functionality is for devices implementing parts of IEEE 802.3
>   specification beyond Clause 22. The better place for this code is
>   phy-c45.c
> - currently it is able to do read/write operations on PHYs with
>   different abilities to not existing registers. It is better to
>   use stored supported_eee abilities to avoid false read/write
>   operations.
> - the eee_active detection will provide wrong results on not supported
>   link modes. It is better to validate speed/duplex properties against
>   supported EEE link modes.
> - it is able to support only limited amount of link modes. We have more
>   EEE link modes...
> 
> By refactoring this code I address most of this point except of the last
> one. Adding additional EEE link modes will need more work.

phydev->eee_broken_modes in particular is an issue. Anybody with
broken 10baseT1L will not be able to work around it currently.

Not that i'm saying this need fixing now.

    Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
