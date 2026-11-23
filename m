Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9EC606A322
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=20XHMaHL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EOw6xWP9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02F2C405BB;
	Mon, 23 Nov 2026 22:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRRy7pndTWPI; Mon, 23 Nov 2026 22:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4EAE0405C8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795473811;
	b=kkrDkVlVntVLmbkiQgtPOYIDJa3JyX+vaz38IOpC3/LOvzOgtxsb+UqIwj2xQIt6ajRo
	 680xP9d8Y3i/+NwlSzarHRMQGD6O3cCrwIOQApMmHty46G4BAk3pt7bKr61tP5M2qYGVG
	 0SVrfjG0gUwDQPTzDYtFLFMPmzMjz+fAiCWkUAgJ24MKcEiN3Q+S1KBY4MMGhNoEelgJ/
	 CkIyZR2bACROpBimb+Vc7v/z4EIRHklxB0AElm8rIbmQK3yHGcf63zA58lpqNiFhihvzh
	 L5V/C4Po0yBQLh0PnLXz2EDUhenVCD/xI9r+TjjVZsoCiMeU8pGZ1NRN24dbYNzFpsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795473811;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KoaCT3k2u+3gdASFJNpsPM+Yd03fFCalQiVgHKeiTvs=;
	b=iUlAdF98a6TQpmIB768JxTI1w9TE3/q9p9YuJrr+BBFHB481OJpLdiEeWfDeOnjam1Ew
	 +9QvduLs55HO/q/UIAYkodmIvg5rSrIxB1S2LaahLh7FP+Lg8MvZigI9fV4jxUNTBLgcV
	 WhVh0cG2CyNngjNs8nR6L3ObAaLwIXAoOVjj997CjY6uSUm2DCH7eGY0pT/Co57CTubta
	 Oa+AFOuMg9fbzbuW2jqPIWDDaqVnCHqboEyOV+o9AJAQVZx7O+ofkMf2eoUNBoiS8beKT
	 K0QC0ItFb1454Gw4b22KjBqOUhcI0ulyUQgmUQq2hGT2+2ad6G7tHgMbgsXxQyXZLgg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795473811;
	bh=KoaCT3k2u+3gdASFJNpsPM+Yd03fFCalQiVgHKeiTvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=20XHMaHL0vo3NwrCEtovEyJ0u0ojLbGsmjnLWzEmYzwUc+4XQnttpZ2cLlxeCZxYS
	 aOp+drPGoc2mR7GthwORegLPZr2/eyqMStA6v7D8P63L4XYNaYdK1c4YtmU5IDlfWX
	 BC7Ze8ZO5Ubxhql3sD+79bZ/jRiasig8QreWf2DyxSKu2ntjHNqoN4DMB4FLFEHb8R
	 azbKy8l06WfSaVzYELeeeYB+lyvct4SBODPwsEfbioKohYeT7XHRmbveiwWzg+SCRR
	 8u/CJGjFi3JPoOyNvTJb1+YHjNKxiS24qMp7zEsXje9/6nAlA9D4FATHS8fM4vdFmc
	 evEK2BuWm45UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EAE0405C8;
	Mon, 23 Nov 2026 22:43:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78E2B260
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EF96400E0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGQnwJo78Fza for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 22:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6AAE940068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EOw6xWP9
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6AAE940068
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:43:27 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so49730105e9.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795473806; x=1796078606; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KoaCT3k2u+3gdASFJNpsPM+Yd03fFCalQiVgHKeiTvs=;
 b=EOw6xWP9pIGDu595aqBUY4AEsUDXjMFJ0Rx/RfhRJ40mSrP7qqj7ikckZcpc31jDYx
 qZ3nYpu9slw7cUclfMUf76mRI13oHSpkutdYUsJ0HbU5IiAo0let7Sfujm+rBBwV5AFH
 eq72h4i/wsKd9HcCq3FZdmgJ5jM+vHLLDescGJWuHh75WdKQhB5C8UaNJkw+bMPI02ch
 N9C12I8EHnvNcbNB3i1+HInnJEpf4AApKFRjyQtyyB6hQR9bSAXTvKT32JvRUgUMwpSK
 4it2OW6YroqO08y7AAiwpqGtkcsLj1y+oEdZp/lVBTw7W5LuG3YYbBTljLTe1ZO+MSvj
 1BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795473806; x=1796078606;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KoaCT3k2u+3gdASFJNpsPM+Yd03fFCalQiVgHKeiTvs=;
 b=DovgPpd6Z0YWX5yyKasq0kflAaJWL7fIu9C9geWiIaaraUgu3wDXublNh2XUo7piOZ
 mg8QmSe5wCUI74Z7TACR2zaZrSnIgahq6ArYmel9hVf+m5Rw78Y+OWrDL/zcfVPKVjpD
 C4YmUrcSMPRWopN7f6qd2x7t/4atbtKsQfHwXjEbhEFLUj4VMph7m5t3+auTHkyd95FT
 k5dWfBJsacFO/aATkHVpOH88OlqWnSv8MrSulB1lhd6xACiy6q3SfEb3GtixDRMCwS56
 MCf3nZt+lFd1RPT6l2nRvJKcdVVXbYEO05/dihahdR5K9CrXAeVLHLC7GSRX/SIwx62D
 4/1A==
