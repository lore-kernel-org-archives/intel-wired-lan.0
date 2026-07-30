Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53572C55162
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 11:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E818680F66;
	Thu, 30 Jul 2026 11:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1A22FU-XvST5; Thu, 30 Jul 2026 11:10:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1054F80F5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785409851;
	bh=AJkDsS9HNsZ4JT0gnehBL3CTCqFSrq9Jq+kMQzKKmTE=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8Tq7ykOWFMQuW6C7cWmPRi6UyzU2TJroRp5nKavDC17X92NQtgx703jYwhC2Eg93r
	 Y6+tB26Qg62R7L2/LUc6lRXyaCCe3mnBxCJPTydNCcjqgHLI67bxuQelHa3ABUTKII
	 redaEl1va5/yWRrwhe9sMwbaMNXjvs7a7HA60V6D9AP/xyrKjV8Rkdym2W60jEOkbJ
	 CsnpyDGJOhnue/biSE+EHGZSchr1hHxut7HVjWbR8BCK6gmH9v9dZwe/XAynB5Kha1
	 rNxDRCZSGr3TngD1UvpUacNnvXD5+CKPSyJBkHD2GmTuItn66bBIYytZJYVLAKGMl8
	 6128VMnfPJhsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1054F80F5E;
	Thu, 30 Jul 2026 11:10:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C10226E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 11:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4267980F5E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 11:10:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UbpGtDCuo7-F for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 11:10:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 614B780F58
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 614B780F58
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 614B780F58
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 11:10:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90CD54006C;
 Thu, 30 Jul 2026 11:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7C61F000E9;
 Thu, 30 Jul 2026 11:10:48 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 563153811979; Thu, 30 Jul 2026 11:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <178540981214.3511446.3496334936444624926.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 11:10:12 +0000
References: <20260725150852.859188-1-ekffu200098@gmail.com>
In-Reply-To: <20260725150852.859188-1-ekffu200098@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: kuba@kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 arkadiusz.kubalewski@intel.com, akiyano@amazon.com,
 arun.ramadoss@microchip.com, claudiu.manoil@nxp.com, darinzon@amazon.com,
 davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
 ioana.ciornei@nxp.com, ivecera@redhat.com, jiri@resnulli.us,
 kory.maincent@bootlin.com, manishc@marvell.com,
 niklas.soderlund@ragnatech.se, o.rempel@pengutronix.de, pabeni@redhat.com,
 Prathosh.Satish@microchip.com, przemyslaw.kitszel@intel.com,
 rahulv@marvell.com, sd@queasysnail.net, shshaikh@marvell.com,
 sukhdeeps@marvell.com, anthony.l.nguyen@intel.com, vadim.fedorenko@linux.dev, 
 GR-Linux-NIC-Dev@marvell.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, linux@armlinux.org.uk, UNGLinuxDriver@microchip.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785409848;
 bh=AJkDsS9HNsZ4JT0gnehBL3CTCqFSrq9Jq+kMQzKKmTE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=LeeldTa+Q4MxaLaZPoWUWBF9WJAGZGxlC7NbcwAqwV7ks8PJwFqmvIEoxh7Xt0ZBS
 Pwn4YfOH77hWo1nbUWpf9B91059YNCseSvbdfJ4ZTERvLYIkt9g66ZloFQlrDPt5WW
 TzTaI1VWVpWAFHDofV7fE1eLtjB9KL5DsB9yS4eO9LHzC62zZjyJ50igJXnXTrfAEc
 jXiQUNVGVAJ14tzuE1DqyjseubynEXL8BjOw9mrXV84XVbKGVlEHSQapvt6Ws32Ndq
 IyByS/6C+zMMhx1V3oZ+shnoo3ObCNLzBvBtca8DejSgm8eSPiOmdMMOU2IeRZ+xWF
 7mZJ6MVwhbtjg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LeeldTa+
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 0/4] net: remove
 conditional returns with no effect
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

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 Jul 2026 00:08:48 +0900 you wrote:
> Hello,
> 
> This series removes conditional returns where both branches return
> the same value, so the check has no effect. As suggested by Jakub, the
> netdev patches of the treewide v1 series [1] are posted separately.
> 
> All patches are generated by the Coccinelle script, which you can
> find in v1.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] dpll: zl3073x: remove conditional return with no effect
    https://git.kernel.org/netdev/net-next/c/87579b8cda9e
  - [net-next,v2,2/4] net: ethernet: remove conditional return with no effect
    https://git.kernel.org/netdev/net-next/c/66084e9510a9
  - [net-next,v2,3/4] net: remove conditional return with no effect
    https://git.kernel.org/netdev/net-next/c/cd833378bafa
  - [net-next,v2,4/4] net: intel: remove conditional return with no effect
    https://git.kernel.org/netdev/net-next/c/1f35011c281a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


