Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1312FC982D7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 19:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C299360E6B;
	Fri, 18 Sep 2026 19:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AKXRVNsobR6t; Fri, 18 Sep 2026 19:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EED4F60E72
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789758516;
	b=XIJfICH7s/p/LXM4VyK2zToQxOOBMQvf0+b2MeNvWr2rdCwACPxYAfTF1K4Z1PGaXh4e
	 S0WcqlI9eD9YoxXyOLTSka/oqpuES0aHMaSrVPVSJ9Qr8/gjixJXDdqzfg+i96NgS5/Dm
	 epvY7L6DJeK23a2bjx8viYodm22Ks1/frrnJEOLbaTsypHA75dEZXPYxJdJ3PmV6Dp+W2
	 3SINQQB3lo1leKO2IflJzPGjd0difXjx88534jMkb3w/Yeh/+YfaThn/mvm7lhGJSSIeS
	 cI6w2IBUOTbOVWVla/MPfZWhuEe/AEaY3LDl99IBy/uM87r+Ny/hmtjCbmxZ69qOYlg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789758516;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MWrsG0dWQtoz4tNsDMFKfRgkKfhoRQPZSmVZHeN4ObY=;
	b=axDSdHA5cVyFC4VkgnHCWEsjpEWljBBNMYfh9HVq9UP/yJ9qy02vFwoxce0xWTXU9Xdo
	 pecF4mWTjQ4jZD48ccxFwpAKhJASR1NfBrQvkkagEN+yNCZhu6gwsPBN8FaTjhdmH8MGq
	 128Rx/jTMI4Pka1ADJeFDwuwwHwRKhNVJReMKgg+TrctW5G+3MVnP9ru3g+zHWALBG5Jl
	 Pn1miwr2QZPKGZvNg++/edQZsZNp1p5zXQ2pBX9HhvyaZ/sZQ8NscEuY38AaSgvCl1Vk3
	 Un3md3/3POVrpx5Gi8MYfVkRb/j+oaE6luYf7qMbYJcFrlkXTjamM/Z0j7xzYgItFMA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789758516;
	bh=MWrsG0dWQtoz4tNsDMFKfRgkKfhoRQPZSmVZHeN4ObY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoDiGKJ9usQEEU0furoMUZEXa2mi3zx/0K1v1RKATSwupSSTKOjKFYrfWq/dtnSnF
	 2bI/8OTW1mf7COJ+0JQkkhRX6mEsjgmp1xCgLt7zGk66CZyMD+SLRSqrwImHTf75de
	 0BYuJody6Dudvcav+zh41tjXAtzQTDlGLWtiJpOrpAbvTkUQWNAm7AqDVE+58EnET8
	 TMjwJg14DnR6lVRHiUxtgq9YJIZynAE7awIMkfYcgRH++FjsAjrpyjCGR3CSf0N5Rr
	 7nL17CCFY7JYyHn+xS1pLhjLMDPqeiIn6997GaSRtE2CvIGp+ZS9Sk6bKGMO31SvRq
	 tJtfX9UsYqBcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EED4F60E72;
	Fri, 18 Sep 2026 19:08:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 341F025B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 19:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2568040CFF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 19:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4yWOnQ6HLwW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 19:08:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EE5BA40CFA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789758514;
 b=FIGmBPRf75r7rnG5pR7OH/gja61KsCcNejh8/zxGZSwrLuuNsxxfqrfOon49A3yZQ1K4
 FtfYjIb5/L/u1M1f16Umm7idFsC4FuNvj3IBIXSTyZi9LvYdYoHlBgBfTBmPhjcyeZeCv
 I2Jkk7yKzw9/BQvMMuLsUS4xb1tDa/et+Wyn8nY9bsEngtSO6wgRw4J083tgyULXMGdcP
 mtbFqDZ8gT1qrKEb+fBk3Y3ZQe9sIlGB1O5omiziBtr92M7p+nV4LhgUKrys5jv2NUYUI
 HxqRo8JuTfamwW+rFuKSSAjESBoppmgIbW7fvRTknYjlJnXdnOLTz5g6hBdLxIlaVBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789758514;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=MWrsG0dWQtoz4tNsDMFKfRgkKfhoRQPZSmVZHeN4ObY=;
 b=aZ0/0yXA2pYuLqriMBT4wzu/XvE+hfFJbhDCA/Xbfb9EzIhWUE8aNWRCNG1i3v5BbuD2
 IxNmoNiwTbJBj4ZjOy3lGddqJSLI8b+jtFPcJW6f8uCaeZGvcIiSwdWtzf3wqt2xEJpKR
 ONKCGyUU1JwdUw4q9ekvEjettDeA/40j9z5IQkBddM0xHoTziSygcu3cS4JeYTT4LSyHO
 jvBJWmmG4zZIbwrNtgcwZOqSxTRL1r7qDb/YjyaCc2sIXWDsyuxpX/plqR+TNZuUCxeIY
 ck0l8RA8tA83EjVupoPGxmaGqaK+fItOkGUP91w/NnSi/FyzoxkDngvEs73Qf1Njmsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="n/15a6T0"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=hayatake396@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=n/15a6T0
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE5BA40CFA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 19:08:33 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a9a2b95b72so1752664a12.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 12:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789758511; cv=none;
 d=google.com; s=arc-20260327;
 b=QNOJmwh6czbF0r5J3e7yjRk1s+6c+/kkonIDQsDC2uh0lqw7yAyCn1Yq3KUqhAbOh1
 lNPiBKkymkCFfJMEdFvEOw+dlhWnPa78GjhqFUsRdS/5kfs4ZuF6e/u9RcpFkLhSiudC
 1SfcEvFnwCGxkP1NskFkq8X+d1J19yewfolgOfKS8MjqxNZm9K9WBd3tEvF5frV6fBt/
 9TCgvHwc64ugN38X2wUqYiOyhOV23tglpVNVhzvNGOewPrRM1twWwvRAbrfgaTAMfzfy
 x7xsrrudrJ6Dtd+5x3wxh/Ho4maYPsMUqwh3eP0eqcO1+4eRIRmK4/Pdu8NI+ZJK1fkD
 Akqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MWrsG0dWQtoz4tNsDMFKfRgkKfhoRQPZSmVZHeN4ObY=;
 fh=7UZf/6+AF5qmYHkgWyF/KMb1OQuhrghSMTjM3j0mtX0=;
 b=U/Z81I5O89yWNzjnAfYiAUFMH+hY8Cm3sQVifRgHk8s2kdw76E3uTqB/R4ShjGHsQQ
 RNPByEQB8xbtWTQSYMZEoba25Di/s9VpDTnMakAPxpSglLCQCpbGiJIxeqwhIMwQaQj9
 Jht5P+/K71gLX7VNHhQ6iukdkhNFCEi9G1QuNYShebyFhrJ0pkO+FY5G7q13H+ISA7SO
 1Sbd44Ot7U13P0nGI3afw9+IND3u55jLJ1+0H7G5tCKh4edAeUcqQAReAcQQiTDH5NsP
 d7HEhaynfi35KeQki5HOFormbef2cAU3GZPusKfQVpecmfa55TKYuqAWLLOvKXdW1iQz
 wLTg==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789758511; x=1790363311; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MWrsG0dWQtoz4tNsDMFKfRgkKfhoRQPZSmVZHeN4ObY=;
 b=n/15a6T0t/gTt7S3RCSKno28nMNtLJHbz7XycTngEgT7M/Yuq/+Qj7fLlovP1qAcLO
 tEVW0X8TH0rz2f8XfOaUgtBZSqNw4K38Mff/NmaVe/GQbVn7Mk3aNuKb3toa0zaO0F1h
 NGMM+6XKAOO3XHYKEsxsAxS5cRLbNqVYgJbqEk2Dkh9PL6ZTC3fhdsMsL6mmpQSRNWtE
 jFy6ltCX1t1NuvYVauQ7PcOqEtaifYgCo2XXd4laZcPUxCzR1sLIToTREzXn1Uh5ZvYf
 zUnJaY32zlZ39LRW2dhJsEqz7g0nIF2aXH2zEHI5Y6Jfhhqje4gQpjCyD+56edJh3TZ+
 8pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789758511; x=1790363311;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MWrsG0dWQtoz4tNsDMFKfRgkKfhoRQPZSmVZHeN4ObY=;
 b=jbHNNtgD5vCjkc607J0AJOBbhfE5IGOVIFI5PRhPU2+W8ijanZmo4zjvcejay0shzk
 WFNBL/5HdXxs0Z/w17mn5y0yxl6jFIa5TGZWP+xQeVPju9WQFAmtJ3sW7uIbc74hugNv
 PBog1PIuR5PwW8XL0Zw7Gs93XNh9NJqcuIm+gCA2yKYkUeLtCgv8FFRIRLL+IDYvnRFn
 oeeWAyhTrboZbj0KzbSD7zEnLHXqzFEa41S1SdWIEko+kD8nxcxqlCz8nv1o3qMtR+cX
 Wf6TK/iqF8oywzY/3G2ErCdvIwtMtB29UBkSHrl0DXirkOHxsgn2JedpN/SRX+vQ0dwt
 N0lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3lcvDdSeliMPwkB3Sp3HDqhvf76rQnIKvLPsjSKe4i7RWGKlQ0veHaRhUPDgUzWxBRPkVscRRA15stDqW6pI=@lists.osuosl.org
