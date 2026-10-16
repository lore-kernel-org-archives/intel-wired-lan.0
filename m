Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7F3CC6B38
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Oct 2026 16:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9C9E60B15;
	Fri, 16 Oct 2026 16:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gqLPbrZ_CvVl; Fri, 16 Oct 2026 16:12:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2262A60B1E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792167167;
	b=ClpnE543fTukZKTU+JVMZ26WMK9/DC3krBI0X2dciuGytRlnhQZciDqEoLD++UT5xzTt
	 3Fm0Z5I4Lvnr4g9OgcFgBIwfqZbolhTJy5reYkpG5PAbYxpEgjaO8qNWvplZYJppnG+CR
	 hSH+NUROmYG/MBk4hAfwxgA7i06cRB+59WH7t6qYesF4pCjMyI+C0qJ8yxDZrWAKXhiF1
	 HnpPsgmLn2WNRuXf2+ymeXScIPPJs6RrNahkXKRnO2tfbt+vgH/PQ4FsirZ4G+G0nxImI
	 MTo2UkOzrBJ7s4reoTyoDY92DImleVHPmdTiZgXYB1i9UD4WDhemLGZP9/94uq3zFRA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792167167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
	b=QrBgz5kybn559kU+3RTaiTF0OwImGxdksCjzVX0pHzkrPVBVUKq1HtMzcKaNxIIJidXa
	 wC7th/fTWf2/FMYaYtHKy+QnCj/8E5pgLk3442T0NKpHqpwNiKWChner0GLbTUEiVk9yj
	 P6J6Ch6elxCvJH7aggmAmF06F+PfIqdhEmypCPhspTRx/ozyVy6qFNn5evyX/ceov+Jq9
	 mT+Z8CBdkEa0Vwcbz/TfO1YrLxtedZiqjxhff4iktCIKm5FG/Z1IDfXisOHPKRjIySotc
	 EIlxQb9JEvC1eui/fAcXyivzXZ9TV2kT8R3EPN2lP01VpvgRC3wd03iyJkfyoO6ndMA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792167167;
	bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QTuOiCInOczRPh3DIfpLi5G8YecyH6BV7NRemA+d9e2sPdr52BMg55/W/3zG/jykt
	 yYkp78VhuZXn3qKks5wq8KLPdaJFBM+DCMKGZeVVp7/DaKzfxgedJnrB3sP08hOBnU
	 h5Qmww5esTtDTCIIp5kohUX3YE3CnEf7q85iLi/PxednGPZkC+wKir5+iwwBoRPi1X
	 xoyKVbtiq74MEp+WbKLN/KiC/lfn8DMJaT1t5el+4xhUxMvN/1QbAzDzQ7wDkn7hUF
	 cVmk1AEmFczTvdN/gxdCP2N4lj/f/1IHvrDNDnGJsorYIUO7AtdqtK7JOfC9sE9lZf
	 9JNOBLUVyAomg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2262A60B1E;
	Fri, 16 Oct 2026 16:12:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24D1D79D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16F88813EE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wDkL_nI__Jra for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Oct 2026 16:12:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2EDE812C2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792167164;
 b=eOZLGnJqUyYcglwHDfVvQ5y/ipNQ/1sCnCJjVIOs/8BKK5b6EVQWnwcHoJwArKkkgnaf
 /2xOW/emnH3ZxKmHoAG332OXBL37hkd6UarXpzMF3TK2m9A4roouP4++IAYhA/T1AwMF7
 MJG84dJTXJMXrrtXoucR/HPs41dohIFpFGPeYuvpDpSsOLbgo528uZPyoMFU1vDt1UjBl
 zneyj63aM7gv4SN62JSD9YnF60Gqo1hH4fX3B4KBPqlGjHZn8z22X0Gb+Dtf1WjYCF9YV
 oijUijJgBCakws54PfleGVwAxQFxi4WGwYL0Dr5ZtX4/TSkJdCFTnKVi+w11sn87opQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792167164;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
 b=pSzN2iCv0g+/V2dQIulg0/sR+0LWcDwj8+u1Kh2RvRZnw1jSYyc6r7TrwHc6mTO/WNU1
 95RGt2VzuP/EcIDNlMg/aB8mlJKwGkTWQarzqTdmKhI45BFwiTd3LjZvTvHlyWmrPYiuj
 Y0RvAV656O35hOqqBXChKVojJlo3gDU5Or1CQ6q4YjSxichnPzrz5tWHBEzelZjH+pMhh
 A7fYWlTiCaGUlPG8NPs4ykn7imzdshUkYoXUDvb7WN48oZGLA3cJ9EWWc0lyX/p+6+Sb2
 sYxtE2wCMoUc7f9G6QhsRGWfQrb1zUgLs4lG42hurMObOAeF1HhJ7OCcD6nXi4a27oQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=nebusec.ai;
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=khuwCyGf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com;
 envelope-from=zihanx@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=khuwCyGf
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2EDE812C2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:12:43 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3a772ec8389so176581fa.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 09:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792167161; cv=none;
 d=google.com; s=arc-20260327;
 b=D+YGCKeCUgJ9/Ovp2DF7SJWl42HJyGKbpWZ3A6inIyLg9EgQ3ZzSZrxRONPlHFYFha
 dGeCxKavtV0B0O5bIjwaU0T4fzz1gzByqkGQ/CErgjgCEY1fTmXDGy4eI95Y+UTgOrVm
 6yzytW8Bkas0eleGY05pB164UsGgAVjJes6D4edn0O4obgPGMpK0r21ZLBaC0fOuuEo+
 poyYQ1p80xOXC57Fgzr0bVDiss0OfsQzobiwgjOS18hO8i1/nPMtX2QqHro0TJcwQkcf
 5x1zbXO49hlS+HIfVj+Ji8lrhfnhNvvUpIc5EiKe61Rvnhj2OJFkwymL0s2HkKC6e34J
 +Zww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
 fh=4MY/kNsJ+18wrfWQHPpDx58cFiV6BSNAxg7/UbkGfLU=;
 b=Csu9s4F+q9HET7+COxU3fdPYn5lEvHvXvRLNbLWjmI4qY+X/aTBXArIf1RSexnaCef
 mfejLUCIvuR/xA96+HGW0K1PSCmew83cw5fg0bm2sxyjOM7YXi/L6EofWTQBpw/oUOed
 P/xpm0Lo6jbGO+bIg7UlAO56gXcCHylyxpZktPP27HoLSFcA4Wn2FXqbekOZKJHOucoK
 8gaZ2JTJx3sdqtK9770VYavyEoC8IFSTjQS+z4pU0BKJ1fwm93F5nUB47Td/eMMspTMZ
 hKdboiXyPeCJq3vyr4lt7y+kfsp8o2SxGpH8pTggQ+WeWTYLZgMCx5Nu2vTUvjafcmOH
 NkOw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1792167161; x=1792771961; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
 b=khuwCyGftTIHlPzAeFOd/NZt/BKWwP10iRW+qt2UKJi3LURopB3Naf+lUAKUXAh6mp
 RtT0yDjYUavYcrezAk7uB1oMIWRxFV7jbWYo8ugw/lv8t4Q5srbNoUq+TaPo41+N1ui/
 FDTrq1QOfalMd2ofVcv28ZLd/K4466DGsSA54gEIZaeWDa0UC0iLY62BeLDC1WqQemQ+
 FUVFKtSH4rI8Xk9KUATunitWMiK7PkK1L6AzOKF81kSgVYWucq5aWH2k6iTOMIBk3A43
 lyKxpJ5mpbovPKVb5P0WZKmMRxNDjMYz69KrXrdTQ4Bmek3dxRQYg6vWVEHRvaDblP+r
 l/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167161; x=1792771961;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1DBXJxHvquUaLKJ+tkdkfcHBt7XZVv/oRHXlHwD+SAo=;
 b=fhjtjx3xRbLFSD9rAimwPrVfdSUxpPzcieNsMVDw4qSl9BRG//2Moopkaayci0+yN6
 8KKBW4iYfKiVRrJq+zaG1jKr503TP8jn9KyZ8ZVzzPf362tC8gzwjKHOcJ95H9ZEgiBR
 wL0+yspYASbZse7PNhXHHeKuPoCecZ7oNPnv4Qc8MH1YkSRwbNFiQ77yv/uRhtw4jbJe
 gAj+rUV5MOQ2givoNOpymYlVElVPNv+iY+bV8v7rF/gwKKuyW9IEcgmb/uRhp9pyWMXH
 iU875pFW7f2he+OcGmzYmoEmUh20hZwhguI2/5358xJw+GgZfULek2/LcSuxnYSkfwfE
 AqTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOy8SB47s2I8aiKa3HHMIG2r1kzyYI1QV5Dgt902d2m7FvnbEVAgkgCrWk76/QsMk0G4Z3mrwZ+EIV78Fwnjc=@lists.osuosl.org
