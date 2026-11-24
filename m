Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B04606A31E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=eBI0KRAM;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv8dHSVA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F17BE605F4;
	Tue, 24 Nov 2026 00:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jI3_J7iaaLlP; Tue, 24 Nov 2026 00:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 199546067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795479477;
	b=HiaZe+EP+MiqIZ+eUzjzhegIFbi+Cv8Y3Vp9j+CBGRtji2hD9keFA/rxy2jFVO6aJ+64
	 T6KfYw+ZqPHlttPuxAcROGR17dZtFBaH+YND449gsAN03NRk95ZEVYPTsXpy1fh5QLP9N
	 Hs40aSsChBeGEmOXbneU76fn053SEATSGsvqrF9HZfHFo5RlAiACqDCpS8390cDHNQK46
	 LYn4OYYiBP9LwuTia6UZ406m04U6FIue0z4nCgHI/grIzRXWQJNy9dREJ8guqrqGPzx1A
	 0DwuoXAyzHzR6d0fKH/Mg7GVgFCWBq0hfRBPp21jRcEieRJscxyE9knqXv5uOoQZ9OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795479477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+f8XxVCKUeDTBInFaSnUJudwLzQYi3S7MYVKIfTz7Oc=;
	b=HAOgzioaiRQMajda3s4/9fHm/LG6inptBS860CgOWt0q0MfAai5cI2JAUUOdoPvkhDmd
	 bE58mTIXSxAB6sidHl2vGGsB6UNHkrxzMAgGQJlWObtJsRahd2j6OoCkH2AvCe9+m+ULW
	 DJwdxpBQMkcphxsy66FujNSZ5XAX70wNvkMoXeVKV+btEz63semT/94ybcOhs5hb3+fHL
	 tlGE5ZqfMK32pkfJMJzvhFpLIdrs8T/CGr8IlZ0jNgJTiowcXnFdB1igMkWpbFV4Oj0z9
	 IySuPQfBi5RFA+7LeGORf83yUZWeetAw4p7sNqoAcSBk678wXMvIgLGp2Z3MAVZd9LQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795479477;
	bh=+f8XxVCKUeDTBInFaSnUJudwLzQYi3S7MYVKIfTz7Oc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eBI0KRAMZOzKivDigulqkfgtepWiExNZyXPpQaAcmGy6kj7fETMOMkN76D10TGAj1
	 HlfNmsLTywt96emAdIIw/NSALJEsSHET13HrXOx7aEQ2hHC0O5BhtFawXHWe4kcihX
	 1PnNnBrrtUykNBlPTbQD95oajxNAM/7mRI4tMUf6rtehwfr2EMbAqUJBuxrYM4fQ6c
	 2b9GzGGeJuE/XYvbfSf9ttX9dIHcn+F1At5VgQtdB5vljqLSz+OCq9t4+fCd41igYl
	 bi0mn7MBBD5WhByseY0C00GGKPt7KbUehjBHxWlaZIoSniNSA6LT6ZBuTRjVFiidit
	 R61Jry/F0K3Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 199546067D;
	Tue, 24 Nov 2026 00:17:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A26FF3A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 00:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EF9A80E07
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 00:17:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWod8XvWbRSQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 00:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B03980BE9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Jv8dHSVA
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B03980BE9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 00:17:53 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so24798095e9.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 16:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795479471; x=1796084271; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+f8XxVCKUeDTBInFaSnUJudwLzQYi3S7MYVKIfTz7Oc=;
 b=Jv8dHSVA+QCGmryHNHA/mhSAWPjEirtvFb8ERBri+OYkubUYk/1GFMNGjzYi1oGw0v
 tMHkKczjZDQ99bXw0qTIFgK4reFaNJRSYZ4y0vyUoELHjAzOVhjvenalLQpJqS89Wn7W
 l0B7o7GS+c1AWGaqzjZUBMyPhNcJ3xPNKWvctqZl8pndmk5p+NEv1o9qs4efqxnKeUa/
 2Y1HVodOnTDXRJoPaHwzx2iwvtVvqhCXKbZN3SgEVJB7PD1hiVpNCtUO/6u0ZM/542wu
 fdWg5V3ICeVBEuoSX7qLufPomAW4jKmPLLkSVUYcTcTn13TymluOvpiLF6mfsU6Fhldr
 A3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795479471; x=1796084271;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+f8XxVCKUeDTBInFaSnUJudwLzQYi3S7MYVKIfTz7Oc=;
 b=gwH8pdMqIKnmcmHXEL9PPG9aO+/2/5UvmTXgSgT9HxaH+QOOUVLjO9JC7O+nsF4LHQ
 fUIBzXYLi/SSZMt1k13cqFFWt6eJ1JRUfAe7ilxTlGwBD0nv6C2XoNcUNUJyWQYH/U4k
 LBOJls24j1tcMcqNUfsSFjXtAlOZVWxjWPhf8r9UhH8h5rcoJdaKc372yzTv4D3iY+st
 rQeBUhgLwKdQxuqrnaPc3k1Iok4CTBjyPKiczsU8AiM8Sw1cuGk94vqySweLfltnlX+T
 oixsUrn6S6YnEgCSs+GLcCnzcecG46xNT0hXlg5BjAsJ+Mf9QmB/XEtCi/aqBBOLM5RH
 m7lQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFobDIPFzem+CxVmuHSphyB3HI9Fvr3Fwdhtzs17wLtsMTGvQtgqxgimvQ8I4r4tDvPo/DSRaoQQvM4NAjKoHk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9S+Mbk6b4S478M0c8vpOSJEV4AuW+fFjyAtwKWf/AeSKBUpdAt
 hHTyx3K2UFsTWyA1N6LdQJUFcDKZioX2DgR87oVocJH+CM1aDp6aHf+0lyK+CMDdxSJcDCOSb2V
 ClBJ3rIxBgmZ+1xh/lba12uYsMSte+H8=
