Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD56606A321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Oct 2026 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=4gVUOVrF;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XZlIQ0te
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14C5480E14;
	Thu, 22 Oct 2026 10:54:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dR44lTKuETTq; Thu, 22 Oct 2026 10:54:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5654F81134
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792666487;
	b=Co76Ubq87ypuSIkeFYw1OUWDl8QUleJlx8QTLMqj6eX2+rTNm4xAmrrizajcuszU3gb6
	 DkIBx+mhDF48WEbjw72e0rDx/w9i4RvPIBbKWLI38kOZx88E8PB3+2TFLOK6GmPrcJPor
	 3kol+BEjEVUJ/mNsDcYqYTYpuozr6WSULkK/kuDWOB2b3eqtUYqRKj5JIRRdEyoSJibR8
	 tuPOnXx6QQFQfCJqPiLuHGQ3s19cBuiQiH3+R9H4KJEMjzFgS09GKdBbEMtHIbWykLcDd
	 +kAx092nT5kXqeesqrO5Lkr/DLG220CwDkeSDcej23ZeD8P3OARVIfQo7H+Tc5JCDug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792666487;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
	b=mDGcpqs7aJiTS5vPOb+FgVVp8RfkpUTwWVRPFeyB32A7Rs99BY7n+8NiZurC2OutrvY6
	 qk0rJwgJl5Br14DftRNzCiZ5pDFDu4AT2lFwfDDK57JsREGqbCXZYt8BA2yssA3Yj3JE/
	 19iu9IjnB5Ga87DO+BIofQbePrzPyBGIhtMixXb6BRpe0v3n1nr/HyP3ELYfRw0YF//Kp
	 S017Y+OiZcYbCG8QTTeq183PxrhznwbV6S6TpO/1BIXlJyptSbIWPJ0Y3QFrOjMGlE88H
	 cbnKT0pPb7hHe3o5W6I+jZLr0STKfnksJ0JU7sa9mdLgCLM478rQuMRLLdBpV0FdCxQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XZlIQ0te;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792666487;
	bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4gVUOVrFgt2zcDhoHA4NQLYcDP1FJzg/GIBSoichrkcWWrG3k063SYVY6xAhz6ucl
	 k2SrcsO/lxP9/DJyWwhj8/KH431Ls5IWeP6nfl/6O3mTVc2RfGbmGUcQXA6bKaLXD8
	 +aWDZxrKZqEtzlPEhvh2ymQSXW5sn7ZLnGbUiRoiWzfmQ8zcIXh5nzUE63tmym7g82
	 UJkTCU1YN6PgLQhoTEDN1veDk+I0YI7eEDqrsoEX4X1zyUiivl701kqT6yQT8M6F+r
	 vH4KXOHHJJZNt/3GYW31x5oUEUf2gz90ew7KnAiZRrwy1UgW035AQOceslB5jdekhm
	 OWifaPF/IE7Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5654F81134;
	Thu, 22 Oct 2026 10:54:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F862356
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 10:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75E7380E14
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 10:54:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id drcqhskbzazE for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Oct 2026 10:54:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0CA7C80D2C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792666484;
 b=GeLGwkJh9NE3GHwggST+hoGUUV2eI88qZaFQ7ty22SukGA2vEZVqNUlAd51wsy9TGgjY
 mpfWuZ/KnzM4fWhjgdYiN0zTzv8jJgPMT9rkYw9zbhUrUSjYXabTwwvqhiQ3DK0UwakAo
 g4OEmgpL68FkhoqjC5RWIauG/p78JdtL0elCpE/qzkfp5rc6sGRJFhLzfQajnQbWaCNMn
 j3vS+z/ZVcl10RV/RZ/Y5KZwXZBX37FSgk/LblbrgiUeY7YB/GF6hSKj5c6pYzZUUWh8C
 7h095uSbG9jvUDP1+NcCuAsiRX2md0kD/ruCg3HmAL5FDfdQ0a8sORzjGAa4kDZSTxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792666484;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
 Content-Type:Content-Transfer-Encoding;
 bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
 b=ZJFc349887nI5x90duvCvQ4O2OgmAu8UTFSEPl71T9eSDZDEbdbGRuqNP52VKEb8UGeu
 zChSLRi/V4cDVpfX4bvt+FA9+c1ce3exihGlA+QEUGReJGOICi3j/yCckFG0XxUBLH++/
 ARMLVlNe9AdQVpdUVIP85eLKEOSZdNQLCBZxaIYYX3SmLfNhtlIZ/5Ugnl3jCpJhdj0QP
 ggNTWh5tRoWEa3zofXT25bM1eXUcsICE8MeRY6Eyw3RHnOqYMbKCpUzkDRHafTAyCkXij
 n3R+iJSVATYIIk8HtDk4tLmCY1YwbcZVj83GWw2DbApJP4Nd+ng6bvbWIAiYS6RM4WA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=XZlIQ0te; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XZlIQ0te
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CA7C80D2C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
 b=XZlIQ0te5fZtQEBIZQXCdXrUf44kpIdx3aE7pnsZhBCpWlnGCTBBW/NuCfuRewQ7j7KUhc
 9o1rRhKangYTthynuZn5Zd8LfSnfcgelB0m+Br2F1dg1DirXoVgqtMO01e2stfCTen3EtW
 FvpCCpakVcg2EBWOAMuur+2AZggEkaY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-C5BrOKxUP4elYKBgAqk9TQ-1; Thu, 22 Oct 2026 10:54:40 +0000
