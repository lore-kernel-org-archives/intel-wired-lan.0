Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347C2C77B7C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Jun 2025 18:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 688EE60D93;
	Tue, 24 Jun 2025 18:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hZXRiBCKBlsw; Tue, 24 Jun 2025 18:35:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D85CF60E37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1750790103;
	bh=+oUXxIfYOVwST5bWKMo3Tg1ykdOeL3eZDAJJuwYSVG8=;
	h=From:Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zAKPjjVpk/HuO/l5JMz+T1KtPVa0d6GiD5RAE6P8QpUc4Q2c3mEc4WAknyVGerJPC
	 hF3BGLJKe8pn1/eOS+Ev4P+GR42wkAivEdtlua90LFqWkXDFELQOEAJQhuffuhPpr/
	 hpzD+ne0uymhW3m4wGcMvcrtpgtKHK8TieRnAkYhwBTZ3/B5AWMlTg4xAS5UqOMmsw
	 IDgCTNo74BT9TctSQtFgG+LcF1V76jPjWrSRnny/vHadOZwq81/5zwE0FG/FJVrZnt
	 LJa2lj0FVkgi74o2tZA5Vgo2YF2oXDPGl9wqmhpN3jsPuOBxnQAnszJ0Tqz90FJ2zw
	 EFrIQyuMhslQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D85CF60E37;
	Tue, 24 Jun 2025 18:35:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 178D912C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jun 2025 18:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F195F40536
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jun 2025 18:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHLCnuuRD7Se for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Jun 2025 18:35:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=jacek@jacekk.info; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DBDFA404E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBDFA404E5
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBDFA404E5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jun 2025 18:35:00 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-607ea238c37so1753550a12.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jun 2025 11:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750790099; x=1751394899;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+oUXxIfYOVwST5bWKMo3Tg1ykdOeL3eZDAJJuwYSVG8=;
 b=KORh2l3tGexSCd3WAHOrq6LQHniSjL93Mq/i4ML2B9YTEqZgSIDMnItuSmd9K/t0g1
 8gk2Dj5K+P0iaoDYrs3yibb41Yde4/6PcMZygHYcVYpOgXkhaBBsUaBv5m6SksMZhxPe
 h8W8F5AjMZJReI6JtQMIgutQ4eNYCXpBzr2D6fGyLyy0Pd090h3GkjOiK8VM5hVXWyX6
 S/gBzZVSONCkfmkPn8rylMckTrdz11nvB6rsdjbLcoVHG1+O9Head+WRAg7SmHbLov2/
 kK7ug1M2K+YOYyKZUESHS8DuQ7ARHBLto5UqEr7pJ0/1KM9FtJKNzA66nthKfbSjqLvE
 MkKg==
X-Gm-Message-State: AOJu0YyVteKUN2d5rLTyDwHMdpMzlrqF5wmvG0CRX21Je59CZzNvh+Qb
 e7LfMQeOMF0PKAYWTsWoOlWdg06tsRHXbTlfIv2vn+0BmM+0GZdwfPr3tNla8RU1Dw==
X-Gm-Gg: ASbGnct2MpXpBXUID9DxY4jehf+pEJVwG9LSZVPZEZkRUT/CZrjCLeOZHixGXDhvMxo
 dgxkNke3Y7moj/PmJLqJoYle0DIzQJVJmIGT7PTljOorWYdTLod+d+CcivwgMrXJX45Ljb0+bBe
 RGs4SAuBQ0y9odeLm/VcRWJVCmhDgpjrkzSC/mHsoRZcQIQBhuc2njTH4v1aZxU9D5XdgNUfjQw
 HJB5jnnQl0RypTBeZpHDFwrm5aaNqOiH/nC768D1+zTYVV2A/TNtkslBaAfdTlnP4G8WBKMMoUd
 pjMBnrlVcmZxvmIfPABTP91iXL2AMTFiy59qCm3MSWO+XkB/bec86BMRRtVds+8/psW+Uqlg9PE
 =
X-Google-Smtp-Source: AGHT+IF2Q7EXG3dh+dQGTwWFowwLHHyt4QaH8eo9c5nwntSUh27oaezGZyQ+fWjE9kDMnfbTjUYneg==
X-Received: by 2002:a05:6402:1e91:b0:604:e440:1d0b with SMTP id
 4fb4d7f45d1cf-60c46435e1amr762835a12.4.1750790098337; 
 Tue, 24 Jun 2025 11:34:58 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c2f1ae651sm1380305a12.28.2025.06.24.11.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 11:34:57 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <e4903c9f-6b84-4831-8530-40ff6e27a367@jacekk.info>
Date: Tue, 24 Jun 2025 20:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vlad URSU <vlad@ursu.me>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
 <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
 <8538df94-8ce3-422d-a360-dd917c7e153a@jacekk.info>
 <431c1aaa-304d-4291-97f8-c092a6bee884@ursu.me>
Content-Language: en-US
In-Reply-To: <431c1aaa-304d-4291-97f8-c092a6bee884@ursu.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jacekk.info; s=g2024; t=1750790099; x=1751394899; darn=lists.osuosl.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+oUXxIfYOVwST5bWKMo3Tg1ykdOeL3eZDAJJuwYSVG8=;
 b=vU4h4cLnLSMYNg9eU7502tAQpFphDmkizXmAxpTVCcrNJUojhLB+mO8nP5tBPEBglO
 liQrPwngF/WVJdilb/LSS0jnTolZRTAfWcTkO7UOFI1SCyXT4VW3BHAN+8/3T1B1Dw04
 BRCBlEAmgvzTj3NSb162LAqyVLIzV356HZzJhFGbEwmSGBATctc9s2ShA/l4XbBtgAEV
 46i0kQNEuTNWsDiidKAJ/gvRzQwf9WkwY9NSeZZd31t/cUElKGvUSfMUsMFVoBxln5jm
 0ksas5PYr7Ekc4lpSJcn3C3ReuoeuEr5ECyECDPuGY/n7o6QhnbaPwRuKTdjL7WTNNPp
 nG/Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=jacekk.info
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=jacekk.info header.i=@jacekk.info header.a=rsa-sha256
 header.s=g2024 header.b=vU4h4cLn
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] e1000e: ignore factory-default
 checksum value on TGP platform
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

> You are comparing the wrong value with NVM_SUM_FACTORY_DEFAULT. You 
> should check it against the checksum word 0x3F (NVM bytes 0x7E and
> 0x7F) which is used to ensure that the base NVM image is a valid
> image, and which in my case is left unchanged by Dell in the 
> firmware.

You are right that I'm comparing the wrong value. But it is only a 
matter of variable name:

-	if (hw->mac.type == e1000_pch_tgp && checksum ==
(u16)NVM_SUM_FACTORY_DEFAULT) {
+	if (hw->mac.type == e1000_pch_tgp && nvm_data ==
(u16)NVM_SUM_FACTORY_DEFAULT) {

Could you check my change with this modification?

-- 
Best regards,
   Jacek Kowalski
