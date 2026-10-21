Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002B606A31F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CEfCefiJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q0cg2GUM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 363496071D;
	Wed, 21 Oct 2026 10:49:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C62EQnbhPyIa; Wed, 21 Oct 2026 10:49:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7393E60749
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792579795;
	b=nKw+eALRTVQXHUUUgqe91NWodCB0lx08f6iiJ/rWCOT9IeO9mgIbnvR78+mGuQmpClha
	 OvQYQrIx4Kg8NrUiCyr/KmHi5/BRjwnhlenO8K/NypE5w/+c6ZzWTvE5nvM6tvh/+q1MO
	 PbOVNheFRl5Ob/fLd6ZAdnn1cSB+uLvL2d/62hwn4Kpfqcrr5qNDIeNz9Q104wLVScBrB
	 EkQ23IyDKZxOictFu3wu73rUKfsfCxV2rUIeUuDTvUvCWA81sW4AWjRV7FI4P0RXia3/C
	 e433Xoaa8hR6o2coWpJHYEg4wphyVwp5AeysoOixNxfAPhR634B3x3WGSpu7ntgwrFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792579795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
	b=qr64I2LuVoOpUV+TWKu5AhJ1hELxYYee3mVfebhHVFW58+q2O0fxMEM2GJriUDoITHHb
	 tsmA4n6+ItEYFVrNGDW61ByRuy7Zp1OZ/kmpR0ZHrbvvI1aL2oPTT+ylYDZpsQ9F6hyUd
	 xLsl1T4yFJopX6My0YRxxIEGNuAaI6brpUZGAZnsELzpNY04gwZ96sFA6HkjXCjeWly7J
	 xMGGsVY1oWtHF2FUWwQSf/B6JHTZ7N1bo3pc2+93Xvy3UEKSmWywZpW8FKd/RKAau9kIy
	 80aMdGVYjf8cA9gzPhcxJrDs3C7aIzCBNbEQMHr47pItgb385nShYVwus8UlE1c5BgA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792579795;
	bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CEfCefiJVBTA1RZtvUfvV1vOdu9L3gBHhbZarLvssM8t08QZRfgpRoNgmKrNAhWPh
	 qa+GdmqL5uDODQI4thEIe8q9YgSUcGK+jHx7q0aJ7zacEDxs4jnBbMqERqakNZDqNZ
	 RLhPrpA79adOHWzMthcBXtnP/z7EekUOBmp/c5DZXXt5RJ9YSa7RS9l6/5ulDAR3FS
	 KlMjU+8uER3yj1U5uOvX9ErdbT8sHNeP7HbVwwL3UGN1BqFSwaUvth9gZ3MjTJKwhG
	 GtOWARJyzDzawUM5jnKQs/5hknRdTKRiM3aAsUFQt8sGm6hxT3sCSQwpmOTq1726Gb
	 pmO6qImB+WBvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7393E60749;
	Wed, 21 Oct 2026 10:49:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BEC771AB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 10:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A48D181029
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 10:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2i6oczRP6dB for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 10:49:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CBDA48100D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792579794;
 b=nn2zDbrjLLNkriE8n/CmwXPyYRFcu0Cuevds90FRVFABm8aDEc7IKsuvTV/689O5+PDg
 PtWON1d3qFCg4UnDNeQmAb3+YKIr6fuFCQ9rTkvDvu7Mneu+FrfdhsFUAPFr9Eol7ob9X
 YoN/rs5Hzijrio8yQsF6v5g0VrsxoYQzL2FwyatmiMEQh0VEceGiG9Smr4IUkjL6i2Eey
 NsrsaKAAyxfhRZW9jwcXQoycXtStktlOxGCgdWJOfNiIOb+7UZNU+pPCMrubC2s60Tz6q
 b6QTsrWrewv69aVkpXtphuBvlA1h0dVoKnB9NaXcT/fCH6m7kmKQCBN/42+NQ8kh5LQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792579794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
 b=AM/4W40j3hTR6qCjNMARGl/LrgOqlxOMYXz36DYPhsyOoK9OXiGhRxKNtVIxD9JR1u6Y
 JVw15icg9+m64jfrn5KkAGCpMXgpACnFmJDoSqRpFOwbah0KcDhtKqqoN1e74cZk+Xbi4
 EFLB10XWRkxpxxUBFGwCGrWcmuoKDV7xcjxpGoi8W+h3UoWz9/9kUzLPX4RtXNi3ZWTJj
 lfw7fbt+V4AbxPSHGCbd2wOOB3aGwH/EWD6+BLJsW0ZMzSASjBHi6cgcWaCOfWCzqzVPp
 3kb4PFfaZtELTYtjbkKrqmyxT5tV1WNSGFDECE5OdXagtsiuUvG2+17wlUahXBHhBpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q0cg2GUM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=andrebrait@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q0cg2GUM
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBDA48100D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 10:49:53 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so340180a12.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 03:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792579793; cv=none;
 d=google.com; s=arc-20260327;
 b=JvXu/0vfzsm7645P1c8EiBFCqN+/QDq56XQuE9xvj6gbm+2W8eRrXSyBwANsgDUhqV
 faU7cClkbIC4EwhiBZHrjjfdKLU+K0gP0Sf/aQtrBmbrsuOQbbqggt7JCDzqsCzqAMJb
 mFV1g5JSk6WHNUimpgg3FQLC/QBezKWXnfpyvNp/sT/dCDDpScKI5B1HHnMGO4TQk8KG
 H1HvQTejMoL5QZ59Ixj1QYlbX0437zWQTu8FmV0Niib7I98JLXF728VMuZ5+zVoZ7vJP
 8fCsTo1/qmmp9uygkzBtvmmJuUB02Gf9DTUju+8B/OfmSDz0d1Bl8dSE66d2begPvuwg
 lO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
 fh=/1ZgaczbI2PME5EUZDsPMbR5Ipx0oUs6joucYMKReaQ=;
 b=VLyciIirQWFjchnEaRrcqEjHyPngRK/BT2OBL5o6toIK1Rc4fPHtiLuiQE8W+FNrIH
 trFYxgiSbEia7CEZdGVmr6HnlP7eX/pOuARg56fvqi0u30HhdptWrI/xhxSxVVai3tx6
 JXGombkACD+EJ+a4q4NM8pbTLF+vr8PSM53yfXBXE1a6GjtlCtOAz6NtpY1X1QnsOR+M
 OJMvGlRM0Xzj6iKlOByIX8aNJvXsW5px81/zl5IkqCCktDXO116agBlrXInFv4CrFxG/
 l07hZ2xawGHM1wafesz2s2BO0Lm7aWxST8aZouuzeMJl0TYeK4nCI3kBpdrbzulFJPrw
 XmJQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792579793; x=1793184593; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
 b=q0cg2GUMTuG/dImlP+KIJt7LLtKFIRibxr9noOJC0hvvt+CtjpDMrKoM00DhC56BGj
 DrIn9FeEHFRksuL8L3qTnHXxzU2rVpbIDGwbeGBl7t4uacT9FBWxwF/a9SnBf/qj6x03
 mL9uhCb4dG78CZNCIfH7SAphacNLpD0uiaZVzuRnauWfzqcYuL2TPJo+734fgQ0zmvSy
 u4OtJQgZ0cAsBPqoJE3ncGYKjyHMKo+vdW+JjOTxYDY6m3XsXmnsCfQNarZbj52pCzKz
 Esz1ssqnp03mXEuEOmi3c5wEOF7pBzJBKDjEVuuRMbwDTnQsBdwAZFSKSVZMSJTm0A3S
 WBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792579793; x=1793184593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eeX6PAsV0Y3sIsjFLfktRyMYpLkWyx6uIk1AtOWozmY=;
 b=Man3yyPMrNEj5ELQHIHRRrFfwzTVZ5rDIU3V+0uQ8XXRMX89xVqAhgyJUaZYkMFINp
 QL1Ueh+EAee/6GaeChae+rYpMYPMc3UcPq0I/fcH942puuVNjZwGSwM7GbA1/pUdYCwV
 RcyPviquKxIBNyGjAvFk/i9wutqUG5O6HjDlscB1IBLUPc/ZrDPQtetKyoSFQEZXt1M6
 Zk2ilqf9N6wp2weepfTpHuiFccA8rIVJQSVn+8BjkkC2WhkWw775ONTNhZpiO/rNTH61
 EIuRKoNtjwWES3BionJ3AuDSJSxzp4+Mse8IYHkcxBRi9Lp1CccXVEqVu6j/EB4orHNY
 9asQ==
