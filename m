Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD3C5B572
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 20:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CB3780F41;
	Mon, 17 Aug 2026 20:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYW2iWsHHNhy; Mon, 17 Aug 2026 20:51:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F41B81006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786999903;
	bh=LN0TpuSE5gvRyvGvBe9lyfvP4qAiHZ3vKJ2gaD7SoWc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=5kUfhANgXWoFexy0qGBwUMOXoDzS8kcVEIzLwpMKwj7rw+HHVyQtvGBjzAy8OafXO
	 YJfZW3ENDhiPG8OTxz8XQYzX7wgvmQZRsjQcM8l3LaFVnFSn4JVv88CJeMEm/gIw6H
	 hrxlYiuOPdlfQadbfOmxHRi40iqwyYMxng3fo+5G8SV3ZOXYRb6ZyzIPpLKAG1j/hk
	 nGmUi8AVWrajdjwlNeME91A7nvjS4QqD1MxLPCZCBCpzqqPF9MRRSQnW9xPMDqTfUz
	 /AoI57zwyatvGKsKBvSyYOztsMgnjF230rf+kDsoqpiAybhhjWMN0c3JLALsu5zrq2
	 Hf56wtacOMtzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F41B81006;
	Mon, 17 Aug 2026 20:51:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E8A1334
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 20:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 747994009A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 20:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y8jVyA7r7ABA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Aug 2026 20:51:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D2CD640063
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2CD640063
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Jvszu26h
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2CD640063
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 20:51:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 187F54008D;
 Mon, 17 Aug 2026 20:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A501F000E9;
 Mon, 17 Aug 2026 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786999901;
 bh=LN0TpuSE5gvRyvGvBe9lyfvP4qAiHZ3vKJ2gaD7SoWc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Jvszu26horZdYF8oCq77XydH2lk1A69clFH9eKPSqWhzfdsK/EznZQMhMqxfOn25O
 L5dl13m9nZifAVcRCF0Qp6MMwNRcp1fcb1lZAqGyrEUXnRe/I91jXHA+7kVHUrzK8/
 KRXehAAr1hS8fxV3ku0bPX3nzsItNEP+Wx2w/hjdeHlguYUr9v7vE8CP+9i2Z1Yrt0
 GuS6a/HXBZOXEq5qB8zEoEiIbaVNk+m+rJOI+5qULs0eRRrLDyJHjJg/ozpNhW0MGr
 /N5RacDoX1NToUZYD8HR934YjCX7GBa5UaQfcBAwYMzNQUbUuRiNZF9WVqpOrpRS/p
 oA9FKb6cHaRZg==
Date: Mon, 17 Aug 2026 13:51:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20260817135140.37c7f578@kernel.org>
In-Reply-To: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
References: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Intel-wired-lan] [PATCH net 0/2][pull request] Intel Wired LAN
 Driver Updates 2026-08-12 (ice)
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
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>, "David
 S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 12 Aug 2026 22:18:04 +0200 Przemek Kitszel wrote:
> Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2026-08-12 (ice)

BTW you marked as a pull request but there's no PR info.
Make sure to drop the [pull request]