X-MC-Unique: C5BrOKxUP4elYKBgAqk9TQ-1
X-Mimecast-MFC-AGG-ID: C5BrOKxUP4elYKBgAqk9TQ_1792666479
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b02d63407so1100614f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 03:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666479; x=1793271279;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
 b=znTcLP4bXZFEUUjphRZkmZTBWts0XNGs8x9DbmuDq3nhm3Z6z6dt8E8YGIRSJ3w1UJ
 Vd6WS3fb8+C1F6x67cNLzE+ZGE9g/9jEx+mx5C6Izkspxut5Xev0e6OY2Mn9Rrry3So5
 F5nuKExQzo/H1T589WXXT6kfn2dg4upFVjjmVTFOlHm7D5f+yDnQuK/pOPZCilNDDZx2
 soxKqrzqvutkL2/7OaJZOGsxbkXYUGlZ5Ku6Qr+hEBdJuvVs/+FidX8OB2FBsrJpP6gp
 tg5tDkVyQCM9qP5f9pZufWeMcEM0yPKJVw7J5x1uJQDy09ncG+Rw7Eti/1a+5zUb4FMU
 aTrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDzet3kWpQvUnnvR5Q2t51L9j3Fj04PofIzQRrJBN5jBt+POeHLbzr7IoBI3zurA2wV1zM+xZP0jRulMsHZnM=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLL+XVXFZt5jI/FLOIS2Qji4TCfC/6WD4x44chuV2Da/0ospbEB
 kiHtKdPMTLKnjoj8zN//ZrtGFQBykINvd+vzftEC01+lrScuCq+SSIrNsDhy2kxw6tSO2OTPGcn
 /E1xd8E8xeC7BnrsvGF+fn7O6IYwWCtIhEdw8Wf/uGtCZ+j4s4AovKfOwBk9Gx60Bdgs7XS8=
X-Gm-Gg: AYBFou2aLrGc3m/3xXgfAGd9nBtK0yWlSiJBqmK3NknH210hh40BLUH5z5yqx5V7zrH
 kaxe6VOWieFbzA6rzqD6xl1jjn8VMyCKXGcpxgzwgoTZm3zlll+lYDe8wTE22CIyMtbKlXSQbl4
 USDNe8x3WQZYciSymm7ky4CCLscPDbCcfc7ZwTW8H91BQwybv9539YE51zrW9Oeu2zCfvw09DSJ
 XkkjS17b8J7BXI+SyC0areT7YCuGde2EEYIvqqX0gcfN0+T0wYKEfF/334Vtwsg22+NxGmx0Tme
 M13qTXmxSwtMs2KLV+G4dCQWVrp2FstivRE0idNl6HO3yjuUJ4uN6gsKv4Y=
