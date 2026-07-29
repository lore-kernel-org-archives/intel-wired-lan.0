Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA91C53200
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 15:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D27154052C;
	Wed, 29 Jul 2026 15:21:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdYT6zW0kDdX; Wed, 29 Jul 2026 15:21:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54BF540538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785338487;
	bh=4A9ljZvg/DonxCLhH0BMsyCR0SqJBPYfHV381hA4JWw=;
	h=From:Date:References:Cc:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9J9akyV3Zm/ARRf1sbHFtWlxk55eJ48gKO6/hHCdXtl+8Kps0AHrUvl6TrfyqCCLI
	 64GouXGjZHuFnQZdTYfiLcFnAXP3Nxj/dFzafe15USsjCv2l6RPkU+NQqzfFWZynUZ
	 CaO0BMrk8F7Okn+X7NwMmpxFxBIOUz3oDBYgJkoFLlrWQDzn9hXD3udoB6ptP4fw1W
	 F//WPHbS/zu3eDp95ykJZOQZ3zOfdpDRWdAuXgXNcUhNz4khftPsi8mY4sJ5oHICUT
	 LGWPHcGc8XFG8rFWr6dCoorgP1MppUlIY469t3cq219/QXTghDdvciNaqJdtbAg+Ub
	 c8UDDnBbuuo1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54BF540538;
	Wed, 29 Jul 2026 15:21:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5468A3B0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51E9B60664
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vjypbsni0oHs for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 14:52:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=hsj0512@snu.ac.kr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0F6F360627
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F6F360627
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F6F360627
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:52:00 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1568983b3a.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 07:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336720; x=1785941520;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4A9ljZvg/DonxCLhH0BMsyCR0SqJBPYfHV381hA4JWw=;
 b=T1rrX8kOzTVebEeJaX0Z8R7aJXIl035vV03Q6jRr3/Vqx8aT3mRS8VdkYy7MBJDaAp
 0cRbl9w8Efz/lCxJq12SzhGR7X4PGPFS+BjQ4x4iKF5Z7XDC/GF/N9+xsl7kyqGc3Ss/
 0orx41ZRTKYg9hNDC/bJakZ0FnWfq2CCTJZJEjL66qqznHcQghEcYlroJ+Qgl2+P9VOD
 7OfhzvlAUYEJN7uwRv85rw01qN1kLm/ztirtAE0ZkscYdZQ8O9Q8jz0UoHSrV/GpPi84
 dROpBVfHtNd1wf4ArqeIt7Y0O5Bvl3RSE4fjT5VxJ32K1HdVUJRlClynv60iy9ZiPt2N
 GLOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOp2ztuyXFrNBEb/SSC6Q9MDHv4sl8wyZWuflMM2J6H7SqcqvJ8F6add9z+oTZ4UP0CCy27OaKrKDz8tCl/dY=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwXWkPhlIK1M/Gkb/A96KPtWlbBZhXu8ZVVm0LAJriEjFr+Drd+
 KlyH1b0YpHYL9QxxC40S+3mfOqr+tTzfpwqEzHxA+dm45e89iD/cmauIoxOkv1zr2Dg=
X-Gm-Gg: AR+sD1087lvNJrzT+qnQDh5s/tgmCIOclDGnUl8Y5vIKq7efQUgcEikOsZs8+RLBDqR
 0CxspXQ7pheyN5qZYDA7dh7NRL2/4Ap3g4tFGO2I7VH9gGRPJifYb4pOAy/cY406lHQHN6cxJ0x
 s+9KUfgzBM0fRK8qa0E4AFncdY0oirOh9q2ycr8ysIotS85s9QXX+IJp/DoM5CHiDSb7w2Lo7we
 Qpx0Cxthes+RVUbCiqazLf2asHHYODgdRxdeNk9yPtnj9NZqmq3ZNl1bIq0zK72ypzvJYC67GQ6
 fx2lDeYSvOVMvSXHexFKmA6KPygHCbofskJiBE9z8L9RciEPfjKuPSs5pwly5xXe3eor7EG5J46
 SeLSc9XKO6N9I7wRu3HIn5nNw3jOPt8sTUgGZW4sbMuEjTawilKDiVJuE3FterzF39mFRfDYHiw
 4AI8uLtLpC71KlL2Oof8VQvL1R3JDXzMiS2uWyj0nek6pfqFv2oxyDXoSRH1qdKpskcdknOTlCW
 hfaI2D+bA==
X-Received: by 2002:a05:6a00:2e28:b0:848:2f77:e2e2 with SMTP id
 d2e1a72fcca58-84e933abf71mr7498955b3a.75.1785336719840; 
 Wed, 29 Jul 2026 07:51:59 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:11d9:ccc7:1d44:fa02:b04:2b65])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e9fe24e6csm1540056b3a.5.2026.07.29.07.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 07:51:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?B?wq3tmY3shLHspIA=?= <hsj0512@snu.ac.kr>
Mime-Version: 1.0 (1.0)
Date: Wed, 29 Jul 2026 23:51:47 +0900
Message-Id: <38144712-66B4-4580-8B9F-708500718E34@snu.ac.kr>
References: <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
Cc: Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Abeni Paolo <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
X-Mailer: iPhone Mail (22H352)
X-Mailman-Approved-At: Wed, 29 Jul 2026 15:21:24 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1785336720; x=1785941520; darn=lists.osuosl.org;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4A9ljZvg/DonxCLhH0BMsyCR0SqJBPYfHV381hA4JWw=;
 b=ygwPaMddGaNLiwcPXMsUiqndpYwHHoDaxR342tvWP0mhjOYMeSxmSn9LArNrEhO87R
 mZuBvCf4M5b3HKf9IPZPXVYd5gKh/nvcGVVBKYc9i6jY52glsWoI8LawpwcJgQ42lZWI
 y8BLou5gZ22AM6OpWK/7YemixsKmLHrCU5YeU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=snu.ac.kr
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256
 header.s=google header.b=ygwPaMdd
Subject: Re: [Intel-wired-lan] [PATCH] e1000: drop dead switch statements in
 configure_tx/rx
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Thanks, then let us keep the switch statements.

> On Jul 29, 2026, at 19:07, Jagielski, Jedrzej <jedrzej.jagielski@intel.com=
> wrote:
>=20
> =EF=BB=BFFrom: Seongjun Hong <hsj0512@snu.ac.kr>
> Sent: Wednesday, July 29, 2026 10:01 AM
>=20
>> remove unnecessary branch
>=20
> Hi Seongjun
>=20
> First of all commit msg definitely needs to be extended. At least
> start with capital letter, finish with dot etc
>=20
> Once sending to netdev please also point target tree in commit title;
> net-next for this case.
>=20
> I see the point, but as the code is quite old and its extensive developmen=
t
> period passed long time ago, i believe value of such cosmetic patches is
> rather questionable.
>=20
>=20
