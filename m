Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE9606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MX9iMf4w;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=WFLG6Y7U
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69953406F7;
	Mon, 23 Nov 2026 23:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LM6pWp2cwCqz; Mon, 23 Nov 2026 23:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A41CB40703
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795476386;
	b=a4nBiP5wLI8Sx1Oa0xwHg1Lg1c37N/r6HyebmPADezMhFtBhVoJHxdaZLnm/8D+uwumn
	 0KUT9GhXVzlhh5gQZZeGwX5eAvd3u4FvrxI3qkjonrBnigdKRE3wLO1eRBZ6cExBVc8zs
	 UoC8iMccyp2ChA7A7q2qx3+HzDg68sT9klh0FXCXQJFGccvQcPc5x2FfGGWiNtPfNFaYw
	 rkT6C3Et9moqyNo6nEo9EjZZXRyKfneqT29Jm7qaCb14VY16t9HhtO0NL0Qls8tn5LxYe
	 xes65qTEZxHmmHuQbxbgvsNK6zrchnqCQvLB2TtpS2EDPk8j35/vDfySPPfeYMIjexg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795476386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MQWlDJjW8xpL/p2sZ5f4jnbMjOG08OgWckpms5J2u/g=;
	b=c4rHfOh1i+MpJkUwzJK9PUymv57FVmgxhGSKzxQHoK77qHHX8HRr2f1HMvoFzbDpepV/
	 3mU1qPmnFfTzVeDZri5+dgimPY0ChdljSltlbE8yPxwUEgRiYdBlTXhYvmgOy0cVDirHw
	 OyLSjcmHq0ZcHgSKoG5jVTLhpdp57vWpH5YT+ikncDaDaD7f+IxA1CAAy05Rhuci6VIR7
	 go3G4d1821Cp9+UpWNJGUQosNzRYcXNN+nC8DVZ0aaauAHRsqNXFyRP3L7O/2RQ0fZSt9
	 rBE6/V4p88lGv2+uD/y4ht9t8QjBDhuJdA8EcgWB43zQz+o+0ZIfrdUJlkwcMi/00OA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795476386;
	bh=MQWlDJjW8xpL/p2sZ5f4jnbMjOG08OgWckpms5J2u/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MX9iMf4wqX8nRbTP+y6X6KT0NgfrYgYto0EnxS9ZLnJNGat1Uqpz/hCfaFR3Jto1G
	 CjlxOlDAe8eD2C40Mx2umNsImygMtBtO3zkCp+CPRGmC3NbM/lEPPqHQV5kXKQYM1a
	 QPZ+uV3FUNhmMO/F5mjwPj1hVY/aJPUSE8GJtJYXp9LYhVlJp0DwyPgbe1o5fYiM25
	 gN8keSO4oTA8QM3g8R3WGCJuZhRVfPrbiEzEOAh1XxU916UNkbJO7CDmsxIhHykbwI
	 hi6KRYvYjCZ6DJ5/6+glx3HsnjaMB+O5bLlrqf5DXxSHIzSchPN2AbkmVh4ilTaNgm
	 aHZg19cuXb7lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A41CB40703;
	Mon, 23 Nov 2026 23:26:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E5F61AB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 23:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 441DE60684
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 23:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndceCrX8FWZP for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 23:26:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E95C60606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=WFLG6Y7U
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E95C60606
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 23:26:23 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-48e2d5a69c4so2010884fac.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 15:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795476383; x=1796081183;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MQWlDJjW8xpL/p2sZ5f4jnbMjOG08OgWckpms5J2u/g=;
 b=WFLG6Y7UG3FgNSPcYif4A8xY+Mm7l7Q8qZpWYnzXy6/zx4Zri3019eSax+M5vCpfG0
 1qrvWF6AHXpYtP0zhczt/eVwqnag6vbpPln9WotL2kPMlB4PgeTYQJFFT5Xsjt5FkzwM
 lJg1Cf2b8t2+5NBtsF92eFcOtf1XS3c8OIHHkMedddAie3NL1DByF0s7UhRxC/d1Eeqx
 s+7jvu5Zx5u7PcGE5nrYU05fD5HQYCDeRg1lncVYVXTWPR53GoiqVKmuzZdW67cytWXp
 9iYMw6AizrJ4a6BjvVfkRv5YNQajcG6hUtdiRzd5zi1DjEncU5DmpH5eroATSXVBFfwr
 sLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795476383; x=1796081183;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MQWlDJjW8xpL/p2sZ5f4jnbMjOG08OgWckpms5J2u/g=;
 b=gKoejfdNyY+hCDV7nmO0zlteCrRJchOAGJp7VZT/jtHP8EpPEqZ9fsw6GUlufXQpdV
 Rkdhx7D6vkcHsZP0GiX2ueIXE1BDH9T1lJyuHAShtP1FslgbKVVYwJzE2c5X5SQqIYg3
 57z4DkM0q94rIu6VIi2zfLEjkLuus9YE78FDWMRqnd76dYAKWAqwvr1LjY/6AsL54i0y
 av4YB3Jv7qScl70B6tDrpQIZaVSEhJoK6VpDwSQq4GL9SlBlCqTShrY5k2Q5BD7PIQJI
 gwaeIT2PTOcYNQBfMk5Nyk+ZLNcAi2XFwLAlksRMYZZ/urpugcjX/cGYtcomY2SbqL1C
 1cKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH9W4uobxqz5o5i21EN5cJrrw0MuY3Ug2yzqqlKFKKwGyf2zyEfL55x0wvf/kE5/00OgJ+QkpuDubKIJIbtviU=@lists.osuosl.org
