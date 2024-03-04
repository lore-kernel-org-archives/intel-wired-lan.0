Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE3C5478C
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 Mar 2024 10:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC8E440396;
	Mon,  4 Mar 2024 10:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YL7NcdLbU9w8; Mon,  4 Mar 2024 10:10:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C812B40523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709547032;
	bh=4WYPSVTomF8U/R10+NN6mnOKsFOciHyNpUg0gjuKtWs=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8bLRZNH/3D030trRw2oVkxB6JgWhmm2TaW0vK/5X3b2H/cbOcW3xlGyalOfIieUz0
	 ax1Gmwv1lz9WL2/3sVTmX/kzE2Cvep6lArjwDqUgI6nOZXouYO4Ce8746BBGoZMPlO
	 WTGOBDqpgFQYrW9w5ibHSxyikwQxvPzI9HXkoy7cqSpCctIvQYn7m+XW22pT595T1O
	 F7eso/ETKV1PGsnL76WmbrFc6Lt7pafiu7AB0uzTn2bDCr2b+hszEZrG3mj7R4Clil
	 2UUHprePGVg+OJhlUWB5re8A6qjdo/gW7IVvGC6Xfh5b6U1JDTpdM3PxYzWAjdOEwz
	 G8C5wh1PusjIg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C812B40523;
	Mon,  4 Mar 2024 10:10:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 4813D1BF2A7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Mar 2024 10:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4158840768
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Mar 2024 10:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0bsp-mNnd3AC for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 Mar 2024 10:10:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 02A4940746
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02A4940746
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02A4940746
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Mar 2024 10:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C945A60E33;
 Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE62C43390;
 Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 1D827D9A4B9; Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <170954702811.29163.12079126596096428666.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 10:10:28 +0000
References: <20240301070255.3108375-1-kuba@kernel.org>
In-Reply-To: <20240301070255.3108375-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1709547028;
 bh=hk8TGQMRtTxgPeCH1vivDUlZ1M0h4KszU+p66HNbbxY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=mjy3A1JQ/CbvmRbtI13eEjVrGfvoI1hUnH0rBUKvxIQbLeV2lhzXCyshWdhvtbz3W
 l27nqqaTQmAgkQHeFmLVNZxPBlWnX5arwEgod4/FMCurXh/6lKcIO1I9/yzccwKago
 9zTTVAt0GQ4THuLBKfvAMUWAjbhhvm0ypiJLwlowsvOgv1cNOcBUBdQ5rrjLVzQl6H
 Y8wiZqI1JzRKb9RPEMN1AI3iO3852ywVS1uIdZ0ha//7pjlbvK6giLDDDECMdy/7LX
 dw9RFxTXBQ+qg0BntHZTTRIwcf6q1hKBizFheLkyRW+LDkL41cleRTiTyAigbkE0Wa
 v3S9nj5p38Kgw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mjy3A1JQ
Subject: Re: [Intel-wired-lan] [PATCH net-next] eth: igc: remove unused
 embedded struct net_device
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
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 23:02:55 -0800 you wrote:
> struct net_device poll_dev in struct igc_q_vector was added
> in one of the initial commits, but never used.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jesse.brandeburg@intel.com
> CC: anthony.l.nguyen@intel.com
> 
> [...]

Here is the summary with links:
  - [net-next] eth: igc: remove unused embedded struct net_device
    https://git.kernel.org/netdev/net-next/c/c2a22688c931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


