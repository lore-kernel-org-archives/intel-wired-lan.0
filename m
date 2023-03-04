Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D37CC678D5
	for <intel-wired-lan@archiver.kernel.org>; Sat,  4 Mar 2023 16:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4FB081E8C;
	Sat,  4 Mar 2023 16:06:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4FB081E8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677946017;
	bh=JcYHs9znXyRvEsW9er3W4d+jKxzC6gw3I55cJl4TkGc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DzrYoC/Aux7+0uCTQvtVD2oaJIBYeuYhipzd9jZJY7IRjVjKkzEQufnjHiCxtfYzX
	 lT/S6dEl1aWNLUqT2sdj+FJoFnRo0hQg16shR9U3HBhS2WgafBSOrpL+NTkgQHyuSC
	 hr5x/5VgIdV5EgHxiggEZzqLc0r1PoxvTiIuCRDib0/WONRxyLGU33XfIS9wc1d+2C
	 TPnxKXVR6nhLx7AnqTl4+RZ+vL+vvcJt3a6aXNPd95ymZh97oT8ncN6Z3vXlwKyzim
	 B6jCGtg9kAriGTf3MLjmGGEHUyoRYIlJCb6yFg1u8kml3WqpQQ61bI7jjc1pU6uZLX
	 GR1MhzbVSzq5A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DIost3EcZTT3; Sat,  4 Mar 2023 16:06:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9E7781E92;
	Sat,  4 Mar 2023 16:06:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9E7781E92
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CB64F1BF82D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Mar 2023 16:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A43B94011D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Mar 2023 16:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A43B94011D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6k7SDaJ4jwHy for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Mar 2023 16:06:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C1F4400BF
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C1F4400BF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Mar 2023 16:06:53 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 cp7-20020a17090afb8700b0023756229427so9111754pjb.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 04 Mar 2023 08:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677946012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNRPswH7mfojPgwky25vynoh6nRPOwNiJhCydmNShSY=;
 b=ccSGZFZP7tdfsLQkfGtLWfjeGxaSE5JL4cjjxXifKg6vXNuXMLMl2n/rAvivc9LAIb
 b2gdA2LRcbegt4cFnRYfagPR6cnimEJbNaBvypiBpKFiKnvZw78rGjjTe2gtCLigRGFs
 ga8jrYdpTHdXOQjdBYbI6gr1NRK6b06BqogqvuQWENHgUdXsh101S+rgQjCah4AEXT7G
 5HoguRJqUNLmb0P3LA2PpVHV2HltRRft1jrgAfvDr4ZDGaljf1oHDDTpdxf1JaHnKBWF
 jGWbez3SAU798tGTM/vmbwdyGnIHH1I2O+Y7BgcKDfk16mYjTyDcakbThr5Sx75nUHw4
 dUew==
X-Gm-Message-State: AO0yUKULkO7HCTjjgmvdBkS//AK9ciIpooHRhCKAnmkK8n6HbBfNoxj8
 fQBiEl8s8hOtyYyVE0vjXLZukQ==
X-Google-Smtp-Source: AK7set8yIGj/nV+mQtoOzSq/HVz1BnOBETpGChwHj8gVR5WIW0N3T7PwA9bRALL9ZeYmRPJ4+Gd84g==
X-Received: by 2002:a17:90b:1b0c:b0:237:cfdb:c251 with SMTP id
 nu12-20020a17090b1b0c00b00237cfdbc251mr5353429pjb.16.1677946012543; 
 Sat, 04 Mar 2023 08:06:52 -0800 (PST)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
 by smtp.gmail.com with ESMTPSA id
 gz7-20020a17090b0ec700b002349608e80csm3276373pjb.47.2023.03.04.08.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Mar 2023 08:06:52 -0800 (PST)
Date: Sat, 4 Mar 2023 08:06:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Message-ID: <20230304080650.74e8d396@hermes.local>
In-Reply-To: <20230304122432.265902-1-vincenzopalazzodev@gmail.com>
References: <20230304122432.265902-1-vincenzopalazzodev@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112; t=1677946012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNRPswH7mfojPgwky25vynoh6nRPOwNiJhCydmNShSY=;
 b=e2PDO04k4zwengrP5dDVN2NczXwr/lPLCrLm+yLJ1NSN1pTVvqiC2QPeQnzB06na06
 UmWqvCRLk7Q3zRhlqU9C+8XlM5TA5ffhJy2L1ay5lh26/66JpUWhw68o14M/juuihdlt
 aKWyTVnVop3VoT97MPHepRXGuOJez2xOM19iQoRjS3GIcSBhIBv9sMaZ2M9xHWIS/lGQ
 axvEZ7GyjXkLqcHi9ucTXuFW2fv/nfH1y9R3IhahRjWa2bkJqJ+9RQVFzd2xNdeODm+f
 lvQO7+N/V59QnpGR1Ca5jKufu81iy1RT/92SPoqS/eKx/dFCmIEaDojgP9uriixxd+Zh
 oMYQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=networkplumber-org.20210112.gappssmtp.com
 header.i=@networkplumber-org.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=e2PDO04k
Subject: Re: [Intel-wired-lan] [PATCH v4] netdevice: use ifmap instead of
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

On Sat,  4 Mar 2023 13:24:33 +0100
Vincenzo Palazzo <vincenzopalazzodev@gmail.com> wrote:

> clean the code by using the ifmap instead of plain fields,
> and avoid code duplication.
> 
> v4 with some build error that the 0 day bot found while
> compiling some drivers that I was not able to build on 
> my machine.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303041847.nRrrz1v9-lkp@intel.com/
> Signed-off-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> ---

Patching cadaver drivers is not worth it.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
