Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00449C6FA91
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Sep 2022 01:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6018A41871;
	Thu, 22 Sep 2022 01:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6018A41871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663810223;
	bh=E6QZZCFrMl33sPcHjYQrjz3TKT1P1w/mgSVOXGeJBsA=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=uoUMT7aDWWt+eaMyTh51C/+Sm0KoRgxNYokJ8xL15rR7xOrk0PvTxvnMa613Icxm4
	 +MA7AFnC/K1dSZ6F8A0BBQdQvYDXstvbUrkHPuVpSLKOTEpM/GyRIvq7auJFjDBcqY
	 21nqFTU/tKUQqEMsf2ky4Lhyl+sBZLnG7uPcBT4gQnJlPcihKgJWBtlhokMYDPBbAM
	 8u3exSzXue8yQEKrdt0XU4inE+pWc2d+K+2ucJ8wxumr/z2fqfZsg17arplVYqRDh4
	 al7JTbxLSyZzpMAYusC7w/GEWsy+gb51NFvHrSakVGia527YZKpBeEANFBf2ZLdPEX
	 ivJrWkzAhhDpg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5j9Uj6g7OoAp; Thu, 22 Sep 2022 01:30:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A13641846;
	Thu, 22 Sep 2022 01:30:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A13641846
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 181471BF303
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Sep 2022 01:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E32DE830AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Sep 2022 01:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E32DE830AB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2HEn0a1GNMRJ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Sep 2022 01:30:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA7468308A
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA7468308A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Sep 2022 01:30:19 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3770CB833B4;
 Thu, 22 Sep 2022 01:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE434C433D7;
 Thu, 22 Sep 2022 01:30:14 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 A9E27E4D03C; Thu, 22 Sep 2022 01:30:14 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <166381021469.720.2209811827600029157.git-patchwork-notify@kernel.org>
Date: Thu, 22 Sep 2022 01:30:14 +0000
References: <20220919134346.25030-1-larysa.zaremba@intel.com>
In-Reply-To: <20220919134346.25030-1-larysa.zaremba@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1663810214;
 bh=PKiHL+1DqQCkB+ys4KLzzlaAz9w9/lU1MRTDk1sC9fY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=RIfuOY5jmlVsL7apquAmm7W9DeEH6g6RZqfdvQgTMrH90PIqN7DqPN0Hq13T+3eGh
 qFmh4oIqzWlxhqVg/O04c63WBX8/zAfwN5WOxbRbCG9hOMPpnftUgzdHRwAD/m/0Ns
 aKx/3woY3NMCHwLrkGeud7WxHbgNof5ytDqvqBNweVzBDeMquR5Z4VA3WhUv6axOjo
 DmqQ0IdLAM8kWDDwYoyDuhiSl9W2I9BNeOOVtlz9ajK4EQZVF7oBP+HQKguBzeBxH7
 ouGYgXVBBu+jQx7BOk4xLFTyoWeup0mvBzeCZJaviIAdE1Mx/v2KJP2KdVGzvuWyaa
 SgBztqRwGYdPQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RIfuOY5j
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix ice_xdp_xmit() when XDP
 TX queue number is not sufficient
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
Cc: daniel@iogearbox.net, netdev@vger.kernel.org, ast@kernel.org,
 edumazet@google.com, kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Sep 2022 15:43:46 +0200 you wrote:
> The original patch added the static branch to handle the situation,
> when assigning an XDP TX queue to every CPU is not possible,
> so they have to be shared.
> 
> However, in the XDP transmit handler ice_xdp_xmit(), an error was
> returned in such cases even before static condition was checked,
> thus making queue sharing still impossible.
> 
> [...]

Here is the summary with links:
  - [net] ice: Fix ice_xdp_xmit() when XDP TX queue number is not sufficient
    https://git.kernel.org/netdev/net/c/114f398d48c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
