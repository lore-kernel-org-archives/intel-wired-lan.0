Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F160CCA465
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 15:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9F704076E;
	Thu, 15 Oct 2026 15:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chkVFR4QiBNA; Thu, 15 Oct 2026 15:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04FCF40869
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792079714;
	b=tdtQG2rMdrHuzu6Ub8mUVNv99loSorYgP0jz0NknUT6Elocp/h/bnEAPbtQjv0Y2jw5z
	 boLiu6jiVlphAxnqmGef6R4587x3Kcz9SZjMb0uGGeu/6OMeFWUJde0eV9QyKCNdlcEeR
	 UjgCE6Osidrfm9nOdPBX6BMsjKgMOJHOFQBSKSkOvRdFx+CBSl2z7jSK5l1QsuglpugRO
	 CknJzVqzZM5wHJWL0Arjw+4sXh/ipmopveT5memtVNJ4cl0BKxMiyDPwPXongKW948bUb
	 BRvC//xovZGHi59fXJAGJMdEMuy5YnVwaeDYjpWIMVDRSdbP9qtE91DzjuqRcxyHXrg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792079714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
	b=p48Oz6YR4Z90siS+8WAwwqwRsB4vCN6ZvtVn3mhB0gU4+Wn77linqj/2ijTxRvVcUsRJ
	 GlnFN4+DCGO8S5bmdEoLSRKajYRbW/2vdWpGfNhJu6U87m17nNMvmINJhG1+yvgxYZgF5
	 K+wGgLawfWtmBvM0epempNf3VILZNNtbiLt5JWlwkNX5+bBMJYyq6QWeuwwrcu8lPZ98F
	 tQlKMh9uhSKZcb2J3yDjC6WhJLRwq4KfPTY4BMpZ4M1+P2ZjPpzNwR5phxJ2jLX1bgM8w
	 FhScBfIFaq7KDsbxC44a+CC2Ui957VWgdOgJ+btTbn4ouTZB9cBjmsfGQpM1bjsnynA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792079714;
	bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NA2ICFvSzZ7RZmcKLpIsr0TTy3NvhrX476Ozi0Ws2OnrHjBpO2O3ZEqeso3KAxbF1
	 5LwfN9GLFQB6zSpRAC24cRioRBlpnDQzCBQylYjc9LrWvQ2YLROa6nB9FLDm0XNqTI
	 6F20tRbSl2w0n+uxr5hNq559I3EFEL4hqCDm4Rvpbrw33R4klsttGezpbUT4HFzlYp
	 CvcpAp+pWyHC18D3THO331fK3naKwgmNjPux881DRgVHQ2SXAR9KX5EA2UmVz50pMD
	 ph5GBudiuF7weF98DuNS6hVITnCSsD410me1KYyQAYjqx6dF4lxh5l7ZAPOr19LMKE
	 HWrGkdIDKkR/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04FCF40869;
	Thu, 15 Oct 2026 15:55:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F27B49D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40C6460758
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e-vC4uravSEF for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 11:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 05C1B60685
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792064027;
 b=gZiDjy5ZXTghULHlz9Q8jZUh4w2JVXUh0YB+2JvxQxr3KJy7Rz66qWQvs4nGHTHUPoj/
 PVfoQrAC/v9UndKI01G2rNW46gYy7xTmqQS6/s2wRkepXWzBDp4ghTAnq0WSz1q9VLZ6W
 CieB/n3Noucx9tbqtvoofp4LsB1FzQIyH8fuPkK8xfoLryBDw8N/usSet3uOPIbT6PkGA
 lyDFaA23pmZden8MejFfchLrunh/iFJVT3fNkHXdWm4XTTuBq6SWn8RjhkU2450uRiaM+
 5FJiSEZYjbMfaNWTFvKYkOtCQ9V3jFUXWSqW8RI/rmQD6EooNhuAXMWuixLRkIQ4npQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792064027;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
 b=ZUL0UPxBLvXgX3bN+/HlFiMqYMzGU1BdOW7sH9bHfQmwmh4ZybTjp21/7Mv/sicxWFWA
 yGXv9NnsdzjkkK1TQ3MU35RGqTO+5xreCMXApWUfLitaRey1QprnXMsHOmOftCmlreBvq
 y5lqPlSCzXOsHJ7o07P0zETCtWlJ6E72IqlknfgJxEUmFO/+Ehe06smvB0EmYjgo2IGH/
 i/+vYzC95VqOHFqOIRlQJ5aiJk/tm1GM26cGFupZq0vnmAonCc87x6AgxHnCSywKiZav8
 wN3hD9e4Lm5UN4bsLld8ihkunHC4M8OpvNsEHwtanK/b0Bryf7Jxquhyaq6NSEmPHzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nebusec.ai;
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=pjzhIh4L; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=zihanx@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=pjzhIh4L
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05C1B60685
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:33:46 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3a9761758adso42542321fa.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 04:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792064024; cv=none;
 d=google.com; s=arc-20260327;
 b=eawmfHMIMkmmt6Qz8DFK6A1wOgpLOmzMO6S6N2ehUrL5NvyJpCm6bp6KKBlXGmO4zK
 Yv/QZ408jn6lfiiO5pa+8sWJC00X+cR62VLwJ15QQwrZnkkxuBf3g0icr3gMRolghGny
 cYJjuhi/BEgcaU+KCEw7OQvoMxk/ZZAwYcedJxbXLXqBL+P1bTp6Zc39oSN7mrsc195s
 mpZkFbmzuYpJVao4fVnyiqEVEx+8mXjiAp3Yibh1uApEdm3dIrlFojQUbl7TZU9/lYvb
 wqFfujjQVY25/2KY/4vwsKIusxpkYtzOY0eoUG/GnVlDv166G9GvM6WED9BkoOyG1Fqs
 03oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
 fh=nbBtNXwVhq+l67wZU3TpkOjeA1FTxRbnU4V2oqGzXWo=;
 b=Kxf+/7LJ1CbSgzKtZs5Q3Q+Lv2JAPq43PkmJki1877cgArhLivJc2PQLy+103aBnI7
 SsmO6PscuoC1fb2KwqsP3vbYXgJsV6r0uwCwoFB+qTk4yaY36+xAloX9BqNXfxLQQCB5
 2qiBKR0UUHtHhYm9wXfe1lrwPo7d1z6tlRP8Ps5uAiJfCgukSIbhhcWqaoltTnxH4rny
 qRqBVzXN5AAUwiZKhtsa/mtz4ifYsgttP2eKfYewuixqqdKZdUGBmf9BbPspW/RePRWn
 zQqfYH73h1tvjx5UPpvOMjURD/SXX55taASCy0uNPiQkjk7f2pOUDRKt5ckb+msQLG+4
 yuXw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1792064024; x=1792668824; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
 b=pjzhIh4LfMzSn+2da993fACzO5CS9ikAJ0DAdqXTc/bvSECxUJ7H58EwX+y/qrg88+
 5RPR4qyuGlHnFmj/bmotC4io4npOBhTAM6z+0apvYmgcl1V79Fexjh/x0D3cNT9weGgp
 pZKJjTk3+0zjQMgwTtT9b95MQstdzv9t7M1cQMWAQGG1VBdbXU5bnf1wSH6WPB5c88Rh
 G/aMfab11OltHCV4XWU04aMm/lCM7zo1kZW0tB3UH7zVvvMaN7mkMdug+T5v+QHUxhy1
 f2NOudYu5lMVZ0hhGs5k4da7gmDMikh0n9vT6ZxX7/wRGfRvOzl+5qG7DWZMonFd27KW
 gEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792064024; x=1792668824;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
 b=Cm5RoVO2Ly3VHSnkeXDZr9y5RX5/CJYd+gGNploXJButwWSPgMYOW7QK02Fsa5wQTl
 Bni5OEXWKONcntFCAJp1CNIB9PVG6bRHxyivYuQ1WtngyIKLRIpmCZDjWuTw8MVjhWf3
 fYVd+98Y3vAYgWBDx9dfRx5wFNgEL8uu6seJmoL3nJNi3aIV+2tCUxOv6xVkVRIcUt2g
 ZMEjAZWIcWeNq/5qIY24O+ZNtoIg1LtWWlIQwJXQgDjYbZ7OkPolDjs5y+qC0s3NCDf0
 UUaDnHluYi8V8WsDsGbhNpYdFc/rGqyVBcAkz1X6V6p7f6RS8tcUirKETTRm7lKJowiV
 OXNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8EOWWWGPk/d52GCclM3GYslqZ5KHVzBs4tjHDbwo9voS2meCM+0WkGgetWDlWOPBGpwZ1+Ne0eBCPlLt2n6s=@lists.osuosl.org
