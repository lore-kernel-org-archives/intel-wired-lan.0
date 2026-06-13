Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD43CD98CF
	for <intel-wired-lan@archiver.kernel.org>; Sat, 13 Jun 2026 20:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EDB040411;
	Sat, 13 Jun 2026 20:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVBMIYi6YSm7; Sat, 13 Jun 2026 20:41:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C03A540521
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781383262;
	bh=7KvCpdXomycTSlNZCr6JrFjKv4URbtC8VTq1VyYP0YE=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ol3IsWNvOqWj1kWXbuhky8lYXvXexw6VlBcpIcfqM7twL0hv4RX85Gu1kopb3sxiR
	 TdSRaAj3DXMO87BdCYLMsyMJq04uQ31dJZ5TjYIiepoHGiDQJNd8QCJQcrTmaq7WCQ
	 WesD8vNMwcan32ew7e8LsJM+CAB/HlCKVQJ726zW7gnbtqQiiEWJlKXjLwTK8vJ9WE
	 3YRJJS+wB2zHRKW8MyTxxGU0975bAiR9EaoEtMxd++/JqweegZHIoMJC4GPDS7lxvV
	 0mkHjWjweW8Ut4KEI1ru9I4kV8HgSAAZ8UHCrkQEXGky6FEe/e/cdKuLXLnHHWyL9R
	 NmcQ3tE2Rloqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C03A540521;
	Sat, 13 Jun 2026 20:41:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DCC3DDE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 20:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DACBF80DC1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 20:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OsnjWojGgW1w for <intel-wired-lan@lists.osuosl.org>;
 Sat, 13 Jun 2026 20:41:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F345080D88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F345080D88
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F345080D88
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 20:41:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A7A8400CC;
 Sat, 13 Jun 2026 20:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9601F000E9;
 Sat, 13 Jun 2026 20:40:59 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 568F83A54A32; Sat, 13 Jun 2026 20:40:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <178138325589.1587607.11012960354687352250.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 20:40:55 +0000
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
In-Reply-To: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
To: Nitka@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
 Grzegorz <grzegorz.nitka@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1781383260;
 bh=7KvCpdXomycTSlNZCr6JrFjKv4URbtC8VTq1VyYP0YE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=ZZU1Vs6Wq2VR+A+giCsV4fvBNE98FEYmqEOamQGIwgpPERz0TMofOQerE/OuCuKnh
 xpfqEZ9Cz77qb55Z5sPYA3I6vslXBt5hGTse1aiX5GN+E5yTLFPMSCAaggpqZxHwKE
 JEsD96247qq7K45+qtHvVCOpI9Yjf9vsfjR06HmT8dt8U9k/ESR8KlcTMfS/N2HtWS
 DDgpWaV1dDUuSj/Oqc+aU9ovSU8P7YSQ5FDttiabSWux/YVR+Kagn3rA2iDCNjwoyQ
 7sNFrdb9zlbm2LYvPXd+vnun4YcbAYcz9IZ2KnVxRBxF0Sk6SdG2r6Xxn0GFXyzdiz
 YVaBWpmB9zLdg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZZU1Vs6W
Subject: Re: [Intel-wired-lan] [PATCH v14 net-next 00/13] dpll/ice: Add
 generic DPLL type and full TX reference clock control for E825
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
Cc: ivecera@redhat.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 jiri@resnulli.us, edumazet@google.com, netdev@vger.kernel.org,
 richardcochran@gmail.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Prathosh.Satish@microchip.com, andrew+netdev@lunn.ch,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Jun 2026 20:30:32 +0200 you wrote:
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].
> 
> This series adds TX reference clock support for E825 devices and exposes
> TX clock selection and synchronization status via the Linux DPLL
> subsystem.
> 
> [...]

Here is the summary with links:
  - [v14,net-next,01/13] dpll: add generic DPLL type
    https://git.kernel.org/netdev/net-next/c/9375487c0c78
  - [v14,net-next,02/13] dpll: allow registering FW-identified pin with a different DPLL
    https://git.kernel.org/netdev/net-next/c/c191b319f208
  - [v14,net-next,03/13] dpll: fix stale iteration in dpll_pin_on_pin_unregister()
    https://git.kernel.org/netdev/net-next/c/32239d600236
  - [v14,net-next,04/13] dpll: send delete notification before unregister in on-pin rollback
    https://git.kernel.org/netdev/net-next/c/e83b403eb142
  - [v14,net-next,05/13] dpll: emit per-dpll delete notifications in dpll_pin_on_pin_unregister()
    https://git.kernel.org/netdev/net-next/c/df0ba51ccf87
  - [v14,net-next,06/13] dpll: guard sync-pair removal on full pin unregister
    https://git.kernel.org/netdev/net-next/c/0a5c720a7d57
  - [v14,net-next,07/13] dpll: balance create/delete notifications in __dpll_pin_(un)register
    https://git.kernel.org/netdev/net-next/c/1a2292101c0d
  - [v14,net-next,08/13] dpll: extend pin notifier with notification source ID
    https://git.kernel.org/netdev/net-next/c/0bf47f722fa9
  - [v14,net-next,09/13] dpll: allow fwnode pins to attempt state change without capability bit
    https://git.kernel.org/netdev/net-next/c/521b6d5de08d
  - [v14,net-next,10/13] ice: introduce TXC DPLL device and TX ref clock pin framework for E825
    https://git.kernel.org/netdev/net-next/c/5db36ee62849
  - [v14,net-next,11/13] ice: implement CPI support for E825C
    https://git.kernel.org/netdev/net-next/c/fff4ed70ca9b
  - [v14,net-next,12/13] ice: add Tx reference clock index handling to AN restart command
    https://git.kernel.org/netdev/net-next/c/4128bda8fc1d
  - [v14,net-next,13/13] ice: implement E825 TX ref clock control and TXC hardware sync status
    https://git.kernel.org/netdev/net-next/c/e075d7768386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