X-Gm-Message-State: AFq9FYItDiVTthuPjVuOHXQV54muOASJUOO5Djxia+8YIMSPvskGWJMg
 p1CDFYD5+BHILx4K+6UOVCgJyUapfJPnM8aJohW4N3WMtVjOh84U0BIZKtu2f1Il6Cq3ocTaDOh
 6VmgkukBCv84Wh6QcZFYP+qjqCI7Uc/hsnn2naMI4Vuk=
X-Gm-Gg: AYBFou24I2vVhz0dDI2ua08xLvTWmzi9uQ0dFVYUtplZ+Wtk/f+m3ZwC2CIl/0z07kx
 UlDq+pgEig2TSIgAfcZFFx0CbKMOby7OuDNespU9JIrehOrKbhaX3pMbVfYvrJuHxFx4WTIL9AX
 nJGan5gATxLff2UhehbPjyLC8I8V8jBnO3kpgFerR1P21tqCwPP49A6HhR3Haue70l35t+vfmeX
 YX3lFfGPSG1x7NV1UkAX5JPvMYv71bfBqOLStPPdt5BfLdYrr69bDqyr/QAXkz2kzEWyL//CkRY
 fjzgGRoRJTH6LF3H2SiFwJNdV++/0h8w5zFBfwb6W4kZ3RfAZ3YT4iixxHqgMjlzEUp05tGkA26
 DRcJM3RgGeQ==