X-Gm-Message-State: AFq9FYIj6pbr/8Y821R33bz/089K4xYfEIiiGKn49nkYge6iYTA7hTiy
 q0WuOEAzwzzlgAhnslShehAyxngv3wlDpCjMNZgN3Y5z6tCW8BEkYu7VyIyAVRUp76MIpLVUIWa
 wgg/jvl7P+bW/nYXEcxx4HGJRkf1bKQDvZvfW
X-Gm-Gg: AYBFou3P2gLeT7m+un4PIscqkYNEIB2qS4M5/alitqgvAdRIZnSYMtpeajZmBTppN/g
 Y2f+FYWOCN4CLG8HawlOSCqMisBWdU3lu2V+n6++pNwd4UfcsAEBL1KozxyzMOUlZgqqMcBuUPj
 gQntn1+55Ygvtjt5HYtKUG5yo0cDzPnbg4orBB2G2lnlQ4pFSqwdr05qNgMkeDjz3s5/RM1GtxW
 WpEHg0Qy8yRrQWQA0P+/xHq0Pebc7dKu1aHdPNwCqknAJ1qOd8W+hGF5oaKIbWFL5QZySCsyFwX
 nvHejLyup8ODv9WG+DXdV5EPEGhQMawud+TQ/ukfbMknXmLghYV+yvsFnEE9ravFyERE84oMEwR
 vPeV0ZNdbSqeKNOP9Kv36SZEY7uEDL6f7Xrqvyt/ARPPadhUP4YYzWd1Ob3ogv0FZTF539Gc=
