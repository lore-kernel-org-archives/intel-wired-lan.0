Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75845606A335
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VtH9qU2M;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kdq2vHu4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C23460884;
	Wed, 21 Oct 2026 13:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHT4QQ6maI8I; Wed, 21 Oct 2026 13:03:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E08260816
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587793;
	b=SoGQeYo97TA1hWGZc2dnIhku6iKdSKByzPNZM3Lv7DzpKYTwaiM9YsKuWvMnUj/T7IBI
	 wGiPkU/mNzsDe8QOoho04AXaoul5tN60Fy1FJEwxAjXnCZeyR23XMu8HXdrRVtBD4H4Ur
	 4GXhnHeND1o6T5jcmPQsFLojE5D7eI/RUmTLuxTpiaTSue85tsHf0ByU7Fv5X+Mhoz8Mt
	 eIDiGvLpsSQoVkvSgvJtrDj38r5wYQJfVeqhVEberqTtbKtqAJj9rmHjhYKJ62Vntl2Ty
	 rcQprvaHkJ9h2gqCDLPIX3nIqjEfNwu36FppaQ4be0zCganA5EcJ2wklW4WH+6LNjHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/lEhM+NhQX69KLd8GwWBz22OjDpzEesWZeFnWyadf5E=;
	b=SJn0ap1QvFTL3J5ZKYB5daN7VcjfGiHE2i4+uhmXLLhCqTpi4xE4QJBFC+lIw7edFKXx
	 MIyAJQxEdyJgEprAiNsM/Af/gD1cQssEfyXSqnzUSzC8/dykEZjHKGDK/dzf30PlzrJdm
	 UnGeBVhQmH6IFsxQKvqun2xdQSP3PDhQfXGE1A9Ef1IMBEAMoA/qiFNFMEesFpRALGvhq
	 gUlyakgLecITW7+erMlLRpCOxFpjWOUKG1yJG8zmwEvssCflNq71oIL5Hb/PUXqUdOBK/
	 KDxa2qLJhrbtQHjcDXSpeORbcToyRg3o//KiIO210IctyYjFourkEC0PT4FihcCBCsg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792587793;
	bh=/lEhM+NhQX69KLd8GwWBz22OjDpzEesWZeFnWyadf5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VtH9qU2MDBq1aDxFefRMZxZqOtTZIX7CnHHUaT7mvuRJRDskCLwrxpiUBLSeqsOKx
	 DyoyuEXKW0pzeywA/BcXdv4zLbo3XX4Mwsw0qJayrjOm9TugTnSXekm9SN3lZzzrae
	 et+Nos3Ugsi9UkJlmBBLLLAE+I80gd/X/iB68cSms4WZWR3vZdMH7sMjc3KwSLiFUx
	 yX2WcTBKOXDWm8Rs43yRaTcRy2V04jUHwTpGhLBFycXoJQvS42xOWA4prWjIFOkuO0
	 mvPRYIGNkeylxnBTRQ2IjycAQOu3U88QclFVj/Jde//MiGeOhTdY1eWsjBVCR3iQaB
	 B3tkYUPH8YcQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E08260816;
	Wed, 21 Oct 2026 13:03:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52F5C3A4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 13:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3875A403BE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 13:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lvsVI8UHzFo6 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 13:03:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0A07F403A6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587790;
 b=AGy4Occd6lw6ztgSD8eMNM1Z+xslvzcFu2H5JHaRebmkraR/D0+BTz9D2WQndVoEtWrz
 Bp9rXy6A6MtJ+huPKc+try/eGyou+gTONdkcdmGTaMC5qChzZx6v5aSMfQpf1xi/L4q0G
 HV4GKZ01xWy2YXD9O3fIskdm7a07GoOKXcWt3z3JugoNqyfCXnh2XrVeGqLAL0e9OrWEZ
 JJSnvOHIPJLIUSpx+bfOVLXRkjgfdvxP5wae6mb2BjSBvQzltrxtMKcclZr7nMTZS0LOi
 /UjNAuhLpT3kH7MJrsJKF/vR4OWQNOIjyj7GOR+jDK0ZJi6ouLEnOKEloZ0rfxT+s5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587790;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=/lEhM+NhQX69KLd8GwWBz22OjDpzEesWZeFnWyadf5E=;
 b=Vjrt8eSVU51561i5X1y/ESZcuVBUG3EWrOKa9WsOKS7izu9k110mtE4xvrbZUVHU388t
 rn/k2RMcWJxQwZmDWeLLP1Q6GYSxdI6CkxTIC0Ox1inpRKCyOXjISUXnnXGi2uSifaaWE
 2hjOG4UZMjlAF24/vcw/kC6Wrhd7scRMeQm5rUw+nDDVYyzUQMTIafS/Z7X/Tz8+OKUmq
 Q4Xc79qRyFRfPlteHEM2Vlkup5M+rQIZxa1d1yQgEsHhWkdkDKvj/bHqHOI97/SQkepeD
 JKlSqjPAbnxvCWz9WcRUlXTCSjez3Lt8Rmn0hlzHcBzi4/KduXgSfN5Jgf9/fnR665g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kdq2vHu4; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=david.laight.linux@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kdq2vHu4
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A07F403A6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 13:03:09 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so474507f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792587787; x=1793192587; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/lEhM+NhQX69KLd8GwWBz22OjDpzEesWZeFnWyadf5E=;
 b=kdq2vHu46zK8K+CWyyVYKDyAKXN7xWWdnxAMdLMmlzkwts1IyJQldUEYMzxzbKeFTk
 hCBSvx6hbXZgpdZ1BrbS/JQ/M5oUo6vr/wSndqD5ZkU1UzqxCVI3HkdlRZjPzyxqxwIN
 NOHa2w5AtEDABCR1vKhSYUBMKnPJd3Vmjv8kTt0mPWMMbBBuLY6Y8maBrksZD7s1b11r
 DR8u6HOn7InQ5r32/fOG/cQtv2Nkrb4QulMEKT8ntDs1cliEgpmFBWBR/4SGuWcgSow3
 8+8J1OTh93f4ybUkJiCvTpvBJS9OlLltu2pdcUNg8/KyuZNIuYMI+1d3mx3JfwpzL2W9
 a6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587787; x=1793192587;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/lEhM+NhQX69KLd8GwWBz22OjDpzEesWZeFnWyadf5E=;
 b=kpWIJ7BZdqi5UDp2a9GO6ntbUSZSmi5EPmULa2dRUv+8k/SnKiAZuLK5iBuPjjwRNW
 QEwqZUPJgnq5p8B3hRmZ8tQdjd0EghoMICjH4e1VUZvcZZgjtQHd0HwkTq8qKZl241RP
 g7gBlXitk52uTsz/o3EKq1Td9muwBYDiQBZeDxCvbefzdJ6/kSYr2FQaahFL7Jhe1Jy6
 2ryuA/qJ+4Gga6eo32ph9lYgM8zh8ZATT4L9FaBUJ5LUvrru1VKM3MI6bb1l/DM7gNDJ
 gHygY57nAIrwrn7aGHVO1GffoXIzryKWoOGDPfLWLpZ79r8yMha2OP/hqU/cK5DPx1ey
 +P9g==
