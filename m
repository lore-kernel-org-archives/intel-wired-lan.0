Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1B5C79FB6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 12:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9156F60756;
	Wed,  9 Sep 2026 12:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JkAfxh7_Z85F; Wed,  9 Sep 2026 12:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E9666606AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788956146;
	b=lZ7AyXC4MjBeYGoKngKChqsER/de5DvXCWT9NUiZres3MAAfgxOP4hJ3a1RcIwGLXbkp
	 2w9qKvaTb/FF1Ieii6MkkcpY/K9N/Jxg7zYcXWoio6AZhgTrmtyv+Qp5AuYRrhBcvyIdG
	 r+xEQ6mxNKXPLO/lrEVDK4ouJA2KebeGDCC/1VVOpbHNTmrcgY0UXEAI6eJ0yBTvIeSwI
	 MVwr7jMrOrkb+d0PXwtfCZ+MmDQK4U2HBh4I5U00bvyo18rW5GRaGz33o9H3VwMQKNAli
	 /9E/eycl3GRieUUOsLzdzR3a7LNaG4uszqblIfGvPd7MVZ8gHb5tIBXX1DZtlBqJepA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788956146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4lNSvoiSu1Oe1KDHuQCmg5IrjKq5LQk9MUhqhzpAfU4=;
	b=E79i4I/E9Oaefaw8bA43REL3bTxfqTvYVpLkXRbCaBPR8KLYxj4/1YXDsvEHFK/44fyO
	 aG3orKIPHNPV70U35tbHLqlf+Y/PM946W5IWh/nv4b4SWHhKsrKbClF3KpPxTWCwp0kio
	 CQWDRJ9giPoJ6TJvqLw+EMIEOIJJhScV7/Sz12Y7gFSt026r4LApA6J7bH913TGyahte2
	 fOesGBNGDAQV082lNvyL6hCo5MCS6wIg0LKBa2NYDFdNXrrus8+gIhlKXivNZ+TD0iEgR
	 B3BakBKpNdBERpxr8P9O9/N8be5UhBCfadElg0/ERlguI0frsxo86bX5Snq5/6NzyvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=f5LZqLGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788956146;
	bh=4lNSvoiSu1Oe1KDHuQCmg5IrjKq5LQk9MUhqhzpAfU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sf7fQ81O2WrUyzXs5CEljPROJUiNhBsRFICVr/hwS42ClY3s5Ing05Z3KOlu46Boe
	 uOkz3i3tDDb49E26JqrwvieMh/CTW3+nRCr6xBl2pPVF150G6KS7WrmqJ/bVwUvonf
	 8nEFQ3felgRcLryS1jnMkYRH7JHxSYPmtoRYWXtpiTQFLTjelXJ5UfLuiT7ihX/EAx
	 2Ge9dSTbc8QBe9DdtoWE7mEQWYGO4H/vRyXwl2sEQVozE7Pn23JSGwp8Bf/jsJRNWY
	 eBnHRWxlGbmMW3Tvs15UGBA+DKItNNC4bajQWt+y0NMF0Z6nBUEyJtCVNo4uo94CQ0
	 Iue9D3QmH7F1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9666606AF;
	Wed,  9 Sep 2026 12:15:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB2CB29C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 12:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D187E606AF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 12:15:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jiqAVs067C5 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 12:15:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3721560639
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788956142;
 b=i3vS59CbERK0TdbliZqVWlTeoSo3UOJPbsVo4kNTxJFNR14QZyHjah4iRijzpqjHShXo
 j6cdNATBxfaqeiyTjPDxZXey6WBP4GbRIwqO0se/oaDVvV2v3Hvk+qv8I7F0Egrs4YqYo
 VstmhmsP2Pzai7lGaZ7neMJ2kspLB6huJrVmIi8kLQGP/FxS5zXkp/fTjTuGYGCHcqqLh
 xdnkPacojwOgu9zw13XwM5Ih5qlMXh6pSDxDiLB0+p9SSu+/2JjgBMOkUzkVZKiRLUHu5
 HBCAXC9hQ2n0/ql7kUp8PhK1lGzDGhxoIhjW57Mzwwi0h9mRNJsBdcDUlJRBMGfLFkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788956142;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=4lNSvoiSu1Oe1KDHuQCmg5IrjKq5LQk9MUhqhzpAfU4=;
 b=qaWw/5IkCnzMO66keYQoXPQdH8x+ck4Ajay7p+ZdOn5dw9bVTZyPObRtgTBGHaCAHfoF
 iXW6LKhbBjDfag5akldFQklyMbE/+cI0tQy6Ue/aCntB5Hax+uEA4NuknVPRx9jyrMf1M
 2V4+FMI8kziHdY03SbInVNKtDy4bt00aBOvcR51gwUWXbsyjnXghkrOzTnKAQ2QmL50v7
 VxBMe7wCh1pbcgzyO0qcFo7USoB/0PPs//c5idnxGddiSlEIciFen1eVFTRa5ukmVTeu9
 vXUxmWsDO5UzbvoB60jWmnkiSuPyqgNI3oo4GZ/PTtT6I/HBLbLH2Lb1J2RFJEcpLLA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=lunn.ch; 
 dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=f5LZqLGX; 
 arc=none smtp.remote-ip=156.67.10.101
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=f5LZqLGX
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3721560639
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 12:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=4lNSvoiSu1Oe1KDHuQCmg5IrjKq5LQk9MUhqhzpAfU4=; b=f5LZqLGXXvOEfc7SKxBaSnFYWD
 8fUD+sruRwzKwhivGLkdPumNJZ49A+elVNBoeoVfknIU5fxLVw+cySda5scTERn+RkCUjJZFAt633
 bsKj28ZCaQbvA4EfO1g/aME7vjZodZFgknm8J2mJE5kUOlS7dvvh3w5GPxdfaD0ysQnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1x4HCs-004CRj-Ki; Wed, 09 Sep 2026 14:15:14 +0200
