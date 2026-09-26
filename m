Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628AC9830E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 26 Sep 2026 01:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E2CF81183;
	Sat, 26 Sep 2026 01:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v390VNm_bSSw; Sat, 26 Sep 2026 01:51:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 99C73812F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790387483;
	b=a6FHiaW78C4MRJSHtJiP/k1iwd0fqehXQWImJAUCAW1XRzIMw92NMfPvGbtw6vKan2h6
	 MuzhbPKFu8kxVu5omDtLjvQxEr2Dfh4H5pTXT50fC00+5RyFwbHoR08a+MfskA5TnBB2H
	 z6eeBy4Kl167lqs8TD3CqCAYTSwIC8aa2cfD/PLxJ9t99cq/yjhj1k0YdlhPuO0hgCDjj
	 U9lh+8NX/vjIxn87ffjbjXz2qO+T/B5nylmhv71tDNTgE92haM00mevEKTW5oCwYnpHRR
	 vevWeBguW2t8r+x0QwR034pTIGYmT4Ps9SUzbZUCbPztqyaN6rzIYvmhtqQfttNEHRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790387483;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+VFT6xlGHxpC3kv25rw/bPdlgDq5bUdmZOCy6ObteTw=;
	b=KWyIbT7QTNYZiJdaxtzqpXBk3lqjTB6BII+KxvNoZoD0YjE9F1CTRnU2s+YuNpecTX2f
	 ObPaWtU/BgPueSvxeNZ3HiTID4Vo+wgF5LWtDTcHspof+kZDX3+9tTULE1HcGCQHpb2OW
	 iogGtjOfUSCzie3S4ykNpj3dUQYM1FHOGdTLETns0NPk0fpLmJEBTZJNwtukH/Prpai7y
	 NK+9S9iQpaiWaUGdhc8RyNOuhH/5AF5t0O6VgZZzf/8N0ZE9QwTQQEuoW571HGM5X3oYR
	 GZsmiGKqT3CZjgaYW+J1rk2TxIv4/Fg/wko5WgNYwh3fcLLCdseB3i+4E6jVPXVxTkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790387483;
	bh=+VFT6xlGHxpC3kv25rw/bPdlgDq5bUdmZOCy6ObteTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3KC25z0Gu7HpyuRdAlmCv+gbkDkNN6Fmh6LAL7XEMNZPLalhJGdG3yodO7DN46Tkg
	 fZugtoGvecxeTSjlNxrRTISy1I9e1GJddOHMG19hRQoKaiFh25CwoI5NsaCuQbaAEW
	 iS+U62+VhB0BEaYyoVsTGydSYfGLLNe4sNcO7hH+P76pmREUyONzqWtedW3GGCLlCP
	 asB9TE2McU1CE8ldICHSwj6YT+vm2yxhzxqtPqUhtuVESi5KcESwf8if8YxYR3hH6R
	 sG0vbnzt3u35ImYeXCtQx8HL9MmARVc7ugRnjScAB+x2blM/yBJsBHy9tWUiXcfmEc
	 8R7CjPJY9XuZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99C73812F2;
	Sat, 26 Sep 2026 01:51:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D0A67194
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 01:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6EAD40270
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 01:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOY7bTospkNx for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 01:51:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E49E040082
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790387481;
 b=lcMoHGDNDsc76cmDmZEUjlw2NpjjKOn8QTIKIXX0yV1AZ4yJRVuIN6q/rGmtJqX2DReO
 7frDAwPRKkeWYsskfyDXwTMmu+wUPGPrlf9rIc+1pgiHt9sgKpvku6zuQP0V7qBfBxOPC
 hpuJo7XYrJ6vo1WUk92Y/T86OcTp76QhVYOKxxkQqj/U8A8GyUhvlz3B1/TdodhTpvIxV
 qsp4oU4oPHaebPlA8z3eo4pVW/UohyXYgTf4IVdRnwoHcMIjMB3YMCp2wiYFSfmBXVpc1
 WqJ5SmyBOR32ByUWJ7OzWaCqPuTuBL84MIQHFyLh8apFP652JOXAvuLyue7vAN0KIaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790387481;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Content-Type:
 MIME-Version:Content-Transfer-Encoding:Subject:From:Message-Id:Date:
 References:In-Reply-To:To:Cc;
 bh=+VFT6xlGHxpC3kv25rw/bPdlgDq5bUdmZOCy6ObteTw=;
 b=cCpu5P4H1N6mOx3LgJiQJgUvL8gjq7YXD0Uj6RmduxL98lAW2Jy4QtM2f/2qDxiFtvjB
 T+BHo/xz0L+f3YQPgAWQ/T7+3m9KWHQjUMEttR1Xvc3xYa/raFl3ZR2Unimfb8FRAvhvX
 U5nuAfJA6Sk/hg4NQGRVqlmlgYA3m7iV2S2F7JLuOsNhFbrdAzJwngpZaZCYlX4HH//fd
 2NUex6saB/JBIinsNUxmoIk+6Zz5F7/lnPmocEDaTVnZuLA5pqWK14oavRKk/9aDi2/3M
 AnozUPpjM1/HQBGQgFu60+5BNV30buyerJMoLSAhXvf9QjYKaTZ1hSurMXLXX2ymBAA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cZQYV8k9; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cZQYV8k9
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E49E040082
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 01:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB14860136;
 Sat, 26 Sep 2026 01:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644361F000FF;
 Sat, 26 Sep 2026 01:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790387479;
 bh=+VFT6xlGHxpC3kv25rw/bPdlgDq5bUdmZOCy6ObteTw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=cZQYV8k9RIgZ70YxU298VqmdSLXwPUIOnfLTb5tz046zpmFAeJDf6KfWOJ+ugslO0
 8dtSipey73QdOPJ46PIfKEsQWR7FWIBRQyYvXi64sI615kQMoncUpkfRH3glRt7Yv8
 MgmDCzN+n7CWj0kZSS3O48pEG34SZPc3+Sc5vtYQ0lUZD0fX+b5qnwtFQL9xgAaTFO
 6UDQ9G/I3mKYPoBKd82O7X49IpEtakxkNB2eNpYQrgWkCJsvjGKK6US+2AcGamOImx
 aP0bB13IcN764QA9Y3zHKuz3d746ks2n0pec46xnPehMmwyGRkW4zKULz7GX3SzLb4
 inzXGQCc+s0Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 196D63809A08; Sat, 26 Sep 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] idpf: fix kernel-doc parameter descriptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <179038740665.3239957.9582197756741743570.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 01:50:06 +0000
References: <20260925000244.72480-1-ayush37735@gmail.com>
In-Reply-To: <20260925000244.72480-1-ayush37735@gmail.com>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 skhan@linuxfoundation.org, jkoolstra@xs4all.nl, me@brighamcampbell.com,
 linux-kernel-mentees@lists.linux.dev
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 05:32:44 +0530 you wrote:
> Remove stale @vport parameter descriptions from
> 
> idpf_rx_desc_rel_all() and idpf_vport_queue_grp_rel_all().
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] idpf: fix kernel-doc parameter descriptions
    https://git.kernel.org/netdev/net-next/c/014d795c7383

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