X-Received: by 2002:a17:90b:3ec5:b0:3ac:b764:8521 with SMTP id
 98e67ed59e1d1-3ad6571ad27mr3402578a91.38.1792579792717; Wed, 21 Oct 2026
 03:49:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020230211.75665-1-andrebrait@gmail.com>
 <20261021095756.0f5770e6@pumpkin>
In-Reply-To: <20261021095756.0f5770e6@pumpkin>
From: =?UTF-8?B?QW5kcsOpIEJyYWl0?= <andrebrait@gmail.com>
Date: Wed, 21 Oct 2026 12:49:16 +0200
X-Gm-Features: AclHuK8XYSgL4sJ6lwVw4WXh8iC7jNprlbe1Q1YOL50NcC6qXVcAOpwDNKlpvC0
Message-ID: <CALhGy9n9EMvV2JN8s4kpKb3Wsc3rjRVfibpNvVdAw_rHT=dYeQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: work around TSO erratum that corrupts
 data and hangs Tx
To: David Laight <david.laight.linux@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 g.goller@proxmox.com
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:57=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:

> > Apply it to all e1000e parts: limit the first data descriptor of a TSO
> > packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
> > pcie_get_readrq() returns 128). The rest of the linear part goes into
> > the next descriptor, which e1000_xmit_frame() already reserves;
>
> Aren't you using an additional descriptor over and above those the code
> might already use?
> So either it was reserving one too many, or you need to reserve another o=
ne.

You're right that the split can use one more descriptor than before.
The count already covers it, though: the bare count++ in
e1000_xmit_frame() is never used by e1000_tx_map(). It comes from e1000,
where that descriptor pays for the 4-byte TSO sentinel ("premature desc
write-backs in TSO mode"); e1000e dropped the sentinel but kept the
count++. With this patch the linear part takes
1 + DIV_ROUND_UP(len - 372, tx_fifo_limit) descriptors instead of
DIV_ROUND_UP(len, tx_fifo_limit), at most one more, so it uses exactly
that spare.

If we want the count to say so, I see two ways:

a) Count the split explicitly and keep the spare:

if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
count++;
count++;
+ /* the headers go in a first buffer of at most tx_hdr_buf_max */
+ if (mss && len > adapter->tx_hdr_buf_max)
+ count++;
count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);

   The split pays for its own descriptor and the old spare stays a
   spare.

b) Replace the spare with the explicit count:

if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
count++;
- count++;
+ if (mss && len > adapter->tx_hdr_buf_max)
+ count++;
count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);

   The count becomes exact, and one lower for every other packet.

Neither fixes a bug I have seen: the reservation already covers the
split, and in about 3.5 hours of test traffic on the patched driver the
ring reached its stop threshold over 300,000 times without a stall. b
also changes the reservation for every other packet, which I haven't
tested. So I'd keep the patch as it is, the smallest change that fixes
the bug, and leave the descriptor accounting for a separate cleanup.

If you'd rather have the dependency explicit, I'm happy to fold a) into
a v3; it only reserves one more descriptor for those TSO packets.

> I'm not actually sure all the logic there is actually needed.
> The code calculates the number of descriptors the packet is expected to n=
eed
> and gets the packet requeued if there aren't enough, but there is also th=
e
> 'post transmit' check that stops the transmit if there isn't enough room
> for a full length packet.
> If the latter is valid you don't need the former.
> Although a sanity check that the ring isn't being wrapped might not do an=
y
> harm.

The post-transmit check reserves (MAX_SKB_FRAGS + 1) *
DIV_ROUND_UP(PAGE_SIZE, tx_fifo_limit) + 4, which assumes no buffer is
larger than a page. The linear part and high-order frags can be, so the
per-packet count is still needed.

Andre
