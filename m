Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E332FC5DF87
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 01:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89D4D40846;
	Fri, 21 Aug 2026 01:29:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1N9PbqHWrK0G; Fri, 21 Aug 2026 01:29:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787275765;
	bh=PL4vLuVN0ieJR1wtgaFdgTaFWontBf4roejCfLnzVDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tLXB4ZGQHw5TooPploELl1gcmgKM60bVISXFGhDl8C1vhDZNVgAuCQMHY4+5oA+yq
	 VWPwSPy4JmHGgEd7WayiLvnthVh5BTYYWn88nNMht2Ws1UwDGVLPyZY7OYrmTsFPeB
	 dMhYC8rRBgs6IcivbhHc/b0V0RtTvYL/Ue31Qjc3txhWZWHzbO/TExeHkKXzcM/2OT
	 WUpbUiTc6Q7Fd2shGZJ1uGhcxq2FdWTSKbZtPTwJKmoE7T89ElDZLZGT0MZ8h78xNo
	 o28mv1a0606k9NuCvWZl3ms9i/VoD/WKhQIcTLC/LfADyffquf/flbc3MJKO3gDRJ7
	 eeg1NmlkxnFEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 961FC40840;
	Fri, 21 Aug 2026 01:29:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 101232B2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 01:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED12360649
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 01:29:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 196vsakwVdjO for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 01:29:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::1;
 helo=mail-pz2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VIVT8EAf
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 534C060648
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 01:29:22 +0000 (UTC)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca7d1dc4554so126369a12.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787275762; x=1787880562; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PL4vLuVN0ieJR1wtgaFdgTaFWontBf4roejCfLnzVDs=;
 b=VIVT8EAfk2NVu6oXGOjo3ni/LefTFMPAS4Ea8bAs70nGR32qAggPyOM2PgB6Nbmjuk
 iBGwpM3W6vd3lGfkwnbN/WhQoFd7Y6hgzeN7i/BcS4vxquErzLOxtp6Fcf0X2agsNvDO
 Fk9kvJkIu0XCl+g7fVs8DemvbKDM0BAhi+SI3XJU/HDX4O5N95Nz+1XrcYc7DW6sd9sk
 NGW8lS/S+r1vdrRM8wsvfCyZR7rjIvtYG46r0suNejeMxn1rpP4QBVzZGel2MGWwkJid
 ZJFnc0exio5MsZw/Pjb6i9jfTzUscaTTEGcrN/y3FPGYivKfpCrzerOctzunc1n/Coev
 qybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787275762; x=1787880562;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PL4vLuVN0ieJR1wtgaFdgTaFWontBf4roejCfLnzVDs=;
 b=XrCwwHeIZJv11l31C4X/rN8QqWihmkxqj2hSMmdMUbEUoYMTSpCkTXV+pGsMk8YJ9M
 jGUF7SP62tkrxnhQ+bLSDsVHejhBm/D/XsNUQYSiup6GnA1b3+8zvg9geA6aFDuwsY2m
 P+/preCXNAWT8hVOEgLcwL0eMDtkoZjz0JCLPdStcxXzrFg2ssbMDjiKFpK52ltvbQGg
 DZlqtJnSELH+OpXRoUX3/NRz1wYn22z98L+BgYyr0OzXzQ6VPiW1lgD6rMK16/dPmnYr
 iKOOzYipyNv9nedtwfiLMFsF3rF/+WLxRQYUEGdbz2M2QLGkLkClIRmQ69B0FEQoZHgN
 X1LA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmDCLzE2yUAHsYQSvD9EzzZCDYqXHL/g9rohTrgGl6D1fJrqthhJ9v8zJiyWrJHLU9eEsHfNbhcWwl8Xd9phA=@lists.osuosl.org
X-Gm-Message-State: AFuF++mi4cIrtPVvBGJe48tEkFreoaD4SFQkkzFeQUxbzw+YKN6Bi8mc
 iwbaxvnpR/SBf7FPiGCXI9ktipIvP3l46OHhlJ0TcuVtv7q7URrZAuHo
