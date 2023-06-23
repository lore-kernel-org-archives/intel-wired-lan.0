Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EF7EB64DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Jun 2023 03:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 647E060AEE;
	Fri, 23 Jun 2023 03:00:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 647E060AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687489227;
	bh=puCQ2GWfTSJMNCylhipkCCml75POCOUCa5WYUZSSCT0=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=rEy4aSO+XKOHHqzNVPZtL8PGZDGkNuk6QgxdM63ylw2K6Ei28IIq6CvEeJjHdfs+2
	 XgYzW0dtFGOkpNCPjx4CGCekvkDJexHXFHrz1MCOUmxjNzNd5CrbkfYfgrEsQcq0AY
	 Ym4WKUVXW0nfAsQaGL4ypXkEer7mfGTTN9MMKj2puqXImf/bb0p2zEBxVa4y9TXeZS
	 CSPw3i31BROw0YNMSq3fMkUCMnx2ljJ8besKobN/vjyyW5pGQD+UELGnWSBCFBRjzp
	 epIrp269YGdF/Xy/IcdhuBSoomJ8Tx7N9O0q1c5zGWPYsKvoV5TG7oqMthiEHhJB/D
	 yFSEX4hfv6Fug==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UzhZnGsOxWfT; Fri, 23 Jun 2023 03:00:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 781C860AF4;
	Fri, 23 Jun 2023 03:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 781C860AF4
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 4698F1BF966
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jun 2023 03:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A7E941B31
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jun 2023 03:00:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A7E941B31
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C6olrJgF2aB8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Jun 2023 03:00:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24C164194C
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24C164194C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jun 2023 03:00:23 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F2D1461952;
 Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E82BC433C8;
 Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 287CFC691EE; Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748922216.4682.2341542021335233510.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:00:22 +0000
References: <20230621132106.991342-1-piotrx.gardocki@intel.com>
In-Reply-To: <20230621132106.991342-1-piotrx.gardocki@intel.com>
To: Piotr Gardocki <piotrx.gardocki@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1687489222;
 bh=0JkyIVBnd41yhwJ/QEUIjTSJ0oWR6KC7ItefkDu2r3A=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=bZatUw6p6nM0F29QVi33QAm/t9MCDfEBTFLCtmqgQwmDX1V85gH+Rv54b0SMUgV2G
 EOYqMWieu/zVImYPDC3ntfypAcTazTHiDZUa7/LpzfL9q5ucvJnbA7NjXI7G6Hsou0
 pjI3IfN+iriNTak9XF67ICIYPiTY/aTYj3tNfw7PSNF89vsIr9AXAKanzH0cyCaSRW
 +ZtgkD3JfCOzd3qXiJ2uRynE04fDfeYvSKwvA1gtmRawZONtrTK5dOo8j33ZhLg0PR
 sEjoUuvt2JhhzqUnBR6SNl5l99ULNJXX/WvPPI8uMnIlOHLEbV23KIkXTgZ9KiOFTm
 nhxC6UiPRuMwg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bZatUw6p
Subject: Re: [Intel-wired-lan] [PATCH net-next] net: fix net device address
 assign type
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org, gal@nvidia.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 simon.horman@corigine.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 15:21:06 +0200 you wrote:
> Commit ad72c4a06acc introduced optimization to return from function
> quickly if the MAC address is not changing at all. It was reported
> that such change causes dev->addr_assign_type to not change
> to NET_ADDR_SET from _PERM or _RANDOM.
> Restore the old behavior and skip only call to ndo_set_mac_address.
> 
> Fixes: ad72c4a06acc ("net: add check for current MAC address in dev_set_mac_address")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fix net device address assign type
    https://git.kernel.org/netdev/net-next/c/0ec92a8f56ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
