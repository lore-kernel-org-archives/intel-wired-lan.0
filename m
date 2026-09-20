Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71067C982D0
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 09:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E671D60641;
	Sun, 20 Sep 2026 09:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SoosC_CrgXY; Sun, 20 Sep 2026 09:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1D94E605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789895560;
	b=TijNz5KIcy44jYnOEHreavna5KQIwnpHAhLEwYSkRJYtGDXKwijQN7jZ/DGuNFZpZe2j
	 AVWHzH05riiKzO4cXppncIbnaQv9SXgrWx4O/gBbcxULiW3T0IA/B51K57DKNNgZP2p27
	 81Q76UZn+IMz5wLFJpsNyhn4HvSg0c3aOzoaU3pDCEqND/+4/8o81fESvU44SGNl5XBsY
	 pCwQ1D8sehaQxy19C2MzkGT47KnRF79xabQOPG5xKy8KusdjcnNC0bugsEgKmCr3OjOpd
	 Pr/yT/aptWjOB06ZAlcvP+aCTzAxn+LNz8Xfv+xXbvIqKd166aX5elcHqKLdXu6Qd6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789895560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wJvbwccNJVQBjScwvHw2FA6Ua+KpAyZyUnPiCvsRwXk=;
	b=bmdg0A9vU6dH4bj+6ZoJOGq0qaY4Eaam/q15knh3dxrYnG+AQWhuF9I7Vi3A40ZC0bBm
	 mvEf4YnVSVo3+UGUtNgNjdDNvZLhDMUBEuf9fk7Fkort+JHZpyRKLhIwKLLInyCalsKni
	 VV6xBoEHbnQyK2AhL7Il7RKcnOJPHdPRZ+TvlrMl/4xFvNd11oCNO6D+c5RVma34FUm+X
	 hVHvI0JMTQkZS8vxnApSKk55iEjKu5iUd9sShzVmtFaRpFrucUB9j7Q/n9M9FpwZjfu42
	 CBGIr4vHxAd3Ckj6gKK+BiUfYgLTepPmha2Jra4z0IkkUchDal0m7WwSY4jHWr71pwg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789895560;
	bh=wJvbwccNJVQBjScwvHw2FA6Ua+KpAyZyUnPiCvsRwXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xqrE036FE7bz8n3V6MfMftchr/QVVyYxFzgzT/awB/PYC2U/fnoviGgjFsRaBO63X
	 JPBjiHEiS/yPqokINOU+aIPqHv3TdRbswORfFtSR+WgFEWwFZNNCEOCimRrLS5NNTo
	 yCKef2hSyncRlsLxznuNi0LzwpFeQHV2DEinC/DFQrieNSGj4Fir8s8MIRN3FV1VE6
	 4JTH8c4rFBY/M+BPtRu+WpP1uTvt3hdGsFFWTO8TiT/npWcHDoLCXnjkg9+CElpo4l
	 FXi7Ke6UFvad4WDrZpK0s8Zaag33iq+sj0WII5/dCQ5LCYIen4slKQ8XWPnAqzLlcu
	 b+ankZ1YhbS0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D94E605FC;
	Sun, 20 Sep 2026 09:12:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4838824D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 09:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E0194007B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 09:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZVd1wYGHo-r for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 09:12:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 164F940062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789895557;
 b=T8AJm6g7J/0B89CxgL2Z0cZZ741GAFOGw5X+Op9ehBeLC75H7OimIip9j4WZkFxOCEw5
 YoKFBqGrWBqTTCJshSmLRvF8MjDMbOyIosu2ugv50P9lriUB+nzyUhr3Sti5SxJnTqTFs
 JlOMdHTh1jO2or4RRi/M6LFyH+KXWDrd3ta0uO+vEWSmxcAdsdnLpKPstMzGyPKUz+ktW
 mPU0gkhDdCWld1RlTb3xGjk+ol56HVkZMHAhqgEAH03UdI/B/p0LVyw2sZ18hMYTHoaDx
 N3MZVtnF1REzMbv8RgXk6w4ohBuXA8h2JazUjlYwIYR27jtICxQtDknZkJw8ZzN8Eow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789895557;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=wJvbwccNJVQBjScwvHw2FA6Ua+KpAyZyUnPiCvsRwXk=;
 b=noylckpBeKb0deoDVsA0soXmCDlPGjRqwhdf4GtQGR4cpjlNM42CPy/m4JFWTFOaL0JV
 26LLJA2c1vaOuubbb8Gtsd4/3jlYta2chZrKBhkW0n3cT5t9Q08iOR5YN0AcJ9Zr3FxRc
 1gTRVQT9DE9ri0loM/AbwGbfKHHHZiO4XhYjqSTh62pItEEqzg0npo87eVofoVP2fB9HD
 +zSf3741wZEhbEss5l7uiP1eGJUc+5ayLuQCLLu9XjzEes/vqnuK84ymymOa1cFiEfft3
 HdqRb/efaRjcmG5Lbn73UWR+adePkoFTnk538F8AsBNKDbJiYelJ8ZJfWQB3uzGb4Ig==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JHKNkAIf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=hayatake396@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JHKNkAIf
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 164F940062
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 09:12:36 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae54so3166541a12.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 02:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789895554; cv=none;
 d=google.com; s=arc-20260327;
 b=QR93v6Ck5pX3f98P2TX7HPKxg8Tv4oZSWC5jm9xIVGfaLS8FDSY23YdH4pEsF3C18/
 EGh4UpNIovs/awtzRx3EiJvrCGsVmOoxjERmr8zRth6J+I2vEa8n3CcyuyUvKYs0cF5e
 A0Pbp2iiLJd/V7bOUX2VnRm/0sviOciaae5pxeOVCnkbgtVGiH1Uyb5gCNL/nhs3DAzB
 XvSBjpa1UDKUEkzrn60B5PV7Fc/PRa6ACgsfkFdmy+PqBv1/Ft0PPCpDZE2fQhVGmmhZ
 iOCw/aPVyn4ht3yX2mdl3qzyPFEo+VWdoRriZw+ZkMRmg9aMbC1ALHMyfGD2gyhKQ1PF
 8G3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wJvbwccNJVQBjScwvHw2FA6Ua+KpAyZyUnPiCvsRwXk=;
 fh=igMw0TM5N7kujgkhPdq2cvTvy5lOCJHDa9MFW8R+B2s=;
 b=abBSSspp5F5KLyF+U4VQCJGeauO8PXMqrYSDLJ+rK6hFfU/oG0v5WnSCHY1Ilf/mwv
 OcVjZ9fIzEd7wHpZAXnqr372xR32tzcvsTzULYqKMVl9/ImWzC/c+Q134WjtMsyCRvpH
 lqM7Q6ohHm0/n23reibFwcOA/Sb/FakEK9E3hLEJOCG7Ruw03sbOKKmqqJVDd3FwaeJk
 nP/lhVBHtq6Fayhipj1oaMPAP9opv9CJa0rSZImsS9O86HAc18wWCV2QZuKztUCkmy9m
 P939m9+fgTYKZfYNykLdk+pVS1oW2omvIoGycVo3dl5topE5R+pJoSrrh9XEisx/A+Dm
 Cm0Q==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789895554; x=1790500354; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wJvbwccNJVQBjScwvHw2FA6Ua+KpAyZyUnPiCvsRwXk=;
 b=JHKNkAIf8qtQeEhwgeQ53+fpwUvC69B4MoqzE4ArDahPMSPLLsyRaRUSiRrWnNHNr3
 ZEA36VJcDFW/uj7SFy+gt1NbsYMhTvgOi57sDkriT3gYLPV0vQVdpTJ4rnPQYmvQYLfY
 /mp+uLYv9IThWxQY45eS+symtn7hrAe/7VkUnUS27zq3A4OOwNiB3qEhwLZTIXxH5YPp
 CGQmQJEGdjmBhxKHJGb5rLxiUb5usgakSH9Z6ducr53xTouWW27YG8ONIBDY80/9fC51
 MGc7hYuxPJ55Tj9Y+7GCRowpVrkZGnQCa94aOQM2SfqXq9lOrgoQxklLpxFUyooNIQ1t
 Q7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789895554; x=1790500354;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wJvbwccNJVQBjScwvHw2FA6Ua+KpAyZyUnPiCvsRwXk=;
 b=fomvc8eSMT8EDgrKyK1SwL0JVfMSmwFPy5BZfC6XDua6TLW4Qs30C383w7Rr0Gjyy2
 1RWm7S/FCic8fXa/YsIE9gjyHzLWnZEoqRnqo9vGf0OM9wh4FY2VyqYNfFcqt5ed4jJJ
 zn2sGpM0U+rysn/sPBxcnt0OnvEQE1tOb8VCBlkct2mO+S6a9uVSOI9P2toZDdlvXIHn
 ze/UEa7xtf5LwwQJTtE1T8IEBiynkxlCqoE0yzrwE93ltFpCRkW6q+yzZtwkL0SYj/2V
 qCxjF0AFO1Eyl7RijKbMbIIk0ovcFv13D4FFDmxTPnWIkheneMPF4soYu/ZdWUx8Rn3O
 ovvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzovOsyVFrdwxLuNqpoS/s/eGiCI6/waAs7ZPKH2lq8K5xYlPuN9wNp9E38cb3eI82+Z/1Gp2lKs7wDjPvo/TU=@lists.osuosl.org
