Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C707606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yMHO2OuO;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJLAdLI4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 443AA80B5F;
	Wed, 25 Nov 2026 22:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id byNUB1_hyI-K; Wed, 25 Nov 2026 22:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A1EE80C6E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795644162;
	b=nrM5iReRJ3xv+vLEXZIqgsOPYDljle4x42njXKkzZHbEH3VDWEqvdLdZUxo6NXUxeZxW
	 0f6ZOpODklzJGtVjFJe6Z8cyeaM3acHLoA/TlUqY1ir1P78wywnMMQD4PTLqLJkMHTKi8
	 XRVI/jokuxNcHaxK3fRnftHSjZ/dxpbS+sW08yfeUAP5+cG2LqS936RTxSM7KWOw3noo+
	 oiM6JR/obkB1QTJag7a5C+xs2hAlA7n7jMoelk8wb9jPmK8ZjmwnxeRLyeSAE1jZJ8d0M
	 /iITEMpGuDb0HFqO+gmk0KZqodXxIAMLR8kXjocTQvga31xznCCktG1vDrXRaIdfWbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795644162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oHR1tBRCrTp4GdTSuulB2NpPvXunoIK0pVzcT18XLsE=;
	b=c6ETP1uLrpc8qdDGqKfYby+WawprqVwxSVaqQuQlllhNyqkREUqq5+PIHKKcT3bc/IyX
	 JBWMLVSy9XQ5uM15S40Wv93z5P/mczIzMPcwKMLFAhheZwuj8x03Va5tHk2Ej0ZI2Zlc5
	 l3iMk8UeU8jEsQfArjYAhRKqeUhLxLqpfDFke+VgANQC4RYbqcQ+ObD5XxsjkwEtZ2XHQ
	 oO1BBFCkBQ70Dff+fXqokQuAwJnUVhupfZ/khTRPfTOCgJCMpW2lOk7OQFHy3/hZEHQBd
	 Pwx/Tev+ruJC82UGNkIo2Lh8RmZAvXRnd2zWVe9mkhJOnyfJYIdsabZN7lvm4quhsgA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795644162;
	bh=oHR1tBRCrTp4GdTSuulB2NpPvXunoIK0pVzcT18XLsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yMHO2OuOJWEnGZKI8fpEPg1yqUe4PG0A7FScG6izZQkfjcKAQYesPljaaefbmkdFt
	 KvhWYWHtRK8yng6GMuKz7kAS/ZnZBEbbujD7TogF9IJXOKfdm7X1s/i1JpiN3L5wJU
	 L8x3kX+bTYaQWRMAuRH8KBs1Y3QoFKVvgqA+8n25tO7VnGdTTz/pZDoKR4wCQ5TS3K
	 +2D9gwcrSLunYt5npUHv+05uZIovQeanPgka9JhVfGnTHUZz97qBhSCSISX8wy30gY
	 p4Ms3MwJn8ui86InTv6yg/gC4cyu665rqvXm6E96AqWD3nDhe3P0RQmla9jn7yqfqx
	 MLxzcAWrm/kiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A1EE80C6E;
	Wed, 25 Nov 2026 22:02:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B463226D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 22:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A567060725
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 22:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CmpX2YO2Y-k7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 22:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F87B6069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=JJLAdLI4
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F87B6069A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 22:02:38 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so67938415e9.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795644157; x=1796248957; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oHR1tBRCrTp4GdTSuulB2NpPvXunoIK0pVzcT18XLsE=;
 b=JJLAdLI482d/GZWhhNYs+BLf7U5lCFLladrE0N3klAhe1T8aWRhBSljDurbO9d+vQA
 aE/JhwGrmtrF/lk0MS5i+yUbJrwgDQ35sHoypg75XXLyeUY5urfPLZZye0SGipK/vSdM
 J2BbOwAKnpHA39+pau4x+5dwp1vd+Vaziuf2lWFF44xU+XRJALpuDN6px/oQyjQJ1OdK
 Tzk0rv6XctQCYtO2uPLeWTCWHKbZBiebk71NtZGJITXudIk/hfAgEkFHID2t+ExpeJtU
 hlI9SZ9is0UXqugWU2Lv6sVzkgNIOl5OkdCLNRMzHNrdbmyCiPQNgMPQ+sWOpJP66fAX
 CXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795644157; x=1796248957;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oHR1tBRCrTp4GdTSuulB2NpPvXunoIK0pVzcT18XLsE=;
 b=cfFed6ZtlSGCg++abKzIQzjA1fbqq+U2EMsX5tBc+08V4vjcFwPaIMQn+FujA0efOD
 eqCHe2lrTFlHiiTeeR0sP9cytxIl0CHw4qKSoz5Mse68+mJK9X7plQVTKpO6/e2RCgTC
 vHNY3hZ/B9VN3ZK3CBgwTiiRlCDblO8VykST8LQd68hIG+Jx2+JkGuBkfo1Iqhy9YAfm
 1G3u7WlBJCvjpQxbIoyulDo65DKK4tEw81febPB3bVeT37dmDMwoTFFeA4AHQplaF3Gz
 JYKP5tSRUbvfMaDkJ0LTULvaFRPr6QnEa74fCySxSHObwd9FuLv+MVsKfo+8DeU0Gah3
 94wQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHSmA8iNtFr4x/treYuRO2DK2eZphtImcDV765OdYqWdn72Wrz1tBajs+RiMHKLLaJMz/zVoXwbwnK+XfJlrTk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+xobXh17voKOhG7sOoS6YNG4Em2QsWgVwe2WHl+2HbhsY4Yp/I
 hu0ReyueqvmlHWu/GCkMFxVVL+0qW8ot8i3JRKjKQNijMZkNjTHm+j3CJOUGYR67Ffae+yosmoD
 ptsK+Dq5uwo58ZTeDBdTXvOtRuPSop7c=
