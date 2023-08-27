Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E7EC83F01
	for <intel-wired-lan@archiver.kernel.org>; Sun, 27 Aug 2023 08:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06CB081F1F;
	Sun, 27 Aug 2023 08:55:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06CB081F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1693126552;
	bh=saIJHQwGchGVa+o5LI7TXup9GHAcoEYbqP8ibIoTdyY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nvqWgsgV2SoK50Tkr7R7T4fWzolIF9E0/PZ5adi5mwEcvbmgP74hjiJblQMHbT/rj
	 Tq7p44E2JOvSgxOv+AyNJPz/S2tWxJEiCbfdvehiXaKHaOY7lT8jxGpZ5y4fZGcTx+
	 CWHyCa3tn9GUteP3255lsnRcdEcLln/ot8RoPm21do2cZP6w1MyKz3oDhL1hQvaF/2
	 bsVQn+2nNBxXHtBHtUaKGe1jaFNqa3ciAPXNHZc85lic4NlNi9tvF81ZXvEFdz1OjS
	 qIggI+r4hCbPiwIHUJF6tKUc5GfY+syD0QYuUgMP9zG+fE3/jRapgX9f7SMyA6bgAV
	 LyeGW7EBmE3WQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ujRghx0-2bzC; Sun, 27 Aug 2023 08:55:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17D2481F24;
	Sun, 27 Aug 2023 08:55:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17D2481F24
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 587321BF316
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Aug 2023 08:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D40681F24
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Aug 2023 08:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D40681F24
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HUdJcOeyp2fI for <intel-wired-lan@lists.osuosl.org>;
 Sun, 27 Aug 2023 08:55:48 +0000 (UTC)
X-Greylist: delayed 519 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 27 Aug 2023 08:55:48 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 405B481F1F
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 405B481F1F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Aug 2023 08:55:48 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id BD0F632004ED;
 Sun, 27 Aug 2023 04:47:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 27 Aug 2023 04:47:08 -0400
X-ME-Sender: <xms:ig3rZNEZqBSUOnaDcOJnVt5FXMXjVv16i1g1uZMuM0cKuEyKWHMlPg>
 <xme:ig3rZCXgZiVLdkYX-P5gi7lw91_1i2Mc8zhRZAaYWr1rwMSq2LsuhBNycsxirNyM4
 Gq-dmn4gU51vZ0>
X-ME-Received: <xmr:ig3rZPIFqwlw0fQ-Guzv2Oq0YmQo0dcYa3TWYv0lLft9qFxOkl1tQ2fqIQzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefvddgtdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
 ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
 htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
 gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:ig3rZDFgJGHZBAgc58CdDSjCUDqEi-bItv-8yPV42ayYSZqIEKEO_w>
 <xmx:ig3rZDW_WHI0sgSxUJ9k6-PD5N1ngdSez_B9-i2BAFww3G49av3ZVA>
 <xmx:ig3rZOOjVScexY_hyG53QeQ5mkwzzo5fVAaYoq6mdfD2WL1hSvmrWA>
 <xmx:iw3rZOSCS9WtpdsN17KxwDkdMTSO8R7SB9QwWRjibbc0npdENb94lQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 04:47:06 -0400 (EDT)
Date: Sun, 27 Aug 2023 11:47:02 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>
Message-ID: <ZOsNhgd3ZxXEaEA5@shredder>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
 <20230824083201.79f79513@kernel.org>
 <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1693126027; x=1693212427; bh=d8FxgVYyitRM8
 +FI5tRdQWjZeyVKzL9XUtF8zxAtM9k=; b=WIOhGrO6WGufry9FnWJtQqotIZo68
 FaCg1EczRd7BUGhN9NCa/rh4EHokxV6U1nHZ0DiIsJwAnSPTyNnwAamScGEml7bu
 8FjtUC74wqhyGEZIiioohwnlQ6VZqgm8N3f5OJWRT7BRxf8parpqSBC/MIMw3iR6
 lPKbJcGfx3n4XCQr6qwoqSfoiZmbKw/8jEwQhye014n3sCwTK1Szw/ZokXES2wQ0
 2aesc8+WZpChaaELtw3udnnSrhksPWQOTnSOGEuEZwv7N2dE9Boco6i3GZDcaQjG
 JVA5KHLBrgGfR1Vp/AmedGLIRLRbKgsJ1kY5YqlzBLyA+IQeYd/W12DtA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=WIOhGrO6
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Disable Cage Max
 Power override
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
Cc: Jakub Kicinski <kuba@kernel.org>, "idosch@nvidia.com" <idosch@nvidia.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Aug 25, 2023 at 11:01:07AM +0000, Drewek, Wojciech wrote:
> CC: Ido
> 
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: czwartek, 24 sierpnia 2023 17:32
> > To: Drewek, Wojciech <wojciech.drewek@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
> > 
> > On Thu, 24 Aug 2023 10:54:59 +0200 Wojciech Drewek wrote:
> > > NVM module called "Cage Max Power override" allows to
> > > change max power in the cage. This can be achieved
> > > using external tools. The responsibility of the ice driver is to
> > > go back to the default settings whenever port split is done.
> > > This is achieved by clearing Override Enable bit in the
> > > NVM module. Override of the max power is disabled so the
> > > default value will be used.
> > 
> > Can you say more? We have ETHTOOL_MSG_MODULE_GET / SET, sounds like
> > something we could quite easily get ethtool to support?
> 
> So you're suggesting that ethtool could support setting the maximum power in the cage? 
> Something like:
>  - new "--set-module" parameter called "power-max"
>  - new "--get-module" parameters: "power-max-allowed", "power-min-allowed" indicating limitations reported by the HW.
> 
> About the patch itself, it's only about restoration of the default settings upon port split. Those might be overwritten by 
> Intel's external tools.

Can you please explain why this setting needs to be changed in the first
place and why it needs to be restored to the default on port split?
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