X-Gm-Message-State: AFuF++kSn1VTS9iEzVB4Z+ZaN9D8F7ZOe9FwULsw51tWY0kTcUvWMX0Y
 jjPTsWj7prQe9DyO0Zdx12fioBuRL//jZS7luRbFzxjt3tO5oyhPQX9bfz2v76cW+mFjM5gDz3Z
 LLMRu/y7FMgPKD8N7AUaIF1qqWwJvaIM=
X-Gm-Gg: AYBFou2XmgL2FjsNuhQNzzfN4Brgfbt4HBlAj90rZfJk/90t3bKBYJHYtSVGJm4vN+E
 29HG0n8Z6TZDaLZLSIXsUdITldiNkKbyPu384gxwY4yYcxOnqnJIgPMqzk9ruhdBRoEvAwGV6Vp
 F0NNZ0yiLhYCl2rvrJHinCrOvWE8lYXp9qVIPgrxO9xBjhpy5MQ1cR5+lh9z9VMjjSh3kEeX3Jg
 zlVnuBTs3qeqqVQvF0lc61B3cRrwGw19XXbepYT05gXHdwsDaOKhXZD1ZDVP3pEkaPpVAP14Lx6
 x+IDgS2y23hpF/sNCPvAM6//b4lY3NuXb5I+WGEE5FFC3oNThus9Tj4aoGwgz31XQwzig7YHgng
 LfPBjMktxNNE=
