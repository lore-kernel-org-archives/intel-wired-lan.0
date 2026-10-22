Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08746606A31A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Oct 2026 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=RBQSnuuy;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=bZ390a8C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5C6980A54;
	Thu, 22 Oct 2026 08:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pVS8hGMSj8Ln; Thu, 22 Oct 2026 08:18:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12B24811A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657092;
	b=EBjyZRyomTD59g4/E0g0fY+gKq7iJTJgw7c0vkUIaTlRETI/0uhWdHqQTgqHAePdaQvX
	 DK6/n4fkc4iMfRJfTeEMD/bcudJaCBonKcBqsd2B58Vx2iP8lTlG/JoexSmbO86QaetlX
	 jFjBosKtJF5e1twqwRQXymSpPHhVhgeM66WmNFySLn80rdVsR3YyrnVLJSZ27TRa6u8c4
	 2zyIa1gHb+dNax7F7qhNzsdgtYCoQRyRq32UfSpolIUnjZeQFMN22Z0hAbM7XPy/IVP3i
	 uajzj/f0uxGsHrjnWprGv7JNoRtXvRbdPHheughEuxJFQQkBgdIMvRGa7b7+SM/REAA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
	b=CzsP3gHZyRRbwpGqGkuagvCgf7h9erjR24udIGWFOd2yD4ajVzOP7Sk82xgAaMUUfxUZ
	 9kNTKr4LQMxc0XFoIzfdaE79kkzx5cKCH2n6oAsiNVwMi0ik/RYPQ3s+6pHl+iDvCz7b/
	 oTS2H1ZMnZLBw+xSiUf96+oDK9mTcsUq5sdcEfEbRDVxGP3bsVraGnkX7kaI4E6lhyBC8
	 FRuWL28M9wwikriHq+95rFJ+VQA08p4kILu60OBt17qrfv5IIc83QTc2lbPfvKAWrAqLj
	 zZc/tQnV+NvXuxSNbifjbmF66IXf3iBrArw5XwecggBBM1FKByecr7Jhs3T7CaRUrkA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=bZ390a8C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792657092;
	bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RBQSnuuyPFuSdkr6z71jtY76JWcaXYImGaxd5goKWxkkU+ohOoMSTxyaiXSmqTLSu
	 jsLsG2B9KjIoOiBw08tWJqGvENeRJQdVzD4ZRgUScHBWOyleXRKW2//hTApYsvv6Jb
	 Hf6vW38rl4P9usMfWZwZ0XvtzaeQ7nMPRvpKRfllBndIhmx/zGhA9ec5I8YtUoCDLx
	 +XCz+OgSEPoCEfigEOGPaQvvo9WWmRkvmGQfd8g6vGeU0tkNjT0TkeOfSOOKgO86KC
	 gCa3HacJS6+AmdkcsHivcyBSgOFh96DRmowgaMExpQMXdL5Wecgwdrh8DZazN9yZb7
	 1JzGBQtAKTAqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12B24811A8;
	Thu, 22 Oct 2026 08:18:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 353E495C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 08:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11C6D811A8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 08:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PcArg2LOlY1Y for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Oct 2026 08:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51E7480A54
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.125.188.123
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657088;
 b=RXKTO//Mo6EijPHy2GJhIYkhD8/WAKIUxKkeXF2vVv2AIrHbqwugzhWTZzjSEP6NpHUf
 6fFIDTNKUlF20djCeZYXzicVlqolXbfOlHMmslLu54dl7ChrYjVnKWV/Jrh2c7bhj7GTj
 MLYJXgAnCnXJJNvshQeHxafFPy0i7UgvJ4tE7ZMJ44Su42x09G/ggMYLgW1UhBP3p9jgH
 lQKZgXUJTgu/J6MjQiSjF03he/XV6fwwv4sZI0YH1VyuzuvQFx0Xg5gZMRwrftxFQUwBM
 Ht4Pd1gV4eC+Csj3WgkjRKqxuTRb4P537iOHmP8rKwxnIMuJGoVAnpa/HMVt+wOmiNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657088;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
 b=RaXwzwby673NbHRmWtz/+qOZCxjIo7YPs0F9Geob/veWNVDAVMICM3ak284bXJD8//lY
 Inb41Y/XTREI/Gi9MrK5zUdWE8DTOIlX7hRHiTbPtTu/ls1YHz1NluCMFKjp/+Bdf3kSI
 8siHABXP+iL9LEOYsZvD6L5STsf+BjkapqkLp5QKP54OBRGA7F3CgsanpuvPyf7ckSVVb
 9Ie3E7JD74bh6AN0z/PtcWJu1Fe0ofR/e4NCGlGTQoLc3XvWONMo/yFyOk+xzEs3GUykS
 GVVg90rcFJPtaRomoM8NU0ELJH7/iqn1QVoIKkj8eJZqzK9Xp0F0f5CiGB6je9IX12w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=bZ390a8C; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=bZ390a8C
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51E7480A54
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 08:18:07 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3500C3FE1B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792657085;
 bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=bZ390a8CAZTJpXzmD8CBlsSHB2OqlSuB7HfenpJcqESalb8pwDrbNVVRVLM+dEshN
 QAw52mcXEztgzIgbfEKwMaf3ASS0qvInAX1Zog3nThI2uMizD6y3h8SkzgfMMF/VHA
 TosbI4cdfhVXfkFNaiSrjGi27WlpWNU6o8akxSr93VA+ehFvPciwarIKKUmCQ9InJ9
 Y9lDt9Bd8lfZ1/EAmS+Bq7lGFVC7XWb3+Bd71Y5X12Awa+cmn+kUcXEx37xK7+rwNj
 ialPXdUvGnjDc9Caq7hvE7WNQ5PeEi7oM8HKFZVkIotqg9qtSMPJfDUNOiCgiVWBs1
 kvPm6da+qe1WF7ZMzJiAx7iBHPuKHhL2JAiAfcae9OHA98607tQnLmiasmJOJjVQe5
 WdhAuxiQIvN1wqJR4cPHfKLgzMXXsDRE8hH1p5Kc6kdN1963U7jBKOgWT8Y6NE6Lcn
 lNDR9h1GteL1cK/k2d62YlPwugvXCLnUyU3yTTPWZQOqyzt9PZF+nRPK3Uh1ScQdos
 Zl9l8A3IAQaRymSz584vqPO24NSeUx4VMnQi7t1HCtl/SAIhPsegCmAmuk5ec9Y+81
 7fi16BfuEsjA6344xfKqSgrySjA1BYfNBWSFihEiVWmR5IzIz419mMP1tTY1p/BHLv
 +n/AAUNLNRKb8C0S8aj3KV6c=
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so2898583eec.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 01:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657083; cv=none;
 d=google.com; s=arc-20260327;
 b=JJ7KCapLtdNlmgB3l7cUokmfuhOB4XIWx7hzgK6nb212/Tv1q6x6QulUYosHdHjCHP
 emR9xzDxsrSTHDxnF2Trp8SB3ktkCqR3I9nU6aGIMKa7pUwSbSFtuH1yWGQC33vVtNJ/
 F5QIqGPaVKGeb+advveQqvCnTY9PsfSTvRiawcYpm8LW7zJPMUqFzJAW2N/qMbs6vUvR
 adI+ErGoiyrZ22NIdCRt60nt6YPFAtHcC48NoSg3lu1TH3xeDJgb5AyVPpoULO1IfB0h
 2ACeJf5aAZpwbSI8zQXKw8qyQbbP6I/lJSkuu6k751MTOZHW8cnKyTvexf7TVKVogao4
 W7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
 fh=bXWK0LQkzSHo6Jldeso5Nt5a/gs2xZigpheOCm5KOCs=;
 b=eEoE+AJYRAfbf2PhgW/he44jBGJFCgAf3w3kYCbIbW86HTuVZxIM1HdI2NlcXunbld
 qK58b+HAEQfEdlbLXU8yKQXJsolGv3QOHT68gjTKzo+f4EdlogTMQ8lGdwxx+iu57iC5
 9rA6Fr2ENp9lwGOb1p08Zy97anj/dAdfwHDvKgVGa1AN9tMnQh/VHj90dr3LKE3YKijW
 upr0FNWlq4Pez0QzYR7G2ftgSDX9xGZHTjOdS27jISR7q9YsLWpqm/WjGMo33KXp6MsV
 tMiFyV6m1+wtQfNMFyFHfTIGUJEFYsUdgR8Q08gLfJ6E88CRhse7u3H0M1AZQbUTzhjl
 mpbQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657083; x=1793261883;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
 b=UnF3eXwj9vaUEY9rLZVyPNY1HEnV2/BoI1UjMDO1ERcIk00jGS4YMhdSotVdAYdWDP
 JyO+TMDbR9uyGSqFN1gPHIlaDSv1JsTv0TB1tU0tWDhWpEgxpYjx/GdrUGSzOzBq1YYf
 gyhjMAswWmCsaDC76NM8BV9N6otaOhHS5lwW8oy4+3HIa9DyNZWSr96chko7Vuwz3UW9
 GjAuvOARzClMOMW/TU5autk/jOelxV3eRKM6cThhaE+yUexY0ZPwPLUKqEM6o5iseCym
 SCIl9p/OTuZjYyKlMIzi122FZBPiijNVEnPStQm2nX72lqAWkTrW6Z+eiW5ch1s12Y9n
 oxHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpqDlPu7v5tsZhBU0CyCd9nsbQDew+EBJI7b/1PfDr9mJF+7sW32U2I0SQcPGycCFkhZcaj2vw0DlSIVkSt50=@lists.osuosl.org
