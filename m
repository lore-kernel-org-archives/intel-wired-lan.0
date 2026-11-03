Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B3606A324
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1VNLRrgo;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWGSeIW9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56D9380D84;
	Tue,  3 Nov 2026 04:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYkN3gVWsDED; Tue,  3 Nov 2026 04:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 664DE80DA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793680326;
	b=sQrWHMW89KeVse8WYeHGTHBxnFoBpjDa+IxJ8TwESJMycuiexdcL5tAa5taZmOVgecoX
	 oNSGVNyj+kWtPqXTlFuGy4gohFFuAgf4aHB3kuhQpAinhEUOmKOaQqZlT1ClU32BQIvyy
	 q3+LS7Yj0EhyuAM/FM3N9O5bVBky5gwy/qDS2QCZOgTR0zbdOvRlD2an51hU1BXBMiRf7
	 GVO6sAaxDrvzq6QLCQ8dHMW7x51J9x7vswMGXbWsVgiqVRzTWT3+6r65CgmZ05P9rfZME
	 R/49PBG6gHIvt3D62ejlxqCJ7/UVnGedXINvTiweWG5uronGNrHukk+0iPJ6oINPljg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793680326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K7cNTtUrlw/YMKMwg5CBdynxQMrMR2KfNh32rGFC1ZY=;
	b=frisxnwaAGBvqWAiY3pgnptvQXuRmayxnqpBuhQ/XOcuBajdeqYMQiU5uRnWC2MFBXbW
	 CNxERDsOEAebS1khdbl010ot6vqplXendFDwVS3ziJmL5G7B4kOL4iGJ7XK84KPoZSFKn
	 2Fz97oQIqClhYk/r90Pz3lszb6eWRV9gODV9Jj4QmLe30bENw5xhdUJrpYkOnbGpQbQtu
	 28YeBUjUMY5enLPPKnPBr66L+I8Zr6VpkcLbgW1WxzUIsk1YRNOWp3FtK2VZsDkEYYK7G
	 B4AIxYT1w2LDg25w6iGHsWrxQxZjkQkBvRcnlQgdlsyPpA0FhcbGxU7di2vwiVmYOaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793680326;
	bh=K7cNTtUrlw/YMKMwg5CBdynxQMrMR2KfNh32rGFC1ZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1VNLRrgoyH+JWoAp04rzkOnjmI70T8iY1xs8JfKoveHjVXr0jql0fpd1RMDPRj41A
	 wtIny+JgO8jcUhp5576Qj92Ztv7f1xWyor2Eyo6Ksaq8ssNKvHev5uRAk4DBiC084/
	 b79K4Ma5ukYKdAQ0OIj1h9bDvMvAG/nyAdQz8EwboCM2H78lVqYgCHjhSJrZEDdZiO
	 sOsBnSHBLj6/7yf4hDIJIXzfkHAUjOepE1LoU8r0gxdh7OZa7bJ4Ht6epLMR6tKU2u
	 j8nIrURz3RoSBFW23tkRMOdvfUbQF5bf+ZkqFucG17H8uOns/NYtJnTm1987Qm6bWz
	 XmWI0bfe/47tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 664DE80DA9;
	Tue,  3 Nov 2026 04:32:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0B152AC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 04:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A23DF606A8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 04:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k0qwrwaPxoyr for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 04:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7DF856067D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793680323;
 b=XEgj/CFekpbPHSrx0j9/otwwa33q1jWIq2+7cHnlXBp2pYvKTJX/bn7RvyQ3ls+QzVlD
 NZ3BXKkeb8dz6EJXasSaf4bUbZk4G4ibRH7Qkb2+ckDgx6SjlbrtEjb5OLHr3LZ5Kegfu
 nUwfWOR1US1YE8aKDdCOLa8bbY3jUnVXw0XQOl+KIiM17JL8yagSVJFliF6ySW0pGHcvq
 X2ojE62hd71YszUdOU33X0Zt+AceTKoURg1mvDEU5HjhbykPcrh3SMTSy3Ym58JgsTsuh
 JXC30OycfSvIY8jp37uRnPN01C+mczjinVdzkRZZaEVJApe6cJE1zCqVrujMxilAVQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793680323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=K7cNTtUrlw/YMKMwg5CBdynxQMrMR2KfNh32rGFC1ZY=;
 b=D5HG8uAADDAIjC5SbjTPwILpKQkOo849I1jGA02h8AYdqTsoXa7FXokffMyytF0N+UuV
 GN1kUglbo1+5+kdHNPPgI1mXCOZ2DJmHv3VHl/c4QR8tUEl07gpn1wKtvq7OQG9TkRdVk
 85cCpExaR4tVWfbrc63qgrXuISgbY0HpHAptr7YchK1zML3ioQEiaSLNF0v4DcvoxlkU+
 ZhieF2uq5zKJeTBwpEJxTYnAyTXUy5UKwKFlTCYrw5hF5jpPOZsNLzjNQcH0nRbS4oKXt
 1XJN7oqK2nKXpoq/ACRlSiMehASdp5c/cxURXa7J+LsVWl67HMuN+fZo/TxM7TyWzQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OWGSeIW9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OWGSeIW9
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DF856067D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 04:32:01 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b2d14968c9so18179737b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 02 Nov 2026 20:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793680320; x=1794285120; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K7cNTtUrlw/YMKMwg5CBdynxQMrMR2KfNh32rGFC1ZY=;
 b=OWGSeIW9GnI5Kq+MVIS3VwVxoHwekCxEIlTaaxa3jK2TKUMSj4o32GkY+FRT6gP6ff
 sphu1IEa9SnypjrT8fyGj8RUeD0vEoXDEbe48q5upVrE6IV7yPpAx3nOKhtMM8OQACTJ
 mIzkXIhtM8PiI0l+fCfrZ2ArwXMeh6PX5FMYcSSd0t9DtAM4Du1ycxdG6fz+EjAul7BH
 uXYjGPV9gCTkdda9h72qQRFkq8tShcZnvgsgoQRE21pinrBWw94kJnRtFGxNKnVvQz9v
 oLbCv3B/4n3dT5wi33FyKGlBVWzbd3wEu8Y/ALEGw+DJzrG7/3TX9w69ig8maZorlZDV
 1VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793680320; x=1794285120;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K7cNTtUrlw/YMKMwg5CBdynxQMrMR2KfNh32rGFC1ZY=;
 b=mlHN9p4fHwmbpnA+a2Lf1ZZgqM83/kcvBzmsqFzvIU1WVyM5cVw9f9NJk9ly+RQ6Bg
 58Tho0hhUKXBsP6K8cH9DgUxQCd+YEl7keZ2W8p0iLgvjChnLd3CCaOd/mx9/3/SgcVM
 qdTjJvxXPPOyJr4tjdln3m6LvcjrlKyuR/nuss4vt+3AER0yvMoatQPYIU+d5FYhd4km
 Ak9Sj3xtCCiztkq2cx7IPZ0cqMwmuRqf29XLtg+Eba2vrUiobtWwN1ZZ9ltRVxmthsLI
 H8V/9jZUUi1C5axc4K72j55JqVdKEqZh2W9PFPdxKk8VUq1j3kQxCvO+JZXyoKjW/MFm
 2Ciw==
