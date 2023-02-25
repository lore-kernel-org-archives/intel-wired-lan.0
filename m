Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52201C7EE2E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Feb 2023 00:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9FAE417B1;
	Sat, 25 Feb 2023 00:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9FAE417B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677283789;
	bh=nrhAhbAtc/A6sQerBfXn8gKSmu+5fFh55yXb/sqwtug=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Hskj58LK1ANMW30uEKhGaF8UgU5nqnBJOmrVp5aABUIAvn1Igv5yjVqf/DL4cO3ve
	 H8Ybqc8CTivMbKhe3xJxfYhVcEUzcPdz8s5NQYnFVU6ezFduL4p5SQ7B1Aq47Mie3Q
	 zEJtI/t8vpIG0krllNhvmzJbM7PXa+qfnbOirbDDqC4STT4IWWaqel9o3Fb80QbgG4
	 MvDw+bxtKtJB2B3DzT4FXICwdDqHNWTIYJ1mQi6xidlQgj7BtujipWaqQ+ut9m99j1
	 gpEnMcVXQtaSIchq93S+e1Oddcer2LZBIZY6cKVA5pRMPDu1qK8KX49XJZ/eT47yr+
	 OK+za+LQJ+jhg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VmN99A7vf0L; Sat, 25 Feb 2023 00:09:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A235417B3;
	Sat, 25 Feb 2023 00:09:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A235417B3
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 7829F1BF982
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Feb 2023 00:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CF6E417B3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Feb 2023 00:09:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CF6E417B3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TrbW2JZG1_FJ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Feb 2023 00:09:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A45F417B1
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A45F417B1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Feb 2023 00:09:44 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 a14-20020a056830100e00b00690ed91749aso573400otp.7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Feb 2023 16:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rG5c0uuSbUunUALVODvqeVNmwOesQ/VQeoXgcA7DJXs=;
 b=YcAbBbnPqNpxZY+6yFzFphGD7gvulymzNCbOxleFAR6SgtcKV8UPmNdSEtpZO/sMvA
 17qZY+bsht5aOWt/TnP3g8y8LzBb77t5baQcYYcqduv08H06Vqp+2vqsbCTBpPZWJ7gs
 WvCx7dcwKQh0F/MPndNSPspIijpdzcEoon57JrpkoMqNDuhAboK5bN9xm9MGMAdWmMUy
 15o46SxHUDo56kRyxjitOO3JTfCALlDRBil5QEWKu/pFeaWpqIj2kT0ApWHSIIjLzNhH
 5Y35CZxBuTGyzhvRy9Q6/1bbDyGh6xc47Y/POqS0CIAQmsiBCfeLkRtSnHiLGkajsyyq
 9hgg==
X-Gm-Message-State: AO0yUKWlSpSpyPO6oPXT8b1KU0Sr3Bvo/JBiryMHpn8Haksfp2r+o5Tn
 YO+oGVWI0BIPeCR9Pmef5O4=
X-Google-Smtp-Source: AK7set8WcGhFL+TrMKfRHGHfrLPh6vX0fv2xNcQjbcOGlJ7MVJ+9A8udFuZGh/wrhMp6ft8NowmqPQ==
X-Received: by 2002:a9d:7194:0:b0:68b:d266:e6cc with SMTP id
 o20-20020a9d7194000000b0068bd266e6ccmr9332800otj.19.1677283784052; 
 Fri, 24 Feb 2023 16:09:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a056830138d00b00690e6d56670sm97789otq.25.2023.02.24.16.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Feb 2023 16:09:43 -0800 (PST)
Message-ID: <52f8bb78-0913-6e9a-7816-f32cdad688f2@roeck-us.net>
Date: Fri, 24 Feb 2023 16:09:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>
References: <20230211074113.2782508-1-o.rempel@pengutronix.de>
 <20230211074113.2782508-7-o.rempel@pengutronix.de>
 <20230224035553.GA1089605@roeck-us.net>
 <20230224041604.GA1353778@roeck-us.net>
 <20230224045340.GN19238@pengutronix.de>
 <363517fc-d16e-5bcd-763d-fc0e32c2301a@roeck-us.net>
 <20230224165213.GO19238@pengutronix.de>
 <20230224174132.GA1224969@roeck-us.net>
 <20230224183646.GA26307@pengutronix.de>
 <b0af4518-3c07-726e-79a0-19c53f799204@roeck-us.net>
 <20230224200207.GA8437@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230224200207.GA8437@pengutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rG5c0uuSbUunUALVODvqeVNmwOesQ/VQeoXgcA7DJXs=;
 b=fgXb8wvgxf5IbFqN//rKtMYLknlIYSo7+RXuCe7GWxq0JNoWRqgJoaYt/ZjxUIsZAr
 E/4PE5YQxC2f4LGr8fWvSedTxXyxEz7LrrHJC891Vs6INgtU0OY7bLMUDbVN+Golf7r2
 sjgYBNhvvO0QbRDnxf6p7xLkXwoewFmuUC2yFhjkzHvas5bJzdYmDHmYqppBRus32KWd
 WVuz3JnKs8iSHAuifAI2ctgYRuBGNulvxo6U/jhypH5SWyLIdT2fkNoORvPD/4MrrbGn
 A4F1TzWCZmI2BMzQCIrtUOmlNtpJYzk71xCwaKZRiY+bcLnyCjZtjQwucMBUWYCgY9DG
 BT5g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=fgXb8wvg
Subject: Re: [Intel-wired-lan] [PATCH net-next v8 6/9] net: phy: c22:
 migrate to genphy_c45_write_eee_adv()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Arun.Ramadoss@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vivien Didelot <vivien.didelot@gmail.com>, UNGLinuxDriver@microchip.com,
 Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
 Wei Fang <wei.fang@nxp.com>, kernel@pengutronix.de,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2/24/23 12:02, Oleksij Rempel wrote:
[ ... ]
>>
>> For cubieboard:
>>
>> MDIO_PCS_EEE_ABLE = 0x0000
>>
>> qemu reports attempts to access unsupported registers.
>>
>> I had a look at the Allwinner mdio driver. There is no indication suggesting
>> what the real hardware would return when trying to access unsupported registers,
>> and the Ethernet controller datasheet is not public.
> 
> These are PHY accesses over MDIO bus. Ethernet controller should not
> care about content of this operations. But on qemu side, it is implemented as
> part of Ethernet controller emulation...
> 
> Since MDIO_PCS_EEE_ABLE == 0x0000, phydev->supported_eee should prevent
> other EEE related operations. But may be actual phy_read_mmd() went
> wrong. It is a combination of simple phy_read/write to different
> registers.
> 

Adding MDD read/write support in qemu doesn't help. Something else in your patch
prevents the PHY from coming up. After reverting your patch, I see

sun4i-emac 1c0b000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

in the log. This is missing with your patch in place.

Anyway, the key difference is not really the qemu emulation, but the added
unconditional call to genphy_c45_write_eee_adv() in your patch. If you look
closely into that function, you may notice that the 'changed' variable is
never set to 0.

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 3813b86689d0..fee514b96ab1 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -672,7 +672,7 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
   */
  int genphy_c45_write_eee_adv(struct phy_device *phydev, unsigned long *adv)
  {
-       int val, changed;
+       int val, changed = 0;

         if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
                 val = linkmode_to_mii_eee_cap1_t(adv);

fixes the problem, both for cubieboard and xtensa.

Guenter

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
