Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BFFC5AD44
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Aug 2026 19:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FA2980A65;
	Sat,  8 Aug 2026 19:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXSKVCPRmQ_6; Sat,  8 Aug 2026 19:10:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F89480A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786216227;
	bh=y4wD+x2lcQbQxh5BgV6YYsoRTfpHiShzTcIKLPwOniI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mY5AMK6QrYzYduJEfD24MqwivfdAv//t8DSq0bkX0AeFHLqRPPBCqiufOPQw/lph0
	 YTQR7gsDjUod+zaUr2qWMyzf9w3YUFC1cChQL6lhJiXNp+ccd125WjRwzMKDcxg/U/
	 29qq6ggbhswDXVtxWyM0EC8NrJj2WVUQ5REoLMf8rhFHEIjSk0dutT/7qatu+ofgkw
	 76kIykSRegqXRFJ/wXTtQPXfk16er/Sc20zd1m1TwW43V/yfzf9pQYeaO4rVqGc8Ov
	 A4ZALuFuY5WKuj5dZ8hulMTXI8jHDxf/qBXCw89icivpU8ShK2zHxXpygdeg3/5zBu
	 jj9Tyy7Zr29Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F89480A4C;
	Sat,  8 Aug 2026 19:10:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 683312F5
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 19:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E4CC4006A
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 19:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VtzdqLJfV_gk for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Aug 2026 19:10:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=pavankumaryalagada@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5F10340065
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F10340065
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F10340065
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 19:10:24 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cf52d15d88so4521375ad.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 08 Aug 2026 12:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786216223; x=1786821023;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y4wD+x2lcQbQxh5BgV6YYsoRTfpHiShzTcIKLPwOniI=;
 b=ZyR7GM9iULJsXIaJNlQJE5vEw1TDq9YPRH2gwzIS3HQV0vhJIYVPRqZuHoHKiXEPXz
 K6ghjySbN2iRfFg6NUqGhGTz/RByefpj8IyMalpzPjOQmVzaHNWpGxDHAJrIx9XyVHvb
 cM75a4sLDR1muB7igL3jdlVoZS57xzuL3VWruYYhGMgLDRo70PfJ01RFvI9IWsWYfvpG
 RlUo8F6ZVt5gHIduXla77J6xjGFbHKXunb+HbEGn4VKjOIUFYUMz1GlW+oOrujGZxPCh
 VRhbB6LjkXRxR9oqrqI1nnLuJ/W3PogE2MANNyjvTw/QlFjN2Buq9+GNM2paMtHIVOiy
 Z30Q==
X-Gm-Message-State: AOJu0YwzoYhFaMyfLWPObQJj7CFvE6Raybz+HXFCirTkJhP7I3TK/xQg
 Be/YEtTsUDfV6RZZLnkG6Nx26HwrQNxBkUxi527WgZ1lfz/Gg84xja5S
X-Gm-Gg: AR+sD10jn1gWBSmgJnRNMS9eegfuJh5rt87jQxAcfFD3ZXZWByMzy8M8/gxx97s25V7
 SvsYY7WO2zNCAanKFOSVXlTA+Ugrtj7c0Qk8gDD0ZDjwM11qlBBpqJErCiipRtDBn9paCb9k7YY
 KnlhCs1C0qiKa1aSOK7HhsCAGfnexrn1tIL+EaO1B6zAjDDdNY893OXGsjivOa7cRlv5xuyG4ke
 hx/P9UBUoipVH49Ac7hO7Sed0+9kuYG5jkDrbDALPweof3ZS7Caosmm4feTyuJjJR+C71t/XWo1
 EyaO3jB+o3PRq+OkqFyNA70nlvKUYc1lZKCT47MAYStuGzicKS/zL++jpW+2NwVzRzJ/Yc2uFlZ
 +lrIpKD1ZJCZvYnPp4V5g8SvVLoPbI2KLWlWEItNc4hg5TcFuZ5hxbbNgrjdXLQeSGzySnKip2K
 AnDJwbbO0sRHJitAjES+aflAYP1YbGj0dhLMWxC0DEzrbKxeaOwyGdCdVGM9Zii5UL