X-Gm-Message-State: APuU4Z8WjCR+qMEesWIh8BJ/sTjUxe/BAi2NBGgBaxlWr0MeLvingQv8
 RTIaTIrK2/+irncD9/t6Gen9Gula0hkuzZxxc5LpGSYpch1juUU//iCF
X-Gm-Gg: AYBFou2w/klprOysNyvAQZtL3gKPM9QvM/Y4ck1nqIFPQRPTW/CGleENWWlIxQOfjmP
 tCgvn+bLEHvHsCORkKsC/JcW/igZK+ZVlqZggz9dYVLyCIXGZh2ymQ6hWsVCztsKIqurdTKkATE
 pqF+M3f7TNfk1R7ONujrqVflCL72ItP/JPf/9N1GhsgO4Wkl93aYTk/nZtHNBZwYWkGnQgm3JhZ
 lUgC9VEEg6sac96VvkQiQ/LlhFPw7yyYMj/hzflyT/NKye6LgK3mxzGhfENxGG5QYEvHiIeH21T
 5rd/RJXCDJz3VI4pD2vBpqUGJxWIAgZlfBfNAqb/sKSf2Zl8VTT+Q8DLMFrhDeEbGaEMNmkOD2t
 S5N+8zi2rhVJbWvu2sojX+vH831k1Dc59f8ffMmxAitFpY4AYFjSnK0GjWEUgeB0jAXNFFwEP2K
 S7ZYwGHb/fGIvg3yhX43Lnyxyy7sUhOEkl+yMbBywIqOqnbTl+eChG9u/uAsJYMxSlZe95MlLhV
 4mqXIgTz4iczZba1wIqxBBM93hxGLJ3/mbzMCBccGMNemckyhSM5O2SEERbgf+biZIRY4XA+vdW
 ZuHktiCiJzgdAXPLIwKo8OjR30G1q6CFafCJsKCTZGKEu8ilF7u5FLQhz3TuyGXDMILN3i4=
