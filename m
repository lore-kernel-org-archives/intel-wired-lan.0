Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D49F45A0F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 23:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 322BD83C55;
	Fri, 10 Apr 2026 23:10:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JP0AJ1YraQG8; Fri, 10 Apr 2026 23:10:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71FEA83C56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775862653;
	bh=WgWtPNRr8FVLCsIgvudRtpMQ7i10lZ9yDhFemLfXDCA=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=luROoWe0cF9vhYGjABmltPwfMWvVL0peayQ4htE6IdWFj6hGoa4gD5qgZU6oc+idv
	 68w0qB6sijhgc0T7W7YqblDWgw5JSzgyeyR8fJp0cwYAH8nL9BotluJkPpLh0Sc5ly
	 s7z1zpg+mZcixs2MbOxACuC6aadniNo7t5GbvOaUFMAhzFAqisbI1E9VrESLnemlxg
	 6SGmInWKqxnfOUniJOEA9XceqilUWv881Ov++SP++idTEcSdZ+x+VwlGY0xHRE0Yom
	 Ua6tW177OBpY9mZVyv8pupQ3GZRTH1PYewzaP9SnaquVtiyK6dIJ0pX7qY0cj0JrUO
	 OKLmD7fTdKIOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71FEA83C56;
	Fri, 10 Apr 2026 23:10:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC2F6194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 23:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9EEC41225
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 23:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FfUxf-4UwWQq for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 23:10:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2A02940CA0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A02940CA0
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A02940CA0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 23:10:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F040760181;
 Fri, 10 Apr 2026 23:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80CBC19421;
 Fri, 10 Apr 2026 23:10:49 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FCBF3809A88; Fri, 10 Apr 2026 23:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <177586262379.2678602.4461794362716512859.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 23:10:23 +0000
References: <20260409093020.3808687-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260409093020.3808687-1-aleksandr.loktionov@intel.com>
To: Loktionov@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
 Aleksandr <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, leszek.pepiak@intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775862649;
 bh=J4LOl9rF5ZCwKIsleAPXSM56vZS43EMCOiWOUy1W4vM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=hUgqET5Ocr0nbQxBSw6DgCwzy3dXUangtyph7ynq/pgXfUX+ERN+zA19p2TgdzDC7
 2rNpk5txApudlMu4/4DANexqTQgh2iUYQM6yBPSFFYv5aFs5iFwcGNvaKRY8/UfFUn
 EzA/TEa8lilr2MmJ501DWxH1Q+I+Om4ik8pa9+nI4a3NC9jGVeLk/QrJwv4nzr/bMx
 UvwxGEoilj6hvZ7TZL9ZgBM/Z20LlMfQZUG5c2NaUPkzc2u8m2bcHt4VpAtU+ygZ0m
 WMTIXsv2G7Ept7Nz/I1OGMjpjn/Y8d2WuK+n9An4GKD0QCqnK48e42DDVjdM0RuAYV
 iGBqmycPIvN7w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hUgqET5O
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] iavf: fix kernel-doc
 comment style in iavf_ethtool.c
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 11:30:20 +0200 you wrote:
> iavf_ethtool.c contains 31 kernel-doc comment blocks using the legacy
> `**/` terminator instead of the correct single `*/`. Two function
> headers also use a colon separator (`iavf_get_channels:`,
> `iavf_set_channels:`) instead of the ` - ` dash required by kernel-doc.
> 
> Additionally several comments embed their return-value descriptions in
> the body paragraph, producing `scripts/kernel-doc -Wreturn` warnings.
> Void functions that incorrectly say "Returns ..." are also rephrased.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] iavf: fix kernel-doc comment style in iavf_ethtool.c
    https://git.kernel.org/netdev/net-next/c/3f3a2aefbc66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