X-Received: by 2002:a05:6402:c4f:b0:6aa:734a:a08d with SMTP id
 4fb4d7f45d1cf-6aa734aa24emr2583626a12.36.1789895554095; Sun, 20 Sep 2026
 02:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260727225659.Cz3qz%anthony.l.nguyen@intel.com>
 <CADFiAcLvxVh=E9Esjh1fQBVqtu-t_=8hyTCW0_dfb2VTKiJ6=A@mail.gmail.com>
 <a1a0545e-730e-40bd-9935-8f5e3fc5dfb9@intel.com>
 <LV1PR11MB87904135610E206A937033D890872@LV1PR11MB8790.namprd11.prod.outlook.com>
 <CADFiAcJ67c+sCDEcKJnTzp2OiUyEiYDVD7OQZ+tHYVk26vpXLA@mail.gmail.com>
In-Reply-To: <CADFiAcJ67c+sCDEcKJnTzp2OiUyEiYDVD7OQZ+tHYVk26vpXLA@mail.gmail.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Sun, 20 Sep 2026 18:12:23 +0900
X-Gm-Features: AcwNN1VIJ1aUT2sL-YYDiLPyDGHxCj1B6AQwfABcaRALgNUxSWDPlB3-22gDXEU
Message-ID: <CADFiAc+ZSky_v3JOYsuB4GMeCp11c5SnwLAtp2fMzajsc0Tz2Q@mail.gmail.com>
Subject: Re: Patch "ice: fix empty PTYPE set for GTP RSS profiles" has been
 added to net-queue tree
To: "Nowlin, Alexander" <alexander.nowlin@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 "Czapnik, Lukasz" <lukasz.czapnik@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi all,
I sended v2 patch.
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260914/057060.html

Please check the new patch.

Thanks
takeru