X-Gm-Message-State: AFq9FYK9RxEwd61+e+F3UiYLsJS4MPH3bhhmWogn/rcvQIArptaYAOdh
 6EJrqsDsDbFch/95zjGRlFt7KxrBYe53ECgp/SITqYvKz/ulExgur+OUEOF30C2Lo012r+lCEGs
 tt8L6CnnqnLMkeFs/lEpgsCUD2EvHooBcTz0QR2q56h8izElhYVYUwvVWkD2L6r41pzqoznQRph
 Odisf8ee5IEw5FRHqA6/qtAENEUp74tqqLCMSLSejp8JDfxaz1eQ6O8mGws/jrtg==
X-Gm-Gg: AYBFou2rq4rlp1nn9qBRP0ai+tGBJyhWUt7UkHwcu/oiH4g2wFYjl6DkDSYye1w4X+S
 tifESsFj8JusWpbxhZtxEV3+7xwAKfkPH1Gk5Blbty3KXDo0hVrm6KMEpABtaKttwpDzpW3pvUH
 +1AY0HtGn88yjn/XQqeupTSDTkJ03yz4AsppZoRdHlO2S9mfo1WmcYlRPMZXsF5G0xsJYV4E1im
 cA7lbx1lgoaDPB7EuwyHoFrkj0CXH5jO8p4YHzSa8BxNhBJkS6sKXESXlruzG9KDYRGcSz78r8n
 jd8+qLujFN9k68h2xi7rm5+FMbHLOs4adAABJzpZjCnOHngJtyOEpGOibp9+cxiVtrCHL14=
