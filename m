Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E5CC636D4
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 19:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0138581271;
	Mon,  6 Feb 2023 19:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0138581271
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675713408;
	bh=hc3TMLIXBz5cVRvcvgi3BUc1VW/g06A8ZWgNVc7zQhY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KTY6xWzh/xI9iLKWZoGE7yj427gsNM9dano9WpMtwCBWgk2o8Y/1rVlQNGbFiGFdK
	 C6lx19z13BYkJUnRewql6e4Z4UpJ2kJFRXG6R2T40jxVov10lTs6jrtozrHTbCM6ZA
	 LvhWGTaAYXPhMEe9VBeG3fH1dYYPk4DnkyZMWrxhupQkilyL4GilsVN5tXfy3oWIDu
	 sy5t1GZT24u/ZDL+n+xz0RbhVrcMg612kQtuMG4wZkaqSIO7HOyX8L4J++M5aV1X4Y
	 91INssWzf3V2afUoLLZbhewSW4fICGqFm9EO4Ng26mKw2UfjUFydywIi0xz2AN6KfL
	 gsGqbUreeK0qg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UeAJOoTEQHEQ; Mon,  6 Feb 2023 19:56:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE640812F7;
	Mon,  6 Feb 2023 19:56:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE640812F7
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D69ED1BF2CD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 18:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B890B40902
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 18:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B890B40902
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7p2UGBZghMOU for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Feb 2023 18:37:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1CA44040B
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1CA44040B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 18:37:24 +0000 (UTC)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pP6MU-0006UG-Vd; Mon, 06 Feb 2023 19:37:06 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pP6MU-00012i-CE; Mon, 06 Feb 2023 19:37:06 +0100
Date: Mon, 6 Feb 2023 19:37:06 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20230206183706.GH12366@pengutronix.de>
References: <20230201145845.2312060-1-o.rempel@pengutronix.de>
 <20230204001332.dd4oq4nxqzmuhmb2@skbuf>
 <20230206054713.GD12366@pengutronix.de>
 <20230206141038.vp5pdkjyco6pyosl@skbuf> <Y+EfSKRwQMRgEurL@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+EfSKRwQMRgEurL@lunn.ch>
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
X-Mailman-Approved-At: Mon, 06 Feb 2023 19:56:41 +0000
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 00/23] net: add EEE
 support for KSZ9477 and AR8035 with i.MX6
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
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
 kernel@pengutronix.de, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Feb 06, 2023 at 04:39:52PM +0100, Andrew Lunn wrote:
> > > > What is the code flow through the kernel with EEE? I wasn't able to find
> > > > a good explanation about it.
> > > > 
> > > > Is it advertised by default, if supported? I guess phy_advertise_supported()
> > > > does that.
> 
> The old flow is poorly defined. If the MAC supports EEE, it should
> call phy_init_eee(). That looks at the results of auto-neg and returns
> if EEE has been negotiated or not.
> 
> However, i'm not aware of any code which disables by default the
> advertisement of EEE, or actually enables the negotiation of EEE. So
> there are probably a number of PHYs which are EEE capable, connected
> to a MAC driver which does not call phy_init_eee() and are advertising
> EEE and negotiating EEE. There might also be a subset of that which
> are actually doing EEE, despite not calling phy_init_eee().
> 
> So the current code is not good, and there is a danger we introduce
> power regressions as we sort this out.
> 
> The current MAC/PHY API is pretty broken. We probably should be
> handling this similar to pause. A MAC which supports pause should call
> phy_support_asym_pause() or phy_support_sym_pause() which will cause
> the PHY to advertise its supported Pause modes. So we might want to
> add a phy_support_eee()? We then want the result of EEE negotiation
> available in phydev for when the link_adjust() callback is called.

Good point.

SmartEEE will be probably a bit more challenging. If MAC do not
advertise EEE support, SmartEEE can be enabled. But it would break PTP
if SmartEEE is active. Except SmartEEE capable PHY implements own PTP
support. In any case, user space will need extra information to
identify potential issues.

> A quick look at a few MAC drivers seems to indicate many are getting
> it wrong and don't actually wait for the result of the auto-neg....

Some ethernet driver trying to do own EEE state detection, and doing
false positive detection on not supported states - for example half
duplex.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
