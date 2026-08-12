Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69845C5B56A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 13:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AC77608A1;
	Wed, 12 Aug 2026 13:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H75fhwNiuNNs; Wed, 12 Aug 2026 13:31:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E85326069A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786541464;
	bh=Uz+bfGVw3BN4xTVdoh1TluUgeBOBBwVoF8DrIGsXOfg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=extNt+INXIuacG503H19ZHRRAF2snFOh7V+HPCsgATwisLAMq4eK7wm0bKwG6IFVA
	 Nobd0vOXVcUiiktPPpVw79Ua9m0SlFYg45gJAO5TFA+noU+q/PslPr2JrViqWMWtVt
	 BVuu1NLQaFNm4q8Bsj8x89r9hT0gqP/djVbTnVW17wSHzIFoVibZaDZLjZCheaC+xd
	 mJWkJw4nHjaZkso7oIqTbAKa7CgnwoQqQXq51lgENY9ejC9LeXhJVUNiJ/iRCndePP
	 NIXfOwE6N6ndvJaMEHL+czRB7MASWAzYoZqHL+VjphljeFiVxQhmOc+T3Jy9QhXFE6
	 F5xT19Fcn1Hxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E85326069A;
	Wed, 12 Aug 2026 13:31:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BFA61F41
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 13:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7186680CB6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 13:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rtLS6l0OtR90 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 13:31:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com;
 envelope-from=pavankumaryalagada@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7E8F880C7E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E8F880C7E
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E8F880C7E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 13:31:01 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so1108463b3a.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 06:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786541461; x=1787146261;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uz+bfGVw3BN4xTVdoh1TluUgeBOBBwVoF8DrIGsXOfg=;
 b=bMzzFgHDMyKee7kvh8VA1zRZcTSUwHJrvD6Z6J8Yok1yCVgL7isU49lWvTQoIQM1UI
 Sbbc9en7joFQvvUF5FnEDLif6mSWmX3HS4w5kzyPzzZ47aH0KirbRujGMArrfDl5p+vZ
 w5cRT8dEqWUkR0vjJNTiglaECbUh0DtF4gI285Qbrr0I0GEAXnKPSw7+y5UWQSZjfCgz
 5wgSqo/9PjRnfTfn3gXpcUztpWnEl3DJgROcy/cagOJepq8WjKmfgwybOOXvOwltWriH
 CI0fVaGGpiT66cv76bsiPUzA1TDXTVY0Zn4AbPWaYPyZhMY1zP5x1f97qGB31TQtQa6A
 SMRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMfrTxXZBRLH5NljknrQXjPKpJab5iNgKmO1as2o2zIJqfJhVWlvFAKHLMkEs8k7ATlUbtsoPiuZEjq7OLJ9w=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzEhsRJlghH6l5W98p5gKKJU38IIORtW9G+WUL5OFc8vem9hxxs
 MXJyjYjIEZ9DhTR5nx8lv9B35iVyKWIAJHsq3U5Hhkf/ohwZ1bjuLcSV
X-Gm-Gg: AR+sD10yHgwPZ+pE2Qi+kiSACjdZ6jJFTEiOHF9oMS3GPMhn0w3D5XDoND0Qt9c07mr
 m+xETykVqGc73XerIXNNoE/LDI7nwJEzlTH0igco+D5mq1JF5KdPzKK47Lx6pd07UPT++CxpGyh
 UkBSwYowdPUK9H6PJeUqPmlHsVcNMY6q/nNe7dvtOAXkJkvLm3HSgmnrzgklJUfI4aXisUMi7sy
 C6SC1CblIZGinCK+scjjJawh9O53jE0ly4X6BO5TTvrjNKsUYM1iIUukd8JaSGjAHO2Zi9NhveA
 /lgAlLKBwX/PGjnjGQs87GO5Ynz/weSmHDzOBe7PsiV3Op7bwbsBUaLc1BBD2UBzRhU5/19zQ18
 d432ckwo3ZUrrDZ+ExefIJ6AqToWmjhDw0Ff1EnXsQsG6kDiguoNni5+IWYWXDHlddO2SZ3wZth
 v11zjK1DDWFn0lcdQ4u03Uor3QhZKolwpmqvFjD9rZ2I/QLTxNwkHPBGK/uTa5e6ydOw==
