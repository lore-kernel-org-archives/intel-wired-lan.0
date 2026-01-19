Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FB8CA5FA9
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Jan 2026 16:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C920180F74;
	Tue, 20 Jan 2026 16:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5JyzfCAw1zOZ; Tue, 20 Jan 2026 16:26:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D827380F72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768926372;
	bh=q8D+nrqZsm9DrZObP52Gb97lohlLVUehKhiIohn1eHw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qnaXF5g+lzb1gtKdADpO+69YHw+KHn9Sora1Tl7qO3xDZ+zGwnU2bwa5TbvNXt+Vw
	 Njqz3r4jI/niqJFfXH99MTA8TJLT6Rxc8uuvx3Cn4hUW/NDLDve0JOb7dXrQTr4mnk
	 hk5IYRqfKAQXBUunWLZR+RNbs+kV518nYNKrpb50Ioss89Sv1Z0HDEUuZLtFcUj+NG
	 ThXb0cL2rjfnnk8hesGUKAnH0uiosHM3ePzcpUq0YrEHXA5zNfqwgUwCNyRnpF50Fu
	 IujtjM4tWp1WWOMGSF0GQ8zqIXDsh9DtefzkjHC5OU4TEDCScoTUxoOqgJgoFnvpm8
	 GwSjqaDlWIOOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D827380F72;
	Tue, 20 Jan 2026 16:26:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64A522CE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Jan 2026 18:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F59B415DC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Jan 2026 18:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8bmvSm3xlSZ6 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Jan 2026 18:08:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=mmyangfl@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6FC7E415D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FC7E415D7
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6FC7E415D7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Jan 2026 18:08:25 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7cfdf0c8908so2098355a34.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Jan 2026 10:08:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768846104; cv=none;
 d=google.com; s=arc-20240605;
 b=T8YQilZa95QAJY+xknF/pwK+vVe36aSi6lmjQT9GSKQPBIkjO3IGIj45jWtBM4/qIY
 XAHfhweEKU8WBF5QyRnzGCLNuiA1+dMfloc0P+vzx+PnoIoex1d/htccj9Kpdl/kGCrX
 /qPKyDOHnU3aE/PG7iarlvB4ViibrssV7eGPRa/FPeD3/TdiGtbJpXGCieQ6e5ETmzoF
 Npv+wrg2i788rfUKPuiPGCmwCkFYs0rfLiayW/PaLee1lJcu0Co/jyxW2wA0qRHwxi4w
 jB3WHYkyJiZJEee/grWfErT1Ce2c2sWV6ReGGZe6UAHY8etw5eDuc6wzbQqYo7HUYKdL
 iFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q8D+nrqZsm9DrZObP52Gb97lohlLVUehKhiIohn1eHw=;
 fh=f251vxVJiP3276P+l+Dz2kVTvMhvKiHJaIDj4tFoS8o=;
 b=iEsiC0nMHQj4UxBDgPGJowEXWBerxz7iwm68s+RdjFkqAjKvcPp83Xkl3l9lETtqHH
 YNy5Wmkz00ri4jWRTAwT1uK+SQpjAIj+LnTdc9HUP9ZqA8iOWU8s4Kk1SLVcouvAxy8p
 OYHadpRnPCrsNhcOEC6ZC04uGiXTa/70LfpW5HfWzXJ6m7dd3XRYT5+19nXpntogbdFV
 FwELP1tKDxEqyiv6pTIogzG4Pdb88JmJnz7N8T8VNS8aDPSS9iTz0DQdsgxVRQq5NoYl
 iFyTmkfOIZufsX5fE7mi8s6loApzitqb7EzDJf9ypuGjdWJCzYOQrR8CPKN2PGhcTx1J
 Y+Hg==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768846104; x=1769450904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8D+nrqZsm9DrZObP52Gb97lohlLVUehKhiIohn1eHw=;
 b=voNUpI3Z9BiSVAUWPaIRPWu8VCLwZzbPg4PqL82DBQUmAcdc+SeYgl2sS02sVsFhBP
 hSqi/F1zupD/Q/8qWTvk/CjBPhR3f5jp1TavsZN6uOWQL3fofkd5WUf7vUPTPVQKrx39
 w/hD7x1ztl8eGUYFaKVOHnUBlIh806Vk52qu1wpjHMeR3tsESxGC4iBr1mq4qwp4DO6y
 hn5nVzcWVi1JFiGun5YpupMP6ibR2xYF/5d0o9G57cQ/0+KWP2oDlY+x9U7Gx7S0yls+
 XAepnxpbaO0m99DjYOQD91f9ziz998dYD4sTni+sjfEflUwmyyz6615sMycLd0tkq8U1
 y42g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAu5vHZlII5hZIkUSr+iZelyFpzZ7182hKECcp+S4DEaxZO4UrBJSgvneWPi4Jlw3vSb4OgFvjs8MOQx5cf+s=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzJ3qPM2MrayUYkoVssgvvNIwJtYPSoorGzHbY8GZ3d/L7aPVZB
 knyAsOJV6jBRWpKjVHNgHscVrawTg8zKsEwRd7ZP1jV0oSxohnrsF3470tYAdOhSljFJ2ESb/0N
 9hQBDYO1++GBI8IrQ+8iWzGgruVJYry8=
