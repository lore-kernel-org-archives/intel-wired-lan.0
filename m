Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12ABEC1EBC
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 15:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87ABE81315;
	Thu,  5 Feb 2026 15:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TeCvNd48GrLM; Thu,  5 Feb 2026 15:10:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA468812BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770304222;
	bh=MoRGkBTin9+wOP6e+OvXZBTezNwdyzO3M7EeXB/EIgs=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TxiJYLgwm4TkEtkIMAp4x3hirnjIhdIoL+ni5mn7z/sIKteM95PM3JTJMGArCNPtZ
	 Gkr3zT39IZAVNVhrWy5ObuM4ch9Joh1AfdRWCDVg0BkWU9i47Ym92yuVxczQlO1hPb
	 F1VqX8HsqJLbWKSdCYUNvZfrs/w37XoNldiwptDpSqDQjeMFFbsJs1q2fsI8qakB72
	 SWET/+KXMHyRk1WEA+xu6E2vrUYJIiAYiXSPF8GdmsyOJ0svUlrP3ZmQGVwY3eUvHk
	 cobfObP16IhFi1UDTE2zrSOQEgnSodQkC+mTGWD4BDo50whgk1zu0MZpKZza+LTCXJ
	 Lj8Obl4yUXggw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA468812BF;
	Thu,  5 Feb 2026 15:10:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DB71117
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 15:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DC6F60D9C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 15:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJal2D2HXkt2 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 15:10:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6ACED60D87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6ACED60D87
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6ACED60D87
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 15:10:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 75C7A441BB;
 Thu,  5 Feb 2026 15:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F532C4CEF7;
 Thu,  5 Feb 2026 15:10:19 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 486033808200; Thu,  5 Feb 2026 15:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <177030421708.447604.18321209785815350003.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 15:10:17 +0000
References: <20260203174002.705176-1-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 andrew+netdev@lunn.ch, arkadiusz.kubalewski@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jiri@resnulli.us,
 jonathan.lemon@gmail.com, leon@kernel.org, mbloch@nvidia.com,
 pabeni@redhat.com, Prathosh.Satish@microchip.com,
 przemyslaw.kitszel@intel.com, richardcochran@gmail.com, saeedm@nvidia.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com, vadim.fedorenko@linux.dev,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770304219;
 bh=VeYMHdnKfPv54A8U9mPwiib6zhPfIcEkcUaDZYvk7xQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=bNsEOqd/D0WbPvbvhpNW8Oi8MvEVrx0k7s8eCItOfz3WEHl/YBnrOIyVQoR2TC2fk
 JxS1oPlrwZj5YQREz5cDlRbfUvg2sy7HDDEkOYZJkB/Y8swytDxUsBPTrIG8jSpXJo
 I5ZsWtKcNgv+whp2eVYoGrTXx5NPB8h3j5KVy99Ud9ZMlKRAKOSlQqxQDw2pEdamYh
 5Ol9Ve9ORYMFCjmn5nwo28POQqYswmuP8Bta4LIAGY6UIJVdARqVgDQ/ViIkZv5scD
 4GKt+Ng7ubfci9POrdU72wYksAypsZbJMHZmHeFdnr2sOou1Da3MShZqPsvzGnGB5j
 5Nq7vqDPmp38A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bNsEOqd/
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 0/9] dpll: Core
 improvements and ice E825-C SyncE support
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

On Tue,  3 Feb 2026 18:39:53 +0100 you wrote:
> This series introduces Synchronous Ethernet (SyncE) support for the Intel
> E825-C Ethernet controller. Unlike previous generations where DPLL
> connections were implicitly assumed, the E825-C architecture relies
> on the platform firmware (ACPI) to describe the physical connections
> between the Ethernet controller and external DPLLs (such as the ZL3073x).
> 
> To accommodate this, the series extends the DPLL subsystem to support
> firmware node (fwnode) associations, asynchronous discovery via notifiers,
> and dynamic pin management. Additionally, a significant refactor of
> the DPLL reference counting logic is included to ensure robustness and
> debuggability.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] dpll: Allow associating dpll pin with a firmware node
    https://git.kernel.org/netdev/net-next/c/d0f4771e2bef
  - [net-next,v5,2/9] dpll: zl3073x: Associate pin with fwnode handle
    https://git.kernel.org/netdev/net-next/c/e6dc7727b608
  - [net-next,v5,3/9] dpll: Add notifier chain for dpll events
    https://git.kernel.org/netdev/net-next/c/2be467588d6b
  - [net-next,v5,4/9] dpll: Support dynamic pin index allocation
    https://git.kernel.org/netdev/net-next/c/711696b3e168
  - [net-next,v5,5/9] dpll: zl3073x: Add support for mux pin type
    https://git.kernel.org/netdev/net-next/c/fdad05ed4ec2
  - [net-next,v5,6/9] dpll: Enhance and consolidate reference counting logic
    https://git.kernel.org/netdev/net-next/c/729f5e0153bd
  - [net-next,v5,7/9] dpll: Add reference count tracking support
    https://git.kernel.org/netdev/net-next/c/3c0da1030c58
  - [net-next,v5,8/9] drivers: Add support for DPLL reference count tracking
    https://git.kernel.org/netdev/net-next/c/085ca5d20171
  - [net-next,v5,9/9] ice: dpll: Support E825-C SyncE and dynamic pin discovery
    https://git.kernel.org/netdev/net-next/c/ad1df4f2d591

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


