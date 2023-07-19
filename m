Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499E5EB64DC
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Jul 2023 02:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD35540106;
	Wed, 19 Jul 2023 02:19:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD35540106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689733198;
	bh=MM1HRgxNOMkHMPC0Wei3rHG+FPd09hjaNGUJjClycHs=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jQtfUJX25YnRbksHCyRQrtZeN0htyIXLpxpYUhniuzAwzcr1++Yp+HGqtv6/zYfLT
	 MASpgt2fkvThLNUx99qPXDNSYhivxZEJq7EygeQ9zMFev/Q//i6B178t1N+KmjKYxu
	 sUkb1S+RWVMEKCrQjypalxud7Vk5kAGDuXlTqqQHov2v58vNYu0HcTRgok9gQivtVG
	 SUJCqMbgsdB+MTYsQg6ijgAKP4acYwJYD3g6rhKzWa59iNPKug9qlffvtOiwkbPC3y
	 lM+VF3QOX9LSvPBYAdJDnNVcBCJmY+0KCriO7imdH1KW6QqTnYnnlekKpSyH8j3IY5
	 BFa8Irq+ISwxg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNwNdJiU12vj; Wed, 19 Jul 2023 02:19:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D50A6403C6;
	Wed, 19 Jul 2023 02:19:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D50A6403C6
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A71A21BF303
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Jul 2023 02:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A61840360
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Jul 2023 02:19:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A61840360
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27rKBDQIAMSt for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Jul 2023 02:19:55 +0000 (UTC)
X-Greylist: delayed 570 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 19 Jul 2023 02:19:55 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4622740357
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4622740357
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Jul 2023 02:19:55 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AFB2F616DA;
 Wed, 19 Jul 2023 02:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70763C43391;
 Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 44377E22AE5; Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168973262227.24960.1211431370018888838.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 02:10:22 +0000
References: <20230717030937.53818-1-yunchuan@nfschina.com>
In-Reply-To: <20230717030937.53818-1-yunchuan@nfschina.com>
To: yunchuan <yunchuan@nfschina.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1689732622;
 bh=GZrsVklu6wW9LRIDBIigNtrV62SEsXbQ+xxiZOxft5s=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=FIb0s6XXYq/T55KzIt+Av0wBEgHCjwPJAodcts8fRWJ6J1jZQlNGPkMQ1tiKO550I
 xFyhtK8xnKYn/XakGD5CBsTPo0I2nXhjALNanhNdzHENLOUM0ANe3usMv+BTjJtAEt
 vtE0WTDDk5w7gifeqCH4SMDAZp5zfq3WiAu84Rh79RrX8vtSLpWdWR1LR1QkwgbGTa
 pDNfcbZE/UuKWCwUcSnnP0eLPRh6sVJ+/wtlaKRyYke1BW3+M4+Xv0gxDOEU7rdu0W
 GHWh9+Y6WPmZv8dy2n2CsUClZTnhEf85MNfMIVA1uq1IfW8hBv6HzjPO+JtpjWndbD
 Q9KUAIcKtF3fQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=FIb0s6XX
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 0/9] Remove unnecessary
 (void*) conversions
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
Cc: andrew@lunn.ch, irusskikh@marvell.com, kernel-janitors@vger.kernel.org,
 jesse.brandeburg@intel.com, edumazet@google.com,
 iyappan@os.amperecomputing.com, anthony.l.nguyen@intel.com,
 quan@os.amperecomputing.com, linux@armlinux.org.uk, xeb@mail.ru,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 yisen.zhuang@huawei.com, wg@grandegger.com, steve.glendinning@shawell.net,
 keyur@os.amperecomputing.com, linux-can@vger.kernel.org,
 mostrows@earthlink.net, mkl@pengutronix.de, salil.mehta@huawei.com,
 GR-Linux-NIC-Dev@marvell.com, uttenthaler@ems-wuensche.com, rmody@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 skalluru@marvell.com, hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 11:09:37 +0800 you wrote:
> Remove (void*) conversions under "drivers/net" directory.
> 
> Changes in v3:
> 	change the author name to my full name "Wu Yunchuan".
> 	improve the commit message to be more clearly.
> 
> Changes in v2:
>         move declarations to be reverse xmas tree.
>         compile it in net and net-next branch.
>         remove some error patches in v1.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/9] net: atlantic: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/f15fbe46f5ed
  - [net-next,v3,2/9] net: ppp: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/89c04d6c49c3
  - [net-next,v3,3/9] net: hns3: remove unnecessary (void*) conversions.
    https://git.kernel.org/netdev/net-next/c/14fbcad00fe5
  - [net-next,v3,4/9] net: hns: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/406eb9cf6f6f
  - [net-next,v3,5/9] ice: remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/c59cc2679acc
  - [net-next,v3,6/9] ethernet: smsc: remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/099090c6effc
  - [net-next,v3,7/9] net: mdio: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/04115debedce
  - [net-next,v3,8/9] can: ems_pci: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/9235e3bcc613
  - [net-next,v3,9/9] net: bna: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/1d5123efdb91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
