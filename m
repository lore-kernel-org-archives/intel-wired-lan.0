Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E280EC52D7C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Aug 2024 00:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F39C608AD;
	Thu, 22 Aug 2024 00:40:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFvVezNFewvp; Thu, 22 Aug 2024 00:40:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99A87608A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724287243;
	bh=akNVn9ch2TW6t1kBwwkMVtUU6x2KQ61U491c5JtIEO8=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PvYhcE9MOkuV3hIJ8FGs2CZUNCoYLjHxyct7ibQn0bw5eCfiIfif/QEqy877/Fxf7
	 u0EF07ta8rROXM5oEn77RUJt5u8he+ShV3GdaMh9KdyG6qwydY2zPry4Bltg3dkm/F
	 IqQD5ICEx1GnguAsoAGTR1+/YtRBFzRpewVpqZFXCwVxiZUUr+2Yz66zHRtWhHhL0t
	 me3iowe4L/NpgfdBK9jk5XXfRVzWXfGGnngwEC8McS3IAvKHr2kHdIXirdbHoUEU4x
	 oWee1YafPlNpYLhQHLB9Avd4H5L0XsrhpAZZtgL0SCfX2Z0ZULR8bU2mGuOp6XUbg1
	 NgmWlwTPYaDtA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99A87608A3;
	Thu, 22 Aug 2024 00:40:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 28F301BF3A6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 00:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22644608A3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 00:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QArxRtJ_t8A8 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Aug 2024 00:40:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 162716086C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 162716086C
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 162716086C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 00:40:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CB3AE611D6;
 Thu, 22 Aug 2024 00:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977F6C32782;
 Thu, 22 Aug 2024 00:40:39 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70E303804CAB; Thu, 22 Aug 2024 00:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <172428723899.1872412.15704401811722513523.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:40:38 +0000
References: <ddc231a8-89c1-4ff4-8704-9198bcb41f8d@stanley.mountain>
In-Reply-To: <ddc231a8-89c1-4ff4-8704-9198bcb41f8d@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1724287239;
 bh=b7nUoUlvVoGjFMH8+Uiil1I9wpRRS3dQOPm1lZtrews=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=fJOYzkF6UhEYzPqWyAMtc92qi8xEjU+8pzsZ23VfzMA/zIxAoErM7QgGS4NJYBAVZ
 FrTOmW4cwabqjemEQ4UtlrF3pPG7oT/FqYqkDBefRkatByooVhl5ZAtkKkLgAEGL30
 sfDvpE5qlr1G2IQ6k/b80G3Ekyse523RHmjo2yH0VxiDEpNF8kvLX3k42qXlq//F3y
 yisPzPfFr6/+wklKW8RddBw9+EHVj2q9bauyJYV4DgqmtWdcvkU3J8a4p/tmG0CSwd
 zW/K9etD5ud9+66uYd2SmH2CM7QOzQj0Q60SbwuYJQ/GMk9JGQkx2lKhVZJxsZuGzS
 RbxysRyc2RoBw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fJOYzkF6
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Fix a 32bit bug
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
Cc: przemyslaw.kitszel@intel.com, qi.z.zhang@intel.com,
 kernel-janitors@vger.kernel.org, ahmed.zaki@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com,
 marcin.szycik@linux.intel.com, anthony.l.nguyen@intel.com, kuba@kernel.org,
 junfeng.guo@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 16:43:46 +0300 you wrote:
> BIT() is unsigned long but ->pu.flg_msk and ->pu.flg_val are u64 type.
> On 32 bit systems, unsigned long is a u32 and the mismatch between u32
> and u64 will break things for the high 32 bits.
> 
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] ice: Fix a 32bit bug
    https://git.kernel.org/netdev/net-next/c/0ce054f2b891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


