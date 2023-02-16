Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54667C61DA4
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Feb 2023 03:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA26D81FD4;
	Thu, 16 Feb 2023 03:20:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA26D81FD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676517621;
	bh=vugmlpxrBxaL21L/4Zb207XDXndBwwrjEUewr7r/QWI=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HqSAJiP59qcsTZ2bTpHrRMGX2DA4FpyM+Yd54q9vppuPee9UqM/G/1Yze5Zy7H8KA
	 3cGZNtCswUc7p5Na+PojAjT31vYfRNQ4gQ6/bgS4J2Wo6kURQ6jENPA9ONUtUKJU8A
	 h91DpN3Op/zILfOTB5AhIvV0zZiPokODY09mVynm/wgm1gMm67o6rhwga28xkOroLO
	 kHTeFIqSOgn6SfsDjK6W/yp27enjKRZDpmNTeUBv9Wts0mHFLOf/TbayvDfByUTLwX
	 vEznT5wGy88WzJp/pL0uwpIoyL6+/3XNtM5dwLfqiJm/SPsmr3R7WpEHwD2pZFz6Pd
	 Y7EwbXR84lprw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0j6UmNBBG7pT; Thu, 16 Feb 2023 03:20:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA36081FDE;
	Thu, 16 Feb 2023 03:20:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA36081FDE
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id F3C3C1BF968
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 03:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC6E860BE4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 03:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC6E860BE4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rLrdrh-agX05 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Feb 2023 03:20:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F149A600BA
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F149A600BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 03:20:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3D82561DAB;
 Thu, 16 Feb 2023 03:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 908D5C4339C;
 Thu, 16 Feb 2023 03:20:17 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 78C57E29F41; Thu, 16 Feb 2023 03:20:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167651761749.25163.14521954005933969050.git-patchwork-notify@kernel.org>
Date: Thu, 16 Feb 2023 03:20:17 +0000
References: <8a4781511ab6e3cd280e944eef69158954f1a15f.1676385351.git.lorenzo@kernel.org>
In-Reply-To: <8a4781511ab6e3cd280e944eef69158954f1a15f.1676385351.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1676517617;
 bh=8NHn6VdKmI/xRIUDKwYgIbZ3NyPBK5jc5xiBk/fK0YQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=l4uLC7pb5PmD8rliE0qMqrCPgILviXBnl/Y7u//1esBfQzvBWbqu9GlSuNwzd8tFo
 OAm+VVQjxei6iBqBAi1N37Opc2y3gQSy12xJver+G95gUjQgTH8I9SxZ/TJdvOIsHH
 radNvm9ZwjvGC+ApuFTsJdSyfKlZXWifO9ntdT1QSMGIm9ZpUKa5f1/00NaoN2pGDz
 p72ncjx77djdTTpimkaBpqBiYqIHmwZKHqcjPelD8n2vMBMQUMzlFWUUuQPolF+9qb
 nkcDsOeVnnhy65aDJxI3b2HPcqPvghasLT2FohDwc96r2ZJKmG31ww/1ukn63gCd7X
 DRO3flQhvwVLA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=l4uLC7pb
Subject: Re: [Intel-wired-lan] [PATCH v2 net-next] ice: update xdp_features
 with xdp multi-buff
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
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Feb 2023 15:39:27 +0100 you wrote:
> Now ice driver supports xdp multi-buffer so add it to xdp_features.
> Check vsi type before setting xdp_features flag.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - rebase on top of net-next
> - check vsi type before setting xdp_features flag
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ice: update xdp_features with xdp multi-buff
    https://git.kernel.org/netdev/net-next/c/b6a4103c3538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