X-Received: by 2002:a05:600c:c4a1:b0:4a1:f0bc:90b with SMTP id
 5b1f17b1804b1-4a1fdd3d407mr99476225e9.29.1792666479364; 
 Thu, 22 Oct 2026 03:54:39 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a1:b0:4a1:f0bc:90b with SMTP id
 5b1f17b1804b1-4a1fdd3d407mr99475815e9.29.1792666478965; 
 Thu, 22 Oct 2026 03:54:38 -0700 (PDT)
Received: from [192.168.2.75] ([46.175.183.46])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f02f1sm12856807f8f.3.2026.10.22.03.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 03:54:38 -0700 (PDT)
Message-ID: <8b9bc610-777b-4436-98a6-2428153cc5f2@redhat.com>
Date: Thu, 22 Oct 2026 12:54:36 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
 ndo_setup_tc
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Ertman, David M" <david.m.ertman@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 "Maziarz, Kamil" <kamil.maziarz@intel.com>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 "Schmidt, Michal" <mschmidt@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
References: <20261019065301.3983537-1-poros@redhat.com>
 <20261019065301.3983537-4-poros@redhat.com>
 <CH3PR11MB566895E0410B0694F734EA7DAFE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <CH3PR11MB566895E0410B0694F734EA7DAFE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 21tlJx6-NkEZhTkCvsN7_oeuPEBKdzPwDJheBYfxLJY_1792666479
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/26 1:22 PM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Petr Oros <poros@redhat.com>
>> Sent: Monday, October 19, 2026 8:53 AM
>> To: netdev@vger.kernel.org
>> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> David S . Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Ertman, David M <david.m.ertman@intel.com>; Shiraz
>> Saleem <shiraz.saleem@intel.com>; Leon Romanovsky <leon@kernel.org>;
>> Maziarz, Kamil <kamil.maziarz@intel.com>; Rafal Rogalski
>> <rafalx.rogalski@intel.com>; Loktionov, Aleksandr
>> <aleksandr.loktionov@intel.com>; Schmidt, Michal <mschmidt@redhat.com>;
>> linux-rdma@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Sebastian Andrzej
>> Siewior <bigeasy@linutronix.de>; Clark Williams <clrkwllms@kernel.org>;
>> Steven Rostedt <rostedt@goodmis.org>; Mateusz Palczewski
>> <mateusz.palczewski@intel.com>; linux-rt-devel@lists.linux.dev
>> Subject: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
>> ndo_setup_tc
>>
>> The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
>> device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
>> runs with the RTNL lock held. This closes the same cycle against the
>> RDMA auxiliary probe as the two preceding patches.
>>
>> Use device_trylock() and report the device as busy when it fails, with a
>> distinct message for the same reason as in the previous patch.
>>
>> Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index edb62606d2aae3..7b251136149615 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -9448,7 +9448,11 @@ ice_setup_tc(struct net_device *netdev, enum
>> tc_setup_type type,
>>   		cdev = pf->cdev_info;
>>   		if (cdev && cdev->adev) {
>>   			mutex_lock(&pf->adev_mutex);
>> -			device_lock(&cdev->adev->dev);
>> +			if (!device_trylock(&cdev->adev->dev)) {
>> +				mutex_unlock(&pf->adev_mutex);
>> +				netdev_dbg(netdev, "RDMA auxiliary device is
>> busy, try again\n");
>> +				return -EBUSY;
> You return error here, but it looks like being silently dropped in mqprio_disable_offload() isn't it ?

Yes, mqprio_disable_offload() ignores it, the same as it ignores the
existing -EBUSY for a bound RDMA driver. Blocking there brings the
deadlock back and skipping the lock races with the probe, so v2 keeps
the refusal and warns about it instead of netdev_dbg().

> 
>> +			}
>>   			locked = true;
>>   			if (cdev->adev->dev.driver) {
>>   				netdev_err(netdev, "Cannot change qdisc when
>> RDMA is active\n");
>> --
>> 2.56.0
> 

