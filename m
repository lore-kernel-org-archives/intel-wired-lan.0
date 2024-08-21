Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EE2C52D6F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Aug 2024 17:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8132F405A2;
	Wed, 21 Aug 2024 17:43:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4mDFknX8Dty; Wed, 21 Aug 2024 17:43:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4D9D405D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724262220;
	bh=F3XKEZPPUnJ7jiN1D7MLFTk70iwQvxCntEUW+jc4m6g=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GgGCH4SUlaVWA0bv5DTuKEOuhd8LsTEKGNwnSQANka+2knku27EG8u2BTAQ9o4128
	 UHGErLDBfi1SiNtLJm7sRS/p4KLXrZA0GKAxL/0/wxf5TWxoVNLdJllDDc5T+llnwE
	 b9+IiABl6TubfgCmr6zCJm4OZiz2HspUXrqm+b49v+tJaTwgSAA3mlvweGTegjVzac
	 i7LmlfA4zk0vZGPS9bq4kapf9mLXFV8eEspBehYygD3icFaPiJm+AmnugBkRQSEzDZ
	 9pSXXrI0JgXPQl7+M/swHVzJk+VEj8L0U8PThUESf2sOgf3vRR6msf+TrdITk0Kl9T
	 A9PinunRo51Fg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4D9D405D9;
	Wed, 21 Aug 2024 17:43:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DE7E01BF59E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Aug 2024 17:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB0046066F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Aug 2024 17:43:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVMxOW9jP5XH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Aug 2024 17:43:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 78C8160622
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78C8160622
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78C8160622
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Aug 2024 17:43:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0172760C39;
 Wed, 21 Aug 2024 17:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D6FC32781;
 Wed, 21 Aug 2024 17:43:35 +0000 (UTC)
Date: Wed, 21 Aug 2024 18:43:33 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Galazka <krzysztof.galazka@intel.com>
Message-ID: <20240821174333.GE2164@kernel.org>
References: <20240821142409.958668-1-krzysztof.galazka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821142409.958668-1-krzysztof.galazka@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1724262216;
 bh=N+YkvIz99IGyeVfRPBrwZTovgPEWZeEgGq7aWXkRxbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NfxiGxXVQoeHVFWGmB1WRmqch+umMkkHtCvWIsWVAJ7AJaGb5OJr6jd+BBvjdGwvA
 CNoJFF9jKVVkKlsJRvOezcNzK8MaxYF6Vr10F1ATWVBG0V3xYT0WAfx3Ud4lwHZMak
 B+1tx6kDz/nQ6fJ50gqVx/skv/sLY5oPhBk6xG7wL0ErB9icFieFvQ6KVJMTCkZ7Jv
 d5KP60JR5FY15j7oppKJ0iHj2i3JKREB+tHHvl+BAJ3zlFacERVXZPLf/fxfcZHzaG
 QV9s3gjiXXoWpoyGn7VFkq32HK6gjkN8vYbut8GwDwJiqKseqp7bkwaLKcA6Hb4NDu
 R0o357Z3379ew==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NfxiGxXV
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] selftests/net: Fix csum test
 for short packets
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Aug 21, 2024 at 04:24:09PM +0200, Krzysztof Galazka wrote:
> For IPv4 and IPv6 packets shorter than minimum Ethernet
> frame payload, recvmsg returns lenght including padding.
> Use length from header for checksum verification to avoid
> csum test failing on correct packets.
> 
> Fixes: 1d0dc857b5d8 (selftests: drv-net: add checksum tests)

nit: I think the correct format for the tag is

Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")

> Signed-off-by: Krzysztof Galazka <krzysztof.galazka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

...
