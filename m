Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E4AF3D329
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Mar 2026 16:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EA148149A;
	Thu,  5 Mar 2026 16:10:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id we-tFB-NrUsw; Thu,  5 Mar 2026 16:10:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 866B08116E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772727031;
	bh=MxO/uAuSvwaEX32/aOvmiV92TkJ2Kk9u1kPBjcGefy4=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DteMWgMmA1ji1SHIlfk74+JTmvCKgzAUhYKUUYCgwP0lwxnRpLRYwbO73NmI405Aj
	 9/mf0cNXacsZ3yvb5JLS+1IQuxc7taUsP+/5jCLhep2PsSk1eNJCWcTpSGteV7nZlp
	 ErJ87iBL+/1igeALI8es131ZLBVhK3xA6mO4SVJSEGVeH1LHJ+ihtdvtOqRkem9eRc
	 rdjCSCDUHWNHtLzDAVtcQkFsG5ln1Vl6OHmO9yAcNhBYRD7FC8XMhg4mWFnA6I/8tD
	 PrYtdnIvvvXXxnVDttFW9CoTDyYokZTJP2XWZFhuJnLyZRDYAtfk64YcOEs0/h/vED
	 Zwd7xEg7GJEvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 866B08116E;
	Thu,  5 Mar 2026 16:10:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 941CA25B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 16:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91D7460BEE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 16:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 47H8pk0Gk1op for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Mar 2026 16:10:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C16CF60BEC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C16CF60BEC
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C16CF60BEC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 16:10:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 384C1419AB;
 Thu,  5 Mar 2026 16:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B15C116C6;
 Thu,  5 Mar 2026 16:10:28 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FE653808200; Thu,  5 Mar 2026 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <177272702805.3188128.16309701518912320444.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 16:10:28 +0000
References: <20260305111253.2317394-2-larysa.zaremba@intel.com>
In-Reply-To: <20260305111253.2317394-2-larysa.zaremba@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, horms@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com,
 bastien.curutchet@bootlin.com, tushar.vyavahare@intel.com,
 kernelxing@tencent.com, rbm@suse.com, echaudro@redhat.com,
 lorenzo@kernel.org, toke@redhat.com, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org, aleksandr.loktionov@intel.com,
 dtatulea@nvidia.com, magnus.karlsson@intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772727028;
 bh=XkVTGgjybgKXZp1qt304mUns/GTshs03+4QI6M7emKQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=pJfHnw1PbGoVjYrwIafL+sqM5ACrKoPeYeM+WMHXQSNVzQkeLJdwDbcj1a5uBNNdJ
 BuvVGHLKoKDiG8WQVhoBATOs+JGvFpBk/FKjbhK6SEiykJYMR1bOlci0Iva/GwZj5E
 rHIWv4INmohx5G6E6T5ZRgKasDjDm+oyIbs00bFGtY0bg3IMG+3iQUGH12oQG3Fi0o
 Q+Ec5yC4V+59xLXVyIdoLCNtst33sLrQEdy2k+LR9+x3tld3vYSUsCkPmdroW1eQTp
 BI9/O0QCIXBz6comfzwNag2tq7+1nv+JuI9kyTWxsW+s/qS20r1YYF81VOoMGoe8Fo
 6wy8AMu24AZsg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=pJfHnw1P
Subject: Re: [Intel-wired-lan] [PATCH net v5 1/9] xdp: use modulo operation
 to calculate XDP frag tailroom
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

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 12:12:42 +0100 you wrote:
> The current formula for calculating XDP tailroom in mbuf packets works only
> if each frag has its own page (if rxq->frag_size is PAGE_SIZE), this
> defeats the purpose of the parameter overall and without any indication
> leads to negative calculated tailroom on at least half of frags, if shared
> pages are used.
> 
> There are not many drivers that set rxq->frag_size. Among them:
> * i40e and enetc always split page uniformly between frags, use shared
>   pages
> * ice uses page_pool frags via libeth, those are power-of-2 and uniformly
>   distributed across page
> * idpf has variable frag_size with XDP on, so current API is not applicable
> * mlx5, mtk and mvneta use PAGE_SIZE or 0 as frag_size for page_pool
> 
> [...]

Here is the summary with links:
  - [net,v5,1/9] xdp: use modulo operation to calculate XDP frag tailroom
    https://git.kernel.org/netdev/net/c/88b6b7f7b216
  - [net,v5,2/9] xsk: introduce helper to determine rxq->frag_size
    https://git.kernel.org/netdev/net/c/16394d805399
  - [net,v5,3/9] ice: fix rxq info registering in mbuf packets
    https://git.kernel.org/netdev/net/c/02852b47c706
  - [net,v5,4/9] ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
    https://git.kernel.org/netdev/net/c/e142dc4ef0f4
  - [net,v5,5/9] i40e: fix registering XDP RxQ info
    https://git.kernel.org/netdev/net/c/8f497dc8a614
  - [net,v5,6/9] i40e: use xdp.frame_sz as XDP RxQ info frag_size
    https://git.kernel.org/netdev/net/c/c69d22c6c46a
  - [net,v5,7/9] libeth, idpf: use truesize as XDP RxQ info frag_size
    https://git.kernel.org/netdev/net/c/75d9228982f2
  - [net,v5,8/9] net: enetc: use truesize as XDP RxQ info frag_size
    https://git.kernel.org/netdev/net/c/f8e18abf183d
  - [net,v5,9/9] xdp: produce a warning when calculated tailroom is negative
    https://git.kernel.org/netdev/net/c/8821e857759b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


