Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5575AC61DBE
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 20:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC0DD6060E;
	Wed, 26 Aug 2026 20:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B7ncygr2loKw; Wed, 26 Aug 2026 20:20:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787775652;
	bh=sdBgprMEYcaiSUj0ygVN2sdfjT+LVmQNKAKHSXm0dYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kNioGHdccMpSz8PM4jH18wMtsN1LY4ikhrgjmxZe9lcS1e2EQELYG0VsYUmldUTqu
	 r5GzGrpE810QGa0XdXAN7vvekEp/lrF5d7iGvvrT9P9TolDlXJTw9MBd0hmxXk95d+
	 ls7sWhOtlkp0wO4e/MjucLlsG9qcFTt7OmpZ6u1RZ6XvnuXDtr1FBc/Bg/rfbztHaX
	 VLx6mM1BbVM8tEJ9UD/bWrMWW99/NwHhNmeyAn05HCr5SejoNxdhMBvD09EtVKYXss
	 273dxIaCYitM5MeSa/cABJmWURGKLE7ZeXgnXFQgtP3oIC86r2+Q8XC9bVPGV0vWzf
	 oycu27lFLl/EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18346605ED;
	Wed, 26 Aug 2026 20:20:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50097323
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 20:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4232D80E4D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 20:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWSc16WhJSxS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 20:20:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Q294isjT
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B0FE80E42
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 20:20:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF3E06011F;
 Wed, 26 Aug 2026 20:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8CE1F000E9;
 Wed, 26 Aug 2026 20:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787775647;
 bh=sdBgprMEYcaiSUj0ygVN2sdfjT+LVmQNKAKHSXm0dYs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Q294isjThieFDrLugvFd1j77TaAVB2QAfsB3TQVc990b36f+1TuRDchhHGUOCTYmZ
 /qLud6mlMd5GX2gWFNZe7LJ+1QxL5wZWzZUyDBEUF7I9TXv5y2wYtUeu0+FCRaTzWY
 cAvQDhTC0CuVC1M7qyRBuC5L8U6uFwyvdHHUh5/doxL+wsmj852Ov18fcsA5Om74iq
 /viq4ftEPN1BpJsgIKXReyaVM8HFTfdzvgUX2sFbi8IqxPsYPvyR1B5ZN32bVpr9J8
 5M2idS8spkwUTRc0+2K7cK0hA+Ho9M2Ks1MKT3zuz1xdZnFcHW5VUrPIjhanKtqtlf
 2GfQQKik9shxA==
Date: Wed, 26 Aug 2026 13:20:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
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
Message-ID: <20260826132043.39fb435a@kernel.org>
In-Reply-To: <dc2ccb14-c7c0-402b-93b3-afba52df78fa@bootlin.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me> <aoceSoSFMx69Z9up@boxer>
 <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
 <aogpDsa8hz6CPpD3@boxer>
 <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
 <20260824111443.34bffe04@kernel.org>
 <dc2ccb14-c7c0-402b-93b3-afba52df78fa@bootlin.com>
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

On Wed, 26 Aug 2026 14:42:25 +0200 Maxime Chevallier wrote:
> >> Let's definitely fix it properly if you have better ideas. But since we
> >> don't have HW, I'm not super confident doing anything sophisticated
> >> myself :-D  
> > 
> > Let me take the first 2 patches and leave the stmmac for later.
> > I don't think anyone involved care particularly deeply here.
> > 
> > Maxime said he bought a bunch of relevant HW. If we finally wrap 
> > the AF_XDP tests into driver runtime he should be able to help us...  
> 
> Indeed, I haven't started looking into the AF_XDP (and XDP in general) on
> stmmac, lots of fixes lately on the subject so I'll get there eventually :)
> 
> I'm currently plumbing the driver selftest on my setup (ethtool -t) and just
> runnign this uncovers lots of issues al lover the place, once this
> passes I'll get on the kselftests and see what we can do on this.

Also if you try running driver ksfts - please keep us posted on what
the blockers are. I _think_ we just need to teach ksft to cross compile
C binaries?
