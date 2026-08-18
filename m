Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E01C5DF7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B617A408BE;
	Tue, 18 Aug 2026 17:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oYwrcTH6sSnC; Tue, 18 Aug 2026 17:03:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84458408AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787072637;
	bh=Q80BWnEZK8DYTRP4qPFCamRkQ8PTkFuflTPG4q2POi4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QbapVC/UB195QP8f+LXr87Y44VN8viY0fdthN1H2dgMy9hylWxVdLzawyOlq1A5MN
	 iP3DpRvIPsVYP+K7Ul1KLi2vIcOLrgwY/z71ZS73wwGvABdRji9jaHynGBImDCBBhb
	 WClCQ4bL7C+7BKetlM2RQPGodFpjp2/YSUSZCmDn3fjWV2uX2MJwrrtc0LrgWzb75m
	 M5r3E1zrog9eh9PNOXKMN9PxSACN+jPVwIMGGUlHKLjuJyNoQo7/FxBFZQ143ispxw
	 YopnjVZujwMsdLwzk9s2ReEukA8zfh7WVNKRoi54jouIoEQ/9IEFlsvARSOAL57yxu
	 k4JceOwGfJM3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84458408AC;
	Tue, 18 Aug 2026 17:03:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E1A839E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 17:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FFDB6078F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 17:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R3W4FCqyBdF1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 17:03:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::4;
 helo=mail-pj2-x04.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6CFA4605F8
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CFA4605F8
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GN9VJ5XS
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CFA4605F8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 17:03:55 +0000 (UTC)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cabf1f1051so242905ad.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787072634; x=1787677434; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q80BWnEZK8DYTRP4qPFCamRkQ8PTkFuflTPG4q2POi4=;
 b=GN9VJ5XSjXvmtMJfIexCgS2RarfrgsqkW3JBFQ45yZP/tU7hwi3O87jCEg/N5cvPQd
 hE60yehCBKQeM+tgjxUod5SDz7x+EPRAxVpd+3alqDtkq/D5zdmX2zAd6sUeV1RRDVUt
 6JzSCKH440DozFPUsNSNoHDAmwBeIddHJg7ylha5AUZhZltkt6Lzt+4UBMdh587ZT6Yl
 LlZK8nl5+wOUOXUoWB2a8Xd1p9F8HDs1PSJo9o5KUwv2mNQKUx2Dkfc3R3KxolWl3K+g
 3mDANYjnLjhEc1QVgDOB9x5FWu/6B80sKn+6ySWfSZOEwwx+Bt93GXi9TVHeZdqsoYIb
 pfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072634; x=1787677434;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q80BWnEZK8DYTRP4qPFCamRkQ8PTkFuflTPG4q2POi4=;
 b=Rbr1Sv/PrlFW/I0yLWrm9+sLkL+fHU4RFnf3qcauxclWERVLOhFHHype8qUgzughjr
 WrKIP1iKUUUqs+taWHRudj7iaVMjKodLxpWZ4tKFctHF4LogHY7dC7AiLxba0nkK4PRF
 ketQAZvPHjgrZk599AIN4ZdlGWB5ZUnXJGfQpswJ8gqk6bHxq0eJy44zeOsP8n3nxSS3
 JZFZ8TO/qCVTpIWY8G9ffvuTB9y0IWYhvGmD34FbI77y7deLdJxrwbb68jV+3+q86Nh+
 21QJnyxZdE+c/x0WPbhi/Hj6dj2zwVc/ZBgwNHmQ8TJ4Zz6jTRdX8csp0wx+6ULj11Dc
 9M+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGWeesgMYlnoLbl2jbIMpNjlFj0LZSlv1JyN0W+eUeFHbGqsA6P65se6/9m6RIFiVDfEjLoCq+vfVIUaGdOHk=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yxy5ZOhixhNljNAvQv/y/oSSEIIqpALasysjzMRZvEc5K9sqqfR
 1/IqyEO9QCOuQeM333Lx+4mB1+uYFOdoHdMWk3MkOj+ctoCJ7HdHbKul
X-Gm-Gg: AR+sD12o48kzlSUKyxa19zntJCgUUKUv0yOxNsa4w2z42gTeJ++a44lyczaXuvYxaC3
 wi1lkfSjx5F7uJF6AFe8avImYCaTcnGQXMjwu4ZDMlEt8ActAxqQ6ZLJGa8U/HxJk1OdBeNocb9
 CpMfp2kqEJxNuBkwlhFd5Smv41ZxsecouUZIy6cWUYDn/03b8m82a73giCCiCAf8l7avi4hGNx8
 +2nTYZbJ/+zy34p1tkyVVXmsXZMC2agiGHgVFCuImL5LbMx+7Wr6x8wL75IjO3QOvTaA9x0bwN9
 6bgiMaHCOa2my8TNr0BQM18xH8IrlQ2gIrD2E8Eft8em8dFxykS5mpXWNgDEFG0CpatRMltm/M/
 csVXSENQOsVn/r4yWa85SI3PJa82fYUUf3+igl/lRbDzgdos7kvUMYGL4XnZr668cq/65nddAz0
 24YMy2Uo1fMIPrb8i7N16+qBs56gBd3oNrbJZrmNfIReMeycuNPU+C
