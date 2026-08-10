Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4487C5AD55
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 12:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6682780DC5;
	Mon, 10 Aug 2026 12:29:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zZ6PnZ2Ua0uL; Mon, 10 Aug 2026 12:29:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D076380DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786364957;
	bh=spaqSKC8vbKom/6b2zD3pj99tr3fiU6lqWnDJwVVV74=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aGBWdqLY5LHu6zBEGYt91lWLuyAIQ0DPayzfa1qvgxlH743cVD8xcJmP4owbhqHuh
	 sMKTBjR4B67EJTWagfp5z52ZVtkCduIgZkZFcN3LsYWAdVxwRLte8OvAMStvsEvv7n
	 +jB4IeHqXJXMkKmSZ9ZDmSoDSGPgh0z7zsuFtuDLf6YgK0ekcEJbSzIrZtnBdrBoQv
	 R2mGX5zYH3vyCF2uEjSy7kZAMgnN6PvCGABb209XCiEbHjQOUA8Oo2u94vm+sTs94V
	 6bq6e3QVCZPTVn8FNOPh04UJ0QMCcCPatgA//BRD9X2VYyWW3xKeD8wk8y4GrCCx9U
	 qetPz8c+HRrnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D076380DA9;
	Mon, 10 Aug 2026 12:29:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BF6E24E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 12:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A6B780DA9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 12:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UmLQzYkQ_6dM for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 12:29:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=pavankumaryalagada@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7024680D47
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7024680D47
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7024680D47
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 12:29:16 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso19447575ad.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 05:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786364956; x=1786969756;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=spaqSKC8vbKom/6b2zD3pj99tr3fiU6lqWnDJwVVV74=;
 b=kmUvljaSlHVVS7DOK9WKRSsKoQHA3Hmic0Kn2vhFjwyjZ7D6P7kHofO3QZT3dmL4ln
 FtqwlVpe6knHHCqclr6iCy9NKgwAR0facQ53uswV5LquzmCHl2vNyn+ZVKzGBPZO2seJ
 /x1YZk/xKvfZ9atIat0THNkuRmZ6hDyDGwMU0dVns5dfrJUxOz7H/NOnK9If7guJJ9fm
 1FL41OeuCyw21GJAWfSBi0BvPEOvwBl0MFh8DaIyo94z9dejJVdWXvOxxgZHYt8cDj3j
 q+0BPUCidbOUvrruXFojy31WNFIRfrXjTWkPZ08k7kdBEsAbj5Qf29qvTnwq62D6zquk
 tG/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5Kyl4CNnJGsWGmrM3l8TLHAQsSD1yoa/uS4vcfWECunUaYpGwXBj/QzjbVvaXUt/ekfCs20DlPEfPDLEU2rA=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyHlnnGKCt/P2sVGD/yJPbapQ+s+mrh27EzqrAaRFCvPpBYSECn
 sPkqN0Fvk/v7xyYC2bH87dbuvUJlthCd1z9/uNAbGHUdEGhm4+ma/HYL
X-Gm-Gg: AR+sD11uz3kMgHLs77vir1+RFFN2/k+w8M8jFwtT2mfIPDuPs+vgBULpg1NBhny/KNj
 OsWvhf3/1KEI2m2Nk5OD+pGI2JcIBEZqOttN91OwhTmmoIrA4I1LioFnAVLL9AbtfFQie2z87hb
 CZfPvX1y0Mvm6ISep7pV3qMNw/yXbnkm2/B1v7e6xv2zyQ8jjNy0NKl5YB3rRZ9v8+xTmvbUcDC
 HI8NRXWSpR/Jar368XyDaA+whuiDeKG5omCbOBwFH1n2ao+bhMMUV/sB+Rb4OBkmhifzu5SUqns
 u1JZWymUGcTR2SkAPxgonbLHrtwtTWhK7nMF7VvWqCP1voUiOzrOf6ncfMgjkRAlM+sNh3VZeZo
 +Axp6B6es1LVH1uYe2zUyvSVYw4LG5R4gyRPVDadkzv9iTpurxhVeJieYweJMlASZ56cRFVoArb
 8W3hjc7FXAOHxP/VExAQGEaoxE18uymKab+KgBAGdQijmewoP8gMJ+8EU56lUh2ZOCvQ==
