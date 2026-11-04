Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F4606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sF4L+Eu+;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fk3x5tew
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4AD780D5E;
	Wed,  4 Nov 2026 01:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIJtAl5LpgLi; Wed,  4 Nov 2026 01:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 450BE80BDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793757014;
	b=ezn5NdZMLz8OEpNBxm1/g5eQCvD36yvDmzPibaiHlvdM/T+etN2PCUW2YRYODDPDoLEv
	 uZqJYkPqtHIvZ5ZRBNvYHLlprwCFfbQz1cy76tBJde6joiCPG9A/Czl4tRaQlT5qFLFyU
	 lDonC04wetjk7tzL9B141Fl1gMMEOfm/hyI+kgKGxpY5J5IAtq4xOeODLFQWGTCy3dgSa
	 9ITSb13jsduGCd2de79tnT52yxvbYzRLvdvHAU3Q/hMFSMB0wNpMIaw0u4fhWB610asqE
	 w2DarF3SchyrcqbQSRpxjcUR7oWOanGCyJZ+FhPwQ5PXU08CrwdgBK/d4Gw4qyxThMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793757014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
	b=DdHrJaiKWnYSHYI8EJ9iJjkYnve8rPWskEQZ+7XL8jYqKgyh2LHPP4RxNaQfi5J8THm3
	 zboXmYFaqGVnhQN0zu6ZH+5RpquFaqjBHdXt6TEb44FEyQZfeBqF/e9mNEF+j9HEErUvE
	 4ga77k/cHEfuRff+v/N1Q1M3F/btP0MnRpzj7ZbbSBYlexaz5/IehxO1SXNvZGHERVVIq
	 ZrG7C1r8Bw8eGMCFPJZNHUiwKr17JAkEbSciZMGyk8/ayWDtQom+7JbKMNdEd16lyyGK6
	 VZdqDVN8uf/o4WMkE1O7rCCBoDr0V0JUxuayRxOXdkV7z6a9F5BOAsSXEMI+R4xcaEg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793757014;
	bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sF4L+Eu+tdKS/r5NqWmnZLjBZLpKXkLwHIgJd804vptgyx7yRlK5OuTupJtSxLzUF
	 5tmv0rCcapCKuqSZOIl9+sIZh0fHOIMnRNGOG/U2lhIhxEoGUER6QHe0PnccUi+dDq
	 7mVNpKTg2jo9OJjns5K/oT2TIUUxf1HFHAtFXiXaiDU6Oj+pH+0waqtGa4q0NgUNl0
	 SFFCSER2yPCyMkgpYjVOX+Aja0fxLug9Kyk6iHNZHLerQ2j3p++t5RbiiCJfxnQLZj
	 MQjD4F+33G+1HV/0oZi975T6crzpaUNnUZBGuhHC8Z4MW0LHurOyXyyb23qHV6Cx7m
	 xeAhidu/MjmAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 450BE80BDF;
	Wed,  4 Nov 2026 01:50:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DEE9784
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 040CF60697
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:50:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lbE-uM2dH0iO for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 01:50:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DAD276066C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793757012;
 b=qYQLnIEj7kQGjJNNmbm1DYdKNYI6skFhgrSlNR3qYlTjhpU839fgnVWsF7uPqSdgMPHf
 sSOtF8tRb/xnLu//0ArBBLe1rrEdtaJpj/xlT27UrNQ/gXUtw/IfX8ASgG9gfQ6P5BexD
 ijfRTltB4t5oSTwzXmznwcBkZTjdlLEJQn+RZxpt/ISglixr9p+defE3S8BgzhgSRNjhx
 IA0Xti5zmC272IotXIz3QxwJa8hzAQy5LpOp/yFM4bHS6X5Gg0r4cx2qr6TRLH+mkf4Bw
 krOsLSZS9weKiotHFpZQVT5oDqOfwduc4H2tnJde0JqwhpPmv8EK+uMlKnJyXMjZc4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793757012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
 b=B1Ed08joZwr42eIG5b5rplIOW47DRnR/LG/QzJn78aheE/u5L2WbdLdob4D4FVzci40V
 DmkyyR3MU13nTOnxRPmxUfRhx6GO3SeIAYNP2gvtJvwsCjDn/1cP3FaRledTCxD6e/yb0
 HWa6+e4xP2PHtVCYPMhEXbxRu2FhuJW0GgYsQI4joo7cnScyZVReUKA2gf6Ey7sHXcnDT
 oGTvlwtkDfUWMPK1CWoec3aOv8oOnf2RAjEuQAZBqKwBvTjpTKxBFgncAVFG5VngYuskO
 zYDWA+Rx2b/HMkf6cH/wM5/ml2Guklb45XQT/94ZzAldfUJYRrRARimGMoLYQd19zsg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=fk3x5tew; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=namangulati@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=fk3x5tew
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAD276066C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 01:50:11 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a54bba0442so10695e9.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 03 Nov 2026 17:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793757009; cv=none;
 d=google.com; s=arc-20260327;
 b=Sh7GxHQBtkTLT5BAT6BxK6vcOIlAFyDdUqNZ7V3eGTyvTw/07JschB/U2bnHFX+QQ3
 GIU142zjc+XoVUgNvgoRWKQlrGnS9VNLhI/Zzqyraai/P/pV8gNkGHAHpLQwwnmioNVq
 uEZgNHu/Omb7zelsdQ/Bn1JtQExMi4RktoqYB/M/UrpbdaWKMNmPYsUv0aEMN3PbLueG
 mz2vOyWdH/ulmStpGFNn9yC1Yyb5HlNvnSN8HbFIKszHt2AtnpcA/jx85LiZ6lQlGn1n
 sjGTmGTZZJ0paeZD/uC/8pLK9TIgNwYd/jWK7EVWBpEpCXOfNH9ekW61sETpfIFX9exZ
 iZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
 fh=yCvw77gD8ir86p7IHENFPWYP/A075sxJzYqhZWxKMBE=;
 b=KsZ2ggwbHRzVuWVxyav8ClS5idmfE6R9jyaKLhH6jDaiuxiuAGAf3DBsqogq3OSmfX
 BcilTZxKNtYuiy0rSQQGYkYwjV5PVfHw4i5x+FhNhCSAQ/PMc7fPIK6ObOhAn4tCKGCN
 afn52jImgizZDjsIBBZPCRh7KrvCWqbJpOyrfNndhUtUgOYqQ/WEDXa5NbsvbsXGW6a9
 J7KAwylikBIEKgCsdRck97/A8TiF5080eUg4tYi6z6qhi2kL8oRYCAgPV8OeLAH5cLAH
 XVmzOLSYB8rotKqQBR/nn6QARPsq0Vv8VDGXvigxUUvGvLaesa84Ioju+usLprUMBZTM
 vr5A==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793757009; x=1794361809; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
 b=fk3x5tewJz7YW2YmpmMEZLKWtlfu6SisDgfb/f5r85nzhoKAOoF6VnOrKDto/31OM1
 8T2W7mW2/VK7d3x46qZAODcu9Z9OhTGjLF9ZoGdVBUshIHAiiOaxz7er+lEBBwhOGriE
 qRffmwnJjX4QXEr0HmTCEsNqGb2N8hb7cAOfhVOyeoYz6mvDJAP68iZpLVTVjBYLUvM5
 xMUk5Ei7pLWk2EepatVpzXRL+iaXCMzPyLEsP0hmef//qQEDztItGgVdC6h5RdnG406H
 LIE2g8tb5oFJGvJCuAmh7wbsz/2ek+jSGzjlAjJKc/0qfNRthmZjSQqHhzhrTgDUkqYx
 UwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793757009; x=1794361809;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
 b=zMyGg6CPcJO9/lBv7EPIDBuCSHHibkYbV30ayBriETxGv44esgH6k4h/MPV47Z5BgH
 ItwqG/NFEacZEH4EfSDB416KD/wqLUSnCO5bXiM1mnPglG2sk5zfQWvYbRXbMfekAWVw
 MAugn6R/1hMegleslsLzOyv7vjqlGgl0KvuFO16Kdsk7FZKLjVVMHMMzBIdWQ6zlZTMm
 DuoDwaLL74vJAbnvTEJ6pU7klrhULaYMmUbXMWC2w4RjIi80WN5lT+oaugb065sQM4AL
 np5FVhDvRELak3KdCSU27778KfWa3lpJ/4uiq2j3vucuQ3oAVlh1/5nfKIzkackVpLH1
 ieQg==