X-Gm-Gg: AZFdTZdXXT4qvqEwYuoj6lPQcqFp0aNxSVgNI3ERU3KV2wzAX8D2cQ76yEcpxywOL24
 8G+u93Pwvw62kH1qPx5Xy7e4swrvEkW8zoP7nHnyELxN98ISFZxXV1u7K/PgTFHrnYuCurjESAL
 UNupbt7FpjII4BekG1LsZJC01UwM6Zw4I1QzB6n0AXfwZI6fd6HWAb2qEOdWot69RXvlUIQEY1x
 sWLFdpWFB12LewwcaukYiiex1SExTcsyAQZUGaGVKfJOFatRU0heEBXV+hrIJMamW0JpoOKap3W
 bk2Zzc0XPF9G80yPb+pK9eu0/Xe2h/GfAisvy2QT+NnFEyhtpQ563/oL4FxxZsweMcTFLJ3PybC
 BJxZWU+WuX6WdiLs61uNUWP5wBKDBTbH55mhzaeljR8b1+uACqqQzQEA2MgpMzdAvyhHa2zuMmH
 KFxuDxHoUP2Dsbc9i0irwdgeJh7Et0OIV56VGtKPXCuSaLiB+9pxiLVuw=
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id
 5b1f17b1804b1-4bb888160cdmr282174825e9.14.1795479471368; Mon, 23 Nov 2026
 16:17:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
 <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
In-Reply-To: <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Nov 2026 16:17:15 -0800
X-Gm-Features: Aa3M54pXq6mr_CU1bdkLP3MSJC2lLz1GXmfjYby6zsKSTGadaC_FLxjN5Btbots
Message-ID: <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>
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
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 3:26=E2=80=AFPM Tianyi Gao <tianyi@cloudflare.com> =
wrote:
>
> Hi Alex,
>
> Thank you for being so responsive, and I really appreciate it.
>
> On Mon, 2026-11-23 at 14:42 -0800, Alexander Duyck wrote:
> > In the mlx5e case they were disabling the feature via the private
> > control flag if it was enabled. In the case of your change you are
> > just disabling it without exposing that it is disabled.
>
> mlx5 does not change the private flag when a program is attached. It
> sets MLX5E_RQ_STATE_NO_CSUM_COMPLETE on the RQ, and
> rx_no_csum_complete keeps its value ("off" by default).
>
> > is it falling through into the CHECKSUM_UNNECESSARY path with all
> > the indications that a tunnel was still there even though you
> > stripped the header?
>
> Yes, the same path as E810, and mlx5 does the same with a program
> attached.
>
> > The issue is that the driver is making a number of assumptions about
> > what is there based on what the hardware parsed for headers and such.
>
> This was discussed in the thread of [1], including the decap problem
> with csum_level. The summary there was that reporting
> CHECKSUM_COMPLETE on the XDP-to-skb path is unsafe, and that the
> safest option for now is CHECKSUM_UNNECESSARY only [3]. The decap
> case with CHECKSUM_UNNECESSARY was left open as a known problem.
>
> I am also working on the long-term design in [2], though there is
> still a long way to go. Please take a look if you are interested.
>
> For this patch, my aim is simple: stop the "hw csum failure", and
> make E830 with XDP report RX checksums the same way as E810, i.e. as
> before GCS was added.
>
> [3] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/
>
> Thanks,
> Tianyi

Any reason why you couldn't just strip the GCS enable flags from the
rings when you add the XDP program in ndo_bpf instead of having to add
a check for every packet if the XDP program is present? That would be
closer to what they did for the Mellanox NIC and wouldn't be adding
code to the hot path. Then it is just a matter of also adding an info
message that you are disabling this in the log so if somebody does
have to figure out a regression it should be more obvious.

Thinking in terms of what the final fix for this might look like,
currently the drivers are already starting to carry stuff for frags to
determine if they support jumbo frames via frags or not. I suspect we
will likely need to do something similar when the time comes
indicating if the program can avoid corrupting a checksum or not when
it is stripping headers.

I am not super thrilled with the idea of this becoming standardized.
In theory this would be much better if there was some way to pass the
data out that the frame was mangled and what the checksum adjustment
is to the total frame. As it stands we are probably going to be
getting CHECKSUM_UNNECESSARY on everything even if we don't expect it.
For example I don't know what will happen with an ICMP frame sent over
this tunnel. I assume it is likely just discaring the
CHECKSUM_UNECESSARY since it isn't used.