X-Received: by 2002:a05:6a00:9515:b0:847:99bb:b6d8 with SMTP id
 d2e1a72fcca58-84fb553c24bmr5293712b3a.26.1786541460521; 
 Wed, 12 Aug 2026 06:31:00 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:f326:be2a:1bb0:bade])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1ee8bdcsm1046727b3a.39.2026.08.12.06.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:30:59 -0700 (PDT)
Date: Wed, 12 Aug 2026 19:00:25 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Malathi <malathi.a2000@gmail.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com"
 <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>
Message-ID: <anx1cdVq5D1vmjWC@user>
References: <20260811050753.234931-1-malathi.a2000@gmail.com>
 <DS4PPF7551E655294090E40920DD86E03A7E5DC2@DS4PPF7551E6552.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS4PPF7551E655294090E40920DD86E03A7E5DC2@DS4PPF7551E6552.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786541461; x=1787146261; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uz+bfGVw3BN4xTVdoh1TluUgeBOBBwVoF8DrIGsXOfg=;
 b=Qn5OzSC1wrwA6osJRvAA+F1gc8P17PETyt9jFRqyN42NCzYGT7q6s8cNdkUNrX94Ya
 ALW+Sc1Aoqf980tOHUjwNvyYkanYE6g1ySymemhHl6vVQ7tqjcIxGMgakBsm+Nn9YwwA
 cOUT41nbuN3HR8wVo8Zcv/cQNfRR+gHSHDY3NtJ4Whs3RZMafxn2Z2d/WuDZjZ65oxk+
 h48jvZCyOQVA1t+Hl1wZaU6sGRzVlg+8mJGz9zsa3Yj3e/6GGszpWiqQkAGeMCDWPWpS
 VLE7KpjQHnyyHbYX4A+Lw+ehR9iSkn9GiB0ISvZwQWTsDIadU7FzRRykG0QK3xFdWPVk
 Ji2A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Qn5OzSC1
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] e100: fix
 shift-out-of-bounds in e100_eeprom_load()
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