X-Received: by 2002:a17:902:d4cf:b0:2ca:660:b1d with SMTP id
 d9443c01a7336-2d3b0d5eccfmr373846305ad.11.1787072634166; 
 Tue, 18 Aug 2026 10:03:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb499d7bsm20728245ad.3.2026.08.18.10.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:03:53 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:03:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
 pabeni@redhat.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, 
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, 
 hawk@kernel.org, john.fastabend@gmail.com, witu@nvidia.com,
 martin.lau@kernel.org, 
 yoong.siang.song@intel.com, rohan.g.thomas@intel.com,
 intel-wired-lan@lists.osuosl.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org, leon@kernel.org
Message-ID: <aoSOau3NuHTLLxnL@devvm7509.cco0.facebook.com>
References: <20260813190800.222527-4-sdf@fomichev.me>
 <20260818162442.3980697-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818162442.3980697-1-kuba@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net v2 3/3] net: stmmac: skip
 queueMaxSDU check for AF_XDP
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

On 08/18, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: stmmac: skip queueMaxSDU check for AF_XDP
> 
> This drops the per-queue max SDU length check from the stmmac AF_XDP
> zero-copy transmit path, on the grounds that xsk_tx_peek_desc() has
> already reserved a completion ring entry and the old "continue" skipped
> both queuing and completion. The change is tagged for stable via a Fixes:
> tag on c5c3e1bfc9e0.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 62de03e65a90c..4a82f4351303a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2710,13 +2710,6 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> >  		if (!xsk_tx_peek_desc(pool, &xdp_desc))
> >  			break;
> >  
> > -		if (priv->est && priv->est->enable &&
> > -		    priv->est->max_sdu[queue] &&
> > -		    xdp_desc.len > priv->est->max_sdu[queue]) {
> > -			priv->xstats.max_sdu_txq_drop[queue]++;
> > -			continue;
> > -		}
> > -
> 
> [Severity: Medium]
> The completion ring imbalance described in the commit message looks real:
> xsk_tx_peek_desc() reserves the cq slot with xskq_prod_reserve_addr() and
> only xsk_tx_completed() submits it, so the old "continue" left the cq
> producer permanently offset.
> 
> Was completing the reserved descriptor considered instead of removing the
> check, i.e. keeping the length test and doing:
> 
> 	if (priv->est && priv->est->enable &&
> 	    priv->est->max_sdu[queue] &&
> 	    xdp_desc.len > priv->est->max_sdu[queue]) {
> 		priv->xstats.max_sdu_txq_drop[queue]++;
> 		xsk_tx_completed(pool, 1);
> 		continue;
> 	}
> 
> That would fix the ring accounting without dropping the enforcement.

Don't think this suggestion would work. xsk_tx_completed(1) will complete
the first queued entry, no the current rejected one (completions are in order).

If it's not convincing, I can repost only patches 1 and 2. Or if it sounds
reasonable, can try to explain that part in the description.

> On stmmac, queueMaxSDU has no hardware table. priv->est->max_sdu[] is
> written only by tc_taprio_map_maxsdu_txq() in stmmac_tc.c:
> 
> 		for (j = offset; j < offset + count; j++)
> 			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
> 
> and read only by the length checks in stmmac_main.c. With this hunk gone,
> does an AF_XDP zero-copy socket now transmit frames above the configured
> per-queue limit while tc_query_caps() still reports:
> 
> 		caps->gate_mask_per_txq = true;
> 		caps->supports_queue_max_sdu = true;
> 
> That capability is what taprio uses to accept a queueMaxSDU configuration
> in the first place, and sch_taprio comments in
> taprio_skb_exceeds_queue_max_sdu() that "Devices with full offload are
> expected to honor this in hardware".
> 
> The "bypasses the qdisc" rationale also applies to stmmac_xdp_xmit_xdpf(),
> which serves XDP_TX and ndo_xdp_xmit and does not traverse the qdisc
> either, yet still enforces the same limit:
> 
> 	if (priv->est && priv->est->enable &&
> 	    priv->est->max_sdu[queue] &&
> 	    xdpf->len > priv->est->max_sdu[queue]) {
> 		priv->xstats.max_sdu_txq_drop[queue]++;
> 		return STMMAC_XDP_CONSUMED;
> 	}
> 
> Should that check be removed as well so the XDP paths agree? The cited igc
> precedent checks only in igc_xmit_frame_ring() and in neither of its XDP
> paths, so matching igc would mean touching stmmac_xdp_xmit_xdpf() too.

xdp_tx does not expose xsk-like descriptor rings, so it doesn't apply.