X-Gm-Gg: AR+sD12FghRPauPclvhjVDtbQ4nDpi48ce6fPQfxQRzndVUoxswn++gyT5I8QNcra0F
 gVYQAeqfDWBFRwdZpB0D7UvAPqMtgZKVHX6jtruZl3M4m2K9m1T2m+T1QtD4hoManAS4OXTwrVi
 RXOgImdVkTJ+pLoKZeQwBforgaCryaMWXSwnIUhZfzmAAzyvY9ZEkytrSC0dt3sOBn1JzDZomZl
 qUxWmCLaz3Sf+Q28VNpKUgC14cWzHUPN15YVknGLaUGPK2ffryCSks7cKhDKo4cG1nNHcnkKyin
 m9FnVyu1NDIxBwA4X7DeMMbyqFoLiqoDZqGbFR580RcSMIBMrIeOyHIDsAf52Msax5tT/X8SdMB
 fkviQ+airn5gk6jBXBRyV3DsT3yneZHgIMXGBUlOCDIyuhPnACFSZafB/fZJ40M5IRx7+WSa3F9
 flYYeizNhNZN/9Es8jDwn34G70cXR7JGeNrIZ9tf1V3/xX+Z73o7ZU4aMHzSvxIW+0
X-Received: by 2002:a05:6a00:170c:b0:845:e440:d0ca with SMTP id
 d2e1a72fcca58-851f9f0db82mr3439334b3a.8.1787275761986; 
 Thu, 20 Aug 2026 18:29:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3640dd4sm2169685b3a.41.2026.08.20.18.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 18:29:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 18:29:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, 
 mbloch@nvidia.com, maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com, horms@kernel.org, 
 magnus.karlsson@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, 
 hawk@kernel.org, john.fastabend@gmail.com, guoren@kernel.org,
 dtatulea@nvidia.com, 
 witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com, 
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Message-ID: <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me> <aoceSoSFMx69Z9up@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoceSoSFMx69Z9up@boxer>
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

On 08/20, Maciej Fijalkowski wrote:
> On Wed, Aug 19, 2026 at 09:05:35AM -0700, Stanislav Fomichev wrote:
> > stmmac drops AF_XDP zero-copy frames that exceed taprio's queueMaxSDU
> > after xsk_tx_peek_desc() has reserved their completion entries.
> > 
> > Completing a rejected descriptor is unsafe because AF_XDP completions are
> > ordered: xsk_tx_completed(pool, 1) would complete the oldest outstanding
> > descriptor, which may still be owned by hardware. Instead, leave the
> > completion pending so the ring eventually wedges and increment the drop
> > counter to expose the application error without risking hardware
> > misbehavior.
> > 
> > Document this intentional ring imbalance at the check.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 62de03e65a90..6a532747c039 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> >  		if (priv->est && priv->est->enable &&
> >  		    priv->est->max_sdu[queue] &&
> >  		    xdp_desc.len > priv->est->max_sdu[queue]) {
> > +			/* Completions are ordered, so this descriptor cannot
> > +			 * be completed safely. Wedge the ring to expose the
> > +			 * application error instead.
> > +			 */
> >  			priv->xstats.max_sdu_txq_drop[queue]++;
> >  			continue;
> 
> Hmm. I read the discussion on v2. Maybe we could cancel cq entry here in
> this branch? Also it feels like something achievable at bind time when
> taprio is configured and vice versa?
> 
> Otherwise we over-commit cq entries.

What do you want to achieve with the cancel here? IIUC it will make it look
as if some (if the user has posted many) tx descriptor has not been consumed
by the kernel?

I do agree that a better idea is to probably do these checks during control
paths, but it's a bit more involved (and not sure if it's possible? if we
have a bunch of xsk sockets and we change that max_sdu, do we go over all
sockets on the system somehow?). My main motivation with this patch was
to make our LLM reviewers less chatty about preexisting issues.
