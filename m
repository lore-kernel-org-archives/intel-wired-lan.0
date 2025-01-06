Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5205E77188
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Jan 2025 21:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5197D607B3;
	Mon,  6 Jan 2025 21:50:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iac0ItPiKdpZ; Mon,  6 Jan 2025 21:50:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77D136075F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736200218;
	bh=EDYCcUj7Nd/tkh8V7qSYUkyMy2+vRckr+otIHWBMQa8=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZzNIrVceeDhf0/oZvIYjxd6zXddNaWk++y+byALtU726Jpxb6BJ32T4sI5i1DWV8n
	 m+DsaJf66rIHwSqR3mW6E8TxN3qTifLUYTepvQnkRM+cD00odmJm11HWzH5i+gQKPH
	 5Z9jfFWcf444p+vInMFJesOj0XhdLxZs3DysvnFoXw7DxxdckgchA5leGa8KNZIERI
	 PJ4k+6T1wexLerQn2oH2G7KXyBg7FRxpNGUh1/Xum8Z6wmkNSyLcud74z/Ed95JwXv
	 kPoCFtRR/GB/VsgL1UKLOyT52W4QJQodCzO7JDhU79XRWgfpXx/4MmEAexOOUOJ12M
	 GUzWG4KHuDZpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77D136075F;
	Mon,  6 Jan 2025 21:50:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 596356B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 21:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5489D812D8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 21:50:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0lr2tnOtp10 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Jan 2025 21:50:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7AAB7812C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AAB7812C4
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AAB7812C4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 21:50:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 054895C60C1;
 Mon,  6 Jan 2025 21:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF59BC4CED2;
 Mon,  6 Jan 2025 21:50:13 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 34013380A97E; Mon,  6 Jan 2025 21:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <173620023500.3628195.15413086820847191505.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 21:50:35 +0000
References: <20250102173717.200359-1-linux@treblig.org>
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1736200213;
 bh=fChATgADLibhMK0tTypbOiYL515hkAgGAV38XsG8XPE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PhgvCN6oji6b5XefgbPcNxe3NaPDWT5HUpitUYP5p+07+ITFrb+5lN5rYwB/kigm8
 V9mSoylc7IvqCnpm/q8ZldMVS/1Ls+xah7EkYtvJ6E+rchATP04Fq+cLRs8kjtql+o
 V8qDuNlipAb3D5JX8hO9OmJ4SBNclijiffziTmu6rdlaV4pqdnw9OOJSITfKQCZTGc
 nt0Ve2jb1Dt15ElqYQ25mQN5re7p5Fl4c+lGdWPt0J2oXEKb1a1h75KUM2MyruPE/T
 2skYrGx7pHXkhlFAMWLYK9Nwp8Hf+y0X3upJL4VpDA3NcpxCBGSU3FxYB5ZkuRAJSj
 dQ9DgPNydZ3zw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=PhgvCN6o
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/9] i40e deadcoding
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Jan 2025 17:37:08 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This is a bunch of deadcoding of functions that
> are entirely uncalled in the i40e driver.
> 
>   Build tested only.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] i40e: Deadcode i40e_aq_*
    https://git.kernel.org/netdev/net-next/c/59ec698d01eb
  - [net-next,2/9] i40e: Remove unused i40e_blink_phy_link_led
    https://git.kernel.org/netdev/net-next/c/39cabb01d26d
  - [net-next,3/9] i40e: Remove unused i40e_(read|write)_phy_register
    https://git.kernel.org/netdev/net-next/c/8cc51e28ecce
  - [net-next,4/9] i40e: Deadcode profile code
    https://git.kernel.org/netdev/net-next/c/81d6bb2012e1
  - [net-next,5/9] i40e: Remove unused i40e_get_cur_guaranteed_fd_count
    https://git.kernel.org/netdev/net-next/c/3eb24a9e0af3
  - [net-next,6/9] i40e: Remove unused i40e_del_filter
    https://git.kernel.org/netdev/net-next/c/38dfb07d9a65
  - [net-next,7/9] i40e: Remove unused i40e_commit_partition_bw_setting
    https://git.kernel.org/netdev/net-next/c/a324484ac855
  - [net-next,8/9] i40e: Remove unused i40e_asq_send_command_v2
    https://git.kernel.org/netdev/net-next/c/d424b93f35a6
  - [net-next,9/9] i40e: Remove unused i40e_dcb_hw_get_num_tc
    https://git.kernel.org/netdev/net-next/c/47ea5d4e6f40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