X-Gm-Message-State: AFq9FYK+ac3SQRRYwHjRWJEJXJWnAw00PKGkFnwlJby9xPoGqQUhckR6
 0cd/J3cJcPUs0SK5YkOI17AgfnkSJh9DoxEPhk6hgbw4e1z99nmltn7Ym2KhPk2VFIe6QKkw15e
 46UF8bLTOBlRnNuxKsOcEh4yXk94H85aermSwVPkq240=
X-Gm-Gg: AYBFou2yuDUcCIdK5io2QjbFQZJ29QApS6Y5FM9xnpP5gqiKG8F7UJzAQ0tVebBEyQE
 VoisN3iq9YuXLJnZuhSQ5VaOvgb9Rr2mtX3GSRdPC2tFhnIuzGd2IffZuX2/kiRMkb1j7mD36Wp
 SF9chuBIpNzamye7GZoGSflHgc0FZekwesKJylkhs5JrTQrQG6zCrTRGtNW5eFNNnhxMxfbj/r4
 UfGYSi0ZTqMfP4zV68/JDizAaSIgW0wcHFS784hUedrq4NA95i9o5mvb7kDhtV//o3sVB9bQPdI
 N0JUM1YULM+PO4bcGz2JC2TBZ33Pa2EIQG1Qacg6MkkF1fN6OIy/zbAUJv7UCEugPAy3dMaum1Q
 otcGMqys5VA==