X-Received: by 2002:a05:690c:a401:20b0:873:5c6b:a305 with SMTP id
 00721157ae682-8b2b678564cmr58378467b3.51.1793680320144; 
 Mon, 02 Nov 2026 20:32:00 -0800 (PST)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71657besm65304927b3.30.2026.11.02.20.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 20:31:59 -0800 (PST)
Message-ID: <bf1f9ee0-c7ec-4e6b-bf22-14e64413118d@gmail.com>
Date: Mon, 2 Nov 2026 23:31:57 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andre Brait <andrebrait@gmail.com>, stable@vger.kernel.org
References: <20261028170239.28606-1-tactii@gmail.com>
 <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
 <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
 <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/31/26 12:53, Alexander Duyck wrote:
> On Fri, Oct 30, 2026 at 12:00 PM Matt Vollrath <tactii@gmail.com> wrote:
>>
>> On 10/29/26 12:47, Alexander H Duyck wrote:
>>> On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
>>>> When an skb arrives at the driver and the header length exceeds the u8
>>>> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
>>>> are sent to the card. If TSO is enabled, some header lengths will cause
>>>> the card to hang.
>>>>
>>>> This was reproduced on an I218-V with an unprivileged Python script.
>>>
>>> Can you elaborate on what the script did to trigger this? I am
>>> wondering if it can even get there with a valid frame supported by the
>>> interface since most of these e1000e parts don't support tunnels and
>>> such.
>>
>> I will send you the script OOB. To be clear, this is a security fix,
>> not a correctness fix for rarely used paths. The rules say I have to
>> post the fix publicly because an LLM found it in a
>> function-by-function scan.
> 
> I got the script, will try to take a look at it over this weekend.
> 
>>> Also did it have separate cases for the CSUM vs the GSO? I would
>>> suspect this is more a CSUM issue than a GSO issue.
>>
>> I have only reproduced hardware hang when TSO is enabled on the nic.
>> Otherwise it likely just mangles the packet, but I have not confirmed
>> that.
>>
>>>> Fix it by disabling GSO and checksum offload when the header length (and
>>>> checksum offset) would exceed the field widths. Compensate for a
>>>> software-inserted VLAN tag.
>>>>
>>>> Because of a quirk in the ordering of ndo_features_check, the skb's
>>>> transport_header field may be stale. If the skb carries
>>>> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
>>>> no reliable interface, so don't offload it.
>>>>
>>>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
>>>
>>> I am pretty sure this Fixes tag is bogus. This is the introduction of
>>> the e1000e driver which was in 2007. The ndo_features_check didn't
>>> exist until 2014 sometime after that if I am not mistaken.
>>
>> My understanding is the Fixes tag should point at the commit where the
>> bug was introduced. A comment on the Cc: stable tag indicates how far
>> back the fix can backport. I didn't bother because this patch should
>> apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.
> 
> I get that, but at the same time the fixes tag is pointing at the
> driver when what more likely happened is that the stack evolved past
> what the driver can handle as evidenced by the fact that the fix would
> never be able to backport that far as the function it was adding was
> introduced sometime after the additional stack complexity was added.

The Fixes tag seems correct to me. To confirm it I reproduced the hanging
hdr_len values against 2.6.24 on top of Fedora 8. It was more or less the
same script, just with different headers. I can't confirm that it hangs
the limited set of hardware supported in the first driver commit. Maybe
Intel could test it in their lab.

