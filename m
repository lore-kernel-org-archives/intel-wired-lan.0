Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4B3CA5FE3
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54CA540C00;
	Fri,  2 Oct 2026 09:14:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IO6VX_xPOOYb; Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8A3E040C9C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790932492;
	b=CoR5UFo3iXjVKQKaOusQe/pZCU/JY0VP3EaeQYwkA6ZX1caFp5hojF/rUtCy2Z3/J+Zd
	 ty48RaYbrm3oGVcM+ZoM5ooGyk1EzB0MlttGREcJHFtDPyyZqQMrhfLsyrbvbCCsActk4
	 WMp1hbUlmxmXzYxVIOIl72Gu338tsYF0L1IljLwMD7k0Oxf9O0YqvbVgnvot00311EvuR
	 uNuH+Us65fgYBt4GOgj2nOCSbl8+FqI2s8+S6FEIb7JbtTllAEyjh/OzZuNK9robInGFH
	 gQe3QkG6nnv1Golphlst3HmXmVeuXR3MP0Yl61dEFUFpQK5Hh+WAAVkvgJ0augGrnAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790932492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=//8fxdMsJh6/kGtDdgLOpr6PPslJ7sGIiQGx+p6a4P4=;
	b=Vpm61HXbaxbc/+UEQWjE/6HKzbbvsAIoiauIxqKYSS0f3in+NZXemgvFJJqQJOAK5z2C
	 rJnS5fxvmt/UJPNrVJzFQw5YEBj4/js8oc576+S5M2Vf/o2rMy3ob7aaSYeDVIYpTV8ey
	 cXK3Y7ubwOfwkLTqX4Wrh/z7Kc1HebOGoNA4zlAr1+yVx2wKLiuAsJr1/kyelvSMHMmOd
	 4CQyvhQyiE8mLCLJGRU3BnigJFhUoV8qi0axkgAijHXR+n5ty7b0uQSacN0mbv5YYApPO
	 udEBj1GU1WB/IYFmVK7Tab2MeQMfV0tNbhH1wq9UaQtG7Ia0dVj+Fr9yTxgz1akx70A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpsmJPb0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790932492;
	bh=//8fxdMsJh6/kGtDdgLOpr6PPslJ7sGIiQGx+p6a4P4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=331WfxRcrhCCegrBPk5BZr2eQbSXjN5BUNCW54wPXzbLwOf9Lz3NhfTj5VBP1ycg8
	 pfms1k/GN6+rEfTVrotypg3orb1oFhgkUd68HzEoKQxslenzkrmH2Rs8q2Wm2DfZNt
	 zDL1mBKvYQS37SpuAZ9Rwkp3YdCtBfFDwZfq1UHF1ZkUsOEEpG+9+8yz58ZkvJCNDs
	 7g7S0H5a29L56m3FSr+N2Q1nfkuEbXZ3xLLACaC89s4lb+JsKXbiEHKmFeSJGYQw8t
	 NCRmzs/kdZ4MKWXLwMSmFXLE51+0eWCz1h5AaGaHrNOa/GNG7b48S2+DHM01EAX7I0
	 IAI4SqLLMVLnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A3E040C9C;
	Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DC103AC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83B7340C00
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIFezvY3T0C3 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 09:14:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AE1E640BF0
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790932489;
 b=eItq4/GIXhDIL2SpW/Xw/ycUBQeoqUz1lpF4JZ4ioOC+ffJjdWRbY7Eb9gePigp/hMRN
 66yqZCKLi6kPmdfFouKeYJf7UV9/G5tE3qvj/3BXc6rr+qkGRWTCRAE8+a4r5gwYWYQEG
 5WIJAn1sUc6wpkY99Us5cXGEioqJM7Mi9uTWLbZ8jbR6UKRRqGmHDeSi0U/hRHA50kMDq
 1s4gGQU7neRuo+FKeXBDxmlxxKI4x/kYMM7b7WsDKvI3WR2YW7OhYIB9R/wAK1KdGopKf
 o3qq+Wb9L5wHb7R4RwHZyJefd396Lz62Hst9wy9njXEv6vBB5U4uBJigaumoEpekt8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790932489;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Reply-To:
 To:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date:Message-Id;
 bh=//8fxdMsJh6/kGtDdgLOpr6PPslJ7sGIiQGx+p6a4P4=;
 b=iuMByAOU5jmrunX5/3keM8I5Rd78iPuNjC8AJoA6rhmtrmJmkt0+8IVr4p4nEesXpigR
 reSW7NL9Ih5cpLcnSl/r55y32A46xqABdv2o1xINwFR2/r6mmnAAYAKQlLxCFR4l9DuiJ
 3k2vdHFpqMr/foStoWmWqL//0gNKqQBj7hSSZt732G3P/QQW4svwKwwv6Y6nJ2Nio9+0P
 gF4OZZLzLfkKGTN2VcQHY2vWIEhLcnQtXTxWU4lR+SBDd08asg+2WMbmbC9DR2LERCUJ5
 wF5hsmSHmIkyiqh9P0ELgB2sv6umEGHra/F5+xdXv3h/oLGBH6n6zN+iEkiYxlt+qiQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XpsmJPb0; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XpsmJPb0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE1E640BF0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A2704127F;
 Fri,  2 Oct 2026 09:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5ED1F000FF;
 Fri,  2 Oct 2026 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932488;
 bh=//8fxdMsJh6/kGtDdgLOpr6PPslJ7sGIiQGx+p6a4P4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XpsmJPb0sdEKeIq/UesdQfhLDQk6S9g+A2bIgzdI/7FdfJJvc81oavlWgIC+Qa6dm
 2o9HtMRYIQQ/lLZ+hmkUI9dYaMPIFiHwkovmCzfugbzp+0ltHoDsg6H9DTk3DeuEKE
 nSaaj5gx5Dai2z9yIUsrzcntO7Dxep0Jr1ol4AUknDlRvPQ797z0Adld5SjYA0WvDI
 6KMEeiWciWSZQzrHE15B+5qz+JX0WChssvTgiCd4lKrtE+TY1ToAl9I0PXc0ybKi+I
 ZuByXYnVxLI6+aqVGWbrhmtHPn/lhqLRFAg+Gsgd/SjbhG8RO3ODIxvfeNSxquYXDG
 ZAUTnGj9psfnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with __stringify()
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org, "Petr
 Pavlu" <petr.pavlu@suse.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-modules@vger.kernel.org
In-Reply-To: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:47 +0000
Message-Id: <20261002091447.DB5ED1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-str=
ing-v2-0-fc7438acaf4d@suse.com?part=3D1