X-Gm-Message-State: AFuF++ncf8ZVci14tftk0WNEfCmdxrtfa0WoO6xck7UNNaqbmY5AiGvr
 fxp2rN/vp9R4Pruit+g4kEkGpwHWSJDI0Wj0+4vb22X0uil067CHljSJWNFH5kCj5+c7QSFlZKR
 AMYQpUZdYy0rvlEWJVqtI99yfGRC+akk=
X-Gm-Gg: AYBFou0JWDfcexR4MTlOnpGAHpznbaa4H0SUWftM6QP4oSFdpfnEPE9hCkGjY2wV+E+
 zgVCmMjJx+UTKT6zuiTA+VHQEnThOqxOtGCTFXAsC6PnU+IZ5aKfMQE0H39+bVkHWHXLp9OpWjO
 r2anU3+Qyj3YXDkfA4gyjk1gb7i9/FopeNjZNHHvY+AkRSOTZAY7N3uWAT/yRtw4321DqmUzhoV
 jdynYf2VS8ny4WFnUfqHgFMO1jYBXzj3axu3SCV4U+HaZuUITy1JjnkWUZNTLQ7EFyfrpkeMnUz
 I6vRGOYN+KCMX8iwwqt0aU8jCEvITCxTGB0qQvoIgvV3lYAKKG8uOEpeCP1W8A3yN5ZPTR7+Cll
 b+imv1NNZFlo=