It's worth finding new core complexities causing problems in drivers, but
in this case the mechanism predates the driver. It really has been a
security bug for 19 years. The switch was enabling TSO6 when e1000e was
spawned from e1000.

The fix not being able to backport all the way to the Fixes tag was a
choice. It has nothing to do with the bug not being a bug that far back.
I'm not spending time supporting Linux 2.6 or any pre-LTS kernel, nor is
anybody at Intel or kernel.org, as far as I know.

The attack surface and details of exploit have changed over time, but
that's not a story that a single Fixes tag can tell. It's the story of
IPv6 headers.
>>> Much of the complexity that enabled frames to build up massive headers
>>> wasn't until much later when the network tunnels and OVS started being
>>> added.
>>
>> The repro script should work back to 4.10.
> 
> Okay. However, that still only goes back as far as 2017 if I am not
> mistaken. The diff you are blaming is from 2007. I suspect we should
> be looking at blaming whatever introduced the ability to push the
> headers this far as the driver itself isn't likely the root cause for
> the issue, but instead a header change was.
> 
>>>> Cc: stable@vger.kernel.org
>>>> Assisted-by: LLM
>>>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
>>>>    1 file changed, 33 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> index 6f85dab5c55c5..370776657d100 100644
>>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *netdev,
>>>>       return 1;
>>>>    }
>>>>
>>>> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
>>>> +                                          struct net_device *netdev,
>>>> +                                          netdev_features_t features)
>>>> +{
>>>> +    /* Do not offload packets whose header lengths exceed the u8 fields
>>>> +     * in the descriptor.
>>>> +     */
>>>> +    unsigned int hdr_len = 0;
>>>> +
>>>> +    if (skb->ip_summed == CHECKSUM_PARTIAL) {
>>>> +            const struct tcphdr *th = (const void *)skb_checksum_start(skb);
>>>> +
>>>> +            hdr_len = skb_checksum_start_offset(skb);
>>>> +            if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
>>>> +                    hdr_len += __tcp_hdrlen(th);
>>>> +            else
>>>> +                    hdr_len += skb->csum_offset;
>>>> +    } else if (skb_is_gso(skb)) {
>>>> +            /* Work around untrustworthy header offsets in this case. */
>>>> +            return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>>>> +    }
>>>
>>> Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
>>> the frame must not be TCP/UDP GSO since for those normally the checksum
>>> and offsets should be populated. Have you identified cases where we are
>>> seeing TCP/UDP GSO w/o the checksum being set up?
>>
>> It looks like this particular case is never reached by normal traffic.
>> It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
>> hostile or niche setup.
>>
>> When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields are
>> used for csum instead, or left zeroed.
>>
>> The transport_header field is unreliable when a packet is being routed,
>> so you would need to parse the packet from the top to find where the
>> transport header ends.
>>
>> Rather than walk all the headers for hdr_len, it seemed prudent to just
>> categorically deny offload for these exceptional cases. I could be
>> convinced otherwise.
> 
> The point I was trying to get at is that the stack shouldn't be
> allowing those sort of frames through in the first place. Basically if
> checksum partial isn't set the stack should be rejecting the frame for
> UDP/TCP GSO, not the drivers.

I agree that this patch demonstrates how obtuse it is for an
ndo_features_check to reliably measure header length, which is something
that several drivers need to do in the hook. The issues being worked
around should be fixed in core.

GSO without NEEDS_CSUM is the biggest offender, no driver is checking for
that in their implementation of ndo_features_check.

Using a potentially stale transport header is next in line. Several
drivers are getting this wrong. I'm working on a fix, a simple reorder.

>>>   From what I can tell it looks like the only valid cases for it not to
>>> be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
>>> FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
>>> anyway.
>>
>> FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e
> 
> This is part of the problem. It pushed through the ability for
> CHECKSUM_UNECESSARY to be valid in an outgoing TCP frame, and then was
> reverted back to using CHECKSUM_PARTIAL. That is what is partially
> what is allowing the non-partial checksum through for GSO frames.
> 
> I will probably look at submitting a diff for this next week to look
> at limiting this as there are a number of drivers that already expect
> all TSO/USO frames to have CHECKSUM_PARTIAL always set before they
> start processing the frames.

That would be great.