X-Gm-Message-State: APuU4Z+MSTD+RFoUPXeNT0DODmRjP3FtLjtBCnHd2USG+2wpM07er4AF
 uw4tObr51zt1gMt3tuENtqFVIIK/DKTloNe65VEo2yCOYYoysGLx+XzmRIToO2Xh2bBw7sr4/Rj
 giPj4itVSJP/mxKYmT7a/zXVnMglXTmSsjpJPfWRB
X-Gm-Gg: AYBFou1dwQ0jvInLtt4LijmXE5PO3gOFG9CdxwSAHarA+Gphvja+EIGfb2WVH7OZ/PE
 N14iDJ0DmhlRGn2aIs1Mt/SVnDND6VKE+ISjYdUl624A25HWchFvKcqWcIvLeOoG6CktZ6BJsRA
 28ckTAmoVNNGAcYc+0Evsx9qKN4UM16MvFpSm9Zjr8hE0EpzaqW3dCGIgcwgNS8gXHNo77n/kYW
 LuJi/rO8yNIs1lDOq3FavmiYGK4M1S+R1uzF5dulVGZsDrF+98QAOaPOvIxPa+0VRMTxlyQYCif
 a0mztGW4nl13eGE7JHTK2g8Wcsp5SXbf1mjL5Lle0cs92DJ4HwQublK3otpFAsiBE/umawItT+T
 gdfQRgeotvSQnR2RBsvWUKT6GLYs4XgvwDx7QqtSEz9taAIHPkFXh8jf08+41bw1Mwuc=
X-Received: by 2002:a05:600c:a109:b0:4a2:a8c:22ae with SMTP id
 5b1f17b1804b1-4b45fd0ef48mr117255e9.12.1793757009083; Tue, 03 Nov 2026
 17:50:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104013606.1527767-1-namangulati@google.com>
 <179375632025.488859.9511320336418102727@kernel.org>
In-Reply-To: <179375632025.488859.9511320336418102727@kernel.org>
From: Naman Gulati <namangulati@google.com>
Date: Tue, 3 Nov 2026 17:49:57 -0800
X-Gm-Features: AclHuK-5IM9JvG08Mx8jxWfqp4ANOqu6iSUagnQ7OJrd60Zl7MpSQbKp4GTnQvA
Message-ID: <CAMP57yVyKuW_4ZRcuaNSqhaD3dOiYNF8Pkrxr839CT4utiJ9cQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
To: netdev-bot+sinfo@kernel.org
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 5:38=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

We hit this in a local testing setup that increased memory pressure
and caused RX header buffer allocations to fail much more often.
Observed a high amount of idpf payload buffer leaks under high flow
count TCP stream tests with this setup. Validated the fix on idpf.

>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
