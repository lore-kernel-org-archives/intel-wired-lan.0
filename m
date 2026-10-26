Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91D606A32E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7BaxhXWr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z71U8dI2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EE3240580;
	Mon, 26 Oct 2026 09:20:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9-rFblzbNgR; Mon, 26 Oct 2026 09:20:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8C2D405CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006433;
	b=inlwXsY+g+i5o+mseEkm88F8IJHzHp1QioA20Csf4auIgBVrhp2V4kTql0wZuu0TPO67
	 ABx69ElQV408CO2qJTCcl16rjAbZnY5NFdpMf88aTkszr43CM64H1A7L0n1F2EXdOjAd+
	 LcztBp/fwZiHlD8h4ulp93OfX2/yGT07WAKOYmePmooDreiN/h8EGdzKJymw/eQhch3OK
	 d6aL9CSRN8WpwLQ61xA6XFtK0PfIvHOD4wThwUsUsNJMSwdexJgqtYdEx04uokBi8MNH6
	 znXWjiHGuGc3jHQCnMk8kqpNJrfaUpiovi5GvHr5vpRsF5GZsEPXj5nooejUp7UI7jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=aUySbOafveqDby3GKeyXnlIRtDnYEfyaQhX6mzFk7c2CyKZcUkQujd6epAnNo4Q4Ov0X
	 Kd860nmtj6GfxiqVuZWHdIAhwCXpQX8mot/+T2V+FC1ifTIzUrbrk4vOyEi99uqnRZFQa
	 SYjacdg8Zpruu1bKvMoHIsqRQFBYfpyJnHlNPSsIXSbfm69GTvoX/T8sRBhRu+1eQUVzs
	 vlsgErYwFWI34Hj3ReMrn315+t2EeCi2Li+9R2WxvoB8AAzS4CgMxR5Wy4k87L6gsXPJ3
	 jPKjKdERgiAfgWoq5Gqjck5O9NiPJZU1BYGDjH2BkO/+9cToLcLZB4gy6Vqk4WOWc6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793006433;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7BaxhXWrtazgF/KYBZNWwtJcgS7qdJiDbSrNYtGFsFqmmNEVyDbjgnlyCME0mqx+0
	 Dc9Y3WZUu5KiQHX4H785Hj0nXgeUtUhzJww9LGyMhL/RqkDE5+S8vvWzq3LSHS411R
	 ntqRckrXWjC7kb3Kr6AdFMuT7XtuzAeA9a4EUxT5U6TZVSpFXjW9tAR8Rs0AzscRPQ
	 XI7LrmTqLO6qyJfhQ0iad+mqSav2Bi2ufQ792rFJxjLhl7WNw4/nTjSnh8Wl19s6uN
	 0pwVeh6DTlQnEH0llNe/K7rRkYyqX75/YyvehQCuECtm9yHCHTTytYWBNMTT7rTzFw
	 WpJRkCA+Iailw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8C2D405CF;
	Mon, 26 Oct 2026 09:20:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 94741279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85C2A60645
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8PNGuLagOQdc for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 09:20:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9D2C60604
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006432;
 b=SHZqvvXB8ksPnOag+5Ae9bL5pMWHZOKVCRtJsNquVJUCPGihjJ4GrBHJPPznibHgR220
 nX6P7agNUp37aLTc9F83vh6WC+5ctw8RiW7TzKAvJRQh6pnEH5rpC3KckNl48kRcCSQeh
 AEK7P8XjJQhsuwxn9pfE1zOcfdDepK/UUPqvP7LU1ncTYh+gCSlN3H2t/RYEPunWIZ0qj
 XCnqn0Pwdc6P6My8Z/KTr4pUXAsiwo5KOqbRwbDWh54kRDzNejAkhwo6XMyf4lEcGolsB
 NCaMUyeaBkQCULHqhafYy+F3NwB05Gj8J/0Da3DMQ54z4yT5yEFPAwy+B6o6ofQ3qEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006432;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=TA3vbwWmOm/sLDy0f4nCtMSuJ9juM17tfep/SeJi1mtvzxR7F5ESu8UOTKX7AeMqR8sF
 M7xPIQpMCU+7rnhoyZizs5yOsge+/3obyiS2ZV7n/C8nQEZngpkBD0wB8eD5RaXExu+cx
 M74eQ1stuTOLgbDSVP7CB9SzAEwrHWKXkOsu4ETN/r9Vty42PpfXhwlkOxDgkwbV2eFO8
 ZQHLniCjR02+qkitabbjReISL+WBn/d74hCCuhg8oSPEQduJWLMPS5ztc4rClYlIkCQDf
 vvLXu5Wr8KOBlQN1rauHTVL89yoocQlGpA/2+SkpyKnXCZGL6fFje0NwoBlqlxCaKCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Z71U8dI2; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Z71U8dI2
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9D2C60604
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:20:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 507256022B;
 Mon, 26 Oct 2026 09:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093211F01829;
 Mon, 26 Oct 2026 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793006429;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z71U8dI2QvKTJynspl15J6gQC6Isn2+VTBjxhFitQebvW7UQ8orPMQoWasdkB4VYp
 YGSWd3olF68KmcAGygnO0PFtlZ0S85iNoacvgXG4zvbDduQVsmjWL10pMX6uD/4vIa
 mKQVIP6oe+Sl/UOTqYz6eEDJqzzFMWD957elaUtbA3MMc5pA0v3DofKBvw0plb3aWc
 g1HEbKMZWulfE3EicsJbzvMqHvB/qQZ1rMQj3IqaeSUVOCbknJ/uUlltz9wlxovGYJ
 Im9haTqcMaM9m3IrKHiNCwfTPtn0GVpqBjeTIQ8JyK+G6hgYvUfXOnAKBZM1R1F6HD
 jiDR0+P2wQPog==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org,
 vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com,
 aduyck@mirantis.com
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
Date: Mon, 26 Oct 2026 09:20:27 +0000
Message-ID: <179300642756.3327.8776904148998915275@kernel.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
References: <20261026091549.605810-1-p@1g4.org>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
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
