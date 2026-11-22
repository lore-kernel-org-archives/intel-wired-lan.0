Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642A606A32C
	for <intel-wired-lan@archiver.kernel.org>; Sun, 22 Nov 2026 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=d8KKL9HV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZ55sfqw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48B4B406CA;
	Sun, 22 Nov 2026 00:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ey-QFlQbT72k; Sun, 22 Nov 2026 00:29:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AB631406AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795307344;
	b=PKRoVcnLiFV0nttK7L1QRtZq2/IoTdsLSZGBtaK+u/r1mOFsqdqOZk3bxjAcaSeYvs10
	 D0ymAYrjD1C/L3r8Rx7OBDQ2ozSOjjGB4QupDubJebmNzZmF3ZuMoUB2HbE0ViIXreiOX
	 bvD4XVU4VZQAhuKBtZtSz8EcDkYmct2VN6s2rWc/isSrgVECD7pCDCP9AyGx1ir6I03fb
	 fWSzxym49WPUoL2fdnCQcsAofPzNc9gDuK6c1T1Ga+nKH4dK7IjpM6p1aFYxFt/mvet5o
	 IHTgEZXSbwnJY0VCf0dquoy7yc2a7Q7rrh33jl/hSwH1KJQbMzAXy3pwWah37ZHr/eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795307344;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=89c9O/yAKJRdizL+0JjVNDt8ds8ZNxXapQLM6WrXSJo=;
	b=D2N1l1XyHkFfmspv0ziYl42fNggTZjlHdD6/dV1EwxePjl3SwfpyB3HxXgX8pr7CVcmT
	 Eg50cC8Qq+wuesHi8ExSgED+fW/S4xm249bUuFxAbMKEfqpg55RJEHkCnvVr1gaYRVtIv
	 nRbL7AAeV5dJgVyXjOAVJlSucgF7JKyBoPdzErPMkF2d5lhru6VpdsOu54dfS9TDrTecT
	 tkmVc1hdOJbyR9i57xl68sspoZow94rl0qe+g3B4lh/RMGDDktq2wfnz3NUax8jWaQpQK
	 PiXZanvTuMPHT57rEbms49FcbCHEU5I5qZ7NQaHqo1vwj1YGpp2qX4Xj7UejRAa3u4Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795307344;
	bh=89c9O/yAKJRdizL+0JjVNDt8ds8ZNxXapQLM6WrXSJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d8KKL9HV48S15XBoIxDr1JcgZ+jIilAdO9ZSRrx06/ESYUH4gd6vgGKhZo6QqBq3E
	 5iszQd2q0jlupvx0mjb4AlGg8QL1FGGiW11zup1MgyF27VyxP+dOtgkJ8TbgkoOZeg
	 5+sYgjWzM4YDB17L/vrG8NUlhS/zZg8vKrM6qAO++4nj4JAokPM+1uanK2AmbIsFL6
	 FGsxwd7yTaqKR1Cl024+gegJH6V4jSoCD4DuhlIx+c6B6cKUix2LhKv1VFoFUjkZUB
	 wfPsLe8JamiZJrcvJaHGkwPGL62DJh9T3+MzBKzEglejFSBUlVZArqpB0j7tQ2jdr1
	 vdwknbor+7RFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB631406AF;
	Sun, 22 Nov 2026 00:29:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6013260
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 00:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB90180BE2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 00:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wH_PQNsoCokO for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Nov 2026 00:29:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 096EC80BB7
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kZ55sfqw
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 096EC80BB7
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 00:29:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1E164411F;
 Sun, 22 Nov 2026 00:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B41F000C0;
 Sun, 22 Nov 2026 00:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795307340;
 bh=89c9O/yAKJRdizL+0JjVNDt8ds8ZNxXapQLM6WrXSJo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=kZ55sfqwCaLPWjQIuuXDWbwCt4EM1BQtUrfE3YsBanoCQqIXzZUxtMAJOaHcNYYAS
 AxzQrtzKacYeaGNReBD+XWWaFTICpPRJJiN2UTq3DpP3iMYfm0zkHW0GPAdMj3iPwA
 fUi1CD6SBr9OIoYT8Yn2CvHKBEK8Mkz5/YrchG4fUHpzz9K473Ma22vPacZ58aXQSY
 oafPScAQKdtOMkMAPCqjpCUa7dVqna4RWWDYnYCuvIW11qYqSMwqXrXXkKg2Fj63YG
 jPQa9Y8sRS+TTb8iSwpnqXzZn4EvAfrIZetww6Br83fp6oahtfnOfYu5cZbWaG2tV8
 yb6/4swbS6iDQ==
Date: Sat, 21 Nov 2026 16:28:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Petr Oros <poros@redhat.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>, <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <edumazet@kernel.org>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
Message-ID: <20261121162859.3522ab89@kernel.org>
In-Reply-To: <fe1ce4cf-3400-4a87-8e46-072563f8fe9d@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <CAJ8uoz0MMUx68rMZWoZs-JwjodpRixwQSrgpyta1NsanGPn=dg@mail.gmail.com>
 <av2syi6lE/Vp86QW@boxer>
 <f7f1ae2d-a623-4eb7-a178-c618316beaf5@redhat.com>
 <0bb65ff3-2e27-4f2e-aaa3-2b8eb7cda356@intel.com>
 <fe1ce4cf-3400-4a87-8e46-072563f8fe9d@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 19 Nov 2026 10:07:10 -0800 Tony Nguyen wrote:
> An idea, but this would still increase the queue for netdev, would be a 
> separate budget for non-Intel authored patches. This would allow 
> community patches to continue flowing without being blocked by Intel work.

No extra patch budget will be provided.

As I think I mentioned multiple times netdev maintainers are happy to
take patches directly. My understanding is that it's Intel that wants
to feed the patches thru their internal QA and have the ability to work
on timelines, let's just say, different than netdev works on.

We wait for an ack/review of a maintainer, from Intel such acks never
come. Przemek / Tony can start acking things directly on netdev.
You can also add another maintainer to your entry, or split it up
and designate even more people.

IOW I agree that the Intel process feels dated, and life would be
easier if Intel switched to an upstream first process.
