Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17507C79FB7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 01:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1179407E0;
	Thu, 10 Sep 2026 01:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oe650g2zK32H; Thu, 10 Sep 2026 01:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E4F1B407F2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789002082;
	b=iQcEPM4qXxyAYd7a1kWfIZiEi2EBa/8C/u8cFUBBcVp05FMMygkDvvC9qFemfUe3SQ7V
	 6xU4LldPRWJYYT596pXZ3LVwDXPxtZzW5Welr8wRUjEluhGTQGpZ26g2K62WB8VZ+itBF
	 BAkBB9N1w5rfHGjRg+/vYdFuliUup4mtok7BVkpgL2FoO2kbh36ZNX9JaOdjDLnKcxWxF
	 jvBO6MSZDaJMZtrfIAKBEXHjIt4guKUt61voZSWkPCZyVHhUpFDLTaGtL/l2Wca5TTm1r
	 qiauPajYczlY4Yp1Mg9s3e+3iYKzA+/ddhga0LyugpFwcIjzSLOWYjwdwk3Xc6RkyiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789002082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+fWzwz5fSEYA5D9sfwfL0DKKi31jx7ftgDv9A8MbtqA=;
	b=bB5eDgn4PtAP6kMf4bBw2TEIRmpeBEwYAsLf4pr0akKyyIJv+jUqCTVncX7hTmoPYeDT
	 C3h8Om6mwkAD+P13HAU280ivjX7xs44IFT0C+zgbI6yIPwAx3bozPwOQyrDYlknx3rYnN
	 3nbzLcHjYOAXNMej6eyhl3KvpHKVeH+rSaFxxUpOiSGLky9XEOuP76EmkBa1KrFOtghbV
	 E+waZ3jCgVC7aMaQpqIpSH+hcvBzjL7z0EINpQ0fcG3kiEFMkMqnFIXCggSpVpGz1qfuI
	 sSW5dXf2uPpU0Jfd+iKob5yzS8PnWpKAuMEDv2MmOeuY33UIhIzgidGFVjQkWKMbI1A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789002081;
	bh=+fWzwz5fSEYA5D9sfwfL0DKKi31jx7ftgDv9A8MbtqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qChfoGLB/vWwJg/p5n3z09MrwSGx/rmBXbx6hPCl5gVqpQcUlQ7Hx1BDz1i0rhwjp
	 G/ZiHGvwvlkqHkgEbgjoTVSrkeEPA7UCG9+ikLB1cuap5Czz98OPD1aW/EQUyo8FNf
	 1VO61IjTtHLdwc1hSuMECykaefijqYr1Owxe5dSfZ3q0WvIH6eBHBoQI4DcLalUBo/
	 KMEUYd4sYGWA86IbfAvv0IjiyZhLKdOu/agvXInlZCf2dWGi5MMHB9xTh+/Jj7NXKd
	 FM+MP6eurdWWo7hb6dqy54JNQwDGivpbGRQesbtEq8nga7OC/h11OYHXpsgxdePfDG
	 RyPKHSk/ADYoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4F1B407F2;
	Thu, 10 Sep 2026 01:01:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DCC51E11
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 01:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5BD280E62
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 01:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XFZdvpUhXt60 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 01:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EC0BE80E5D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789002079;
 b=tMdOHd7Lvnn+3Dr4+S7Dox8eijlcJCK18L7mqgrPos34hh3RDvGkAo8clRftxSdU7GhJ
 d7+rnZvDGSE+iOvg4L9FQNB84k+Lqo6TGNNDPJ/AlHMwQOGFjj/t/ANGnvFH3Wl+VMgR0
 xDfbjCIDuHLKUrt5MGycbqoOlzT9dmi7trY1bF47qJwgdGiV0yr477U66j1wus+ssTLrU
 EfAiUZRb8a8YkFKRFH4XVeY9v1+KXMAkSpzqMuqkOklTTqqUCt038hFBiv5ggh3hD8i9W
 mYVWjB/8F2WtkcTQe9PDBF2NB07oaERJet9Dn8QYnYDhJKHxX/bD47Ivo9EdZ4IEiGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789002079;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Content-Type:
 MIME-Version:Content-Transfer-Encoding:Subject:From:Message-Id:Date:
 References:In-Reply-To:To:Cc;
 bh=+fWzwz5fSEYA5D9sfwfL0DKKi31jx7ftgDv9A8MbtqA=;
 b=mvwIzkBKXxBLnDa/GV6Z1ukRSFMKe7xY+l4hTlJOyei726W+4xEmXYIiUGpqsmPeLC+f
 q964NYvg35SK26VhMSOMEyptsprqtddf64t79GeJ7iKy8c6agZju7ZHbexcRHPnSjPGes
 sWf8R4Mr6sowrEK9Fm1q9yaL7YDiVfy5UetvPK00gnR3gjWeTkXDMzVdiG1WRsKtQ7fyb
 E0hSpe/QgOR5B9Qkdk/BL5ZzAwwhsuwxuNmdFIh8pxDa3Gjdls78vQUTbeTQFbfAtLcFn
 7a57mSfGBAc7H/p7O1BJvhtRuuqupI2j8nOytcal0D0wIVWS7oOUBOX204yD79RJlsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="R9Ll7a/7"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R9Ll7a/7
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC0BE80E5D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 01:01:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DE86601F0;
 Thu, 10 Sep 2026 01:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F8A1F0089A;
 Thu, 10 Sep 2026 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789002076;
 bh=+fWzwz5fSEYA5D9sfwfL0DKKi31jx7ftgDv9A8MbtqA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=R9Ll7a/79ru1gtXD8Z452sTegu9jMDunC+rPms0IrehTisLlfvLN7Kn2ymXiXsgyp
 CZ/tOZ4GoZy5zgb6Z6drtTS4sDJj5bTokrBw9FcaGV3PqWjk//msJBD+X60LN/6WtB
 lfjZJCovGVTtoRgx6Eh3CCjfkOmgufIy6iaI260HtwpjRBBvzsH1JDnFTI0bgoBDXn
 T2joMxBGCSJWOpPoyQAlpivjBS4lkFVGQTQnchnoStSE3L9joJYZy46LfA3yHnLva0
 5mKMmjjlkp3ISbO0YRhb7lL/sr4saNqEvKco/wDtLq1Ua+gyVJzLRBPO5nhS8zxdrC
 Nvx5DYtDSTFLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198DE380CEC5; Thu, 10 Sep 2026 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <178900201362.1131357.10028347424643768946.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:00:13 +0000
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Sep 2026 15:24:42 +0530 you wrote:
> Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Comments only, no code
> changes.
> 
> v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> each subject now names the component it touches instead of "net:".  The
> series is rebased onto that tree; the diff is unchanged.
> 
> [...]

Here is the summary with links:
  - [iwl-next,v2,1/4] i40e: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/42fe5a08078f
  - [iwl-next,v2,2/4] ice: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/e2700f56c33e
  - [iwl-next,v2,3/4] ixgbevf: fix typo "enble" in comment
    https://git.kernel.org/netdev/net-next/c/47ea470150c8
  - [iwl-next,v2,4/4] Documentation/eth/intel: fix repeated words in comments
    https://git.kernel.org/netdev/net-next/c/f3056082e084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


