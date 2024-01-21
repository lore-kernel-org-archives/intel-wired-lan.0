Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B548C47422
	for <intel-wired-lan@archiver.kernel.org>; Sun, 21 Jan 2024 18:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8EF660A63;
	Sun, 21 Jan 2024 18:21:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8EF660A63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705861287;
	bh=0GV1ONzNOUYKbA8cnVTHNgG8GdAXRBpG8Q9e5/OVdsw=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=up7Vtoj77JTky1VPZFTDQLVCTxdrpor8mj8Yzm4QLmVEAKATiIF9nd+4lEu/wCTrE
	 eAmNoZEHjXrfJRHqpUEQsn+/qrKLhbWo4INoiOcYlUh0/jj7wzT+BVK4cnzwFAP0nq
	 UijGXhyBt4pVZrRVnKZd7cxIrdloRPqdpZI/ljY03/jRWnQ2cFaykIsxsjvFW474u7
	 QjF4YcDfEmP/Eyrprytmg4rlosmcZHhccl/q+7AgES4zs3Ea/O7M6tBvMfiAfj3Tzj
	 O2S/FA4TB2awDIjmlf72+sxAs6wlk+rYnFmgh4bndzOjnqS9CumArNZN9zbH1A7Xwp
	 z5vN0J5AbX/hg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v5v15JKBCuoJ; Sun, 21 Jan 2024 18:21:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D40E560B2B;
	Sun, 21 Jan 2024 18:21:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D40E560B2B
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id BC3E81BF427
 for <intel-wired-lan@lists.osuosl.org>; Sun, 21 Jan 2024 18:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9469D60B2B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 21 Jan 2024 18:21:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9469D60B2B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNUgYzS8H3Aw for <intel-wired-lan@lists.osuosl.org>;
 Sun, 21 Jan 2024 18:21:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E07EC60A63
 for <intel-wired-lan@lists.osuosl.org>; Sun, 21 Jan 2024 18:21:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E07EC60A63
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 93E1E60EE2;
 Sun, 21 Jan 2024 18:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4092EC433F1;
 Sun, 21 Jan 2024 18:21:23 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2F804D8C978; Sun, 21 Jan 2024 18:21:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <170586128319.13193.14696779543743835984.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jan 2024 18:21:23 +0000
References: <20240118205040.346632-1-mschmidt@redhat.com>
In-Reply-To: <20240118205040.346632-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1705861283;
 bh=pMjLSdDvZNyvUwDM5dr+/k9ky+gpYkg2n+u1mNpEqVI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=RwbO0iKhyHW8lMiJSNEHidMfMpJax+5THX5OeP721g5YRwFTfCFDTKL6RETn9NYUr
 BKS3lcXfGVLYzeedlDAoVks3tVEVtQycltd5K19VC9kNzsfUP6FpoKZGLsJST9SXL3
 ySjJ/NbmRfCe4NIEKEOY+NQHf+nC1Vd5513TPbUwquK7Lb7LldfIuGt6OSq3ZWIM0F
 grUkH1UEYz6gU/+BbDm38Kk33ihXVEQcUVA5ipuEDciOfXcXbyCbqN2ydMSRclV1M/
 wXUi1TzaDs+CEnnftaGANSixLnEAR4H8jpPmB6U6Qb4Swwq7diaI/Lzi6whB8+dvz3
 OhAkJLvUdTDTQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RwbO0iKh
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: distinguish vports by the
 dev_port attribute
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
Cc: shailendra.bhatnagar@intel.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, pavan.kumar.linga@intel.com,
 anthony.l.nguyen@intel.com, alan.brady@intel.com, sridhar.samudrala@intel.com,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Jan 2024 21:50:40 +0100 you wrote:
> idpf registers multiple netdevs (virtual ports) for one PCI function,
> but it does not provide a way for userspace to distinguish them with
> sysfs attributes. Per Documentation/ABI/testing/sysfs-class-net, it is
> a bug not to set dev_port for independent ports on the same PCI bus,
> device and function.
> 
> Without dev_port set, systemd-udevd's default naming policy attempts
> to assign the same name ("ens2f0") to all four idpf netdevs on my test
> system and obviously fails, leaving three of them with the initial
> eth<N> name.
> 
> [...]

Here is the summary with links:
  - [net] idpf: distinguish vports by the dev_port attribute
    https://git.kernel.org/netdev/net/c/359724fa3ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