X-Forwarded-Encrypted: i=1;
 AL+hErFnzShuLUr/9FCuDfiKvn4s1VgEUPPdfHBlBpm34oATVqYQuC2Mf/MOroV9lNn6Avy09qXOMYVb5XwM5x4U3/E=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+KVl/N2mNs3IvZ46AUDLEJr6LmWZKjl14jMPwuezTAMFF+z+lt
 Q982RLgdOK4bAA2oVjzkcLqB9XtmwSfEBDe9sIcVotBaiMu7yRyoUv9VFTK941XvLT7v0ggJFus
 /MrXDJmF7GaDc2q2pLSN+0WKtoqgDxJc=
X-Gm-Gg: AZFdTZd4znx/Mpm5p5aDBNfeZb44heSJxLrBuzGglom/ipzEIH5eXMK40zSMGFXDt7A
 jOarXAUzdGx+bEZ1H8f9m0rBEM+DHXE+ky2WNklpO119zLelhKPc7bccJmRlnJxnktagv28gc6T
 X8bMLsWJ4S1xlRPztd/fpLS9cKs4yNk6JlMGtEYfH8Arl1eQ3Z9vxNVhmLsXfKYLgHONApCkuBZ
 s9lKO2Tp3FVjfvYZnTGWRwT+xAwzrx1ZrUYvwTvtPvHbYFbrpH4Rkzw9yKyKalDuI8gQPyHgqFX
 eLdD8jc4RNKb9g73uMil5AqmUTUq0HGQVsJdGYkjCeWIOvO8EuBhkvUC075sa67Uj+L2LpAYFc/
 hZmD9wNME58cX3awnp3USm3Qu0ZRC2oRk1LZcyb+Fqmo9hmNhy9abkn/CWONkeSmecuWcOcYbN0
 98wUPw/gp0tqok7BwaMt5dPdY34cxKP4frfgGsifOi4GzROOtnXAvw7TWdv0GJqI9tgfV+zME9t
 1E=
X-Received: by 2002:a05:600c:20c:b0:4a2:f58:9a82 with SMTP id
 5b1f17b1804b1-4bb861590abmr246078985e9.13.1795473805423; Mon, 23 Nov 2026
 14:43:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
In-Reply-To: <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Nov 2026 14:42:48 -0800
X-Gm-Features: Aa3M54qi82M1DAMMWxrM8C2P0C7XHARA7mgqCdyXPQsvQZsIrQdsx5S-vHEw8KA
Message-ID: <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
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

On Mon, Nov 23, 2026 at 2:01=E2=80=AFPM Tianyi Gao <tianyi@cloudflare.com> =
wrote:
>
> On Mon, 2026-11-23, Alexander H Duyck wrote:
> > For example, one recent one I saw was an issue on the Tx side where
> > an outgoing XDP program was modifying the frame and actually not
> > updating the pseudoheader checksum. As a result it was breaking Tx
> > checksum offloads for NICs that were using the HW_CSUM that used
> > that checksum header. We could have fixed it by forcing all the
> > drivers to recalculate the pseudo-header checksum, but instead we
> > pushed back on the program that was making that change.
>
> Thank you for the explanation, Alex.
>
> On Tx the checksum is in the frame, so the program can fix it. On Rx
> the program can't touch skb->csum at all, so there is nothing to push
> back on.
>
> > The point is you are fixing things for your use case, but anybody
> > who is using the CHECKSUM_COMPLETE to compute the checksum on the
> > frames and using XDP without changing the frames will see this as a
> > significant performance regression.
>
> Without GCS, TCP and UDP still get CHECKSUM_UNNECESSARY, same as
> E810. GCS only came in v6.15, so this just puts E830 with XDP back
> to where it was.
>
> The cases I can think of that are truly impacted are IPv6 with
> extension headers, and UDP tunnels that the NIC does not parse and
> that have a zero outer checksum. These fall back to software
> checksum.
>
> And programs that do change the frame are worse off today. Every
> packet gets summed again in software, plus the "hw csum failure".
>
> I don't see a fix that meets all of these:
>
> 1. It is small enough and can be backported to stable.
> 2. It fixes the problem fully. We could drop CHECKSUM_COMPLETE only
>    when the program moved data or data_end, but some in-place
>    writes, e.g. NAT or the IPv6 hop limit, would still trigger
>    "hw csum failure". IMO that brings more problems.
> 3. It keeps CHECKSUM_COMPLETE for programs that do not change the
>    frame. But that looks like a bigger change, which doesn't fit
>    net.
>
> If you have one, I am happy to take it. Otherwise, as I understand
> it, the choice is between:
>
> 1. A performance regression for some programs, but no "hw csum
>    failure".
> 2. No regression for those programs, but "hw csum failure" stays
>    for programs that change the frame.
>
> I would like to know how the community normally decides between
> these.

The thing is your fix isn't really complete. As I said it is primarily
just addressing your use case and sweeping follow-on issues under the
rug. In the mlx5e case they were disabling the feature via the private
control flag if it was enabled. In the case of your change you are
just disabling it without exposing that it is disabled.

From what I can tell you are just bypassing the checksum complete
logic, but you don't exit out of the function as a result. What
effects is that having on frames that would have been normally
checksum complete? Specifically, is it being treated as though the
frame is unrecognized, or is it falling through into the
CHECKSUM_UNNECESSARY path with all the indications that a tunnel was
still there even though you stripped the header?

The issue is that the driver is making a number of assumptions about
what is there based on what the hardware parsed for headers and such.
With the headers being stripped and/or replaced those aren't correct
anymore. That is why we should probably be looking at dropping more of
the existing logic or forcing a rescan of the packet once the headers
are replaced to update the descriptor data for the skb configuration.