On Wed, Aug 12, 2026 at 09:44:08AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Malathi
> > Sent: Tuesday, August 11, 2026 7:08 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org;
> > kuba@kernel.org; pabeni@redhat.com; edumazet@google.com;
> > andrew+netdev@lunn.ch; davem@davemloft.net; linux-
> > kernel@vger.kernel.org; Malathi <malathi.a2000@gmail.com>;
> > syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Subject: [Intel-wired-lan] [PATCH net-next v2] e100: fix shift-out-of-
> > bounds in e100_eeprom_load()
> > 
> > e100_eeprom_load() and e100_eeprom_save() start with an address length
> > of 8 and call e100_eeprom_read() to auto-detect the real EEPROM
> > address length. e100_eeprom_read() adjusts the length with
> > 
> > 	*addr_len -= (i - 16);
> > 
> > based on when the EEPROM drives a dummy zero onto EEDO. A
> > malfunctioning or emulated device that drives EEDO low too early makes
> > (i - 16) exceed the current length, underflowing the u16 addr_len to a
> > large value such as 65529.
> > 
> > That value is then used as a shift count:
> > 
> > 	nic->eeprom_wc = 1 << addr_len;
> > 
> > which is undefined behaviour and additionally overflows the fixed-size
> > nic->eeprom[256] cache.
> > 
> >   UBSAN: shift-out-of-bounds in
> > drivers/net/ethernet/intel/e100.c:768:21
> >   shift exponent 65529 is too large for 32-bit type 'int'
> > 
> > The same corrupted addr_len is also fed back into e100_eeprom_read()
> > for every subsequent word, where it is used as a shift count again:
> > 
> > 	cmd_addr_data = ((op_read << *addr_len) | addr) << 16;
> > 
> > so validating the length only once at the caller is not enough.
> > 
> > Clamp the length in e100_eeprom_read() so the subtraction can never
> > underflow the u16, and reject a zero or out-of-range length in
> > e100_eeprom_load() and e100_eeprom_save() before using it. The EEPROM
> > cache holds at most 256 words, so a valid address length is in [1, 8].
> > 
> > Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> > Signed-off-by: Malathi <malathi.a2000@gmail.com>
> > ---
> > v2:
> >  - Drop the Fixes: tag and retarget to net-next; the underflow is only
> >    reachable with malfunctioning or emulated hardware, so this is a
> >    hardening change and not stable material.
> >  - Clamp addr_len inside e100_eeprom_read() so the auto-detect
> >    subtraction can never underflow the u16.  The corrupted length was
> >    otherwise reused as a shift count for every subsequent word, so
> >    validating it only once at the callers (as in v1) was not enough.
> >  - Also reject a zero address length in e100_eeprom_load() and
> >    e100_eeprom_save().
> > 
> >  drivers/net/ethernet/intel/e100.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e100.c
> > b/drivers/net/ethernet/intel/e100.c
> > index 29960762e64a..26a7c0aaa6e2 100644
> > --- a/drivers/net/ethernet/intel/e100.c
> > +++ b/drivers/net/ethernet/intel/e100.c
> > @@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic,
> > u16 *addr_len, u16 addr)
> >  		 * complete address.  Use this to adjust addr_len. */
> >  		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
> >  		if (!(ctrl & eedo) && i > 16) {
> > -			*addr_len -= (i - 16);
> > +			u16 len = i - 16;
> > +
> > +			if (len > *addr_len)
> > +				*addr_len = 0;
> > +			else
> > +				*addr_len -= len;
> >  			i = 17;
> >  		}
> > 
> > @@ -765,6 +770,11 @@ static int e100_eeprom_load(struct nic *nic)
> > 
> >  	/* Try reading with an 8-bit addr len to discover actual addr
> > len */
> >  	e100_eeprom_read(nic, &addr_len, 0);
> > +	if (!addr_len || addr_len > 8) {
> > +		netif_err(nic, probe, nic->netdev,
> > +			  "invalid EEPROM address length %u\n",
> > addr_len);
> > +		return -EINVAL;
> > +	}
> >  	nic->eeprom_wc = 1 << addr_len;
> > 
> >  	for (addr = 0; addr < nic->eeprom_wc; addr++) { @@ -791,6
> > +801,11 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16
> > count)
> > 
> >  	/* Try reading with an 8-bit addr len to discover actual addr
> > len */
> >  	e100_eeprom_read(nic, &addr_len, 0);
> > +	if (!addr_len || addr_len > 8) {
> > +		netif_err(nic, probe, nic->netdev,
> > +			  "invalid EEPROM address length %u\n",
> > addr_len);
> > +		return -EINVAL;
> > +	}
> >  	nic->eeprom_wc = 1 << addr_len;
> > 
> >  	if (start + count >= nic->eeprom_wc)
> > --
> > 2.43.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Hi Aleksandr Loktionov,

could you please clarify something regarding this issue?

I submitted this code as part of the bug report on July 7 v1[1]
and July 10 v2 [2] and we were already discussing it.

Later on July 10, the same code lines were submitted again by her.

I noticed that her submission was reviewed, even though i had already shared
the same code earlier.

Could you please clarify why her submission was reviewed instead of the
original one i submitted?

I also sent you reply on v2 [2]. Could you please review that as well when you
get a chance?

I just want to understand how the submissions are being considered in this
case and make sure the contribution timeline is clear.

[1] https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/T/
[2] https://lore.kernel.org/all/20260810083355.21631-1-pavankumaryalagada@gmail.com/T/

Thank you,
Pavan
