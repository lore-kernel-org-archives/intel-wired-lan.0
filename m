Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD8606B122
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xAg0/Ubt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzRXHrX9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BE2F606F6;
	Tue,  3 Nov 2026 10:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1mb9vV0EXRQz; Tue,  3 Nov 2026 10:10:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8829B60670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700628;
	b=Va/E9y+H0H5T+W2pYBQ9b7ZlAoRUnr/XSNUpderrMicDGZf9wEZhjjJopMrC6mByANOu
	 CHjkoEv6KYnPsKdsVqm23xpeGNFJP3qRLVVk+W+ueerNceMMg8MubtdIPtnN1xdIV8JLM
	 +0dXp9zngIOt2RTZapAN+X7H+b9XeVKv7I8EdsugpAAtrIgvXtW8FRsSMfvsHLlWiDiaD
	 hgbRZ1YtEM+ICE7y4LvpFHfe4amR5Gtq1h0Zlwzh7pcO+PG/xhNehnEX69Yrfm6qq4mfi
	 bxchPaZkaWRvjHFKE6Kis56pwaFUDsMceuj7Cf8pMUQtugjsoBabWx+IlKlhZR683Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=JKd+z4At3weCMt6JrNPhCzcl6jXpvo36VQgWbs54mwnHyoejbwV1YEU2SqbNmYxJwWjt
	 6fjA0JCdOW1DUBw9Dv445WeWWWcjNMck4zJaqakcJmTBPQ1SINpcD0y5MX3TB6ElllBI6
	 vHNKK7IEjfSkMfySjTVA/8SU7JqT7MvyEwoCsWGX5XtqIpJP7MWJlMtUZj54aCFJwmFkH
	 dQ0EoJG8Gkl7hZAzEK2K6Oqnp1fDWZZ/6oN+WIuY2BswalqiRaNDvFY0We/Qy64P8ZvFT
	 369YN5K0L3DidnWSt0YAby+BY3QRNNhGxQADAqwY/9qGKiSocTJTlGWHjTgftrU2ZZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzRXHrX9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793700628;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xAg0/UbtXNb+R8p1qE5liyPn2kTXKjgweppSDIFsXiV+ER9wiczJVjWFhzFNEki38
	 /WTl7sVSd+RUqNPNaVHHuDBp3kTp6QE60zCKg7TLrQuIwOI7fhEt/YGY9KpTwxRw30
	 /Mqxixm3BV+2zY1Vg5uy5CClyGS4VDwYzAqeJRxZo1StlfVhQ0HXIdMbznvRolNHkJ
	 qavwfKxZWV3rPs5lPo++SCl6NxGJmXyApdDXMJJqFRRKwkJa3/q7pMqpx06PVkKliD
	 N1EiL3QLaG4G1sSTA7j4+W3XvDe8bkAjaW6nOli8WHk3MAEOPVN2+j+gAD5Wsfcsdk
	 dVG0AaR29s8sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8829B60670;
	Tue,  3 Nov 2026 10:10:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 811502AC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E7B860670
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qB0v3KjKWqfQ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:10:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03CF760642
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700625;
 b=YQdO+cYZJQvpyXBNh4gSZYvWTv7ViRxiDht6ETAoQwbttiUQLU0lxCxd/x+jTWXPeCr4
 LhQtorOUYng9TWXVSqva3XmZ32AIZlkhaLfFQQuLEyCxFl3HU2J2A968MHtA6L5dMpTgy
 Zoe4cvAVD82NqbWGgrU3EZ8pYBBBjBnJUTWbEdyflS2aVqm3IbphPbNVTRWH/F4blcN0y
 64Igxk6bf9IIupcMh89GbRQX9X+OhZPj9TXDrgtv84/HMQtuoTYBpCY3LRwTeppovZiaU
 /dSr7vICYOv3/9dwazn8XGCAIi8mzKCszU+7+cfY7D5vpEWBPDU6peEWtREXmGwfypg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700625;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=LYcjdzeB2P1D6XPgIJK6zlRsu7jzO7+gB/lHIdL40KiNiupbvfGTNcQzJOoMCsB4hrn3
 bOSZPXkHlJJaFsn9LaOBgYI2Q94S1PEw5JDoRUjN48Mqt2VjqSMlLCyr4wAOI5yYV/74M
 sVFmpbXKswGithp7xJTZwHBET/EVUswKR6znwVCPafjIKq915tPTRZRVBbwyh+lMFJQ1R
 YtJtKw112VDK6PUn2nw4LQniulNQHq+TaaWMat+J6SXrw0AOV1G1ACmhK2busy8J3xKF8
 HW+zwZU9AvYU6sBZ299QU8O5QtrLviYsrRF1+DJNX6w3LPXYEVBeknbqAghWiAvcZ+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QzRXHrX9; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=QzRXHrX9
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03CF760642
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:10:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3648609A2;
 Tue,  3 Nov 2026 10:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55D01F0093A;
 Tue,  3 Nov 2026 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700623;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QzRXHrX9ufeaXz0LR2RDzdX8pA+pRgZ06SF3ZyCm7wsOLtwd7fGBh9sueSEAKybaK
 ThfwjztZr3au5myV8I5TNTudKoypRJ/EpO3qwMhIqsqEj0elRSwkQCsD6h+/dQzItP
 ZuZyckzgQ20/YbM5I/Aw/ULOel8Xa2nGwPXmEcdNF3jjFC9gGHJCIfqmutJLBReoY1
 OqgGh9Vo6TwISjHk3R/Y6IUF0Rhk8dnBdZeIWtH45papu9kMjojzufMPzcQumoffK1
 /CTzrGver/lvTQjhaaudOuqnSvESdbyjE0ZHnfVgNAB7w5lPo+IQsmN0TF1xw0AD36
 ivJZzhK9h2sag==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: ixgbevf: drop the SA reference if secpath_set() fails
Date: Tue, 03 Nov 2026 10:10:22 +0000
Message-ID: <179370062239.488859.17760478051473372751@kernel.org>
In-Reply-To: <20261103100534.1310071-1-vulab@iscas.ac.cn>
References: <20261103100534.1310071-1-vulab@iscas.ac.cn>
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