X-Received: by 2002:a2e:b019:0:b0:3a6:53b7:65f with SMTP id
 38308e7fff4ca-3a9c56e2e18mr32007541fa.24.1792064023930; Thu, 15 Oct 2026
 04:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792048855.git.zihanx@nebusec.ai>
 <atCtUFcG9b4ykXY3@strlen.de>
In-Reply-To: <atCtUFcG9b4ykXY3@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 15 Oct 2026 19:33:31 +0800
X-Gm-Features: AclHuK_8_Kk2IIVBq5gfnontRtGKaffdTFvzSUc3-5H_TGMTs9I-jfqzlZDWd3I
Message-ID: <CAANe3eS=72iEkSwLGToMZmv_Drk3Naky2OL8oM_11GZztR3s4g@mail.gmail.com>
Subject: Re: [PATCH nf v8 0/3] netfilter: bound asynchronous packet duplication
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, virtualization@lists.linux.dev, 
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, pablo@netfilter.org, 
 phil@nwl.cc, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
 horms@kernel.org, kaber@trash.net, jengelh@medozas.de, andrew+netdev@lunn.ch, 
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
 xuanzhuo@linux.alibaba.com, aleksander.lobakin@intel.com, ast@kernel.org, 
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
 sdf@fomichev.me, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
 willemb@google.com, alice.kernel@fastmail.im, eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, shiming.cheng@mediatek.com, sd@queasysnail.net, 
 vega@nebusec.ai, root@tr0jan.top
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

