Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EB6C64EC4
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Mar 2023 15:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7112F81404;
	Mon,  6 Mar 2023 15:56:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7112F81404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678118190;
	bh=NyoXh7k5sE0Qk3A6fys7GEAv5NdAUPqNul+zPZvDWFs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=sNWCR1J0Dh8PsVsM4qyi5pdVGwgeRu8WJYQUeDvFb0rxZ6HIn1OmIJLHVUP2HHK1r
	 0SQWUgH7sgNVfvuV1gb1ODPgw9Opy76UR8MEC2/VUCceex5T95A5TbwAhS0eTMH69P
	 hGTZF50man3/WoyKgbx8vwFcGKAIcPDn7AdqTIKiMQw5oaD/MPTmDKtWS1bIpurY3u
	 fiHMv5g6G8TITN3niyabEZHza4MMtECE7F+g9/Q0N/SKkYPldLHlIqKcXGsbLGsXY5
	 Tl5x/KqbS+IR6zaoJTo1BYO9UdEyGzn7K9KTvhMS6d27Qzqs001cLVnKoa5yM6SqIF
	 bB0nrI9TZEEMQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQLgOZI5-leQ; Mon,  6 Mar 2023 15:56:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EA0B817AD;
	Mon,  6 Mar 2023 15:56:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EA0B817AD
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 476B11BF337
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Mar 2023 19:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1EB81410C5
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Mar 2023 19:33:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EB81410C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GQrO3AHWNA81 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Mar 2023 19:33:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E9C041061
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E9C041061
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Mar 2023 19:33:41 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 m25-20020a7bcb99000000b003e7842b75f2so3049070wmi.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 04 Mar 2023 11:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677958420;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pYJuOHy6ey6sKW/GVsJJOVLV3R+SJynIVwsy0b2HCrE=;
 b=3xDeTLd1wVnSWreEOhMatPJeSxqdFR/5X6tP0I7VjwIETcZGy1isRfmVFyA/uV4qNj
 UgLBOKJ8AMHGqfWhz9IHmSJ+ssXEkbbScLNnhfc4YGZ2mfZocdQREG2DJ1fxdd+LAyNh
 vEcSNaMbmZcFfEgL5JEisFyax/4zB1cX9Z1ch103ns5w0dKnNeHz+wVKP3RniAVkkqzI
 zQI3QSBzSVQvyFmXg5DAl5qGouHiHf1FVwzEkx8oWA0V+EqKJIHq2s+QxV1JYP395dFj
 yuOmlv0iLFcFDBGBdw0XSfvYGO8bLaxxaD/+LCqffOeSqqTM02S7HOZquC8vpIdObl0R
 SlAQ==
X-Gm-Message-State: AO0yUKW6kCCSGnWHhRwKMfg1ArQynMWrd+kSNW7J0n3xc+eoZ7gQtd5U
 ooN7aCspuT0GhoQ+S8rMLYE=
X-Google-Smtp-Source: AK7set88FRPib16c0RvSSUbf250TGhbybX3NvuZ3eFFUcS3Belffl9daDxa/nz+2lkq940Wp9gqrkw==
X-Received: by 2002:a05:600c:524b:b0:3df:de28:f819 with SMTP id
 fc11-20020a05600c524b00b003dfde28f819mr5143013wmb.15.1677958420080; 
 Sat, 04 Mar 2023 11:33:40 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a05600c310c00b003dc49e0132asm10852100wmo.1.2023.03.04.11.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Mar 2023 11:33:39 -0800 (PST)
Mime-Version: 1.0
Date: Sat, 04 Mar 2023 20:33:38 +0100
Message-Id: <CQXUM7MRJU3X.321CXIWRLP8ZL@vincent-arch>
From: "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230304115626.215026-1-vincenzopalazzodev@gmail.com>
 <20230304110641.6467996b@kernel.org>
In-Reply-To: <20230304110641.6467996b@kernel.org>
X-Mailman-Approved-At: Mon, 06 Mar 2023 15:56:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1677958420;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYJuOHy6ey6sKW/GVsJJOVLV3R+SJynIVwsy0b2HCrE=;
 b=pgVhJShZuzbLJxqmMY7P3JuzmuDkQkmmQksMw8r+vYQ7j2vuhdspSOCvAihJ0sZGu5
 kFckdUq2vMcaSpPB5ObwmWCRKMeNcBVrmqtMeWUdX+acSfmg6Aq+AC/vKWkjsH4AZPid
 +pyQ30BMjyikz+Ekozndq0ck1xwm+5xIHLoAuXyGcJ23GxrZwYhRmJDWmz+Vl1QgmdAN
 c01VgfucaR9So8ayadVkOPAOGOx4xl+KUf1+gtoDFcXfWPFxSitbH1zZYX+4TLYyx0Ji
 MlpBXLSPcFJVQitnrYvbVEpQH2jEMD7eflqIokxoKNSL3S6Hz7U7ZgxXykLoxxujZKtR
 XJjg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=pgVhJShZ
Subject: Re: [Intel-wired-lan] [PATCH v3] netdevice: use ifmap instead of
 plain fields
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
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, davem@davemloft.net, khc@pm.waw.pl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat Mar 4, 2023 at 8:06 PM CET, Jakub Kicinski wrote:
> On Sat,  4 Mar 2023 12:56:26 +0100 Vincenzo Palazzo wrote:
> > clean the code by using the ifmap instead of plain fields,
> > and avoid code duplication.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202303041847.nRrrz1v9-lkp@intel.com/
> > Signed-off-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
>
> Please don't, as already explained it's not worth the code churn.

Ah! ok I got it, yes maybe this should be an RFC, I thought also that
this change will impact in so many things!

Ok, so I will remove just the FIXME that at this point is not 
useful anymore.

Cheers!

Vincent.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
