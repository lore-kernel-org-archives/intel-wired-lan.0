Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE40D73E81
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 17:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CCF180ED9;
	Thu, 29 Jan 2026 17:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36Wcf83TEGKh; Thu, 29 Jan 2026 17:44:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED98B80DFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769708682;
	bh=y9D1drPigF3GBERuSadntJ/K8x+G3Qy3gQC2QgkpIHs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bjy85RPJK7ypwHxD2/OlwNQlyPx3ikmccEQ/YtoXaiK/HPB0cW8TL0h+W5gzSvlFa
	 xo86y4KYvjXaXpuviB+QspUEn2YuRfqcvU7hb7j4g9TRjv4TBolY8pcGJD0WbAJ+YO
	 9S7V5cTFjxDLPErBImLbKM9js+OQHSwojT7Bz168rQWOOrn5h6vjZ0VEUZMBosXhXE
	 jMlONJy85u9mnS2f31TqDYTfvElDpLpmxbYEj6mTP3OR+MNVYZKQiQO1D8tuJB7zDr
	 7UnDh6vMDZG2g+hN67KZd3jAPeo+vBPZ7xiH+Z/12Hgc8ESySygBatL+rT+xnbGJq4
	 ELbNVYUJJ/Ipg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED98B80DFD;
	Thu, 29 Jan 2026 17:44:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F0C92CF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 17:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FE8060A3D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 17:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SlHuAqIMTEbF for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 17:44:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1EB2160A3F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EB2160A3F
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EB2160A3F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 17:44:38 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1vlW4H-005OhC-8x; Thu, 29 Jan 2026 18:44:33 +0100
Date: Thu, 29 Jan 2026 18:44:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 dan.carpenter@linaro.org, horms@kernel.org, pmenzel@molgen.mpg.de
Message-ID: <60e6bfa6-4267-4d33-9987-24b87c0d0091@lunn.ch>
References: <20260129175455.174241-1-piotr.kwapulinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129175455.174241-1-piotr.kwapulinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=y9D1drPigF3GBERuSadntJ/K8x+G3Qy3gQC2QgkpIHs=; b=moE76XG27gjdd+QZotxLBinDqt
 gFbktZYq47ZTWoMjGx+m+Dg9bIS5tKLfWmJV5Mv4HnHgXeM/cnU58XsyzJN6gRyU+un9/uM1jhVqN
 0WS+7eBSi6VrH7uGLvxWDiNyg5AtYZDyVEEOgovEWK+H9Aq0xG4ZvCug0jW+4o5fGXTI=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=moE76XG2
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: e610: remove
 redundant assignment
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

>  	/* Read sync Admin Command response */
> -	if ((hicr & IXGBE_PF_HICR_SV)) {
> -		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +	if ((hicr & IXGBE_PF_HICR_SV))
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];

Did you look through the history? When i see code like this it makes
me want to have an understanding why it exists, since it looks so odd.

Is it a merge conflict resolution gone bad? Is it a typo and there is
a cooked_desc[i] which could be set?

>  	/* Read async Admin Command response */
> -	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> -		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C))
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -			raw_desc[i] = raw_desc[i];

and it exists twice. Which makes it even odder....

    Andrew
