Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4B7C5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 18:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC2CE80E28;
	Mon, 24 Aug 2026 18:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEtQ5RBMIQJT; Mon, 24 Aug 2026 18:14:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787595287;
	bh=bBAzJ1wZvTBzk2jjxXm3YqIN0/WHyV3eBtBFUun8nQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pEhFMiaFJu96prwZIWRBoS1nBSVfO8rTD6oudxK2Jw3gqbYME2ue5v1BjS8ZOHzuC
	 T01FNIc9BGzeaoFlvEWQmBsxuBiDuh0tPKS389Kl7Ga2qyeKJz205bD++0zs/7jnlW
	 E2OzO+umIZt95EyGT3nNAhOLTu3JJalLjgXL7tCq8rlcjIPjHwQnr/A7N412cXMh/k
	 /MpTrBHT9kmlrqmHyuPX0KOw8ijR44GDle86EOxfzhF1//BQ1UzMvd/RuMBF5DScgm
	 1TuJJXxkx43iDTPDlR1gIxGRazEafIVogkJWUUotnUqdHtXVPPKVG+sLpblaHEXwvF
	 saU8sK1pC8xRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 756DF80E1F;
	Mon, 24 Aug 2026 18:14:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFD804B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 18:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1B8F80E1F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 18:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixcFW80B6bir for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 18:14:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jgAXqGNa
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E2D980E1A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 18:14:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FBA64394A;
 Mon, 24 Aug 2026 18:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CDE1F000E9;
 Mon, 24 Aug 2026 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787595285;
 bh=bBAzJ1wZvTBzk2jjxXm3YqIN0/WHyV3eBtBFUun8nQ0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jgAXqGNasidbaHQMnp5/SMprfR24IUmQiq8GmvgOdzqvGTFc2WNl2gHAGWyK4UJAA
 ByhiiLyF1JoFw7QInGYLTqnz+lO0fpq17gGejgBfcoz7NmvTrzJBpPt8adRbXiucr1
 L0t2oByWLooDg+TVK0h9NBQUcLB9lymHNbTp8uxRMCiTarrOWYheF9dynLWEDL9JSm
 O8q+q9akjuhyhLslrVdA2J35E+njlTzbRjn74YPpXf151DwVAaHU7jc5HQd2inb97W
 5Z7HSEz580eRcD1F//V50hLwnc5oh6A1WHNp1zrJNVf2qLx+W9sIf+z6hUf9fyKfHb
 pqGoM30MOUnBg==
Date: Mon, 24 Aug 2026 11:14:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, guoren@kernel.org, dtatulea@nvidia.com,
 witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-csky@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Message-ID: <20260824111443.34bffe04@kernel.org>
In-Reply-To: <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me> <aoceSoSFMx69Z9up@boxer>
 <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
 <aogpDsa8hz6CPpD3@boxer>
 <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 21 Aug 2026 10:28:47 -0700 Stanislav Fomichev wrote:
> > > I do agree that a better idea is to probably do these checks during control
> > > paths, but it's a bit more involved (and not sure if it's possible? if we
> > > have a bunch of xsk sockets and we change that max_sdu, do we go over all
> > > sockets on the system somehow?). My main motivation with this patch was
> > > to make our LLM reviewers less chatty about preexisting issues.  
> > 
> > I hear you, however I feel like we do not know this driver too much and
> > probably we don't have a HW to test out such changes, so maybe let us try
> > to fix existing behavior?  
> 
> Let's definitely fix it properly if you have better ideas. But since we
> don't have HW, I'm not super confident doing anything sophisticated
> myself :-D

Let me take the first 2 patches and leave the stmmac for later.
I don't think anyone involved care particularly deeply here.

Maxime said he bought a bunch of relevant HW. If we finally wrap 
the AF_XDP tests into driver runtime he should be able to help us...