X-Received: by 2002:a05:6a21:6816:b0:3bf:6237:4d49 with SMTP id
 adf61e73a8af0-3cbce8d8e50mr10397119637.23.1786216223277; 
 Sat, 08 Aug 2026 12:10:23 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:e5fc:7669:b85:3eb7])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1410199cf49sm18817125c88.3.2026.08.08.12.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 12:10:22 -0700 (PDT)
Date: Sun, 9 Aug 2026 00:39:21 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Message-ID: <and-4dPXVkwerqZU@user>
References: <20260807145626.52692-1-pavankumaryalagada@gmail.com>
 <andBqsDhcLG9vDmn@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <andBqsDhcLG9vDmn@x1>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786216223; x=1786821023; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y4wD+x2lcQbQxh5BgV6YYsoRTfpHiShzTcIKLPwOniI=;
 b=Rorvd5axFIBBdrA/HUnBZH8C9uYqo2JcdeGF+d3fM0dewqYb3agf5jypQ+Pk2hbZA2
 S1Ru6SMF9dVdckUiF4FbyEwnPCGZLLaQTy+ShWv4zSqxfbBb6QQ1WEU+FZdBRpg5kSOt
 LTDnA8Vvp9P6E2z/YsmVNdPwrmwKcdFO5mWAurWSRO4WWrCxE9TXjF+WZ7ehqFpxIW/x
 eVk6ZtIx/uXo62+ujmKXv5H6sqoH+nKWwN4zNDWRCnhdxpyZEHstQMlyWRFsr+ggwE4L
 HdvTAWL5/MX4OyrpHM4+2WJMIp3abZYFa+3IqJnxcbuaWV73Wd2xsvKpm1+pK4SrxrtE
 WIMA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Rorvd5ax
Subject: Re: [Intel-wired-lan] [PATCH] e100: prevent shift out-of-bounds in
 e100_eeprom_load
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

On Sun, Aug 09, 2026 at 12:12:31AM +0900, Kohei Enju wrote:
> On 08/07 20:26, pavankumaryalagada@gmail.com wrote:
> > From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > 
> > When reading the EEPROM address length, e100_eeprom_read() can return
> > an invalid length (0 or >= 16). Passing an invalid addr_len to bit-shift
> > operations causes a shift out-of-bounds, triggering a kernel panic or
> > UBSAN warning.
> > 
> > Validate addr_len after reading it from EEPROM and return -EINVAL if
> > the value is out of bounds. Additionally, use 1U to prevent
> > signed integer overflow when calculating eeprom_wc.
> > 
> > Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Tested-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> > Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > ---
> > Tested using syzbot c reproducer.
> > ---
> >  drivers/net/ethernet/intel/e100.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> > index 29960762e64a..1de5cd41ea0c 100644
> > --- a/drivers/net/ethernet/intel/e100.c
> > +++ b/drivers/net/ethernet/intel/e100.c
> > @@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
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
> > @@ -765,7 +770,15 @@ static int e100_eeprom_load(struct nic *nic)
> >  
> >  	/* Try reading with an 8-bit addr len to discover actual addr len */
> >  	e100_eeprom_read(nic, &addr_len, 0);
> > -	nic->eeprom_wc = 1 << addr_len;
> > +
> > +	if (!addr_len || addr_len >= 16) {
> > +		netif_err(nic, probe, nic->netdev,
> > +			"Invalid EEPROM address length %u\n",
> > +			addr_len);
> > +		return -EINVAL;
> 
> An invalid address length here appears to indicate an unexpected
> response from the EEPROM, rather than an invalid argument. Therefore,
> -EINVAL seems somewhat misleading. Would -EIO be more appropriate here?
Agreed, addr_len comes from an unexpected EEPROM response,
so i will change -EINVAL to -EIO.
> 
> Also, e100_eeprom_save() seems to have the same pattern. Shouldn't we
> fix that as well?
yes, i'll fix e100_eeprom_save() as well. 
> 
> > +	}
> > +
> > +	nic->eeprom_wc = 1U << addr_len;
> 
> The commit message says that the U suffix prevents signed integer
> overflow. However, after the validation addr_len is in [1, 15], so 1 <<
> addr_len cannot overflow an int. I think what prevents the out-of-bounds
> shift is the validation, not the U.
Agreed, I'll remove the unnecessary U suffix.
I made these changes and will send v2.
> 
> >  
> >  	for (addr = 0; addr < nic->eeprom_wc; addr++) {
> >  		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
> > -- 
> > 2.43.0
> > 
