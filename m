Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34CFC5DF8C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 17:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A51040B74;
	Fri, 21 Aug 2026 17:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R7OlClUru4XB; Fri, 21 Aug 2026 17:28:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787333334;
	bh=+RpCheSrOdysr+r97ve0JN+xVtWYbZrCXCOuzISS1Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sWLatHsWkogRNKpEQSLVDJjFUwNSaMxy2r53f4OEOP7dnQSOd+oVm/y8HcWKPZ3Dx
	 YtVwbc647TybaRwpbit/5lmN2z+rGRGSZuzbNLbym1oRAVrcaVEF8mbp2CqOaIm26v
	 pemEdkjZJBeb1fMaLadjd3AwHNTw30+L1rzgzgcDbVgv1ZeppUr10zSoNUviexvYaR
	 E7ZZGLQHyy0uAMDEPcu5utXqDvQttMMIhHyPIDnUruwxCYCRfACRrGc/RBYvu91gVh
	 EBEUDlYSdn0tqKJ+TpqmZqbeSssMYw/EoXgmCMCLabnG7jVPccyFFk4hvr2Y9kJ/f3
	 gZCXby8LYqlCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4C7540A26;
	Fri, 21 Aug 2026 17:28:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 463274B8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 17:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37D61811E0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 17:28:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yq105oN4W-HE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 17:28:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::b;
 helo=mail-pj2-x0b.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PlXnp2gQ
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EE5081178
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 17:28:52 +0000 (UTC)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2d59734a089so8363565ad.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787333332; x=1787938132; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+RpCheSrOdysr+r97ve0JN+xVtWYbZrCXCOuzISS1Oo=;
 b=PlXnp2gQwgprLEd8ZVQIv/cUDQ8rHmqRflXH/4j2+21wnLCM/mAsEQOF43JvKDHkqz
 SfvmTHNp/FQdM7qIl4UvTc4I3GoF430VZDk4lw2Diiz1lr9ZhS6nzDnGJZoBScd70vE+
 T9he4rgxCL5ov9xH298HCMNPsM0UQSIqBrwFZPI/+NmR2WFXVUwC9MIbzx6Tt5lm//m6
 T5ttn4a/7qyWbILCGkqWgIIZ0OqKk8eAqvSgbhx4pq16cnkXD/zciLyZvJlGPd1ThN6c
 05lADmDIVTnB1jWE2EQSZXC5d/eqcV7zfyAkMqBh4UW3WZqmuQ2jFm96XD9Zc5Ar4nCy
 rGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787333332; x=1787938132;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+RpCheSrOdysr+r97ve0JN+xVtWYbZrCXCOuzISS1Oo=;
 b=bjz2gV0Ex2Dr3Z0SEO94vzrkmgDgHSxvtb5LlBIWwqy3RxXf9OOXpPBwrxdJFc9l74
 2WIrsmlRPKQWLuOMcT9nO1cR4RfoD5MbT/zqpGnHYm6RBPV6tbx5GRBKF8lq5nD4gdeI
 AU0ZWzomQRxU2xhupnHe0/RbrAaMuyvRRykY3u9ojfhdKeM3K2rS/QbcW8t6y/Jl4Jz4
 qD4jhHdk+t1uDWDUoWpjE3CDMXD1G9xvH5WYUCoWGtUTprIrK7WM6i8M6z30uTZ21Q7x
 BtgvP8m42XVbzglJYSQDzFFFKmqFYKuMZ3JwlN3aTEwMh5Ts2OuyrHOGplAwFygaWiCq
 5ljA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6ta21yfHKADYFv2ZAuOda0Ouu1c8qbtmt7k/nl/AO1xMcYoJOZps1/HKGd0QbRyTC8Fz5VD0+m6oZfuYSBS8=@lists.osuosl.org
X-Gm-Message-State: AFuF++mkN4RcwNPL8YPWtuq+8sFF6YOHoC+j4jEi/TVIrO3TNFXy+Jd7
 PjwzqPcXShNv7eX1d+6PFEygY0JLqAceqdwi53Zo+OB1t3HyCzOOm3WB