X-Received: by 2002:a17:902:e812:b0:2d2:da8e:9017 with SMTP id
 d9443c01a7336-2d2da8eb6e0mr119633235ad.8.1786364955548; 
 Mon, 10 Aug 2026 05:29:15 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:8ed8:ab8b:ff23:d5e4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14dbeaa7bsm35401635ad.41.2026.08.10.05.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:29:14 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:58:42 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com"
 <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>, 
 Kohei Enju <kohei@enjuk.jp>
Message-ID: <annD-sZeweknPnFt@user>
References: <20260810083355.21631-1-pavankumaryalagada@gmail.com>
 <DS4PPF7551E65529B793FF5258AF910943FE5DE2@DS4PPF7551E6552.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS4PPF7551E65529B793FF5258AF910943FE5DE2@DS4PPF7551E6552.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786364956; x=1786969756; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=spaqSKC8vbKom/6b2zD3pj99tr3fiU6lqWnDJwVVV74=;
 b=gLiKS8QT0i65m3TcbrAP7kJQlOlH5AxA5o3nUNtAAWjtFoZhHqWAR8Z8Yi9TP2bKNv
 cEEr678vWSqbnssvJC/8dPULh2jyTlUR0ANagLZ5Wxeaba01Bpr7axw4eMJmJSP5j/+/
 6HqhQf+Z/smIPFwP2Gdqqb6mrsWvVj7b43sqKageUDA5VU1xZmpNbIgpIc8PVwcB5mF3
 UbwpS3x3Pg9Vsfj0/kp/Rvl3+V1fGwBXKv/SpXEFPSghYTeIfWiAdPBPiVo78SFiCmGF
 EcQQdb5iwnu2YuDFhsEd4kvcAvMqWCIMcIHHmhFGp9q3o6ru7phe4c6rbvMsOUmZ/vD7
 C91A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gLiKS8QT
Subject: Re: [Intel-wired-lan] [PATCH v2] e100: prevent shift-out-of-bounds
 in e100_eeprom_load()
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

On Mon, Aug 10, 2026 at 08:49:42AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of pavankumaryalagada@gmail.com
> > Sent: Monday, August 10, 2026 10:34 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > skhan@linuxfoundation.org;
> > syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com; Yalagada Pavan
> > Kumar <pavankumaryalagada@gmail.com>
> > Subject: [Intel-wired-lan] [PATCH v2] e100: prevent shift-out-of-
> > bounds in e100_eeprom_load()
> > 
> > From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > 
> > When reading the EEPROM address length, e100_eeprom_read() can return
> > an invalid length (0 or >= 16). Passing an invalid addr_len to bit-
> > shift operations causes a shift out-of-bounds, triggering a kernel
> > panic or UBSAN warning.
> > 
> > Validate addr_len after reading it from EEPROM in both
> > e100_eeprom_load() and e100_eeprom_save(), and return -EIO if the
> > value is out of bounds.
> > 
> > Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> > Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > ---
> > Tested in QEMU using syzbot c reproducer.
> > 
> > v2:
> > - Return -EIO instead of -EINVAL for an invalid EEPROM address length.
> > - Validate addr_len in e100_eeprom_save() as well.
> > - Drop the unnecessary 1U change in the shift.
> > - Update the commit message.
> > 
> > v1:
> > https://lore.kernel.org/all/20260807145626.52692-1-
> > pavankumaryalagada@gmail.com/T/
> > ---
> >  drivers/net/ethernet/intel/e100.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e100.c
> > b/drivers/net/ethernet/intel/e100.c
> > index 1de5cd41ea0c..464dc2d6cdb5 100644
> > --- a/drivers/net/ethernet/intel/e100.c
> > +++ b/drivers/net/ethernet/intel/e100.c
> > @@ -775,10 +775,10 @@ static int e100_eeprom_load(struct nic *nic)
> >  		netif_err(nic, probe, nic->netdev,
> >  			"Invalid EEPROM address length %u\n",
> >  			addr_len);
> > -		return -EINVAL;
> > +		return -EIO;
> >  	}
> > 
> > -	nic->eeprom_wc = 1U << addr_len;
> > +	nic->eeprom_wc = 1 << addr_len;
> Why do you drop U suffix? For me it looks like you trade one warning for another.

