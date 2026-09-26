Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE33C9832A
	for <intel-wired-lan@archiver.kernel.org>; Sat, 26 Sep 2026 01:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C41B40AA3;
	Sat, 26 Sep 2026 01:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BRFv_C8fkdx; Sat, 26 Sep 2026 01:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C046840AA9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790387482;
	b=YUII6ohn2qVBX6sRGFd43o28bFKfEU517+l97RC16aqpZe6mA5JNnMm4e53+H4jfhhbZ
	 k9Oei/OrzMkJsX37/o8qhiMNlZ+eadaHmRCV+fKibYzM9FuqyDQIExSUCgXZ98rOJR9ar
	 iUYfoQD2kdIrYNLD/1MEPL6Af/8NAZj13ji2E9YRxaPrWdvPfnxKRQVUAe+THL+7FCb0X
	 e1EQNX2gITD6l0N5hOCPz0+hc3/wM+lJa2Ohbp10PvtPfKgbgtuN/nHtT5y23CSAhnHLt
	 J8jyBAYEsF6KFAeueBhGcDDWRZhAZYe3rCOcuvRFE1ZSkTytef22JE6Rj4sqvc/Ug1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790387482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=n70V3vdtX6ryAsqYNi13UkyqF4WaKk+bYDJNpQ4nOnM=;
	b=rZ9xAtWFIpqNoJfMz/O0tbKkZBIpAxAPPUMk1GlqKrv45rad9h9z+brcHpdBfpn0oVmL
	 lARV55ecMt1s71KsiZZOfQrPxf9GP8taB9gSVo90fop4Y/gykWLL99HXOACO+Qizi7CG1
	 dwUPvmYMKPp4fxSPqVZYW15Yf/w6AJWOkofjbUsm+SURAmKOOPTiztMIQvyAsejNnZ18m
	 BZRpMJuNnHl2UomwcP7YAO9lKWH1W33sgEwzZ6PqumO5HWNYAXlDBKs+Ylwi1Go9CXLKw
	 gMw97ohIfR4HhwoNjau//5oUCwuYodGX3kQSzxuyFften94rBiIFGkwNjeNp4SaWmHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkWJQp+F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790387482;
	bh=n70V3vdtX6ryAsqYNi13UkyqF4WaKk+bYDJNpQ4nOnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8GQm2FmPNGQ8yOOMsnu1ZYuRvFZkJwkPL6bgvcjcGLhEzhqnajQlsvhK4tugrdcxz
	 4ZyhX5f+SnSQM0KsQ+Ve6I1+LkBPX/DdtpncMca/wHFMSYlJBLlhLTNy+ONjER/qfh
	 HL3vdr0w3gNMVuvbxGAZQaUO4fIHSCa4fqA09HpyDxE9DNseM6QPqfssXu57/gEUJR
	 Wsw6/HpWk7JdwSkCj0W15gzxsoqgKVuFJ8t8Whd45DLA78+CxHUykg+zyhtJHzpUqu
	 HlN6ztVhtrTupyIt0Q9Kqtfl0EUt3qvsX/zyr1OQQhR6IeaaJ1lDF8bLs5p22Qcekb
	 qnrYFhpmhKwNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C046840AA9;
	Sat, 26 Sep 2026 01:51:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC743194
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 01:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E40440AA9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 01:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYcaDluteap4 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 01:51:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BE79B40AA3
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790387481;
 b=JE1X19IEpdAuclsnHiV8kLeynuCfx0CVWhOeBZFx9raQEnuzICgKp7Wnm2MXRw6zVFW/
 iQgbTERy7SQgYa2uUoJJy3+zeExRX2amZadqUwDtKHVLacRLcpadakmjNsJo7Q+RakiF8
 jme5dXIUGYM6I5DnYcVLJGMpvY5nXl5OA7iQ5zaxYLCa94DB2HnqCKou1vWyIUWT/VipL
 dzpqDObjG+bUHUZgcAlw1sSTTv+3Nd1mnERs7iA1Eh+EgNnXcaehmV/US2J2kooyE5uSy
 7WTaySnLsSUed8zVfs/o+ODUYkhEELSnOiyix9mLiCBfK+xoP+RkHiY7dl1+CDX71Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790387481;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Content-Type:
 MIME-Version:Content-Transfer-Encoding:Subject:From:Message-Id:Date:
 References:In-Reply-To:To:Cc;
 bh=n70V3vdtX6ryAsqYNi13UkyqF4WaKk+bYDJNpQ4nOnM=;
 b=qw/aX6cTNG6NVIktQAbdalQFdgnpUPDn+xoxy4GAc8zKjZ/EuW5RG+8uT1qg/Bt0HL/i
 RP3P210fdLxaDNjtuqXBjCJSztwn4ZeK9PJyJT467N1/SkLYWrufx8Y2prntP2v8EQaVD
 FYvUPg6n384ToJr2qfLIpFbx21T+FUoMLNSTbuOFtoEwGMV1EXMQMgcz/CgpcYBdE9FEw
 O6A28DX8NHu2ewyEJnGS75B+t1YxFWzUfdARQbZMxPloQyAUyuF+NyM5oX8Jp1qyfZbQU
 nt7c7CG2mbI72o4R3bYBYmZAvfYNnmWA1gH3FZOfOzgEjxGTcyyBI5v27Rx7iNsX8dQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bkWJQp+F; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bkWJQp+F
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE79B40AA3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 01:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 310BE6022B;
 Sat, 26 Sep 2026 01:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE141F000FF;
 Sat, 26 Sep 2026 01:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790387477;
 bh=n70V3vdtX6ryAsqYNi13UkyqF4WaKk+bYDJNpQ4nOnM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=bkWJQp+FjkW+hC1+S34vjASvOHnKb7rpwr6dU8KWmutF0gKK6/ljnY5pNt1TlxvhK
 XP1vL77Q+4el0ebhWClBzu4us5rp/TWW8LV+w25m1EI3ZHMEoiqqwJzDFdMH0yHcfM
 hGH5GlgVW6t9WVTWpa8vu7oz7vwD+YiA8f54xwwV7g8D0QALsHRXwRBVVf0swY7LJx
 39XwILRrF/9R7gL4gwqaNbrcf3mDQoFoqfHFkrc/gCzLhyMSMtcSpWeFo9IRmvYW7r
 X8aiEtOPOuN22hoc0DBz8M8zey93jWjjMQMFlG78i53pZY5U6OzJCPSXQpQPiOCxD2
 wKVarVTyPUAdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93CCA3809A08; Sat, 26 Sep 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ice: dpll: fix kernel-doc parameter descriptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <179038740515.3239957.17007030778615072789.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 01:50:05 +0000
References: <20260924232138.69492-1-ayush37735@gmail.com>
In-Reply-To: <20260924232138.69492-1-ayush37735@gmail.com>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 skhan@linuxfoundation.org, jkoolstra@xs4all.nl, me@brighamcampbell.com,
 linux-kernel-mentees@lists.linux.dev
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

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 04:51:38 +0530 you wrote:
> Remove stale @count and @cgu parameter descriptions from
> ice_dpll_init_fwnode_pins() and ice_dpll_init_pins_e825().
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - ice: dpll: fix kernel-doc parameter descriptions
    https://git.kernel.org/netdev/net-next/c/a72690652227

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


