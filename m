Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F363CC6B39
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 15:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC006608C0;
	Thu, 15 Oct 2026 15:55:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvO1VYXFr5iI; Thu, 15 Oct 2026 15:55:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D7605608DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792079712;
	b=llf1Q1SOq14rBXRFQ8f+xTkt4kSFwIqrAxvjwY2RcZjbVhCeYXxBB6001k0+zk6hfawQ
	 rYzWqnKmMwgkISmOm/+p1d9aaIGTtw9YxbBDvAYnMycxSWmRjOm+5jehWOlvnc/vqe4yB
	 gBupO554rnkPafV15mg0dQzLI3iO8mCtqePRiLhMvhSrSlkFDdCq1FJte6LYb1MD/P/d2
	 C4Tc7jgJ/bm/oKvGrMJwPx+NIQfRskBM3Eqz7QsZ+cAhTm1Uaojdqhd42iGz3HqTQittm
	 QvKrf5AZxuFmZTPeQo2baPmkqBSR5UrHRn0gJIr75tbbGqO6gEMIVhrQmISSx01XbNA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792079712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
	b=UEKf/8TooUMsAJrsYMM/gNn0c+4YvslBTIDOmiAict7IPXNBmPle0RIhAuYxdCGIH3nz
	 0AduDET+ImZl8LYedgAygT4qTOaFz/aHp2wRhDEctnlqHYxWJzA5FP0l/Cvrd0whqGdSI
	 3fJcSc1PQRkiLgMjRKWciRAX5zpUPY7y6gYsZCYkZ4kguDMCrSZaqAmhJRVB3V0qt4Kbk
	 Awqyj/m5gEvJ8Q1jSYpac9+1MshHEcaFuW5fd2/ZgkCdrPqTyHzXmH2bX127EaIHx1Co5
	 ewXJwOAzas3U9oM6F0LjaC0BPGFUena8l7N14TMUb99Y38WxKlDOcllB/2Tv+Zq1FQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792079712;
	bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJd6EDqEnQxqBt4obQT1m+hajzMLOQ3BKlAGnXdpw3R7KmslyCM5eGYpjjxFxgvbR
	 i72puYMiB2EwbTTflmdCPsgfWI1yKpTbB/9QYVJyJk0VhIq1qpq1yP8NzIFj5zoKnp
	 pKK/hfDjKtPtLKgrK0TWk7tKQKdtQOlzefmb6I3lbfNv/SsUH9A76btXPOc74k6UxS
	 gHJ+RlXXbrtKONfJB41CMM4Awc5zuimwSd3sWGEvEDLub1ZuXzdkcAL/RhYNtmJxqC
	 EzeJ0etGAg4YP/2YPEvxuGASOCGTPDCAn3gKU+DVa/1FJoNwCOYZsmySd7JEre6oyB
	 foMcGGwvK2tXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7605608DB;
	Thu, 15 Oct 2026 15:55:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C5188A58
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 08:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2CD440811
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 08:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ECCXKgnDgUJK for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 08:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB17940806
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052045;
 b=rPd0M3noHcDgd7Sqkfd0ZT86aDm2D4evuecNhjQp78EY9Mxzn8sN2P9hbZQSiiDsqmqn
 v1KxBuzxK7z+ee8p8uRD/IPuT14tUaWhjKIpQwnToI1TF2Cl6kwSMPFlGcPl23TY8e7ep
 +kOE30KqgbwCGGPRV0VjZVKCmDYUoPwsIGDFxa/V4UC1qbLlhNveMGGXnxvC+QXfx5DkK
 zdo8RmqA8luy4VhloH8/8lg+FlJjhRrl8QQdQIKoNekLzKzAM71vWU0EXwi3IACFxrk0n
 SP+BD+SCfCUsp1FrTlQ90XOiNzjvlYt/rZ6BbcU9Mk/k5KfSrBzbWTUi+/CEtu4NNMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792052045;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
 b=rsgabeKsAoKrW1CM+DNRKJTVebDeT6/KjkL3ykSdZwPwhD37CB1IgUnJ0G2SelbClC4X
 5wzmdksPcEZBeIzCsYIKyusPvMy/luKfsO/Pt+6WS9MeDutLutXS6fkgndVr0iXv9yLZU
 hQRWcCMR5nR1hUDnnzedNlTji+ACQWGFAhB+svkFwGsZdhaxXwqnxoexBZS1fCd+8GcrG
 7lmCqDFfFGNwegIc8UB9H4pDc/z7Qq5CDP3MQRcdy3AoUZSCGaYjD+CjvJtyX4tV6gEiV
 o8JdG6hJWZVcuP9g+rPgcJGPLI4mnl4+I3qRw/n3gFUfyPBNkU/M14PpgMl0I+2+sIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=nebusec.ai;
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=dUZJfSv3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=zihanx@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=dUZJfSv3
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB17940806
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 08:14:04 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso7622655ad.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 01:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792052044; cv=none;
 d=google.com; s=arc-20260327;
 b=d+wb+9pVnfAIWBnGtc3kbArt+z9XyW8lDI5zB8GZigIVCzSxYgvTQ7JlkAMTqoAcCy
 R/uA2NiXYmY4T5BN0eCn1TznBvaQZYqjV/P1XWvj41gj80K7iJXgj3Mudo3cpmdr0V32
 UMWaet8L4kvsAs189A4uyjYAQ7v0cRZd7W7ABkv2Oua3o9Kt28PfJoxNnFAbI9SQo4ra
 9WR2ibUHnM+YaogKZj7S1N+K6OHBcFoaW5nyL07NKjRbFQQ9wTuA3hxmiiMRogQ+HHIj
 W3pkz+zHaZ9WgfyewuY4+3pY+OjSC1vxfIJXGc9m2MYcpSy2H6vxEXE172qaA4KAOGZg
 3rIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
 fh=SZht3wiNyMsEAXJanvEJMWNhW510NPTggytwOeRP9Q4=;
 b=PgZi75HYC5oh+D+ivif7L7ImenegBLlJQq/v/8ceBHWKyEjLIoYkMFPT4zEdhJoOE5
 U8v/gEYV7JiS5mPTuPjIBfe4bIBiZGeQbtZ5DXCZMFwcM41YzOFu2zMLzXWVY90wqcrN
 CR/IbobnQzJmzl9aLST91k4YPLe41LfRVKuwVIRlXZ9sl88DjuI7Psqp9jMKiyeCgUTe
 9HTRrFyZ38ES44plAFnHZUmRUebx1GKL8UZzeLkiTwXuu8KEJnSQnTcozioanNzieJsQ
 n0Ojz7IltYP0BiqFom5JbWFnZCgMMjSrWdT07I+vTHAAjrQ5IcClQDAc73AO3GrqZs8U
 dU3Q==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1792052044; x=1792656844; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
 b=dUZJfSv3/+yp5+Z3rCrpjOfCmnv4KFrW1l4UflvvVNn4HfHbBXEh7UyjmjEMQaMaaY
 +tWcPyuXxLQQo2mWMtUISVdN6qPnjVMSdTpQE0qbDF0vUm0xsNg+WbWR+peBeDubS4QV
 vdT7fCeNKD/Sa9VbLpyJwtPzWqm/kAcWK9hOGzVuNJdALvlRu6vRueOR52Y+bTVy3ZjF
 PQMIMZKqnt0D7NGxo2V2Yht5kb2ey+lsm+vsVFG88O2dDbaNuot5QBGebl0KSgyOujqE
 cl/RQrllfAaBUp6RDBVAL1uZYAEi9ze24hTL9yxYrZv1GsAfFNwL5F5NighLpeDjZoea
 LDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792052044; x=1792656844;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
 b=T77YscVZtp2YVzaLWVoLP1max1aPDCCpDthvIK8F8p4TyqUiDyTZPmBQY8aX1xuHcC
 j+3+zNmHKCccv0gFM/V/o40Mnr+kIUBgDG06gzdSKs6ZXSoi7mYFQPP3kccQuOo86iPo
 6aF5v2B/nj12qn2JYH/5xmd7T63anPAJwAoo7zryMjH7PwHBcNn/zEJB2l+M1mcAg7o0
 5bXzU6xknRSToYCtV1Z6vId2sC6aGofiRNidO3JTS1DLfz1QrwwBdJkLRaJMxCKBP6ws
 +9LqAOViimK58QiNWcsHSujh9uNkH6cF+qVbSZL9FbdfTsVw6fmrm0U6zuYg6SCYSxkt
 nSeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6FKZV+yU/l5MFVDc8V4QuFD+uM2Z6FkoTU0zGheWN1X4EnveSKlTf9IWigYq4YsdHG80vXSNZ41UF7KWU3fk=@lists.osuosl.org
