Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8752DC7EE21
	for <intel-wired-lan@archiver.kernel.org>; Thu, 27 Apr 2023 17:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14E7F83B61;
	Thu, 27 Apr 2023 17:00:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14E7F83B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682614827;
	bh=Yjb7hhm8LZbpOOKI/klJW3o7rIMf1n6KzvRX16bJ/Xk=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XaGS72dOKmgcCC60Sy52U2+KZpMR5CX8m5aeSGISL6VauqnmcbUpPCsKx/rdKOAtt
	 ADNbpFhpnDS9Qtr2ZYTc2F9xb1Xk62/Cg0AMN1w5zSN1bZICVclYEf+6o9jVXVdDVl
	 N5TFeXPz16tNEirTBhiVodH6daQ5cgi86Bf9iodUSsSyNPISGcY0+lWXo+lrkxj1iy
	 kNn2vjQ7a5Wmf82+x9F51DnLrGn+MKa242KTuncGwbsdbS6Wb5kAovFbyyfqnHIznT
	 aywbLIrfyqiMZQyJzk78JEGk5u/pADMEVreF3xlAt+oPIjz0YQrzsfKuFLURucNBol
	 j1TeswD+OTFnA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7orMahLQi54X; Thu, 27 Apr 2023 17:00:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 273A483D0D;
	Thu, 27 Apr 2023 17:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 273A483D0D
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 048B81BF5A1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Apr 2023 17:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF60C40860
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Apr 2023 17:00:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF60C40860
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id STgbvPV0R94n for <intel-wired-lan@lists.osuosl.org>;
 Thu, 27 Apr 2023 17:00:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9EB2407D7
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9EB2407D7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Apr 2023 17:00:23 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 95F2163E82;
 Thu, 27 Apr 2023 17:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC6B6C433D2;
 Thu, 27 Apr 2023 17:00:21 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C4217C43158; Thu, 27 Apr 2023 17:00:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168261482179.5377.8182484249151476104.git-patchwork-notify@kernel.org>
Date: Thu, 27 Apr 2023 17:00:21 +0000
References: <168182460362.616355.14591423386485175723.stgit@firesoul>
In-Reply-To: <168182460362.616355.14591423386485175723.stgit@firesoul>
To: Jesper Dangaard Brouer <brouer@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1682614822;
 bh=JyIySdGEmS2lvqX23RxQJW2WsiscvHOpbSP1ElxnVeI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=o2GYbH6/kS2borua9TpV7kVKhf3Vs/Qco35Yp9Tb3Va5uK4thtS7S+msIJUAgIO7a
 XK3mu8V4/eViWfMYaIu2UxzEXPvi9n3bKS5JoUaaNigdlVmceB55Dd0hdJJunZZlsJ
 DyJyr/ZGCJMBDVb9cMdA4/0O3zA6EnFMSw9bYcN8NadDF/udo/WhkwGmljoZ2ddZWQ
 xvkNqAGNsUDYc1RpNxVGAUTWljyweUX/Rej5PcYK3TXZjzwgVDl9tE4ctReSUajxyP
 7JV5Q5htudH0UMArpNxKG3ZBNOVWcdX6NynftbFkuINAO933rkM5K/3/mxD0c9ggVK
 L2zL8pfayDKSg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=o2GYbH6/
Subject: Re: [Intel-wired-lan] [PATCH bpf-next V2 0/5] XDP-hints: XDP kfunc
 metadata for driver igc
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
Cc: xdp-hints@xdp-project.net, martin.lau@kernel.org, daniel@iogearbox.net,
 larysa.zaremba@intel.com, netdev@vger.kernel.org, toke@redhat.com,
 john.fastabend@gmail.com, ast@kernel.org, jesse.brandeburg@intel.com,
 edumazet@google.com, sdf@google.com, yoong.siang.song@intel.com,
 kuba@kernel.org, intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 pabeni@redhat.com, davem@davemloft.net, hawk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 18 Apr 2023 15:30:37 +0200 you wrote:
> Implement both RX hash and RX timestamp XDP hints kfunc metadata
> for driver igc.
> 
> First patch fix RX hashing for igc in general.
> 
> Last patch change test program xdp_hw_metadata to track more
> timestamps, which helps us correlate the hardware RX timestamp
> with something.
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2,1/5] igc: enable and fix RX hash usage by netstack
    https://git.kernel.org/bpf/bpf-next/c/84214ab4689f
  - [bpf-next,V2,2/5] igc: add igc_xdp_buff wrapper for xdp_buff in driver
    https://git.kernel.org/bpf/bpf-next/c/73b7123de0cf
  - [bpf-next,V2,3/5] igc: add XDP hints kfuncs for RX hash
    https://git.kernel.org/bpf/bpf-next/c/8416814fffa9
  - [bpf-next,V2,4/5] igc: add XDP hints kfuncs for RX timestamp
    https://git.kernel.org/bpf/bpf-next/c/d677266755c6
  - [bpf-next,V2,5/5] selftests/bpf: xdp_hw_metadata track more timestamps
    https://git.kernel.org/bpf/bpf-next/c/bb323478767d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
