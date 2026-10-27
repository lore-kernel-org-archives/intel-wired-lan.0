Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A9606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8+vcbPV+;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEAhnRJi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDE9F80CEE;
	Tue, 27 Oct 2026 12:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0B-yU-CUshM; Tue, 27 Oct 2026 12:20:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 659F580C48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103614;
	b=YzdXCJadaJqr3F1afHsg3YC+U+Y6a8r0jwTboMS5R/2i5BG+8HNpvmTFnRhOKO/QwNtu
	 c7QgZ8k3E413eN8BRktr4xZ+DBbXkqguhW50/c8DeyYALHIyfetpJUA6PKDTXmAIMCYUK
	 jO4nta5Pt5tjeT+3myCeVtUf2LctfO1QNC323p0drm3HuLFx0Qr4w+aOfHAfdmNdapP3p
	 swpQpsK/ROvipffWnFLXqo7MwDgyqtKvKeh0/R4+sHJGmO3OJjRpi3T9cLbx8b1QL1516
	 uXOvWOyDMPt0WcAun7QPi/JdnD/0KMeaJf2nCJgxCaFbPARsBZfsizq/zXyhk5NMHiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=KJD4CUJ7hhyT+FFO3oPu4SBjZZeeLFv9ddA64Ns+5gIonPLsBqgfK8mKLsTYPDnH0Mx9
	 zfzAi7/kBoORTxIFLloJqOj/fSgSpRFyj29yZZWa9wKFWMqnqvvI44+pM50sXJeJ1E5c0
	 s6lI0JTmUPQ0dnEsGEiRmzAgcd4PYY4CwRGnfE6qOc4VY4qoZw45Zlbr4fwY6TNEGlZB7
	 bjXoVWGGsvQdAcPc2rkPmpa5Wc4UCPS0r22ng9mtfDnlErlneh3IxMrCA0UBSZfzMqSn3
	 JOm+W+scAv+DfuSYD3twTsKpb3Sjgyk7wTQDF6W0EY5698qwZRhma9n8txe9fS8FZTQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEAhnRJi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793103614;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8+vcbPV+um/OJH5KNgzjs0Fghuh1vtPszdYbafp4GtQ3UuLBfaY397d5b5p8R/S9m
	 ArD0fxSfBCVgvbkE879rM5qGFIxgJMpWZDPvMH52uxd4xeij84q2xe4KLfzkKCExHG
	 +u+tDOUtN7GAWkuT5R5ocOViiZu8WwlJ5aKaTTDWb+9UzrSZlYiNrVABVzGs6NflBP
	 svtsfne0BpI+UG6gxQXafs75v3ZtgP/ER5ehR3pLII4CUZCGoPw2tur9j6MdKceC/D
	 YkLOGwS0vo4BzY+RTKw6t8lgitl0o2Gin6cj1XnIfz2N/WC4DhdKcBSI14vqLGYBFM
	 mn7B2EBUlncEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 659F580C48;
	Tue, 27 Oct 2026 12:20:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED3C14BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DED9D80C48
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:20:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FvOVVtibddKX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 487E580C0D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793103612;
 b=fZvk4k444mn0rp+sfztrSm3ORe3RQLY/j8WK/0aDt20QTt7+WsOScM7XxSXMwDkBHOri
 UHFBpDVmaQ2hoYOMOPPF/AsF9rJD6lopvxEh64KHnHXIHlHRkfdIW8hU5ri+PTT/Nr/1k
 Vjja08N8ChGWljHn7vNZpdVnHzpD0E8RUUbdkm9y9I2Od5Js0WMgzdoHEVAFt2JnJoIpd
 dFH1UEMJCrWVbZQYCBqywhsX1+3snrc1hDS6pPLu4mT93m5o+q1SeMSZyDtvuM1VNwu1S
 LZAabhe2p+KffAwwG52ERqwcLAEHwXwmHlaLlJhtZDbgz83lghaudS4w3bjEtblbZxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793103612;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
 b=MqyPY6ZT15ksb5wFyHl1tsPka08aoQFSBpMaOzj74sUH17NLcdQAiso6jGYNPL3YaRs6
 LZXt5vZUCgvhPcbHYPP8fsYOiRGyivwmQpGz+0lZ7qPPOKmWAErh45MoNRSH9vad7MExi
 mVcNSe8pL1zpofJHMhrZXItf5PdubhRjX8wV2FzdHp+U5kWWDtf+wL2iCHZc6TPS5nYWA
 8tsZsl4JBOBv/fWcLetvvGyoTLiDOWjpC4frO2V5rfuL7OlI+kTfm8Kt0xjJr6HyMwh4t
 tTLpL9xlfj8OK7N5TwDIZvpfG1poB/PbynjD4Nmil2JAzO9p1RmYcfxZxz3gcjuew/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iEAhnRJi; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=iEAhnRJi
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 487E580C0D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:20:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CC2960052;
 Tue, 27 Oct 2026 12:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FB61F01825;
 Tue, 27 Oct 2026 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793103610;
 bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iEAhnRJiB4uWBnRlaX/a2bxhjXfdDSQaZXG/HRjqs943SzYeUWZ5H3Udr4+6pr7Wd
 o3M69PSb4ouLUtACExiC/TLXZ6RbC60GKiSgNaC5786TuKF5xE8nSuGgnfQ0b6lc1m
 KLy5IXZeVT5Rba7WcbkNm8z7WbN4QSS02M9lN0uXIfEYkFEvh/9pzx1S14OseB1Sre
 Vl520JwEEV3/Qjy15bL07y7RRm0QIr6kI8Cihx9AbKVnjMcwwqkePrco9qlsmb2a0c
 OGrm+Ji2+fYxmxjg4MrClsCCyN5wYdvusHU0SAWcjHxLhFT3vaBsZVmZUksXJben/y
 nmHVEvVMPvkeQ==
From: netdev-bot+sinfo@kernel.org
To: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH iwl-net 0/2] ice: iavf: fix USO for 32-bit systems
Date: Tue, 27 Oct 2026 12:20:08 +0000
Message-ID: <179310360889.3327.4157213770892413960@kernel.org>
In-Reply-To: <20261027121442.907414-1-magnus.karlsson@intel.com>
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

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