X-Received: by 2002:a2e:9a10:0:b0:3a9:c840:10ee with SMTP id
 38308e7fff4ca-3ab2927a909mr511431fa.5.1792167160733; Fri, 16 Oct 2026
 09:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792048855.git.zihanx@nebusec.ai>
 <atCtUFcG9b4ykXY3@strlen.de>
In-Reply-To: <atCtUFcG9b4ykXY3@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Sat, 17 Oct 2026 00:12:27 +0800
X-Gm-Features: AclHuK9WXLPZ_WQaM633BzwfDjRGTUWRZmkMt1BFBbMb-E1VSzEd_hb2wxJXXZk
Message-ID: <CAANe3eTSz3-EE0=9JNFBMFDqZ9NUfScHdi8EN30UVaTiRq0vcg@mail.gmail.com>
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

Following up on my earlier note, I reviewed the NFQUEUE and netdev
paths and narrowed the proposed fix.

For IPv4/IPv6 duplication through NFQUEUE, the queue entry can preserve
current->in_nf_duplicate from the task that queued the packet. Reinjection
can restore that value while hook traversal resumes, then restore the
verdict task's previous value on exit. The reinjection path also needs
bottom halves disabled across that traversal so the task-local state
cannot be changed by BH processing during reinjection. The fail-open
case is synchronous: the queue entry carries the set state, so the
diagnostic must not warn merely because current->in_nf_duplicate is set
on entry.

The netdev duplication path is separate. It uses
nf_dev_xmit_recursion(), and the current counter does not follow the skb
through asynchronous software receive paths. My earlier patch 2 tried
to cover skb/XDP state propagation across those paths, but I agree that
it was too broad and complex. I have dropped it from this series rather
than present it as a complete or sufficiently small design. I have also
dropped the unrelated TTL/hop-limit change.

I will send a one-patch v9 series for the NFQUEUE guard preservation
only. It does not address netdev duplication or claim to provide a
general facility for bounding every asynchronous duplication path.

Best regards,
Zihan
