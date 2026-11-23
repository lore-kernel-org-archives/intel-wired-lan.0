Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0099606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Tgds5ks1;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=PPAdALoV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2E0E60789;
	Mon, 23 Nov 2026 22:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aq4pXZ5AEfJJ; Mon, 23 Nov 2026 22:01:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EAE5E6068B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795471293;
	b=H2NWg6zXRiwm5H0bbNK++0PX8CefN8DtFF7ukMFNd2yApNVbSOMmNjke6wLdxzVYrvDI
	 bD6naaUdWrprpBNpwOh9w2Yw70rWvL/o7UmX8ohTe/Dubm3ZAlDgkr4ALMyQi1jesNqPs
	 p3ykUKgmMNCOXoC3LOvXX4V2LBAVmGGCon6hRvdLxdDn9udZ25hIRQpHjwaziB4cRVdia
	 ws/j1FTxuzqlgYCW2TsUxJO5ymi9PQms4w1/8dZJ/mwyPcyAMCdQ5UhyqEJT97piCuX6k
	 8BqliWAPTXsukgtyEHEbx1KBitG5dxHHjhkjHSRIHQvP4OCVWdpcy7zi5KKtYD9/ZHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795471293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=srL4Uf6AX26Xr4iCAP6zHkN1OE8a5FhQcDs//2mI1Q8=;
	b=D2xXOLEAk7rc1qp8Euh9CKWwlU+Eun8WFyX+PIr5YSFMq9cnbZY9/wniVe6DoMDsvMpR
	 M0h9nepJE5sPD92bsURTpnboeKqI9a4QqIh+y9cJ1VNU6icHBZnfyqOJ6DaNimPXuuj8P
	 MVoB1FbICBUYe9YyOHcT7GvoLF48QpC/wMuioOMsbcd+CNaYnGcEzj+Nt+fyS0q1AgPjP
	 fwhmA9RQH3A7XcAasStEktS7xDi4LCIU0FVwookTIyo38ZVylyzZlQWYGfpNJm4zI12re
	 Me+60cLC1vmtpmVNB+mo0VGdz0He1jaiaOIfoRAXR6vAPLJshgMCWRwFKCcZM6B4cDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=PPAdALoV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795471293;
	bh=srL4Uf6AX26Xr4iCAP6zHkN1OE8a5FhQcDs//2mI1Q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tgds5ks1BufCDgEJe8KRyz7uGYhcNmp2p1ebiICHHXcoTOwMPMSigEAC4HF9/YmdA
	 qK/bJ9Tq0IqLnSv1ATmNS4s0eoL6oW8QDTRWKOrwRrvngc79OLOZBn38aROXO5t9OT
	 QkWzRXNEP6ATICGZYjDbtxf/3Cnq/x5Ia4f8oABGOC2i2j8AmJoBB+rcJKXZxfUOKm
	 Xj44OCqXIpaIW2xQWEVz4tkAWKBk21WwpH9YbCKDvtoznKrmnwQ4Q31LoPoZerMhEI
	 IcHYO43DNaMTNWaExK9c4gzrHe243izZQDxMtZ85nAAW5RZOQVzbrzp0dD+I+5b86z
	 oOHTRtJHrk+IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAE5E6068B;
	Mon, 23 Nov 2026 22:01:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3C21499
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D13C46068B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6VB3ZNYR48Rh for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 22:01:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D37E86067D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=PPAdALoV
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D37E86067D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 22:01:30 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4adae187d94so2581279fac.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795471289; x=1796076089;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=srL4Uf6AX26Xr4iCAP6zHkN1OE8a5FhQcDs//2mI1Q8=;
 b=PPAdALoVODv7Eg6N6eThnoyYzYu7z3oRErsbYj8VKi+0x1xbYn82AVUQog1E8BO2/5
 U7hdLWDSTxMD3hN4vyVVeROk52qhWIJ/405F8hSu2zzOR5YpAj4VtyadCQKysRAUylRV
 58EP5Tz0s8Dl8v3yV7vC60H8lKQvfP44ENHlPlo9H81/BrYibcQKSBXdu/4vXXftgN67
 RQfUHH5JoshX0a0aJVNiwaQdQ2CNrnzLSSSw6RQ+4eZba1yAD2DCHp66MYgOFHszq6mO
 fYeAp7chrD5c/YRF/8k8gfZIlSrkD/QMGE7uIxulQn66bdJhKxR9GjCC3CyWq0qKRaLz
 t4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795471289; x=1796076089;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=srL4Uf6AX26Xr4iCAP6zHkN1OE8a5FhQcDs//2mI1Q8=;
 b=NoO/6wyTHSx/HhT2qOPqS3vPqsfXNw5yUtjJ4LiXqlTzKDfeUqJTgQPh519EfBpR6g
 ZCSFXxIEqx75RL3d0SeKbkwna1GPQ0YNTx8Ha3PdcQQjxw+gMR6s9JG7Hb+aGEcTueAr
 Pad9F/gsP5xa97PvhOIbONZG20eHliT3RzhR9I5EYuyjrrSuXDXRSmL8v0I/Dh++qpL1
 Mn9sCTc5EffUjOIsVX4YvYsy1sjdE7PugjLYhcYxuWtzkLnze7t9selJPel0HUxWJv2F
 zzqJki3raNTwanAjWowLlHnY+x7OJt5WYe3GfYuEfsqWkCJ6Ehgnit/RFYZ50CqW3WiS
 SpAw==
