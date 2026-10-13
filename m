Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A55CA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 01:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0FD14055C;
	Tue, 13 Oct 2026 01:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Nktuqwuyl4r; Tue, 13 Oct 2026 01:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A8D64053F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791854125;
	b=dn7VOU0y6JFVNrzV7PddJTo3h8k8Zp9vV50epQLuMoW8Q/h8IzOlGozziQh9m/E9vvkb
	 HUAbu8F45+s2+T6TbE49CC46rGgob47uQyR+AaiTFXFx+bDgWIeWT8Xa8mL/z1FzU/bT1
	 xWXrXhOKXrGNATQTkfYr4zpXCCMfmMPeBBBuF3YR0P8Y8rP9fBmLAmcMaUCKBMvrokNDA
	 kNIezgqNP8gEyyIxDJQof4VaMkfcj7YXhx2+UvA7q9ToMb+tZ06BPPrkKb+GujlpsdZIA
	 U+ZXHC5DJBvPkB3uXCJsp3PFFBRB6gg4gib2VIKL3RozHebu118MPkGC1Iu76GrN3Rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791854125;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=PTB8BsoTKgAa5XokTsn+rxOlldJZhYNHkmWK7f8FnePXWLT0y6QSkeLOrkj7giRUJCXC
	 tID4Jy8ZAHmtZQ+HuVjiJT3aiJvRvF5V5eeyjc2VwvyaP2tND9ZDj8y/dZo6VKjfSlvvX
	 49B/6ssE7xUyfINpVFUhEFD7wPvhX66FxAntFxv4kujYx/uyloAn+xCqMaLbBxvdNGWHA
	 xyiCLO5bgiBd0O98yft8B1DhwtVCDvNdQlA1emJK4yhvdF8Uy2lFk8dZ6foK8vrafgNnE
	 y7g5f6P25t744H+gIXcUxQFmiXCswIjm25cLHOEewaV1K8e4Ek5Hv2cDFeK7FwxNxRA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPFYbJOo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791854125;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nuIANnump3TRrQxUj1J2e2zCR7Dxj8JkGuYp6wSDojfHsLtvo3/2lePOznNShffDy
	 j2phAWSQm9MWbHpsEL6GvaufRnZM4Vzt7J3lV/PcCIdRJe21J65KSTU7W9W3/bxcqO
	 lbNc4bPZeDSoJzFLbTdeaM0MEGxGJtMoBO9a2sMMxtV8+4numz6ip9PeeO/bSDTtQW
	 39pYVDbTphHWBjfbk6xMaJLEiGzvE7Dwv8SPgqN0/jvX9LQ+FXH7/ZWnom0JivEJfM
	 +Z87sWAxRUGu38SK9XpXuN39TOu8t3oraDPKFUqH5SQUtb8R4lt82k7ueDWQUyAT7T
	 F4SjSMBg8/JNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A8D64053F;
	Tue, 13 Oct 2026 01:15:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5787C105
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 01:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DC5A4053F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 01:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N5VZ44BD3UBa for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 01:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9D99A40538
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791854122;
 b=chDYv/6pQlQd2LFrVbS2yprT8qq7RU+NPMkyfJqbHfxjQ95jkasRkVuqMiBVzGU21hw7
 CqfmVUBZOiDiPrKsGad+ySHQEU+jla5iptjLpaDmjTFPCeM0KSG3A6OhEWc6Nt1miRKAw
 d2SgoW3q+37aonREYqzowBg2vBP731NnU09+J3B2u3HxxLs0rxTbYLQftdbZ6OaJr1v5W
 7XwkTFhnMupQvbIig6T3nmJgi1i87JSmyts42NTAghod7fV8WfkYWLXcXu5PGqDLh5NLT
 j0pH2BSe2Ek5SIAl1mTecrahEormVEDpDm6vg0Qe76Y5k8CwV2pJeQN51AtnF/zfqeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791854122;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 b=H8v5/gT80V1bjaT+TDe6kjDd7ykq/4O5Jx6Eb0Q7YEGWw+A603vhYEFlLt3ggDgEuq4F
 5zwTJfEl1SHoDHivzb8/KFUeZ4kxwLOtiHGA1C5cWFpr6TZNBBiQhxghYHksXNm0WlP0Z
 hwjDrKyI8epC6tAlXQa003XB+Nxd9QzaQMmQP8VtJmHgIAOv9M5ZvPP0u3++r60pwO8wf
 8Twedzc69MxIvS5XdDdU66F/viJoP7bnVgVlonQfkBZ4ZmyGsYWvnaa+ANHh1ruZMGWPG
 TAgtRjI1aT/ThSD6GpTDsXGHtqP17S54vwEOz9rdWiKHllipTZrzcgfaTeSa1MiIHaA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NPFYbJOo; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NPFYbJOo
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D99A40538
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 01:15:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B53D2600D1;
 Tue, 13 Oct 2026 01:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10E81F0089B;
 Tue, 13 Oct 2026 01:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791854120;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NPFYbJOo+N/pyhUfJOjVCp0P1q4q1Dc8eoOB88zAggOtYW3Qx8GwO7Nsn60RTTQNQ
 PFOl/ti4qfYLllfHXiAdMWTORs0NvvKewlOBOMGfzGtB/9RKrrDsuuxftYp1QryoxI
 dg6Iw+ID2WtTLBGQBYJacHHOKF6QZdccmhC6Qs0+ciNgWtiOgaCP1MqNEle0mo8zzR
 MvPUevGIE4O6A/kSE+9L/NL9rgj762KGWJ+mv9itMs2aVJGuP7qlM4z7VXGv8Fkbr0
 v7ByqQZnqsUoSD9V/JLlJd7nXrbdBaNVinIzsZSSB/HiZ73Nc5OZetzbs5GKQ/UUzt
 xHBIg0XR1z1xQ==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 maciej.fijalkowski@intel.com, avigailx.dahan@intel.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first
 buffer
Date: Tue, 13 Oct 2026 01:15:19 +0000
Message-ID: <179185411924.2527009.3756808928521081401@kernel.org>
In-Reply-To: <20261013010854.4068874-1-p@1g4.org>
References: <20261013010854.4068874-1-p@1g4.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