On Thu, Oct 15, 2026 at 6:39=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
> > Hi Linux kernel maintainers,
> >
> > We found and validated an issue in netfilter packet duplication. The bu=
g
> > is reachable by an unprivileged user in user and network namespaces.
> > Bounded tests exercised the fixes. Non-duplication packet semantics are
> > intended to remain unchanged. MIRRED flow offload for affected netdev d=
up
> > rules is rejected because it cannot enforce the duplication-depth limit=
.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
>
> Series makes no sense to me, sorry.  I dislike the 2nd patch, I see no
> reason why we need to make changes all over the place for this...?
>
> Also, if we go with 2nd patch, why do we still need the first?
>
> > The IPv4 and IPv6 duplication helpers use a task-local guard while a cl=
oned
> > packet traverses output hooks. If NFQUEUE suspends that traversal, the
> > output call can return and clear the guard before a later verdict resum=
es
> > the remaining hooks. The resumed packet can reach another duplication
> > consumer without the original guard. This can cause repeated packet
> > processing and consume CPU and network resources.
>
> "Don't do that, then"?
>
> I think the kernel should not crash when misused, but I don't think
> kernel should have to do extreme stunts to detect such loops.
>
> There are probably many other ways to make kernel allocate lots of
> memory or waste cpu cycles.
>
> E.g. via create use of veth and bridges, sched plug, teql, ...
>
> > Patch 1 records the
> > guard in the queue entry and restores it during reinjection. It keeps
> > bottom halves disabled during the reinjection traversal, restoring the
> > verdict task state before reenabling them.
>
> Its small enough, so I have no objections to this patch.
>
> > The netdev nft dup path has a separate synchronous transmit recursion
> > counter. It does not accompany a duplicated skb through asynchronous
> > software receive paths. Patch 2 carries a bounded duplication depth thr=
ough
> > skb and supported XDP conversions, resets it on reused buffers, and rej=
ects
> > MIRRED flow offload where the software depth cannot be enforced. This s=
cope
> > covers software skb/XDP continuity, not packet loops through physical
> > hardware or userspace device round trips.
>
> I think it would be better to first go to the drawing board and make ONE
> facility that governs the recursion part.
>
> From a quick glance, the difference is historical from time when
> per-module pcpu counters were used, so nf_dup netdev could not see the st=
ate
> of nft_dup toggle.  Now that its in task struct anyway, maybe its time to
> just zap the egress recursion counter and first make a patch that
> uses the bool toggle for both egress and normal dup?
>
> I would like to remove code, not add more.
>
> > At PRE_ROUTING and LOCAL_IN, the IPv4 and IPv6 helpers decrement TTL or
> > hop limit on the copy. Patch 3 stops creating copies when the value is
> > <=3D 1, so the decrement cannot reach zero or wrap a zero value to the
> > maximum.
>
> Thats unrelated problem.  There are other places that do TTL/HL
> decrements.  I think it makes sense to clean this up in -next and
> add common helpers and then use those.

Hi Florian,

Thanks for taking the time to review this series. Your comments make
clear that I have not yet presented a sufficiently simple, coherent
design, particularly why both patches 1 and 2 are needed.

I will go back to the recursion-guard design and first evaluate
whether the existing current->in_nf_duplicate flag can be used by both
the IPv4/IPv6 and netdev duplication paths, replacing the separate
egress recursion counter. I will check the effects on the counter=E2=80=99s
other users and verify the relevant egress, bottom-half, and
asynchronous receive paths before deciding whether a task-local flag
is sufficient. I will not assume that it covers asynchronous paths
without evidence.

I understand that you have no objection to patch 1 on its own. I will
nevertheless check whether the unified design makes its NFQUEUE
queue-entry state redundant; if not, I will keep that change limited
to the NFQUEUE state-lifetimeissue.

I agree that the TTL/hop-limit change is separate from this series. I
will leave it out and consider it independently alongside the
common-helper work in -next.

I also take your point about scope: the goal should be a simple,
coherent recursion guard for this duplication behavior, not a general
mechanism for detecting every possible source of CPU or memory
consumption. I will return with the path analysis and a smaller design
before sending another series.

Best regards,
Zihan
