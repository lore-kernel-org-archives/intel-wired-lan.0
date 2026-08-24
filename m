Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C43C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 18:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7393B40588;
	Mon, 24 Aug 2026 18:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUxlpcEp3wxu; Mon, 24 Aug 2026 18:21:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787595675;
	bh=sETMReISMBe6rjtQEm20AuiXiK56X85vfYOV++AGSe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KUFrdYoBQH/brvtWhk39p+JkzJjZD1EblYnifSw2wnjyHxSozVPt9RD0GWb0V5pYs
	 I3xpJ4Aeb1HRnT3IXCy+kxqHsWZc9vzBiGvZDt0UaTDHmiBdZGpUCxyrWV3V0JLs3w
	 wtM3TlbxQXk1YapxQpcxedVwq1P8BMsxwB5DGQbqBzy6/4nk6nZxzaWnKVxOq5Cnon
	 bhsSjjKofJ5kDMoCVFwUs4EppgQQQo/z/4xHUWZCHdOG99Zd2S0wfv+G6JiYNiIQd5
	 MZ4o2OUPa1jplB+2v1YsyTzRiqVs5Ctuvaisf1QA1gmwuQOnxEu7GC7XNIYZQyAD7p
	 iypyLXbnmQVuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 713FA40593;
	Mon, 24 Aug 2026 18:21:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0733934E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 18:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9BDE80E1A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 18:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2MS1qlNcQ8S for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 18:21:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VrGbKR9V
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C774280E0E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 18:21:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0805601E0;
 Mon, 24 Aug 2026 18:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6021F000E9;
 Mon, 24 Aug 2026 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787595663;
 bh=sETMReISMBe6rjtQEm20AuiXiK56X85vfYOV++AGSe0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=VrGbKR9VGsJYoffJbq9RnobYFUSqZaedkdBTA9n+E0B8M/63QpKK2qWaY6o6GUbE5
 Yy5mFkwiYeMj6Wn2sImSQDB4h8GlwgUpFEP7LV21npHJhCrl+N/X2lwWeQVEoZUcH9
 9rLU3chh0c8FKvVXPacPV7VED0TUFNKreWGOXHxNgCNEIoEmPv+oqx2Cid1JDfF0V8
 ff1cnVCX1dXwwd/2ld/uu2p4CdQeCe8G7wum/2xp/v84ZK47b9UQeQZOm7Glr5nNhe
 Kwnr8dOiinRNdnlrPCI9+kVoW42AfuMNHDPhXwHz3eFIFqzu8biPlkPmxe4OnExdTd
 TLVmIr73BSt1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 0FF863924A4C; Mon, 24 Aug 2026 18:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] xsk: pre-existing AF_XDP TX metadata fixes from
 Sashiko
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <178759561065.3051903.3086695861982033843.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:20:10 +0000
References: <20260819160535.1472459-1-sdf@fomichev.me>
In-Reply-To: <20260819160535.1472459-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 guoren@kernel.org, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-csky@vger.kernel.org, leon@kernel.org
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

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Aug 2026 09:05:32 -0700 you wrote:
> A few fixes to address pre-existing issues from Sashiko review.
> 
> Notes on the feedback from net-next v1 posting [0]:
> - It correctly complains about ABI breakage for 32 bit systems, added
>   an explanation why I think we unlikely to have any 32 bit users with
>   launch time
> - mlx5 batching (pre existing) - I think my point in the comment still
>   stays (that we do not make it worse)
> - stmmac recycled descriptors (pre existing) - seems valid but I don't feel
>   confident sending a vibe-coded fix
> - stmmac queueMaxSDU vs taprio offload - don't think this is real but
>   we can fix separately later if it is (the existing issue with breaking
>   xsk seems more real)
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] xsk: align TX metadata layout across ABIs
    https://git.kernel.org/netdev/net/c/bd7d30bd1d38
  - [net,v3,2/3] xsk: honor XDP_TX_METADATA in zero-copy path
    https://git.kernel.org/netdev/net/c/a6e4b9a6deb9
  - [net,v3,3/3] net: stmmac: document oversized AF_XDP frame handling
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