Date: Wed, 9 Sep 2026 14:15:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yury Norov <yury.norov@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Message-ID: <3fcc6c7e-a9c6-46c4-8393-1abe7d12dea6@lunn.ch>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-8-ynorov@nvidia.com>
 <67ed1522-cec8-4137-85df-ffbae654e07c@lunn.ch>
 <aqAnd1gpXne2lqCT@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqAnd1gpXne2lqCT@yury>
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

On Tue, Sep 08, 2026 at 11:19:19AM -0400, Yury Norov wrote:
> On Tue, Sep 08, 2026 at 03:52:09PM +0200, Andrew Lunn wrote:
> > > -	linkmode_and(sfp_support, port->supported, caps->link_modes);
> > > -	if (linkmode_empty(sfp_support)) {
> > > +	if (!linkmode_and(sfp_support, port->supported, caps->link_modes)) {
> > >  		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");
> > 
> > From a readability perspective, i like linkmode_empty(). It is more
> > obvious than !linkmode_and().
> 
> OK, a function returning 2 values is not something obvious in C. What
> about this?
> 
>         
> 	sfp_supported = linkmode_and(sfp_support, port->supported, caps->link_modes);
>         if (!sfp_supported)
> 		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");

Why not keep it as it is? If the link mode is empty, we know we have a
problem. 


> 
> > None of this code is in the hot path. So we should put readability
> > above performance. 
> > 
> > >  	/* Some PHYs may advertise, by default, not support EEE modes. So,
> > >  	 * we need to clean them. In addition remove all disabled EEE modes.
> > >  	 */
> > > -	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
> > > -		     phydev->advertising_eee);
> > > -	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
> > > -			phydev->eee_disabled_modes);
> > > -
> > >  	/* There is no "enabled" flag. If PHY is advertising, assume it is
> > >  	 * kind of enabled.
> > >  	 */
> > > -	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
> > > +	phydev->eee_cfg.eee_enabled =
> > > +		linkmode_and_andnot(phydev->advertising_eee,
> > > +				    phydev->advertising_eee,
> > > +				    phydev->supported_eee,
> > > +				    phydev->eee_disabled_modes);
> > 
> > So, which is more readable, the original or this?
> 
> The new version is more readable to me. What about this:
>         
>         eee_advertised = linkmode_and_andnot(phydev->advertising_eee,
> 	                                     phydev->advertising_eee,
>                                              phydev->supported_eee,
> 		                             phydev->eee_disabled_modes);

I still prefer the original version.

Where do you stop with these functions? Why not add
linkmode_and_andnot_or()?  linkmode_and_nand_xor_nor()?

If complex expressions were used on the fast path, every packet
needing some bitmap logic, i can see the benefit of such complex
functions, if they can be optimised. But this is slow path, probe
time, or when the link goes up. Human readability comes first.

Just out of interest, did you look at the disassembly for both
versions? Isn't it the inline linkmode_ wrapper function which drops
the return value, which you are adding back. But the
compiler/optimizer sees it and could make use of it? Is gcc/clang
clever enough to do that?

	Andrew
