Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE315C48297
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Feb 2024 14:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5952241E38;
	Tue,  6 Feb 2024 14:26:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5952241E38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707229560;
	bh=v9k+wXSjFP1gf2hdsJ6BF7YhNnlmP4KyBwDgOaZfcbI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mKomq8na/ZXHKT4wShYM5WZgfj2W7sx+1LsxVZUxbSOADvnfBKJD3WzdBJM2aQcOV
	 0E5sWVD/sad3dyCNQYSt+0R7gNaVddz0OoRutdc8RDHWMoxEPqnlJofBVpPmCDZYVY
	 ckZDgLhZXRGVYfI8Prwf/q7oVfMABA9VAzMyttqhrnCuoG7qIqboy6WR14eZH93w5k
	 zUvzM18Ie2+QWA37p6+eAO9IlPMvO8nMr833DpKPCgjoq4br0Aycu++7hduF3c8Rtc
	 65n74+KqCNEX91Ez1dIz6/GRhmGXCAaOrBujPqbvB03OXURSlMYWoB6CZE0wgIsoy4
	 BqBNOvmLGnZUA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MB0aWKEYcKY; Tue,  6 Feb 2024 14:25:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 970D941E3F;
	Tue,  6 Feb 2024 14:25:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 970D941E3F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 418461BF423
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 14:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15C5241E3F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 14:25:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15C5241E3F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ow05wv6CS_Ou for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Feb 2024 14:25:56 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A12441E38
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 14:25:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A12441E38
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1rXMOD-0078nm-UA; Tue, 06 Feb 2024 15:25:33 +0100
Date: Tue, 6 Feb 2024 15:25:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Message-ID: <a476df99-d6f9-43ad-8af1-afc858bcd3a8@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
 <20240204-keee-u32-cleanup-v1-7-fb6e08329d9a@lunn.ch>
 <20240206103425.28e64a8f@device-28.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206103425.28e64a8f@device-28.home>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=v9k+wXSjFP1gf2hdsJ6BF7YhNnlmP4KyBwDgOaZfcbI=; b=b7vrV39A71XHo6t/G+sJWupZJm
 Iaveyf5gWkytLfoRXY2yzy15yPlqA9DSPGb72mGmuMsrpJVQOSFtmPKx8LhiPF18kSZY4OHH51UfY
 EwS/sUZpA7wyPzfy4Z1N/rOUhayCf15zB7y6UHnKIqzkMnCAjluSKRxLreZtmgl61rks=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=b7vrV39A
Subject: Re: [Intel-wired-lan] [PATCH 7/8] net: intel: igb: Use linkmode
 helpers for EEE
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
Cc: Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> > -		adv100m_eee = !!(edata->advertised_u32 & ADVERTISE_100_FULL);
> > -		adv1g_eee = !!(edata->advertised_u32 & ADVERTISE_1000_FULL);
> > +		adv100m_eee = linkmode_test_bit(
> > +			ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > +			edata->advertised);
> > +		adv1g_eee = linkmode_test_bit(
> > +			ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> 
> Probably a typo, I think it should be ETHTOOL_LINK_MODE_1000baseT_Full_BIT
> here :)

Yes, good catch. Thanks.

    Andrew

---
pw-bot: cr