X-Gm-Message-State: AFq9FYLz6zfpo038AG+EqPs12uTJEV5ZHumf8EcfuC1Tbn3LZLC1o4T5
 WFuQMuMEu5b4miO9ikvwzHze6dNU4JNrpWucZeCYkHT+aR3THZ2E2UOf
X-Gm-Gg: AYBFou3suqmRTkEPX6Hmk+j23/x7HSSct2AbzxxZrMpf+J1dYK9V7LLqGnKeJHtRkKD
 K4lpzzsdpzp/ig3ju3MoUkAPMhUMKPBo5QQtKZf17BEifA1Nx56LZiiKlXO57o8ED444ylEIwPd
 s8bawfXrA2OcbV5jorohfDUvj5oOg3hshgHFPXfQiJrUPHf124JJgKr3CzwyOW3OfQbwXcYz7HN
 /N8Xf23JRZ1AHGUq+p3rHkQJwfg6a3wBXs/wQK/xwR0D9P8eVVUoLAvgAqWn+9158EN8+dwouN0
 ZPPXzAOQYGQJnWzQ36Nxjtu8A2IQ6Nv21Mx/p3C5zR1Ws/1Kr4r43OO935l7lhECqHL8g0xREW9
 OaQv2pSfFpbsJ5l2Rm9dnsofrBipKWzSMOIaB95Hc6vyLLjsKHd+ZJCF0xOSgFOxcRtWbMlirA6
 okg0O8fKcQUiARys2sxz5EBH/bx4rFNKZMix/VbqUOnOoaXhGvsLqW7sta2W6ZiVk8ax0CvzsIW
 mXZfHdpmxfm5T6Pyzmrv2gmoui2GznY3Tm+KgzfNbKQXGcAjtbntV28b852thzS6t96ZUK38Wi1
 klXMpbxvCQzrSqgYSph7qp3BC9zL8hziYiY/eQ==
X-Received: by 2002:a05:600d:864b:20b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4a201e10debmr12370745e9.28.1792587785886; 
 Wed, 21 Oct 2026 06:03:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835e22sm6124852f8f.44.2026.10.21.06.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:03:05 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:03:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?QW5kcsOp?= Brait <andrebrait@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 g.goller@proxmox.com