I dropped the `U` suffix in v2 based on previous review. My understanding from that
review was that the `U` suffix is not what prevents the shift-out-of-bounds issue.

The problem is that `addr_len` can underflow as a `u16` and become a large value
such as 65529.

In that case, both `1 << addr_len` and `1U << addr_len` would have an invalid shift count.
Validating addr_len before calculating `eeprom_wc` is what prevents the invalid shift.

The reason i used `1U << addr_len` in v1 was to make the left operand unsigned.

However, after validating `addr_len` to supported range, the maximum shift is 8, so the U
suffix is not needed to prevent signed overflow.

I also tested the reproducer with all three forms:
	1U << addr_len
	1 << addr_len
	(u16)BIT(addr_len)

They all produced the same result with reproducer because the invalid address length is
rejected before the shift is performed.

Regarding the validation range, I initially used
	if (!addr_len || addr_len >= 16)

because the reported value was 65529 and this was sufficient to reject
it before the shift.

However, after reviewing the Intel 8255x Software Developer Manual,
i found that the EEPROM address field is 6 bits for a 64-regsiter EEPROM
and 8 bits for a 256-register EEPROM.

the driver also has:
	__le16 eeprom[256];

and calculates the EEPROM word count from address length.

Therefore, i think if (!addr_len || addr_len > 8) is more
appropriate validation than `>= 16`.
it validates the actual supported EEPROM address length.

> I'm for explicit (u16)BIT(addr_len), what do you think?

for the calculation itself, i agree with using:
	nic->eeprom_wc = (u16)BIT(addr_len);

1 << addr_len means shifting the value 1 by addr_len bits

for example: 
an 8-bit EEPROM address length gives 1 << 8 or 256 EEPROM words.

BIT(addr_len) expresses this bit operation explicitly, and the
(u16) cast makes result type match nic->eeprom_wc.

I will therefore change both e100_eeprom_load() and e100_eeprom_save()
to validate with addr_len > 8 and use (u16)BIT(addr_len).

Please let me know if you agree with using addr_len > 8 based on
the EEPROM address length limitation.

Also, would you prefer (u16)BIT(addr_len) for calculating eeprom_wc
or if you would prefer to keep the original shift expression?

Thank you!
-Pavan
> 
> 
> > 
> >  	for (addr = 0; addr < nic->eeprom_wc; addr++) {
> >  		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len,
> > addr); @@ -804,6 +804,14 @@ static int e100_eeprom_save(struct nic
> > *nic, u16 start, u16 count)
> > 
> >  	/* Try reading with an 8-bit addr len to discover actual addr
> > len */
> >  	e100_eeprom_read(nic, &addr_len, 0);
> > +
> > +	if (!addr_len || addr_len >= 16) {
> > +		netif_err(nic, probe, nic->netdev,
> > +			"Invalid EEPROM address length %u\n",
> > +			addr_len);
> > +		return -EIO;
> > +	}
> > +
> >  	nic->eeprom_wc = 1 << addr_len;
> I'm for explicit (u16)BIT(addr_len) here too, what do you think?
> 
> > 
> >  	if (start + count >= nic->eeprom_wc)
> > --
> > 2.43.0
> 