X-Gm-Gg: AY/fxX4muqJrDh9Qig6XsAtvn5cl5H7mrLnCY1sa6n1oumRdQW1kYS8LbOPkjL9ivMF
 Ngtx5Wmka4ELujtekAagcn+iVOSDpfqpv/BJdC9rneGkFwq4bcIxgkVyeZ0r6tQlg1G0dzYDtmE
 ZdSo7W785RC9Q92RocdM+lgUob+PDDUacCqL8WM/RLXnpvrBNoBOXU4RS4Zk6Tq+1SDaL3u19AE
 XmfhCHTYz2PcN7aL1zQgP5cQq9OEYDVHirJswm9i8c82gL0XnQSbEfjYJS/flqWyWQdAd1QfptI
 ylWxnEQgMP8wp5TrnWGsB7uIM0TdLmsG2fekPuPKCroJAlcdcTdgprBVUDI5
X-Received: by 2002:a05:6820:1787:b0:65f:64f5:5b79 with SMTP id
 006d021491bc7-6611793d4bcmr5481444eaf.16.1768846104301; Mon, 19 Jan 2026
 10:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20260119162720.1463859-1-mmyangfl@gmail.com>
 <CANn89iLuo+A3M0BSXKJwwsd4T+crXe8u0KiAns7=ks1TXnWaeQ@mail.gmail.com>
In-Reply-To: <CANn89iLuo+A3M0BSXKJwwsd4T+crXe8u0KiAns7=ks1TXnWaeQ@mail.gmail.com>
From: Yangfl <mmyangfl@gmail.com>
Date: Tue, 20 Jan 2026 02:07:48 +0800
X-Gm-Features: AZwV_QgYa-0zOYsjzwo8YEi6ZVG9_cSElG1hlh5M9B3SsCMIK1usQ7MzaKlTl6c
Message-ID: <CAAXyoMMbfUL78oq3MOk0G0sjgA6jSXHYz2m6SbXqk-cpB+P4ig@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Phani Burra <phani.r.burra@intel.com>, 
 Willem de Bruijn <willemb@google.com>, Alan Brady <alan.brady@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, 
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Jan 2026 16:26:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768846104; x=1769450904; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8D+nrqZsm9DrZObP52Gb97lohlLVUehKhiIohn1eHw=;
 b=KPkXT68tePPsLdFRyvfhA3BwL5GNeMaXb0FVI4ZhPb6CsxaKYB2UpbHFpok9lhOcVP
 U6OyAHUbLcBdUO4rmAg/soNJ4pG9OGLCyDh2iAeVEmwnYbZk1uQBqRJR8l/NYIKvpZwb
 2saQ+6h/IGIOhz30CbHlkgwrsENsqiVLvnw/2sL3E1gYuNGMSmDo3XSkKPloAOvFPmQE
 +8ffCmNlt6PQXnHJp0ONA0TAgcj+78mO6h4uQ8bJOA4uaRJWA5PCwMQfDxAtl3EL9z9A
 O75F7GBnCTungGIUILoxLqLw4P55xSciaAZlo/EaHILKrI+sn7MU8kK84E3+Xr77wH50
 jooQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=KPkXT68t
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: Fix data race in
 idpf_net_dim
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jan 20, 2026 at 1:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jan 19, 2026 at 5:28=E2=80=AFPM David Yang <mmyangfl@gmail.com> w=
rote:
> >
> > In idpf_net_dim(), some statistics protected by u64_stats_sync, are rea=
d
> > and accumulated in ignorance of possible u64_stats_fetch_retry() events=
.
> > The correct way to copy statistics is already illustrated by
> > idpf_add_queue_stats(). Fix this by reading them into temporary variabl=
es
> > first.
> >
> > Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> > Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> It seems ovs_vport_get_upcall_stats() has a similar bug, are you
> interested to fix it as well ?
>
> Thanks !

Sure, I'll take a look at it.
