Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE10E606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=X6SjuI3i;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iCqs9lXP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAFEA60603;
	Mon, 23 Nov 2026 21:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ah2cUbdN_SvO; Mon, 23 Nov 2026 21:10:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 21A836067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795468215;
	b=lH47F0/gBDTbL7RbYcnWHqjlpZ071jwewIs5J8rj++Nyk0Ll/OHFpZ9mj/MKiMNfZ5Yt
	 xtOAbO4H69zq8/GaUBsjRcGKox1Ew6WS9T7Tv9IRfzRyaahnS0agF6u3ULLCLW+1zupXx
	 vMM4iDymM7uzbteDDuy13j48Zdd37pfy2zrHylbldYj0yoqIaDli2pbQ7YKCr8nk4DYaI
	 hfWUc07ecrr8w7QUAMcfcCVLMUgtanGohxfTAse4EHv/81hliwcESSWB/eX6Vu12+9qg4
	 UUp1QVsOFdvtLNkUE/MTLEs37OJ39qHCmdAJZM+Uq6RKbsK9o+ww2OMSNwVlw1EWvBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795468215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FkFupnOVJ01TJ277CJauG6Yuwd78xHj7FKn66yy/ozg=;
	b=awZVGgSydZigjOL1v+rsDLAG/gbxuqkRMYNoiAiQD+gffQWAaEIyLc5EonADQbSS0vfr
	 mzJhn7L7Et3JHKfv8IaaT0qJMjy78+VfMZ3tcxofCI/F3RInt/crmDIfmsBhTs6q+B8+L
	 /4ykrNN3wEYznCb+lQl3ctmaVrq6j4NlR0asTZPaUO6a+3GQBvXerDiLGo/9U/jszZwGO
	 F+DQQajR11SOG7DDJy6R7kGcvJoQFz2sZbJLihTPJUNS2pWltiCAgAg0Jgm/A6S7UTjT9
	 UByUiJf38m1yRTGUbqzy/QGSHQmLJSGLph+xfPjp/0PGSefE0UlHc4AxO20Jwx86dLg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795468215;
	bh=FkFupnOVJ01TJ277CJauG6Yuwd78xHj7FKn66yy/ozg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X6SjuI3ixvaIUxbiV3DJ7vIvji+JXP2kDfEyHEbO1ZsP6VrYLkqxVCyJybMeXnINq
	 IADnZYO2NjU6cQW2pwWdbF9NfOSBoVEwhNKunhS5fUQh0+mTeLqeAEs6TEx90OHbSZ
	 pxKHgVP/8VWCAfPtWT75/ReFQ0fD1V85ZFMRKR1wFER1VsM34WWR6+iWp3Zt6zaNbl
	 RW3sRrRse3KAmjRjHjmg77gXuQxpLqTsMQD3DVJW0I7kWJion/iBC13sT/sHAOnlcr
	 NHMOJqUAoKL8FJGOL6gIY+ir1EDchLXabjWe8Q9TK+IY78hjm66wQl0RvRn135xmQu
	 +1kgSD9g9JiLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21A836067D;
	Mon, 23 Nov 2026 21:10:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF83C22B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1075406A4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1TyqYwVzItDd for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 21:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC69740609
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iCqs9lXP
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC69740609
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:10:11 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4b52fcb410dso589537f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 13:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795468210; x=1796073010; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FkFupnOVJ01TJ277CJauG6Yuwd78xHj7FKn66yy/ozg=;
 b=iCqs9lXPMlHBPBaWSXW5ZsfGe+QtPNz0UTV3lQOqWuSpEBKoAPiSu70y5yUTa7Vqda
 u0HITQZyHjiiH03owAVW1kVwB3SbkqInK8vC1tNfv2Tt4pgmwcnVFAWbLeK5gYRZWq+x
 bB1X/dsdQMF7O9VWeAD0p4JBfg4Igb7HRMfP31vfCAJLtIbc9LIqeumYGAH5t1n7XO4k
 MKo2Jv9pnGfGxr91q6VuFn8fa5VQKlIyBjUT4DkyJCwJNcs2uOAiypyiGbUTtEZb4fw0
 5DgEbGSuefFpDYZ2lJdOFpeeZwus088HaG/DiR1EPaKgLLnINDQ4dKle1vMmvdXSKaPd
 aMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795468210; x=1796073010;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkFupnOVJ01TJ277CJauG6Yuwd78xHj7FKn66yy/ozg=;
 b=F7LGUpeE9OW6EVSl6VpS8MvxIv1Rlf6i/ndfWFfHhh9QxJ2S/6oiYFIx9Pq1Hnu4wd
 YjhgCvslUKT7Iaqu1n37zXvxlFHySq4ukAnvFiAqVzoA7hnq0BjjinIjLoH5mxaZwLR0
 IDCHLUn6qZaa/fm0ORwIiWgw5M45nHHVIxJGIdcBKYgYri8jXYp7DWFjz54ax3o8LXWX
 p5isyjAH0WbahY56z2NHTjPZfIos1zDJSOxpmT5NfpjiBw5Ctqj+abcFUpNlEhxP7YmH
 aUVz8ojCl781ogDV5QOAfIK+Eg/l8lissPplLRvlOZB/GhqqjOXFihpY0r+dQOz/yYfF
 Da3g==