X-Received: by 2002:a05:7022:158d:b0:193:9568:b42a with SMTP id
 a92af1059eb24-1939568b477mr1517917c88.8.1792657083328; 
 Thu, 22 Oct 2026 01:18:03 -0700 (PDT)
X-Received: by 2002:a05:7022:158d:b0:193:9568:b42a with SMTP id
 a92af1059eb24-1939568b477mr1517875c88.8.1792657082883; Thu, 22 Oct 2026
 01:18:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-4-aaron.ma@canonical.com>
 <CH3PR11MB56689592183937149141CA5D6DE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB56689592183937149141CA5D6DE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Thu, 22 Oct 2026 16:17:51 +0800
X-Gm-Features: AclHuK_MWaUe4Kt9JlOwlYzMGPqVeUahl-zxhu0V2P8ckRAI2qMspUXp9TfYrYA
Message-ID: <CAJ6xRxUcCpwdxpiNijA8G+h8wS=RM8T+uGKc+-t-7Gd2_4ovAw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ice: scope global configuration lock to the adapter
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dan Nowlin <dan.nowlin@intel.com>, 
 Brett Creeley <brett.creeley@intel.com>, "Keller,
 Jacob E" <jacob.e.keller@intel.com>, 
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 7:12=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Aaron Ma <aaron.ma@canonical.com>
> > Sent: Monday, October 19, 2026 12:52 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> > David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>=
;
> > Richard Cochran <richardcochran@gmail.com>; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Cc: Dan Nowlin <dan.nowlin@intel.com>; Brett Creeley
> > <brett.creeley@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> > moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org=
>
> > Subject: [PATCH 3/5] ice: scope global configuration lock to the adapte=
r
> >
> > ice_global_cfg_lock_sw is a module-global mutex, so a package download
> > on one E810 adapter blocks Admin Queue commands on unrelated adapters i=
n
> > the same system. In addition, the mutex is acquired only after firmware
> > grants the Global Configuration Lock and dropped before firmware
> > releases it, while the opcode exemption list in ice_aq_send_cmd() does
> > not check whether the caller is the lock owner. Non-owning PFs on the
> > same adapter can therefore submit exempted Admin Queue commands or
> > sideband requests while another PF holds firmware ownership.
> >
> > Move the software mutex to struct ice_adapter and record the owning tas=
k
> > across the entire Global Configuration Lock acquisition and release
> > sequence, including the core reset path in ice_cfg_tx_topo(). In
> > ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mute=
x
> > while allowing the owning task to issue the permitted configuration
> > commands. Route the Admin Queue fallback in ice_sbq_send_cmd() through
> > ice_aq_send_cmd() as well.
> >
> > This patch depends on the previous patch in this series.
> >
> > Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization
> > (DDP) download")
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_adapter.c |  2 +
> > drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++
> > drivers/net/ethernet/intel/ice/ice_common.c  | 63 +++++++++++++-------
> > drivers/net/ethernet/intel/ice/ice_common.h  |  3 +-
> >  drivers/net/ethernet/intel/ice/ice_ddp.c     |  7 +--
> >  5 files changed, 55 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c
> > b/drivers/net/ethernet/intel/ice/ice_adapter.c
> > index 7de9223e971a7..17819c3a172fa 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> > @@ -65,6 +65,7 @@ static struct ice_adapter *ice_adapter_new(struct
> > pci_dev *pdev)
> >       for (int i =3D 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
> >               mutex_init(&adapter->cpi_phy_lock[i]);
> >       mutex_init(&adapter->rebuild_lock);
>
> ...
>
> >  /**
> >   * ice_should_retry_sq_send_cmd
> >   * @opcode: AQ opcode
> > @@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct
> > libie_aq_desc *desc, void *buf,
> >               u16 buf_size, struct ice_sq_cd *cd)
> >  {
> >       struct libie_aqc_req_res *cmd =3D libie_aq_raw(desc);
> > -     bool lock_acquired =3D false;
> > -     int status;
> > +     struct ice_pf *pf =3D hw->back;
> > +     struct ice_adapter *adapter =3D pf->adapter;
>
>
> pf->adapter can be NULL during ice_init_hw(), is it ok?

Patch 2/5 moves ice_adapter_get() and the pf->adapter assignment before
ice_init_hw() in ice_probe(), and retains the reference until after
hardware teardown. The reference is also retained across Tx-topology
reinitialization and devlink reload, so pf->adapter is valid during
ice_init_hw() with that patch applied.

Thanks for review,
Aaron

>
> > +
> > +     if (READ_ONCE(adapter->global_cfg_owner) !=3D current) {
> > +             guard(mutex)(&adapter->global_cfg_lock);
> > +             return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf,
> > +                                          buf_size, cd);
> > +     }
> >
> >       /* When a package download is in process (i.e. when the
> > firmware's
> >        * Global Configuration Lock resource is held), only the Download
> >        * Package, Get Version, Get Package Info List, Upload Section,
> >        * Update Package, Set Port Parameters, Get/Set VLAN Mode
> > Parameters,
>
> ...
>
> >       /* Since we triggered a CORER, re-initialize hardware */
> >       ice_deinit_hw(hw);
> >       if (ice_init_hw(hw)) {
> > --
> > 2.53.0
>
