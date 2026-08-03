Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1ABC55184
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 23:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D94FF60672;
	Mon,  3 Aug 2026 23:51:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvu70rkl-s55; Mon,  3 Aug 2026 23:51:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C1D6606AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785801069;
	bh=B4yhz+JQv0QMMgQVrxwyPdXvzn96hxmm8mw/fYkupHg=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=15fVqhm+Y1wfLspDJk/71T3RmfWi/c43z2yL16DNwzzRN4NIkp7TDPuwHfRQUT8oK
	 Z8Z6/lcwboyiIAsNcSVm3AZZcTYsC2oCRNsPZHtLns2cPlUkfg3vlxBdawGrudgARG
	 RidWR5xGKlW3bpSAL07N7rKifTPzovsCKtvX8i8yXG0yKK1HUBSUJGAKKESickqVqi
	 zqxzbkChoqpZSD4p6f6czAqlUt8V/k9Mq7RGe1CgWHjDN+CaTh9FSrZ2ADzxdc2bgy
	 1THFOysnhwzihtgJeh9ngGUdUyF1KGKcOTTGxWqcPLYATJNFjc4ftjbFwD8jADNcyl
	 D5Fhn3BKpj8VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C1D6606AE;
	Mon,  3 Aug 2026 23:51:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 462802BF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 23:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BF82606AE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 23:51:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1v6vdEd5piU5 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 23:51:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 38E2360672
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38E2360672
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38E2360672
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 23:51:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46DF460A5F;
 Mon,  3 Aug 2026 23:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9061F000E9;
 Mon,  3 Aug 2026 23:51:03 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19A113924467; Mon,  3 Aug 2026 23:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <178580102466.2881314.4527278917944249834.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 23:50:24 +0000
References: <20260727161959.885642-1-sdf@fomichev.me>
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com, horms@kernel.org, 
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, witu@nvidia.com,
 alice.kernel@fastmail.im, dtatulea@nvidia.com, yoong.siang.song@intel.com,
 martin.lau@kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, leon@kernel.org,
 AutonomousCodeSecurity@microsoft.com, blbllhy@gmail.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785801064;
 bh=B4yhz+JQv0QMMgQVrxwyPdXvzn96hxmm8mw/fYkupHg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=dkRYn8yGh74TjYjobcsupvOS3FRrRLYd6cOInE3TOiNWpDcNrujN0Indh9wOZKxVw
 ej01a4pV8te8xzikOjLkSAlrhDSVOfvD4+7ethit34sQMSO3Xq3vynpRNbRXhgyWhl
 xlzoXLS1Z2TLS+DePJy8rTxUnKc575FIikguZAMkayr8U5Bdjfn/Xg3of0RYOCLnAq
 giq2gUJ0G3gwY2dNLcPYB7Le7xc3cksCq5QycHWD87aspIJUWvRRdy7jqLKUEKCJPR
 iPnBf6PILULBZj7W5vT/2LgoQs6ktqXCkjc3EGwKxVpkjtkEeUgcL7RGyyoXmHhcou
 piWz4OrX8iklA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dkRYn8yG
Subject: Re: [Intel-wired-lan] [PATCH net 0/6] xsk: harden TX metadata
 validation against races
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

On Mon, 27 Jul 2026 09:19:53 -0700 you wrote:
> Cen Zhang reported a KASAN out-of-bounds read when AF_XDP is configured
> with a TX metadata area smaller than struct xsk_tx_metadata. The metadata
> is also shared with user space, so reading its flags more than once can
> produce inconsistent validation and processing decisions.
> 
> Require enough space for the flags and one request field, validate the
> launch-time field against the configured metadata length, and use one
> snapshot of the flags while processing each request. Carry the validated
> decision through completion handling so later user-space changes cannot
> enable an unrequested completion timestamp.
> 
> [...]

Here is the summary with links:
  - [net,1/6] xsk: require at least 16 bytes of TX metadata
    https://git.kernel.org/netdev/net/c/1bb30b181d9f
  - [net,2/6] xsk: pass TX metadata pointer by reference
    https://git.kernel.org/netdev/net/c/19366db6dfcc
  - [net,3/6] xsk: clear metadata pointer when no timestamp is requested
    https://git.kernel.org/netdev/net/c/9f60a67df8d3
  - [net,4/6] xsk: validate launch-time metadata size
    https://git.kernel.org/netdev/net/c/439ce2dddf3d
  - [net,5/6] xsk: move xsk_tx_metadata_request() to xdp_sock_drv.h
    https://git.kernel.org/netdev/net/c/ddd0d6c5bfe2
  - [net,6/6] xsk: validate metadata when processing requests
    https://git.kernel.org/netdev/net/c/849b1664dbda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


