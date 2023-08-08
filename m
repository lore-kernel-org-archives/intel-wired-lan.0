Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A15C001DB
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Aug 2023 22:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6F4082127;
	Tue,  8 Aug 2023 22:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6F4082127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691532032;
	bh=x1POtZoC/MsoWcAHSP0xaEUy09UFrZ8xiqP2T8vUYkc=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xurP89U/4kslJ4cinV+7edUO4Wf5Pyyhx2Z5IpzYAaac76mZudJD70+cPwaTIavDK
	 GtOd5RfD1Z4KWWVdp8MIw+KGl78nLYMscLSpPo0SyVXxuGsYj5X3jH3pqn5RUrOHAg
	 CPgVewUPXF/aWXAjDDFmkT4lUTA4LwUI3kOsd16Y1cWfG4vgdG8mQEJV+3OtZf6s2b
	 IDjAdbq91EfYnB8s2SROzgsEfyh8dbWvRFcNpbsTFMm3hmyyBszTsLkWaFZoCn4K5p
	 cbJWS5U4/gPCX9TaTWGi9u8G+fYi3qX39Um74+sZ4s4+UVyeW94LbBDpeEdHp7vDIl
	 N3vgqn4EiXAVQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3_DLy0rWVD_f; Tue,  8 Aug 2023 22:00:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2D2C82110;
	Tue,  8 Aug 2023 22:00:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2D2C82110
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 82C161BF966
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 22:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58A42611A3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 22:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58A42611A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FTI1uau0JGGv for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Aug 2023 22:00:24 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A2C060FAB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 22:00:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A2C060FAB
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3489062DA4;
 Tue,  8 Aug 2023 22:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93BCCC433C8;
 Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 7D8AEE270C1; Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169153202250.6931.1664624518645907875.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:00:22 +0000
References: <20230804125525.20244-1-yuehaibing@huawei.com>
In-Reply-To: <20230804125525.20244-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1691532022;
 bh=/ectyVaXd9Zis7G/opRD/OZEU4xVFxCrxvK+dcca9K4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=hKcYuR6iuskB/rAYjPA6l3fgF3f+BjYY6ckcEg+oAsfaFhmHeMJTLVH7viogcBQvU
 cQZ4Rj/+b8/Bcjp8A7bXprcZHdy8C3BRE4dvH4oAp+VTmqeM9MPL8c4I+Hj2m5lwEi
 dmvsHAd7FBKu9YYMCNW2sqVt7awYxSzXR7Cku9zrhiwCXQ35wYt3q0D2jwAV8hwuVW
 fuh+rRZO1T/y/ZQ6zBHL+53lTUYjgx29sUzyQ7HdSHlWvmJo/OSfHC2Q2IVt6VQW3B
 PuQElRescXWKziFaD75pdlJGrFJNFVOQ4ug6xHzwMbbKjUnQcDrkYP2gGQnsrhLImM
 Oda7mXNjNdjsQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hKcYuR6i
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: Remove unused function
 declarations
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 edumazet@google.com, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Aug 2023 20:55:25 +0800 you wrote:
> Commit f62b5060d670 ("i40e: fix mac address checking") left behind
> i40e_validate_mac_addr() declaration.
> Also the other declarations are declared but never implemented in
> commit 56a62fc86895 ("i40e: init code and hardware support").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] i40e: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/2359fd0b8b1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
