Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE34C636CC
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Feb 2023 09:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 549B7400CB;
	Wed,  8 Feb 2023 09:50:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 549B7400CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675849824;
	bh=Ye+uE2GNt62M3zgFgocJ74CcUchh5HwHsG49K9/Hcl4=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=11Rfr0FpgwysgHwPtBaCKxAJ9pgDPD4lv/q2v2IN1ea88hrkb+RGW0KbXQ+fXtnGh
	 GnyMWmT3hdHMABArcowZ3Sui7pdawVCcJBYWH3fN5MoOS1LBPj32z5hSLi23iSKVhx
	 xOwh4LI0iZ441tVXQh7WRR919Xn35ARS5xLcsXaq9XyMXJf46f/dlCmR2iHXLTymCG
	 exXfQuYdDZSKUhw80DIG/scRDkI8PHP67gU457XBAr/cx4O9O49u3j/JDc6qdpfms+
	 gGKCNWWuL1E5yri24RXM4qjC/UO25EOBQYv1Ut4e+IpcUucIHYQrsnFT0X3EjD8/4w
	 Gfmty5pJn8niw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PepY-JmiTu-W; Wed,  8 Feb 2023 09:50:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 171AD402A7;
	Wed,  8 Feb 2023 09:50:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 171AD402A7
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 297E21BF2C6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Feb 2023 09:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0EF15610B1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Feb 2023 09:50:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EF15610B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2_WANfJ-vpFK for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Feb 2023 09:50:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 178C860C0C
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 178C860C0C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Feb 2023 09:50:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F3803615E8;
 Wed,  8 Feb 2023 09:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CEF6C4339B;
 Wed,  8 Feb 2023 09:50:19 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3EF27E4D032; Wed,  8 Feb 2023 09:50:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167584981925.2615.15266963787745673788.git-patchwork-notify@kernel.org>
Date: Wed, 08 Feb 2023 09:50:19 +0000
References: <20230207135440.1482856-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230207135440.1482856-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1675849819;
 bh=cLiPbOJ8zntt3fSqPa689jgruBIOeqFLTn5rcFwFJJA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=m+5QnJSzY7JbT+QW/JcxM0+Lkfwu9rZOkcKacMD02O5xiOKp+7sk56E4ur+Xyl/hd
 ureYbVa+mQYqpcrgu2hYiaQP0C13hETs9JkE6TbwSj89XQrtM/3svD2IVjiZPXSpv3
 ITT+0rT2Y7NStsbpueGxRzx3IfajFiEgeLOq4t70kIMM0+nTAkfcxO4daX7+0tqR5S
 430/cpfUlPBJKmi/YNMFS7CjiV+mdUCd5kCeSNKrLnToCdwXGQqerbjKW/IaPJEcb7
 VHrQwEA+r+ktr5VjFD1MS0ikzi3nUz47eIluGKfwKiBP7/R7p7D+PHQ4MTCQAhIW/X
 bZL3ILqueUaQA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=m+5QnJSz
Subject: Re: [Intel-wired-lan] [PATCH v2 net-next 00/15] taprio automatic
 queueMaxSDU and new TXQ selection procedure
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
Cc: jiri@resnulli.us, netdev@vger.kernel.org, kurt@linutronix.de,
 jhs@mojatatu.com, jesse.brandeburg@intel.com, gerhard@engleder-embedded.com,
 edumazet@google.com, anthony.l.nguyen@intel.com, xiyou.wangcong@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue,  7 Feb 2023 15:54:25 +0200 you wrote:
> This patch set addresses 2 design limitations in the taprio software scheduler:
> 
> 1. Software scheduling fundamentally prioritizes traffic incorrectly,
>    in a way which was inspired from Intel igb/igc drivers and does not
>    follow the inputs user space gives (traffic classes and TC to TXQ
>    mapping). Patch 05/15 handles this, 01/15 - 04/15 are preparations
>    for this work.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/15] net/sched: taprio: delete peek() implementation
    https://git.kernel.org/netdev/net-next/c/ecc0cc98632a
  - [v2,net-next,02/15] net/sched: taprio: continue with other TXQs if one dequeue() failed
    https://git.kernel.org/netdev/net-next/c/1638bbbe4ece
  - [v2,net-next,03/15] net/sched: taprio: refactor one skb dequeue from TXQ to separate function
    https://git.kernel.org/netdev/net-next/c/92f966674f6a
  - [v2,net-next,04/15] net/sched: taprio: avoid calling child->ops->dequeue(child) twice
    https://git.kernel.org/netdev/net-next/c/4c22942734f0
  - [v2,net-next,05/15] net/sched: taprio: give higher priority to higher TCs in software dequeue mode
    https://git.kernel.org/netdev/net-next/c/2f530df76c8c
  - [v2,net-next,06/15] net/sched: taprio: calculate tc gate durations
    https://git.kernel.org/netdev/net-next/c/a306a90c8ffe
  - [v2,net-next,07/15] net/sched: taprio: rename close_time to end_time
    https://git.kernel.org/netdev/net-next/c/e5517551112f
  - [v2,net-next,08/15] net/sched: taprio: calculate budgets per traffic class
    https://git.kernel.org/netdev/net-next/c/d2ad689dec10
  - [v2,net-next,09/15] net/sched: taprio: calculate guard band against actual TC gate close time
    https://git.kernel.org/netdev/net-next/c/a1e6ad30fa19
  - [v2,net-next,10/15] net/sched: make stab available before ops->init() call
    https://git.kernel.org/netdev/net-next/c/1f62879e3632
  - [v2,net-next,11/15] net/sched: taprio: warn about missing size table
    https://git.kernel.org/netdev/net-next/c/a3d91b2c6f6b
  - [v2,net-next,12/15] net/sched: keep the max_frm_len information inside struct sched_gate_list
    https://git.kernel.org/netdev/net-next/c/a878fd46fe43
  - [v2,net-next,13/15] net/sched: taprio: automatically calculate queueMaxSDU based on TC gate durations
    https://git.kernel.org/netdev/net-next/c/fed87cc6718a
  - [v2,net-next,14/15] net/sched: taprio: split segmentation logic from qdisc_enqueue()
    https://git.kernel.org/netdev/net-next/c/2d5e8071c47a
  - [v2,net-next,15/15] net/sched: taprio: don't segment unnecessarily
    https://git.kernel.org/netdev/net-next/c/39b02d6d104a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