X-Gm-Message-State: AFq9FYI2xu7WKx0b5IdXrnbIrjkGq0Btw16Q/MeLKYbr+pRIsMbOz1D9
 CweNw1b345ejZnTn85ixmAB8A1yuz8ZHH/37hdt0+0C6e0cC8utcJXhXYqd31CvldehKwfSpKx7
 d170Wj4gNDXUOkLvR+GKwY/AmambP+eVoOHFnYP4doUw=
X-Gm-Gg: AYBFou1e+gEVAr0GCbQv8+tFWJ+46NhpFFbACoIG6hVDaAu0bcMKfJkFRku+vKdG00L
 VJ5+9cKuqNk4OjoP+N8PiI3SONn2JLKkMaA9wbPYCqIvUKsas3t7FhyaG+FzOE0+0ahk8uAlPzf
 ei7MmsJm3CFit+pQ3Nb73J/rESgREJfHQE3xiabbx9QsDtqWSWaEcIniM6pFrw4OVrNoa9q3Y9a
 e995iwXCxy5Av3POnkw3mK6kY4FqMCb3GGF36v5vm9JdPSmOyofFuDc9NI+VXe64lDef6IYFQM4
 nj/HTnYrrEcqdzq1znx9grOSkZgxL1kFmnWFQG+p57NExjELDBJc/Ys/Tu6MZZmDjase2acdUz8
 XEXPqqIEHNYw=