X-Gm-Message-State: APuU4Z934kDa49yklUEqm0XpTLUmxhXHGA7S2+PmcrUi+1WQhrIKHS5j
 WE/eAcx7p6q/YMIpfDEmN69M3zIRnjLlSR4tpzTswZ3xQdVFxM19GZR2UvPDlmzlprsZE3PW/A7
 tXEg49ZFuTlDgdReWAKY36hX7L59yJD3ed2GsFnEoFw==
X-Gm-Gg: AZFdTZcaMiwZW4URrQQTmQqAp91FbWy+blTYEKPAxFXitaK+EblhhHxbVxqdPLbYDa0
 Z8xX5GsXT4fxzyoTUSksw3eS2V/SnrXCvKGxZFcvMCKKnpRKBVzT/GqYevjrZgBdJnWasVNZVtn
 xGWLjuvTBXpyDTfX0SutoPT8rNB5SF0I5cVjecFmlkGSf2kD6zG8FJ9acltIsBWcIIXdFBXduqh
 pd6JVH40cGBUjpPabcgrbhGJSWhn7bHykEkjORxLUcocEWCow4onoMPMHAdPgEa8dW7CGZ+vT/U
 UGC7yUJCjo7Q5Hrh/ffGWRv7hI88M6BGYVAU9A+X4TVUIX3GJFOWiypQs/DrOaMeMC/e9pFm5NF
 CsN0LlfS5WKz73MXtZVJdXHhi4ZSbah5JHF4mjn/pt8rG6elLWbwqbxJFJ3Z99N8t8Zs1ohxcTG
 IlZ8w3tkptAA==
X-Received: by 2002:a05:6870:31a4:b0:48f:e0f6:bd58 with SMTP id
 586e51a60fabf-4bc860f05e8mr13202699fac.41.1795476382627; Mon, 23 Nov 2026
 15:26:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
In-Reply-To: <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 23 Nov 2026 23:26:11 +0000
X-Gm-Features: Aa3M54qQLsKa50Hpke4S8nRP-l5tPOwhsGlHSy5rlgDYx5CUns_VsM1q-PHhDTE
Message-ID: <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>, 
 Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

Thank you for being so responsive, and I really appreciate it.

On Mon, 2026-11-23 at 14:42 -0800, Alexander Duyck wrote:
> In the mlx5e case they were disabling the feature via the private
> control flag if it was enabled. In the case of your change you are
> just disabling it without exposing that it is disabled.

mlx5 does not change the private flag when a program is attached. It
sets MLX5E_RQ_STATE_NO_CSUM_COMPLETE on the RQ, and
rx_no_csum_complete keeps its value ("off" by default).

> is it falling through into the CHECKSUM_UNNECESSARY path with all
> the indications that a tunnel was still there even though you
> stripped the header?

Yes, the same path as E810, and mlx5 does the same with a program
attached.

> The issue is that the driver is making a number of assumptions about
> what is there based on what the hardware parsed for headers and such.

This was discussed in the thread of [1], including the decap problem
with csum_level. The summary there was that reporting
CHECKSUM_COMPLETE on the XDP-to-skb path is unsafe, and that the
safest option for now is CHECKSUM_UNNECESSARY only [3]. The decap
case with CHECKSUM_UNNECESSARY was left open as a known problem.

I am also working on the long-term design in [2], though there is
still a long way to go. Please take a look if you are interested.

For this patch, my aim is simple: stop the "hw csum failure", and
make E830 with XDP report RX checksums the same way as E810, i.e. as
before GCS was added.

[3] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/

Thanks,
Tianyi
