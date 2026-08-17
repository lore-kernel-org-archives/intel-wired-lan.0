Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09F3C5B572
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 10:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 782D780ED2;
	Mon, 17 Aug 2026 10:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPeOx-W6l3Bz; Mon, 17 Aug 2026 10:18:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADC1B80ECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786961884;
	bh=TXBQkyiFLvXRPc/vOwn4FFBd5nq323zoO1sSOJOX4cw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6SPvT9MmezlugVvWNR0ZPAX6Cu/P+gCXiZcXPc/5OZN5l2YFIa8QeMpc6xC0IbqQ
	 zLpaxnDPQDrI6C4jsRr9NHqgXSLTIeVtKqGggB50L8/4tl3DH8EsYaL7qPLVwL8gFg
	 hUUba0FKl93/oRoFt+ggSofPUjbryThxDSCd/ROhnbnV1bzIW+rk2I0Bb7KG+OI/hl
	 795BeCNRFeyL3FGf9xvhAEn8jUznbkClGTf60pH+TYw8WPToO8g/hQ/N/Xw83OeFLo
	 UF198F2OXn+9B/VzdQEVLem4lFS7ExMsuoCv6XUYFC3qqSgDdP2JEAXRuVL9x82/x5
	 mTW3w5GKZnSlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADC1B80ECB;
	Mon, 17 Aug 2026 10:18:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B1E6A282
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 10:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97A4E80ECA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 10:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0OmdcYVI-7l for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Aug 2026 10:18:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2951D80ECB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2951D80ECB
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WnoxnwwN
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2951D80ECB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 10:18:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6868600AE;
 Mon, 17 Aug 2026 10:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000DA1F000E9;
 Mon, 17 Aug 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786961880;
 bh=TXBQkyiFLvXRPc/vOwn4FFBd5nq323zoO1sSOJOX4cw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WnoxnwwNzxDZ1uTD3Jm53Egy4+C6aqoRoY0GEIURu9TYM82Zq+KqLLAJ/E2+/+UgC
 M3LKx/OX2d5cuGEO1UZnES5hvb30VCRndCdCmDJLGMHFSiUhJ4tPIkuebjI6x+fVFc
 54056sAl+BGJK1Lbbl5FuyrHxcXqwZqkNt2PJuLbhjKopgFXps6Xa+ABEO2rh1Lpi8
 85D0gqTYZKc38c3RkDt/Cgbz3XaSYodY+Dyf0yuy0eQfJ4A6+3RbG6kV0jYw6lQ+fT
 T9FC3OurG4v08tTv0HWDox4ksMeFINLXpqRB2B8uP2i+pZ/0T8/T5jOE0dTqPDugUo
 aiXwObD4UGM8A==
Date: Mon, 17 Aug 2026 11:17:52 +0100
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Message-ID: <20260817101752.GY265046@horms.kernel.org>
References: <20260813190800.222527-1-sdf@fomichev.me>
 <20260813190800.222527-4-sdf@fomichev.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813190800.222527-4-sdf@fomichev.me>
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

On Thu, Aug 13, 2026 at 12:08:00PM -0700, Stanislav Fomichev wrote:
> Commit c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
> was inspired by commit 92a0dcb8427d ("igc: offload queue max SDU from
> tc-taprio"), but the igc change does not apply the check to AF_XDP.
> 
> xsk_tx_peek_desc() reserves a completion entry. Continuing without
> queuing or completing the descriptor leaves the AF_XDP rings imbalanced,
> so remove the check from the zero-copy path.
> 
> The assumptions is that AF_XDP zero-copy traffic bypasses the qdisc, so
> taprio's queueMaxSDU check does not apply to this path.
> 
> Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Simon Horman <horms@kernel.org>

