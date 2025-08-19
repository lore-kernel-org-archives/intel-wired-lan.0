Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2AACA0EF5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 19 Aug 2025 01:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 975CB807A0;
	Tue, 19 Aug 2025 01:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AEGUqgl5LBSc; Tue, 19 Aug 2025 01:00:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2FB8807BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1755565213;
	bh=M5EH3786I0X7Y+Pm0jgAUYf/BJhNycPnHDfiHTkqu+c=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lg+IAlYAZfuoMUL86EG9XxF0xHoMxgOJ2Tj4Lr6h2P4/bv5QPtQYiz9JHDN7WkbD2
	 6aAJWhY1wl1sT0+G3yuikchFOtkVadt0A1SfGQ8C2Doj5noHRVjZeqWsqnpB7vK/QV
	 CWYBWvpMbmPYslHbtl8YqSamPmMsQtzKxaKB9UP7TwTpmITbWCCzgqxjhG6tNCcR0u
	 testEczQGYEuF3S6l8F/PYxFu/oTIPxw51bDDmpP/kpWpbeTCaZ0LcGboB/QdJEDbL
	 fG115ldM5VEERyoIdJ6QYPk0MKtTiNXOZCmzOqvcLXJKbCUSw4gtQALqqxFN1DxSft
	 uTMTjM3Mu9I4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2FB8807BE;
	Tue, 19 Aug 2025 01:00:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73BC4E0A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Aug 2025 01:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59E8E4008C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Aug 2025 01:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9-FF9WABCbJ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 19 Aug 2025 01:00:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7BC42403E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BC42403E6
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BC42403E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Aug 2025 01:00:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 88CBE46083;
 Tue, 19 Aug 2025 01:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CB7C4CEEB;
 Tue, 19 Aug 2025 01:00:10 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADFE6383BF4E; Tue, 19 Aug 2025 01:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <175556522029.2966773.8890220490164839233.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 01:00:20 +0000
References: <20250816090659.117699-1-rongqianfeng@vivo.com>
In-Reply-To: <20250816090659.117699-1-rongqianfeng@vivo.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oss-drivers@corigine.com, bpf@vger.kernel.org
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1755565210;
 bh=3/EqCP9BMz1mop7oC6jXP4NN8+Nr+7g8yHxkv925huE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=uyhjr72A1AjxlODW8N2te3G29SBWvFomyEE/XD9uPJom5bfLfUQRtlr1XDrycvVLW
 2NwHGHx3NhXOFl5e4xEIFwmwJp/SdC3dJZ8Ezt5YpLZpk8K2POVE25nEPRwALyn7gS
 I8DzXuCeJVsboZr0iS0R9PeOJyedBrBfMC2OFM3Gir0RT+TrYWuqXB9X/WiWIzxxlY
 Wk7snQe+Ft4QbT2X43utTGGjsOC85SWm2PikIFU3jaRCqR7foEdYS6nNIVlQaPyyRP
 9MH8CAdTNbg8elBfStILQff9r3MRqWnUno67acML7/guY6ZyGrRfdl4ePN1U1gw8u3
 3uMDrVxjSA0Xg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uyhjr72A
Subject: Re: [Intel-wired-lan] [PATCH v3 0/3] net: use vmalloc_array() to
 simplify code
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

On Sat, 16 Aug 2025 17:06:51 +0800 you wrote:
> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> simplify the code and maintain consistency with existing kmalloc_array()
> usage.
> 
> vmalloc_array() is also optimized better, resulting in less instructions
> being used [1].
> 
> [...]

Here is the summary with links:
  - [v3,1/3] eth: intel: use vmalloc_array() to simplify code
    https://git.kernel.org/netdev/net-next/c/4490d075c2d9
  - [v3,2/3] nfp: flower: use vmalloc_array() to simplify code
    https://git.kernel.org/netdev/net-next/c/fce214586f99
  - [v3,3/3] ppp: use vmalloc_array() to simplify code
    https://git.kernel.org/netdev/net-next/c/dad3280591ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