X-Gm-Gg: AZFdTZfXJxRVYL5ntwevfY2TWga6Vs6xzVCjJO9xi9klY/7rMTgN1hxRTR8e1PMfrhq
 qS7D+321MYTc8OagTbpfrSb++LxWTrldrkNQEYGqakGa+TJ4dXFYQVfQfXjCuvsl7l/Rhx0c49U
 fL2fFJ8Pxt6ifsmWO204YvfD+W6pG0MiJqO8zSgN9SHnQ1mBEPGBtmcKjwc5z3apQTUza6suXJj
 nKUFG4OWv+j5a5xzTufk5Xw9eCsNXGbk1C5GBZtd3OPG6As5BN2RPcaur4mBd87rNwipLH0Qxo6
 RpWFh0I7Suov+5V3sGK9ZZRvWMULoph+UnLluD5tAl1O0X/KEnoen0yuiSboATWiRauRWY6tI/w
 V1ttmzHXXGFZTEsGX1KnBJ5VKOZq/XQQBCbcfXH825VfnE+9nOEsNKVOJQQopfcag6ps5o81y0d
 +V+SkS9+DVTCS8JsTJtfKir0mfID7JqDEfMVpnHO+U1T/nyg5I83raHA==
X-Received: by 2002:a05:600c:4e0d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4bb88922a67mr378017515e9.31.1795644156940; Wed, 25 Nov 2026
 14:02:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
 <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
 <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
 <20261125090732.69233-1-tianyi@cloudflare.com>
 <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com>
 <20261125183125.25801-1-tianyi@cloudflare.com>
In-Reply-To: <20261125183125.25801-1-tianyi@cloudflare.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Nov 2026 14:02:00 -0800
X-Gm-Features: Aa3M54o80FY0kbVxOnhE-mBTpxSO-3Img4pRNLDvWi5ZvexKf5BGtRjI4tXLTnA
Message-ID: <CAKgT0Ueso=OQ7=GJp7m8nr90kBUp-+N6ko+Qy4e29MZv6tLQfQ@mail.gmail.com>
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
 kernel-team@cloudflare.com, 
 tianyi.gao@linux.dev, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 10:31=E2=80=AFAM Tianyi Gao <tianyi@cloudflare.com>=
 wrote:
>
> On Wed, 2026-11-25 at 08:32 -0800, Alexander Duyck wrote:
> > Realistically speaking there is an easy solution to this in the
> > program itself. It would be to look at using something like the
> > REDIRECT action instead of just stripping the tunnels and passing it
> > back to the original interface. It would then take the frame and stop
> > processing the remaining descriptor data. As it stands that would be
> > the more correct solution as you could then just redirect it to the
> > tunnel interface I assume you have stacked on top of it and have it
> > receive the frame instead of having received it at the interface that
> > just head the header stripped.
> >
> > It would also match up better with how the stack would actually expect
> > this to work if you didn't have the XDP program in place.
>
> That is exactly what we are trying to do. Our traffic will be
> redirected anyway, to a cpumap for load balancing. We tried to keep the
> RX metadata across the redirect autonomously in [2], but this has been
> strongly opposed so far [5][6].
>
> [2] https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.co=
m/
> [5] https://lore.kernel.org/all/20261117161856.6f6c2ce9@kernel.org/
> [6] https://lore.kernel.org/all/20250716142015.0b309c71@kernel.org/

The thing is once you start making modifications to the frame all that
metadata should probably be thrown out anyway since none of it is
really valid. I would probably treat it like we would a namespace
leak. I get that you want things like the RSS hash to provide some
entropy but it is basically just snooping into fields that you
wouldn't want getting passed on anyway like details about the outer
headers. Same thing for CHECKSUM_UNNECESSARY. It was making
assumptions about the frame that you likely changed, as a result you
can't really trust the flag when it is provided.

If anything, the path you are taking now with disabling
CHECKSUM_COMPLETE is the opposite direction of how I would probably go
about this. If you are wanting something that is more universal
focusing more on CHECKSUM_COMPLETE would more than likely be the way
to go as it doesn't care about what the outer or inner protocols are
and the math is pretty lightweight as you only have to fold in the
header checksums as you modify them and don't have to mess with the
entire frame. Your modified frame could return whatever the value is
that you want to pass out to indicate that it is modified, and you
would then be able to just pass the checksum modification out as part
of the metadata in some expected format that the drivers could then
process.

By disabling it you are basically forcing yourself into a
vendor/protocol lock in as you can only get checksum info on the
packet types the hardware supports. The issue is that
CHECKSUM_UNNECESSARY doesn't convert well to anything once you strip
the header. That is why back in the day we had strongly encouraged
people to use non-zero UDP checksum on their tunnels and had added the
ability to convert the CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE when
decapsulating generic UDP tunnels. With that we could support most
NICs instead of the 2 or 3 that supported all the new tunnel types
that were coming out that then had to parse all the way to the inner
headers.