X-Received: by 2002:a05:6402:2106:b0:6a9:eec5:83c8 with SMTP id
 4fb4d7f45d1cf-6aa57818ef3mr2350329a12.14.1789758510923; Fri, 18 Sep 2026
 12:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260727225659.Cz3qz%anthony.l.nguyen@intel.com>
 <CADFiAcLvxVh=E9Esjh1fQBVqtu-t_=8hyTCW0_dfb2VTKiJ6=A@mail.gmail.com>
 <a1a0545e-730e-40bd-9935-8f5e3fc5dfb9@intel.com>
 <LV1PR11MB87904135610E206A937033D890872@LV1PR11MB8790.namprd11.prod.outlook.com>
In-Reply-To: <LV1PR11MB87904135610E206A937033D890872@LV1PR11MB8790.namprd11.prod.outlook.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Sat, 19 Sep 2026 04:08:19 +0900
X-Gm-Features: AcwNN1VKkQFg82VVCfn_r0WKJhUWNBRnpKxOMjDVOPLmqRZpA-MkWHyS4aceXRw
Message-ID: <CADFiAcJ67c+sCDEcKJnTzp2OiUyEiYDVD7OQZ+tHYVk26vpXLA@mail.gmail.com>
Subject: Re: Patch "ice: fix empty PTYPE set for GTP RSS profiles" has been
 added to net-queue tree
To: "Nowlin, Alexander" <alexander.nowlin@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 "Czapnik, Lukasz" <lukasz.czapnik@intel.com>
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

2026=E5=B9=B49=E6=9C=8819=E6=97=A5(=E5=9C=9F) 3:24 Nowlin, Alexander <alexa=
nder.nowlin@intel.com>:
>
> On 9/16/2026 6:13 PM, Takeru Hayasaka wrote:
> > > Hi all,
> > >
> > > Gentle ping on this series, posted about a 2 month ago:
> > > https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=3D5=
137
> > > 64
> > >
> > > Please let me know if anything is needed from my side.
> >
> > Hi Takeru,
> >
> > Our validation came across an issue while testing this and we're still =
working on getting the scope of the > problem. The display (ethtool -n) is =
not showing the expected fields; we're working to see if it's just the > di=
splay or whether it is not programming it correctly as well.
>
> Hi Takeru,
>
> We have finished the validation that Tony had mentioned in the previous r=
esponse.
>
> Based on our testing the underlying functionality of the patch is working=
, as we confirmed that traffic is routed to multiple queues as expected. Th=
erefore, the only issue with the patch is the ethtool -n display not listin=
g the expected fields; without this patch applied the GTP fields are displa=
yed as expected.
>
> Thank you,
> Alexander
>
> > Thanks,
> > Tony
> >
> > > Thanks,
> > > Takeru
>


Hi Alexander, Tony,

Thanks for taking the time to validate this, and sorry for the
incomplete patch.

I can reproduce the display issue here. It's the lookup in
ice_get_rss_cfg(): the patch adds IPV_OTHER to the stored hdrs, but
ethtool's hdrs never carry that bit, so the exact match fails and
nothing is shown. Programming is unaffected, as you observed.

I'll send a v2 that fixes the lookup.

Thanks,
Takeru
