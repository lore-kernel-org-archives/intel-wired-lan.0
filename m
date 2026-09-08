Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE088C79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8131D606F5;
	Tue,  8 Sep 2026 13:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBl3Q3CfpS7f; Tue,  8 Sep 2026 13:52:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 47470606E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788875551;
	b=YP84wEQEgPOqCQorcpf1SUbJEoPGRpIwengDKO+X2l54WcCtmdwifGcx1YNwobqBo1Fh
	 jjwr7HOWLkcGysm9dQj9N3d0K70sO4qICIGuNM6PQP9rSqSVdpRoaXqnJ72GzJsWCXPkK
	 cPpL1uNpHPuneU5maicJN00XJ3tnM5CQyxbG3W1bypmALv3skSqYv+1YwuICfEgvaKIbO
	 YlnEBIx6hIs7XdOtzXbxEpUPoru7KNcw6Uh5Ox1xjSQEP4+Sub2V55Pwttm4YO8Vbks5x
	 3yGdmfPO30hxD5y8aXXKypk2n48Ouxvn0rJlCI3YFDrCW6tOyWdH/dYg68WGO+zo9JQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788875551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VAXatVKGahitIUlqFkVj2QcQX1N1ATM06SDkNFJyLQ4=;
	b=DQ1vWQz6IOkNaG/72OE/geITph6y/tYOBnm3L+ixmO86DhxmC0RX3zNnwrQdUODNplN7
	 mhUXSh4aFkmcUN5JlTHLopstVe7vj68XEh3PLQOFqHxjsGFyUJzVruJEmctsFlo6SUMyL
	 7xUd+5G6hfNXKXBMlCwnGaQ6qwVxHfuRPvJ8wRW45ZZxKogYE0gl1/VUH33NV43j7EX2L
	 lux4wYFcKWNySdRWb43IHEKWWx7/WyBGUyIwNthro1ZW/Q6lEUW+e2oq8n7xTsP84x1q+
	 aKJNkbFm9J7EnenCFuaLb2s6xH7wbBme1yJ7VsgI3uCVkh9BEdozh0KJhy4H6tYglRg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788875551;
	bh=VAXatVKGahitIUlqFkVj2QcQX1N1ATM06SDkNFJyLQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R4lkJXZ3LUmoQX+XBPZJk5JPAxArpqOL64xtGnZAYv58qMjodNJlDRE71eUSQD4Yo
	 yTL73rx9urujXyO+z9zqlpGA7nHIC73qkj3gIP/0c+GibyH1mg1U40yAYCzgfwEf/h
	 frzOZxRxqejWPpueNnp81jbBdmNmXBIgC899Ah/DEyQU56wEKFkdkkB7VIY7XY7ACl
	 MQEDvWeKuYLMNfgYYOQKl9j2J3zAdkEYabgpGWiRSrP5w7Qh8pHpgaySRWxjSIbycI
	 XOnBijzoNKxBNx1yOB0KlqQ61E72ffqrAuquRNOw0tnbvM5TLiTV2iHs9EfM7U7rCM
	 wIKbE+1aR8Qdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47470606E8;
	Tue,  8 Sep 2026 13:52:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D925AEB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 033D94058B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbbVSy1HXIro for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:52:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ABD0D40483
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788875549;
 b=LU56UeksoVvISPksTAj9UaUsRoe+ncNiio2nqXleOyvmKM+dT3AYPMNRsAsRW+E84sAQ
 YvCVyCUGiSeqzncCGAMaXUPt6LHAMQ7OFO6y//1fuWMCYbR8Wvev+9HB4SmUovJOuk5l8
 omEnBG4CTf5rdqT8i88v0xhW0yW9JsWoIRtw95WgagMYdzRBOS8LhecsMoD/1rKunDvLt
 ETndgM8KyvitBc21eaaWJ8qTnFumsB1l+3yvz+nMgsTuODpWUo5ePFcK6Pz5hlL3VMVr1
 yYQKUlxvGlXxE7X/b1QBDeML+IgSzpvKo2EM6cRC98Dp4vQO4kClKUVsW317u1KZMIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788875549;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=VAXatVKGahitIUlqFkVj2QcQX1N1ATM06SDkNFJyLQ4=;
 b=ayeSlXnitpz/whqLFlmc3nRSLtTpmtOoQGHyTw8F1EVUzn0R6xi3ZRpQu6A1Vm1N978d
 Tfo/nO7LnxsRjA0s/3SmfVERjnnIbcqLBct+qszaSdKdIoifrkLNEnjsj9pxukwqG5sjg
 zi0ZdW0yUYv8RNDsQTSrdMbSWca08Cw9WKz16HVRxGVFN60WOwNeEYAdAz19UK5SsAOxa
 iBmRpOZyvlGR3hZnivY306RsF+rckG3vOYk3GbxSF12onKpyA/sohUNH/SxHoYfKK9R7s
 SNWjm92OG9Hk1ETV0BPEdW3j/+FDYpP0/cdGl04CAC3e/m2yb5IhpRxCc6sjRHOP9ag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=lunn.ch; 
 dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=Gez3hxu8; 
 arc=none smtp.remote-ip=156.67.10.101
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=Gez3hxu8
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABD0D40483
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=VAXatVKGahitIUlqFkVj2QcQX1N1ATM06SDkNFJyLQ4=; b=Gez3hxu8ldF098qehu+vYdRXv7
 iwPSK7oxGamRMi1ZkTPWAfhNFjfteuEP8KsuvWz8vgUv6T7SLLR/IavF1xqL8xYvyriN2lC/HInR6
 Vg/j5qOOzVmgPqboO+SBUYbeqgmU49RgVDQw2wzKsPLXfD64ON1cqkyhkLzf6FUMdMTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1x3wF7-003uBS-95; Tue, 08 Sep 2026 15:52:09 +0200
Date: Tue, 8 Sep 2026 15:52:09 +0200
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
 Yury Norov <ynorov@nvidia.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Message-ID: <67ed1522-cec8-4137-85df-ffbae654e07c@lunn.ch>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-8-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907215439.409858-8-ynorov@nvidia.com>
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

> -	linkmode_and(sfp_support, port->supported, caps->link_modes);
> -	if (linkmode_empty(sfp_support)) {
> +	if (!linkmode_and(sfp_support, port->supported, caps->link_modes)) {
>  		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");

From a readability perspective, i like linkmode_empty(). It is more
obvious than !linkmode_and().

None of this code is in the hot path. So we should put readability
above performance. 

>  	/* Some PHYs may advertise, by default, not support EEE modes. So,
>  	 * we need to clean them. In addition remove all disabled EEE modes.
>  	 */
> -	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
> -		     phydev->advertising_eee);
> -	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
> -			phydev->eee_disabled_modes);
> -
>  	/* There is no "enabled" flag. If PHY is advertising, assume it is
>  	 * kind of enabled.
>  	 */
> -	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
> +	phydev->eee_cfg.eee_enabled =
> +		linkmode_and_andnot(phydev->advertising_eee,
> +				    phydev->advertising_eee,
> +				    phydev->supported_eee,
> +				    phydev->eee_disabled_modes);

So, which is more readable, the original or this?

	Andrew