X-Received: by 2002:a17:902:ef07:b0:2e9:3395:cca8 with SMTP id
 d9443c01a7336-2e93395d1c7mr45816975ad.46.1792052043589; Thu, 15 Oct 2026
 01:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792048855.git.zihanx@nebusec.ai>
 <1eca65f844ea4eaefa9ea4a852f1db27aacc10b9.1792048855.git.zihanx@nebusec.ai>
 <sashiko-outbox-172439@kernel.org>
In-Reply-To: <sashiko-outbox-172439@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 15 Oct 2026 16:13:48 +0800
X-Gm-Features: AclHuK-Od2hWn9HWhQZkM0X9wiI-VanPEIsuQFAjFuP9aKbDkjFi0zgaRUsjr9g
Message-ID: <CAANe3eTJcfGU8DcbrTLtOwM8tcDx5TkUrZDXXnUbT70m7X3+1Q@mail.gmail.com>
Subject: Re: [PATCH nf v8 1/3] netfilter: nf_dup: preserve guard across
 NFQUEUE reinjection
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Oct 2026 15:55:07 +0000
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

On Thu, Oct 15, 2026 at 3:56=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] netfilter: nf_queue synchronous bypass triggers false DEBUG_NET_=
WARN_ONCE
> --
>
> commit 6ab1ebe7cd71aef0c99fc87d28ca2657ffc20779
> Author: Zihan Xi <zihanx@nebusec.ai>
>
> netfilter: nf_dup: preserve guard across NFQUEUE reinjection
>
> This commit saves the task-local in_nf_duplicate guard into struct
> nf_queue_entry when queuing a packet and restores it during reinjection. =
It
> also adds a warning in nf_reinject() to ensure it is not called with the
> guard already set.
>
> > diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_=
queue.c
> > index 477fc632657f4..1ec9c1fbae843 100644
> > --- a/net/netfilter/nfnetlink_queue.c
> > +++ b/net/netfilter/nfnetlink_queue.c
> [ ... ]
> > @@ -369,17 +370,24 @@ static void nf_reinject(struct nf_queue_entry *en=
try, unsigned int verdict)
> >       unsigned int i;
> >       int err;
> >       u8 pf;
> > +     bool old_in_nf_duplicate;
> > +
> > +     DEBUG_NET_WARN_ONCE(current->in_nf_duplicate,
> > +                         "%s called with duplication guard set", __fun=
c__);
>
> [Severity: High]
> Does this warning falsely trigger when a packet is synchronously reinject=
ed
> during queue bypass?
>
> When an NFQUEUE rule is configured with queue-bypass (fail-open), packets
> are synchronously reinjected if the netlink queue is full. This synchrono=
us
> reinjection path (nfqnl_enqueue_packet() -> nfqnl_reinject() ->
> nf_reinject()) executes in the same task context as the original hook
> traversal.
>
> If the packet was originally duplicated via xt_TEE or nft_dup,
> current->in_nf_duplicate will already be true.
>
> Because this can be triggered by remote traffic intentionally filling a
> bypass-enabled queue with duplicated packets, could this introduce a remo=
tely
> triggerable regression on systems with panic_on_warn enabled?
>
> > +     local_bh_disable();
> > +     old_in_nf_duplicate =3D current->in_nf_duplicate;
> >
> >       net =3D entry->state.net;
> >       pf =3D entry->state.pf;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792048855.=
git.zihanx@nebusec.ai?part=3D1

Thanks for catching this. The warning can fire on synchronous NFQUEUE
fail-open reinjection, where both guard values
are set. I=E2=80=99ve narrowed the local check to warn only if the
current-task guard is set but the queue entry did not
record it. I=E2=80=99ll test the queue-full fail-open path before sending a=
n
updated series.
