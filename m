Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B0606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=RWguGNCC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3fibLOx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CA738096A;
	Wed,  4 Nov 2026 01:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3Z6GiUSNuuA; Wed,  4 Nov 2026 01:38:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5D66808BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793756325;
	b=Y9Tfs0VM0Aj5seorrvjtkGyLV30SD8RHk67uVrQPEMlLsiB6sdheIrAiPnTTkotlPO3l
	 PfWVcUjKoHViP3Z1bPboFaTOfvVeXfTxkDMJNELBTA+Sr/CRLVzSiuyXqIhm87IzOmKDu
	 2hDrGTQ5cR7eKQWm/S/RZgaCv6uTnNx/3kfFqRjy9S+DA0UbKfy7tTwfKzBlVbELRKNsm
	 tWdRNHWWMrCFj3HAPkQOsIxBIk6rDnC4LbezY7ZJSi1O/O3v02XGeCx6j4C6mQ1lwxSxl
	 FIeDhYTeyB4LbzQ0QkX+Tdrjn+di9+fAbL7ObwoqerIG85+/nvPTzPG1X0vI0LWnctw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793756325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=ql2vUAYusK6tnKgP29z1RHw6bjbckOfbqPgzopQ0bJtHB24xJusOYFj4ED9T8yax0fnJ
	 I7lGAyw3WkLHTaXTwagTe3FzNa8tLXmo/wVgnWtzXQyJ0VnahtRs0b3wrIx6qPXww+X8H
	 YyEmKpBKu6mI9AbXLCspTyn8+wjpBdFtVkdKohKcvYuliOWePBHtOeOhbppT1dqoMPRVh
	 paiVsbZhpiNQ1pHEpAX1V6AefGh//41aeKKDpYrW39SJX65k7bAmhRElA+j6Z1BQVyk/3
	 xDWpz1WKlp2FUJZf+iBv74gMz2KUFhCqs7QSQOORBzwZOuD+yi3EVI/xryvOZbLQoMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793756324;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RWguGNCCM2pc6gabACAfTJtAB0+DSI2clAjfQztUngFasmY6f2nTYln6qV1FeMJuv
	 N1mAxTpZmLm03cQCuOGm4KW7DSyKqJsl88kPY+n4M2lMrzIcwaiMgo0d0AnAboX2dM
	 OpaxrBd3JBYjEdItqs8PsBdDC+ZAJfwv5ZGyozZhx5Xtp0kCOrn2nCXMKG4/MAlEnS
	 PD7fe4XeALu+rVILg0AxinkGBJd1uS79Wy4fslzdjNkfvQyUD1Bup2Lna8RP9+03NU
	 tYXkeGpjE5shPjyRo91aAvjW1eKkceiJGZlA6Oc111bH/zPqHMsKrSLqLmgfAJeZIL
	 yTXe26+VJgzig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5D66808BB;
	Wed,  4 Nov 2026 01:38:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 381C9784
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DD86400D2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZ0THC5zoKFS for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 01:38:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 706D840048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793756322;
 b=YtZ8Q/A3ofXQyjd5LBUVwiLi8bVHQ5+UEVDtFhTMDS5tOc/X+WuIpg5cJlyxP1JD/O9B
 DXbNX4t1FGQnPnHeUQcz1aa+OPXczlKPifkPyBRSFuBinGIFa3C5oq9jqNQMslf40zFo0
 1GUQ/yR0o9EhkOc7fFdvjs5uvVTqYUzgozghJogzfm0YG5ZGsyt/HwDkhcxPLB27oWx0X
 31A+65P+8Eu/frbwOF//Gpl3JaIH2stM0ytELKBof4U19G4JTfChriOmXRnoFbI2hCaPY
 JswmHNZuOn7u5BnQ/hAOlFpOcQAdwY6QjEOHjAALriF26mqf7CbyOFsrtE/IQyyoIHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793756322;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=o44J8n4MFtcuAYXuU7lkmSGwt4WLZspxAS6rQAITb3kVaqGLeODnOMOzQhy+ADhhsPT1
 LGVSIxvLJbqSolaFPxQmUm2q9s5VTa6wbI2r+UUAoZXl9x3vydtQIY0wCn7KhGW4iPSvW
 v/7liQiNLs6mDHFTiwzqvk2kXJMX7Wmf8eDofGeo/v9dAaNVweXujzWEXpA+ZibYbMVqt
 dkCTj16L6hGxGCq/jZDzmNr42NwrKwHsaM0watY4NIapPXAreDk5RNnGi8pfUBq6PL+Jy
 wNl9FgN2ayXu3SVh/bd4uuXFK1zZui9S9SD+6JODCGek2qUCSnlBchzB93T+UZC3c3A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O3fibLOx; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O3fibLOx
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 706D840048
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:38:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FED643609;
 Wed,  4 Nov 2026 01:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54731F000C1;
 Wed,  4 Nov 2026 01:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793756321;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O3fibLOxv4KNPjesOeQDqOOwIG98LN+S5vFG+j7JHIzcNpoQX0wNyZDZEK0KeCQ6w
 TPOX0YCqXFlABzQqBUX0dGQGXLv2uayJFVqgR93o70HZifbIaTGvFqFmtmWA7LVru/
 LjsnpvKGwiJFyndC2HMswPJXT/nw0bd2QwwivQU4WcBlAK0jiqRr5DDXQd29asXPnO
 vwNSo/DDv54uLqOawXU39FqJJL2ZxZdPiubnamG/386Vm2Iik7WQnpUH468kzKJc93
 64xaArgGwtkk4n8bkzC4s92wXbsAU6fWwm5OxiGyZ6YnP+gTYf7zEUuKsWqDlK8fry
 aUVfor2QGncyw==
From: netdev-bot+sinfo@kernel.org
To: Naman Gulati <namangulati@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
Date: Wed, 04 Nov 2026 01:38:40 +0000
Message-ID: <179375632025.488859.9511320336418102727@kernel.org>
In-Reply-To: <20261104013606.1527767-1-namangulati@google.com>
References: <20261104013606.1527767-1-namangulati@google.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
