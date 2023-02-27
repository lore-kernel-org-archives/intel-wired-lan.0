Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285FCC64ED6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Feb 2023 05:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7AB0400B8;
	Mon, 27 Feb 2023 05:53:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7AB0400B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677477197;
	bh=5FJIJc1t/IC3J6uR7RClNfNi+qhCMggGl8MynJMZ96Q=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nPGxVDgRHnb3Pslb8uuUAkxcZ9EdztwzCXRnu2TBpbzETMvteQdMorBCyKonzv9uZ
	 lX1dlG2jrerg2e8+ovcLF2c7gFho6K5iyvgMUdiguVIxVR/jDJKrFilo2jSyIszF7u
	 agQPkXW/Vw0JoN8Ad6Hp+QUfNfq0JM/6DNYbSUm4NpifBwAs9YH8go0gN9sjEly+ob
	 KBKTjqBMh+eyT9Honf1p+fkxj2stAGljJd79TrbJJGAphHdZ+oQ8AOceiQ1MdVbWZc
	 AngAW+UWfd/qOei+g1nBHDKvCSgfzixFFR1cn6c4GtAVqrGqOFoQ41mQpqFSIQLDx3
	 MUsXEl8YQL0Ww==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id al3QpTblsez9; Mon, 27 Feb 2023 05:53:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1AC740111;
	Mon, 27 Feb 2023 05:53:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1AC740111
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 13B0B1BF406
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Feb 2023 05:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEE6D402F4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Feb 2023 05:53:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DEE6D402F4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rbX2HlFT8uhs for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Feb 2023 05:53:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C27340343
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C27340343
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Feb 2023 05:53:13 +0000 (UTC)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pWWRK-0008Db-1o; Mon, 27 Feb 2023 06:52:46 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pWWRF-00059C-Aw; Mon, 27 Feb 2023 06:52:41 +0100
Date: Mon, 27 Feb 2023 06:52:41 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20230227055241.GC8437@pengutronix.de>
References: <20230211074113.2782508-1-o.rempel@pengutronix.de>
 <20230211074113.2782508-6-o.rempel@pengutronix.de>
 <Y/ufuLJdMcxc6f47@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y/ufuLJdMcxc6f47@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v8 5/9] net: phy: add
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Eric Dumazet <edumazet@google.com>, linux-amlogic@lists.infradead.org,
 Arun.Ramadoss@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
 Jose Abreu <joabreu@synopsys.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, Wei Fang <wei.fang@nxp.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
 kernel@pengutronix.de, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Mark,

On Sun, Feb 26, 2023 at 06:06:48PM +0000, Mark Brown wrote:
> On Sat, Feb 11, 2023 at 08:41:09AM +0100, Oleksij Rempel wrote:
> > Add replacement for phy_ethtool_get/set_eee() functions.
> > 
> > Current phy_ethtool_get/set_eee() implementation is great and it is
> > possible to make it even better:
> > - this functionality is for devices implementing parts of IEEE 802.3
> >   specification beyond Clause 22. The better place for this code is
> >   phy-c45.c
> 
> Currently mainline is failing to bring up networking on the Libre
> Computer AML-S905X-CC, with a bisect pointing at this commit,
> 022c3f87f88 upstream (although I'm not 100% sure I trust the bisect it
> seems to be in roughly the right place).  I've not dug into what's going
> on more than running the bisect yet.

Can you please test following fixes:
https://lore.kernel.org/all/167715661799.11159.2057121677394149658.git-patchwork-notify@kernel.org/
https://lore.kernel.org/all/20230225071644.2754893-1-o.rempel@pengutronix.de/

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