X-Forwarded-Encrypted: i=1;
 AL+hErGbfHAGmJICk4lkEKINhRRk2wu6PqGN0HAC6bawXGmESwfMNxWLkuzRLZoknWvQaQC9tN9tNIo8W9nH4bvvT+c=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8wB+ZrHYFPnMUisLu6rrtIjDIaFy/Mm+0x11/7hDdYjyc1aZaX
 uVd0TJYA4S0gayvEua9bd6EPB7CqnGpvU2RaQjFiov59bpNA4NNAacqRns3TceVvNrXR/T4uvL/
 5kxFf4U22dAxROdJ/oGfA3ct3kdozULM=
X-Gm-Gg: AZFdTZdBZhMB3g8W3GKg/rKnf4+u/m1FMn7zxYu+sSW97V7OAxOLzghZIikX3Tjjczd
 bA3bc43FiojcaK3HaSa/f24/nY+LECz2ls5HaX1a//n9dojVXQBjuJ2SG9OWqAFIsElwRYEj3gs
 63EJQETBxcbEcVekIuVt6sRavTyTOprBlVa3U9T6S3AuXQ3P/zVTlr+Jkp48m7qnPC9H7LaVp9V
 kYmFlqkEsTgCtd43B+DHpbH87EGDI0uZg5gsTT7T8ifijX4ZpwomfkJOkgSSTv/i8Wr9NTlFlZ1
 FLWcWODYL4mPZhhQ4WmJsXLckDQYpWumOCipIikL/Uqbjrs1YNwYVY3v+gN95Q2P1U2wlpKqqwN
 kpS4o5gdwqQWMerdxg5fZeR3vLgsfgvWEZ1OGgX2cT/ExQxRkmBIx3REJ1dq227o0g2dzax1zET
 sbFvzu06gCMpC2LaVUuHcJkD/5atufSXFiHLSlXTgqGrzBlQy8YLPpOw==
X-Received: by 2002:a05:6000:2903:b0:491:c392:1f31 with SMTP id
 ffacd0b85a97d-4aa5ab788d1mr32985157f8f.28.1795468209755; Mon, 23 Nov 2026
 13:10:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
In-Reply-To: <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Nov 2026 13:09:33 -0800
X-Gm-Features: Aa3M54rzlNA1FR82U1PdfiFY5TW0gboojcKZPxdPIZcmX7lagtS1GzjDMw4zL4w
Message-ID: <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
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

On Mon, Nov 23, 2026 at 12:35=E2=80=AFPM Tianyi Gao <tianyi@cloudflare.com>=
 wrote:
>
> On Mon, 2026-11-23 at 10:49 -0800, Alexander H Duyck wrote:
> > I'm not sure this is the best fix for this. If we are needing all NICs
> > that support CHECKSUM_COMPLETE *and* XDP to report CHECKSUM_NONE in the
> > event of a frame being modified by XDP it really feels like we should
> > probably look at moving this further up the stack.
>
> Thanks for the review, Alex.
>
> IMHO we should first make sure XDP programs do not cause "hw csum
> failure" in current kernels. Whatever an XDP program does, it should
> not be able to trigger a hw csum failure. It's not an uncommon use
> case, e.g., Katran from Meta [3] and Cloudflare's load balancer. And
> existing selftests already do it (test_xdp_native_adjst_head_* and
> test_xdp_native_adjst_tail_* in
> tools/testing/selftests/drivers/net/xdp.py).

That is exactly my point though. What we have is a divergence between
a number of the existing drivers in how they handle these things. As a
result the behavior is currently different depending on which NIC is
in use.

For example, one recent one I saw was an issue on the Tx side where an
outgoing XDP program was modifying the frame and actually not updating
the pseudoheader checksum. As a result it was breaking Tx checksum
offloads for NICs that were using the HW_CSUM that used that checksum
header. We could have fixed it by forcing all the drivers to
recalculate the pseudo-header checksum, but instead we pushed back on
the program that was making that change.

> > Also even if we go the multiple driver fix route I wonder if we
> > shouldn't look at adding a new XDP return type to indicate that we are
> > passing a modified frame
>
> IMHO that is for net-next. There we can add optimizations, such as a
> way to keep CHECKSUM_COMPLETE for programs that do not change the
> frame, potentially after [1] or [2] is accepted.

The point is you are fixing things for your use case, but anybody who
is using the CHECKSUM_COMPLETE to compute the checksum on the frames
and using XDP without changing the frames will see this as a
significant performance regression.
