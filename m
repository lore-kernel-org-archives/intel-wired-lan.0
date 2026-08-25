Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2396C61DB9
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A4F880D05;
	Tue, 25 Aug 2026 22:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sLAx0FKTPLRC; Tue, 25 Aug 2026 22:07:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787695631;
	bh=E2HRqo0BNmOG+wvSL71FMHVkpYIR+F5v9R73Mp72HJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yWroRMkF2j5JyUT4uWiTwy6Kzt1VLsgYtsYlIYNtoczVusenq/0d3MnoQi/SdFb4j
	 xDKuVAzsXZBtF745crMh0KgfvuubIPiKjl58yWm2bNN5mXichZdKMbEhdnUyZn22MU
	 wdd/C0ERCAAindGIuGtCMC4Fs/V2p+bhyFX6HlBiMEx+jSgZGWFuUycNweT17PhXY4
	 ojHAFfomiKRhR97Zea7I1oRbGvWlG9vHM0CLDTufkkjmuv9EM9ULsgPfX2WuMUINvr
	 yzydIzp79Fzjgxj3MXB8z+LEeA6qgfKmKUPskhw2s/ZxDQskIwTN2kMHAXMrXZ/faI
	 OYsSA1AXikypg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CA9C80AE6;
	Tue, 25 Aug 2026 22:07:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D25E334
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F16640612
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EzFEFTKIu3wq for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:07:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::6;
 helo=mail-pj2-x06.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MgSTmUF+
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C38BE40606
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:07:09 +0000 (UTC)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3964deae8a7so129493a91.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787695628; x=1788300428; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E2HRqo0BNmOG+wvSL71FMHVkpYIR+F5v9R73Mp72HJs=;
 b=MgSTmUF+ayeemzbz24DzyddBbiT1taAFkW8uSqDRPVpj245AVxCrZIyTJx0tDHLO9M
 wYyECEbCw6LthI/+8TkqsNZpnMFL+yAJap5nls3GHPGnysdGhAPYothrIJ5fnysJqNZ8
 dpuU5dczF87D2G3L/nbQo7gG38Ve9sqtP7vM0KUrkLk0CYs5HtV/tV8EAqVJRN++N84k
 4/ctYo9+tQbiKQHwDGLpBpyeWDwMNfRy/YD20AzNi0oUEZwtveei2bAB7CJjy2J/19tD
 gUBKzUaiaTKNDNBtRheKLYLsYEDmpRrMIyUGEQbWrIQhYBRRXooRBt6yS+UeWXXFp3iP
 qaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695628; x=1788300428;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E2HRqo0BNmOG+wvSL71FMHVkpYIR+F5v9R73Mp72HJs=;
 b=GzhR9k2cWBGiFFJNcEcv0alDeZKaWiPfWJpqDgwhriaCwp+JLouoEXvqqGfOYs2Wt0
 bgdD9ODi8ADgV/slNUY9tT5QGaOL6Jmqj1HqMA1ihEpHUCsNK/33DOIVnatFgzW1sI3I
 +PzB3MHGwpsGC3XxNpRASP+haesH0rzP+E9Lzih51u8PLGbm71hgkXoZ9I4rHvDI3I47
 ODWADOBqsn8sOeNGJMxHBnjpNVql6pd6b+h2WMeZH98av7OFnrpgHlRbh3VY4bvKF27M
 2VhtoJeGjLNyz2/GHNI1llKMs9LYnRMySMslyagutQlacwveJZR6NOOwDgQlNtz1gO8x
 +2sA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU/64bWT2lQhN69QolIGU0pg4930F8+iMeZ8JvgDyC7PtYgc19hMYkUYJ0gsMgFkjCbm+sC/ajpQsYWiZvKbM=@lists.osuosl.org
X-Gm-Message-State: AFuF++n3JmZYTa8VIkpKYzrHMH2ZY35/gphuPRDEu9AbM7vhf9g0YEJi
 bsMURWeC7wgPhRLCqNq4MBeWoNBnMWaV/+lqvACK2T+w6zCZvwVsBuEB
X-Gm-Gg: AR+sD10MhXKSwCduAWrC2WOsBicmJq0qLoeyfrUpyp9/gLXgk9sggFLrjyKyb6PJ4KT
 ZVAfaxz85tQt3pV2W9d0FG3JRYz2h6ajn/QiDWBooIIYGb79Of4lYlwUqDeud6+Wak0Z8rpqHsj
 7/EqnS8BXTQKPPi8laWfa8F+latHdAsKoMPIr2qI7eqAnRbOYSjNRCLXtEyx1YVh7gRVMAyAdVT
 beVVt0+HjIyDHW29m1KE7G+7VKhmJSzv4SC2AHEt7oW0RXiHWC1NfbAYYCJvmmFoklyF7BoApTu
 27U/2FgrN/AF5ca4CQBMzM/afG1SJt8yRgmtA4+AmmBcuTm43i7/Bmo1HLR6iJEm4t2Lty6YKgm
 zF1IpCwNqiKt0Nvd06Lzl2lldl/X3SqIL3LC4due44l6qlp8ulv4aL6IuAT7LKuykQ4Sx9+UUMT
 kWZu3y3BdRWt65lFaflD7hxkPcwdhD4hP5Landl/go4mRuqsgaUrb+5Chk6cNzSCvC
X-Received: by 2002:a17:90b:3b4b:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3966d8b6295mr4351538a91.14.1787695628197; 
 Tue, 25 Aug 2026 15:07:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a57396sm1314425a91.13.2026.08.25.15.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:07:07 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:05:46 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, 
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 sdf@fomichev.me, 
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 guoren@kernel.org, dtatulea@nvidia.com, witu@nvidia.com, martin.lau@kernel.org,
 yoong.siang.song@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-csky@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Message-ID: <ao4RsulsnIEMOmiG@devvm7509.cco0.facebook.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me> <aoceSoSFMx69Z9up@boxer>
 <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
 <aogpDsa8hz6CPpD3@boxer>
 <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
 <20260824111443.34bffe04@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824111443.34bffe04@kernel.org>
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

On 08/24, Jakub Kicinski wrote:
> On Fri, 21 Aug 2026 10:28:47 -0700 Stanislav Fomichev wrote:
> > > > I do agree that a better idea is to probably do these checks during control
> > > > paths, but it's a bit more involved (and not sure if it's possible? if we
> > > > have a bunch of xsk sockets and we change that max_sdu, do we go over all
> > > > sockets on the system somehow?). My main motivation with this patch was
> > > > to make our LLM reviewers less chatty about preexisting issues.  
> > > 
> > > I hear you, however I feel like we do not know this driver too much and
> > > probably we don't have a HW to test out such changes, so maybe let us try
> > > to fix existing behavior?  
> > 
> > Let's definitely fix it properly if you have better ideas. But since we
> > don't have HW, I'm not super confident doing anything sophisticated
> > myself :-D
> 
> Let me take the first 2 patches and leave the stmmac for later.
> I don't think anyone involved care particularly deeply here.
> 
> Maxime said he bought a bunch of relevant HW. If we finally wrap 
> the AF_XDP tests into driver runtime he should be able to help us...

Sounds fair, thanks!