X-Gm-Gg: AR+sD13EkIfp9Q2LPcjfSkyEVXUb/Br6guh3847/Nt1yAIe0XKshFzcxfABCaWTA9B0
 fY9vs2YMCwfAxH7/+efRs1+K2iDFJcXh5MXu0iZ4hW6fsypd1Htw1lZex9SbrCgs39J7K2YTP07
 r3xq/nfRkiFOcV1rQ38T6GEeMLLrJ18CcXJc4YNVV0xz/6OSKs6lsBpvI8JuU2WunZuQe1KMkIw
 ni/w3ZQgmncULvetyG8ttBY4BqXem2BH+VtKIO6QteclOagggu0zoQWMLep/xm1LYmfdtVkgm0j
 7HkpWvQqk9F789meI3SdjILGKx0Xh4Rxi5PxzR7b3d+yXti5Ryr7TAwCUsTpl2WrV0hoedZEwKN
 VntH3GuX2utUOwbT/ef1Pog0fN1fOHVHdRG0FrgBEXYXbirP7N25u+vg4c+XDwhJReauS81DEQv
 htDyf7AjLP3JracltXVXRmJg49h+O+TsLd9EebQJqHcCUuYdDARSQjdg==
X-Received: by 2002:a17:902:e943:b0:2d6:3c2f:69b with SMTP id
 d9443c01a7336-2d64af6f8cemr156390915ad.8.1787333331890; 
 Fri, 21 Aug 2026 10:28:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d555b51sm21790945ad.7.2026.08.21.10.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 10:28:51 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:28:47 -0700
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
Message-ID: <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me> <aoceSoSFMx69Z9up@boxer>
 <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
 <aogpDsa8hz6CPpD3@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aogpDsa8hz6CPpD3@boxer>
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

On 08/21, Maciej Fijalkowski wrote:
> On Thu, Aug 20, 2026 at 06:29:16PM -0700, Stanislav Fomichev wrote:
> > On 08/20, Maciej Fijalkowski wrote:
> > > On Wed, Aug 19, 2026 at 09:05:35AM -0700, Stanislav Fomichev wrote:
> > > > stmmac drops AF_XDP zero-copy frames that exceed taprio's queueMaxSDU
> > > > after xsk_tx_peek_desc() has reserved their completion entries.
> > > > 
> > > > Completing a rejected descriptor is unsafe because AF_XDP completions are
> > > > ordered: xsk_tx_completed(pool, 1) would complete the oldest outstanding
> > > > descriptor, which may still be owned by hardware. Instead, leave the
> > > > completion pending so the ring eventually wedges and increment the drop
> > > > counter to expose the application error without risking hardware
> > > > misbehavior.
> > > > 
> > > > Document this intentional ring imbalance at the check.
> > > > 
> > > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 62de03e65a90..6a532747c039 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> > > >  		if (priv->est && priv->est->enable &&
> > > >  		    priv->est->max_sdu[queue] &&
> > > >  		    xdp_desc.len > priv->est->max_sdu[queue]) {
> > > > +			/* Completions are ordered, so this descriptor cannot
> > > > +			 * be completed safely. Wedge the ring to expose the
> > > > +			 * application error instead.
> > > > +			 */
> > > >  			priv->xstats.max_sdu_txq_drop[queue]++;
> > > >  			continue;
> > > 
> > > Hmm. I read the discussion on v2. Maybe we could cancel cq entry here in
> > > this branch? Also it feels like something achievable at bind time when
> > > taprio is configured and vice versa?
> > > 
> > > Otherwise we over-commit cq entries.
> > 
> > What do you want to achieve with the cancel here? IIUC it will make it look
> > as if some (if the user has posted many) tx descriptor has not been consumed
> > by the kernel?
> 
> Oof. My bad. I meant completely different thing :D
> 
> Right now the semantics are that we post invalid/dropped addrs to cq (the
> rationale was that dropped descs are gone and unreachable which might
> eventually lead to dying traffic).
> 
> We should submit xdp_desc's addr to cq.
> 
> Regarding the comment included in code I must disagree. CQ entries no
> longer imply that 'this particular descriptor has been successfully sent
> by HW'.

But then we need to support some sort of out-of-order completions, no?
This looks similar to
https://lore.kernel.org/netdev/20260818162442.3980697-1-kuba@kernel.org/

We write desc to cq at xsk_tx_peek_desc, so when we get an error here
we might have already "queued" a bunch of cq entries (which will be
xsk_tx_completed(num) from sirq). So unless we rewrite the way
we do completions, there is no easy way to put that desc on cq without
breaking the order and racing with real completions from the HW.
Am I missing something here?

> > I do agree that a better idea is to probably do these checks during control
> > paths, but it's a bit more involved (and not sure if it's possible? if we
> > have a bunch of xsk sockets and we change that max_sdu, do we go over all
> > sockets on the system somehow?). My main motivation with this patch was
> > to make our LLM reviewers less chatty about preexisting issues.
> 
> I hear you, however I feel like we do not know this driver too much and
> probably we don't have a HW to test out such changes, so maybe let us try
> to fix existing behavior?

Let's definitely fix it properly if you have better ideas. But since we
don't have HW, I'm not super confident doing anything sophisticated
myself :-D
