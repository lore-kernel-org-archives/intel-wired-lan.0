Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6960C4828F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Feb 2024 17:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7862883BD3;
	Wed,  7 Feb 2024 17:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3nlowYlTxP8U; Wed,  7 Feb 2024 17:50:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94D4983BDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707328236;
	bh=S1Gysjg4KyiJWgQMcBFBP2LDaAQ0lRmYpgPBLpGPK+k=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=L58OBh8MxdQgOMPLPZlbrholgt+Kj+8PjRMOvs/kdlBuHaWkfSNVUQon4RShqnJF1
	 q746M9KdjsTF2kVWrykaAfobE3w/ncNNavPmC1uGTr+0Ev9Wqw84iG8bqjeeMvF8ye
	 vnLBZ9WsMzsQBJdoBJNOsLkC4kZPeetm61ptTx+E6chgCUJVrHVWtlct3jt0iwwBE6
	 1veDdFPqE+QghRbLyEcWVewl6H1ZUPzeqg8GcGfkNtxjebYsOYJ5YeWpiQTr3S7vX8
	 6DpMea+yWYz3i3jdp7dRx0Fi/OX0s6cKb++EbGSTVsmrvdU4GMEWBopRxkklq/lTPB
	 YAXf1SfO26prA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94D4983BDA;
	Wed,  7 Feb 2024 17:50:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A78D81BF868
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Feb 2024 17:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9311583BDA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Feb 2024 17:50:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WqYNB-REXiLu for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Feb 2024 17:50:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A139E83BD3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A139E83BD3
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A139E83BD3
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Feb 2024 17:50:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 65E55617DB;
 Wed,  7 Feb 2024 17:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0749CC433F1;
 Wed,  7 Feb 2024 17:50:32 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E55AAD8C96F; Wed,  7 Feb 2024 17:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <170732823192.3503.5684754555089844535.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 17:50:31 +0000
References: <20240206022906.2194214-1-jesse.brandeburg@intel.com>
In-Reply-To: <20240206022906.2194214-1-jesse.brandeburg@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1707328232;
 bh=7eNeFJx9fu3HeVGO7sMld6c2F5KIY9EmjAc86hsUYLo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=NhFHD4k198OhWThXBYOyswAKv+ZIcyiq4S9Pi9AXV1zc1CJAPqrazJFR10x/xCz6A
 I4fE9YaUziSN9jxMc9WlaOpUFoPZkto4rE4CykHad5FV8lgNmgbekNiRsyly5YfPIE
 65VQRNMSgeODCu1doAL6u0AUTE+ilAZBqVqpZYuycLU0OxEPjUSOtWxsiVBH9ByIqX
 2zNWPshTOAICmo7FChItAcn/F51AFKX05zCryWTyL23La3ldK72xgepnKBfLpWkyp7
 DmKmtY4ywjZBubcl8Roe9GyzCN+lUOtdnxeNGPaxKvVlJwnbKj8Wtbi2FhLPlaOgFB
 rkwhSk2Ocxw1Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NhFHD4k1
Subject: Re: [Intel-wired-lan] [PATCH net v1] net: intel: fix old compiler
 regressions
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 18:29:06 -0800 you wrote:
> The kernel build regressions/improvements email contained a couple of
> issues with old compilers (in fact all the reports were on different
> architectures, but all gcc 5.5) and the FIELD_PREP() and FIELD_GET()
> conversions. They're all because an integer #define that should have
> been declared as unsigned, was shifted to the point that it could set
> the sign bit.
> 
> [...]

Here is the summary with links:
  - [net,v1] net: intel: fix old compiler regressions
    https://git.kernel.org/netdev/net/c/75428f537d7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