Subject: Re: [PATCH iwl-net v2] e1000e: work around TSO erratum that
 corrupts data and hangs Tx
Message-ID: <20261021140303.5533fb2d@pumpkin>
In-Reply-To: <CALhGy9n9EMvV2JN8s4kpKb3Wsc3rjRVfibpNvVdAw_rHT=dYeQ@mail.gmail.com>
References: <20261020230211.75665-1-andrebrait@gmail.com>
 <20261021095756.0f5770e6@pumpkin>
 <CALhGy9n9EMvV2JN8s4kpKb3Wsc3rjRVfibpNvVdAw_rHT=dYeQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 12:49:16 +0200
Andr=C3=A9 Brait <andrebrait@gmail.com> wrote:

> On Wed, Oct 21, 2026 at 10:57=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
>=20
> > > Apply it to all e1000e parts: limit the first data descriptor of a TSO
> > > packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
> > > pcie_get_readrq() returns 128). The rest of the linear part goes into
> > > the next descriptor, which e1000_xmit_frame() already reserves; =20
> >
> > Aren't you using an additional descriptor over and above those the code
> > might already use?
> > So either it was reserving one too many, or you need to reserve another=
 one. =20
>=20
> You're right that the split can use one more descriptor than before.
> The count already covers it, though: the bare count++ in
> e1000_xmit_frame() is never used by e1000_tx_map().

You could just comment that that count++ is in case the linear part
has the extra fragment.
(Indeed the other count++ could be unconditional as well, you aren't
going to notice if a transmit fails to fit by one descriptor.)

> It comes from e1000,
> where that descriptor pays for the 4-byte TSO sentinel ("premature desc
> write-backs in TSO mode"); e1000e dropped the sentinel but kept the
> count++.

Put that in the commit message.

> With this patch the linear part takes
> 1 + DIV_ROUND_UP(len - 372, tx_fifo_limit) descriptors instead of
> DIV_ROUND_UP(len, tx_fifo_limit), at most one more, so it uses exactly
> that spare.
>=20
> If we want the count to say so, I see two ways:
>=20
> a) Count the split explicitly and keep the spare:
>=20
> if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> count++;
> count++;
> + /* the headers go in a first buffer of at most tx_hdr_buf_max */
> + if (mss && len > adapter->tx_hdr_buf_max)
> + count++;
> count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);
>=20
>    The split pays for its own descriptor and the old spare stays a
>    spare.
>=20
> b) Replace the spare with the explicit count:
>=20
> if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> count++;
> - count++;
> + if (mss && len > adapter->tx_hdr_buf_max)
> + count++;
> count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);

c) Adjust the DIV_ROUND_UP() for the linear part.
   I think:
    DIV_ROUND_UP(len + adapter->tx_fifo_limit - 372, adapter->tx_fifo_limit)
   is right.

Although I wonder if you really want to be doing all those divides?
I'm guessing that tx_fifo_limit is usually 24k (and the actual buffer large=
r).
So the result is almost always 1.
(Indeed, does TSO and checksum insertion work if the packets are longer
than the real buffer?)

>=20
>    The count becomes exact, and one lower for every other packet.
>=20
> Neither fixes a bug I have seen: the reservation already covers the
> split, and in about 3.5 hours of test traffic on the patched driver the
> ring reached its stop threshold over 300,000 times without a stall. b
> also changes the reservation for every other packet, which I haven't
> tested. So I'd keep the patch as it is, the smallest change that fixes
> the bug, and leave the descriptor accounting for a separate cleanup.

It'll only matter if you are transmitting packets that need more descriptors
than the post-transmit check.
Otherwise that check disables transmit first and you don't bounce off the
'just enough space' check.

>=20
> If you'd rather have the dependency explicit, I'm happy to fold a) into
> a v3; it only reserves one more descriptor for those TSO packets.
>=20
> > I'm not actually sure all the logic there is actually needed.
> > The code calculates the number of descriptors the packet is expected to=
 need
> > and gets the packet requeued if there aren't enough, but there is also =
the
> > 'post transmit' check that stops the transmit if there isn't enough room
> > for a full length packet.
> > If the latter is valid you don't need the former.
> > Although a sanity check that the ring isn't being wrapped might not do =
any
> > harm. =20
>=20
> The post-transmit check reserves (MAX_SKB_FRAGS + 1) *
> DIV_ROUND_UP(PAGE_SIZE, tx_fifo_limit) + 4, which assumes no buffer is
> larger than a page.

That limit is constant (for the device) - so could be pre-calculated.

It has to be said that I've always thought that check should be for a
'reasonable packet' whereas the docs sort of imply it should be for the
largest packet and the driver should never really return 'I couldn't do it'.

David

> The linear part and high-order frags can be, so the
> per-packet count is still needed.
>=20
> Andre