X-Forwarded-Encrypted: i=1;
 AL+hErE8a26iNn7YwFgckNEwrmoMqXtnELSRrhppzwrgFlh0nW/p7+1f9qgRwyNE3myJQdpUX2rN8StdXAT7pjAq3cE=@lists.osuosl.org
X-Gm-Message-State: APuU4Z++CQjlGOFtsCL7U5h+Skz7V7veFrg5B/ebOeI49WTBLNstRjf9
 c/SsmecbAAJ1ZFF6Ze40nsYcldxAqi69h1dV3YHz0UUfz/eOsDIdDEcFsVldS7UM1jZgXDcVG4j
 6vj22wNOTHnUjejOCUHfuoFH/PSGRUtDeQT0k6rXcjA==
X-Gm-Gg: AZFdTZd4Kf3FMjgt17tNIuNES3ZnW6aC5Dt4N8ud4LISbRxJcw409OxDytVTHYUPRfK
 GVxve7s/wNO/oXsuuVk68X9rjCZA0mDZsz3kZEoNvZJG44pp1tRVw/I+IqtcnqyyWFHEmWimCAf
 VeDHLD0kagIIyfM0SOQFuPnSSjv30cb+d8BIEZdO108IBoTE81kpdMCcU+4/O1sxCyQwDRBuBSZ
 u9wc8+WwH5gQS5Lp2bM9v92VeQSb5qib4as+W57gGNPHvLI4rkDZb7PnYZK5OcvZ9mzDzsRqaU4
 8nPgotQ0H5BLg3caircWyd/P/Zs2pn4nG/gmp225UHad9UeFBn9xSA4/xZ/xdWyFotLWbA1VNz6
 v3zC+1dSuMpIfBmS5rJYNUuVafViyvtHmbdSEqKcG5yPCb+wBuKxnoIs+uFwDL1x0CZsWiPg=
X-Received: by 2002:a05:6871:60c:b0:475:a153:2dce with SMTP id
 586e51a60fabf-4bc84926567mr11531088fac.36.1795471288917; Mon, 23 Nov 2026
 14:01:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
In-Reply-To: <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 23 Nov 2026 22:01:17 +0000
X-Gm-Features: Aa3M54rB6Tkjt_a_xBRCBKw7WSvCOL2uVv3n24p_DPRCDrCGO9kKs27p19qzjqs
Message-ID: <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
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

On Mon, 2026-11-23, Alexander H Duyck wrote:
> For example, one recent one I saw was an issue on the Tx side where
> an outgoing XDP program was modifying the frame and actually not
> updating the pseudoheader checksum. As a result it was breaking Tx
> checksum offloads for NICs that were using the HW_CSUM that used
> that checksum header. We could have fixed it by forcing all the
> drivers to recalculate the pseudo-header checksum, but instead we
> pushed back on the program that was making that change.

Thank you for the explanation, Alex.

On Tx the checksum is in the frame, so the program can fix it. On Rx
the program can't touch skb->csum at all, so there is nothing to push
back on.

> The point is you are fixing things for your use case, but anybody
> who is using the CHECKSUM_COMPLETE to compute the checksum on the
> frames and using XDP without changing the frames will see this as a
> significant performance regression.

Without GCS, TCP and UDP still get CHECKSUM_UNNECESSARY, same as
E810. GCS only came in v6.15, so this just puts E830 with XDP back
to where it was.

The cases I can think of that are truly impacted are IPv6 with
extension headers, and UDP tunnels that the NIC does not parse and
that have a zero outer checksum. These fall back to software
checksum.

And programs that do change the frame are worse off today. Every
packet gets summed again in software, plus the "hw csum failure".

I don't see a fix that meets all of these:

1. It is small enough and can be backported to stable.
2. It fixes the problem fully. We could drop CHECKSUM_COMPLETE only
   when the program moved data or data_end, but some in-place
   writes, e.g. NAT or the IPv6 hop limit, would still trigger
   "hw csum failure". IMO that brings more problems.
3. It keeps CHECKSUM_COMPLETE for programs that do not change the
   frame. But that looks like a bigger change, which doesn't fit
   net.

If you have one, I am happy to take it. Otherwise, as I understand
it, the choice is between:

1. A performance regression for some programs, but no "hw csum
   failure".
2. No regression for those programs, but "hw csum failure" stays
   for programs that change the frame.

I would like to know how the community normally decides between
these.
