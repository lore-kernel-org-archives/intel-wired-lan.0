Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08801CF395B
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Sep 2024 15:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABA0C42719;
	Thu, 19 Sep 2024 15:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESldAWbQxnVP; Thu, 19 Sep 2024 15:07:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA76E4271B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1726758475;
	bh=JEDklkIuM4g74LbRiLWac77J7RDe0/5AVecDahYHHj8=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KWu58AZyyxZR0zDOEUTEge0M4p47AAN+jrxxEbGaGeLK7X8vKIONc8PsL+XRU0nLm
	 5XbeK/bzJBqBrntlSKXlQ9sEBIymYpkAi/sJXDkQngFCJNDpavGdaQVlgK7kCmr808
	 N3J+6pAkUUbUYmspSjrD1B4L5rnYE29wB9ZI0JxeWw07YvNXp7GAzMLquE04NNhKMr
	 ABdiw429ViTUz7UX8gNCO3YIFN+aWa4uQyx96n7N4+tK3yYgu89Imkfw/dOa3hq5+C
	 pWR/trO1y/8gbfzJNcWePxjst5k8nG1tTheUAIV9zBpsCwuUoO4VfaTncOMYzXxbu7
	 zRb87P/afoQrw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA76E4271B;
	Thu, 19 Sep 2024 15:07:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 3A03D1BF46D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Sep 2024 15:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2864F849F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Sep 2024 15:07:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXXoH6Uw8UOb for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Sep 2024 15:07:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5B9958473C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B9958473C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B9958473C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Sep 2024 15:07:53 +0000 (UTC)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-cU7cvxcrPXeTL1Hm8I--gg-1; Thu, 19 Sep 2024 11:07:50 -0400
X-MC-Unique: cU7cvxcrPXeTL1Hm8I--gg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5365fdec97fso1000578e87.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Sep 2024 08:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726758468; x=1727363268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JEDklkIuM4g74LbRiLWac77J7RDe0/5AVecDahYHHj8=;
 b=PoCVUTX9K7HpCpfbXzVBxN8hA5tiwbQmoXWtYsBgtgtxY403MRAbgujxu7huBDv1LL
 bEyvg7OIp7Pl42nQaD9KKOUbYP/ajEpkrXWt5ILqAJIa4Fk1KHkVoKa81ncAvjref2YZ
 IkM84FOG2S1G6+sG1p+JK0OYpWf+BXeAdMeebY5xNP6t/qZio0taENvrTM4axQ1JZZkB
 N4QmBLsUQGBtSniBTwjAXqwM41zy2YajRXw18SDwIclWukWRktBAxQQXuWS4v9HoMJJ9
 T1hHBJzLm+YvKTDkqkC0Ffv5h2IwOjqQjBDOxgVaWN3YWa09sD0YVlmKIuod8maBAZ+X
 QUpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNCmS33GFgX28ty/OKRGuIz3Ee5K+Lp2HJsFfort0ETyZYqIneWkC+A8LbaCmGA7A59COvSG4ONzTZcUChGsY=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yzbx+uMI3xN/D2Q6URw3PwNOBY1DLNl1VudEzDfGJJkqdwcT8UD
 6mui1cYZ7d4TqG5x6R0YfErFL4nK90J/LOyuQJJaZ7QQQn8AVOsgnv/pTplgvNMmT2bAMsalz/d
 N5S0scBCtf296KnXButlCQBNiP1yOkSlqo/Kgnk6mCGiJ5I1YqNsXgEaGAhtqAXGWYlk=
X-Received: by 2002:a05:6512:1325:b0:533:42ae:c985 with SMTP id
 2adb3069b0e04-53678fbf06dmr14588693e87.25.1726758468502; 
 Thu, 19 Sep 2024 08:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXcMkkrCh8HDpINz1LdCe2tcnd2OREnJby19CPHPVqYGFBcAVw89mmXmpvN21zuCRaOdAyCA==
X-Received: by 2002:a05:6512:1325:b0:533:42ae:c985 with SMTP id
 2adb3069b0e04-53678fbf06dmr14588655e87.25.1726758467969; 
 Thu, 19 Sep 2024 08:07:47 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e75458230sm24108085e9.38.2024.09.19.08.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 08:07:47 -0700 (PDT)
Message-ID: <18971a87-4b52-4ce6-a36c-2d92738d7bfa@redhat.com>
Date: Thu, 19 Sep 2024 17:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jakub Kicinski <kuba@kernel.org>
References: <cover.1725919039.git.pabeni@redhat.com>
 <6c6b03fca7cc58658d47e0f3da68bbbcda4ae1ec.1725919039.git.pabeni@redhat.com>
 <20240910150337.6c397227@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240910150337.6c397227@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1726758471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEDklkIuM4g74LbRiLWac77J7RDe0/5AVecDahYHHj8=;
 b=bKU3398hyNz8br3Eahy9UfMc82sbnMtgJcM6eqlQZ2UDnSh8XBFgneGDMEcdSHD5jV+abx
 972mOC+zNpB4eXqBm+u78uc2iN7m6FzRfGlyE0o7tG1KCWh/1f8nrhYQ5TuW2nrot4QFgp
 NP0erGv6/XrB1lPGz9NAQMXUcwDBJv8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=bKU3398h
Subject: Re: [Intel-wired-lan] [PATCH v7 net-next 14/15] iavf: Add
 net_shaper_ops support
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
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 edumazet@google.com, Madhu Chittim <madhu.chittim@intel.com>,
 anthony.l.nguyen@intel.com, Simon Horman <horms@kernel.org>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Donald Hunter <donald.hunter@gmail.com>, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com, Sunil Kovvuri Goutham <sgoutham@marvell.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 9/11/24 00:03, Jakub Kicinski wrote:
> On Tue, 10 Sep 2024 00:10:08 +0200 Paolo Abeni wrote:
>> +	if (adapter->netdev->reg_state == NETREG_REGISTERED) {
>> +		mutex_lock(&adapter->netdev->lock);
>> +		devlock = true;
>> +	}
> 
> This leads to a false positive in cocci.
> 
> Any concerns about moving the mutex_init() / _destroy() into
> alloc_netdev_mqs() / free_netdev()?  I guess one could argue
> that narrower scope of the lock being valid may help catching
> errors, but I think we'll instead end up with more checks like
> the above sprinkled around than bugs caught?

I considered moving the locking initialization and shutdown, but I kept 
there for symmetry with the rss_lock. I'll move the init/destroy in the 
next revision.

Thanks,

Paolo

