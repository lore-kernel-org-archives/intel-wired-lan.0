Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC371CA0ED3
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Sep 2024 13:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D02E60832;
	Mon,  2 Sep 2024 13:00:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORf39IxO1BW7; Mon,  2 Sep 2024 13:00:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9430260813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1725282057;
	bh=w4UjvHRX8Oj9LnIjMNRuX4yJ+xeGtxIsSsEqvGhv+ro=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9ytf/z9tciIawA8vJWLsXdda3lmHz07/Ioft2ChwVBHqTmAu73c4ufSosTGleoOAw
	 yqJstQHI2iFbKgpcWz9NVRdUhfIfPDDZHb1MZ6MmlXO5Bw/JKrD8SivtaeXLCu2qp0
	 g6oMeYsnruXHRfP/olhQxDCHwVynaciz4PFOoI57TLWB5UsNPpil74K+ar2cTH/Tc4
	 s4i3GaTosdW2Qwa+D7BgZg/2PYvJVa32DtndVEyOqXSAupeiO8NCNPJxnO/dNU3o3q
	 YrQ07QINRwj28DSmZgyw2Wm5jTOnscQv3qL40E3Eao/U6mDdDDdue06B/aKhYvSTMt
	 lHpair9nAPHaw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9430260813;
	Mon,  2 Sep 2024 13:00:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 04DF71BF40F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Sep 2024 13:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E44FA80FBA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Sep 2024 13:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doimO927LzKX for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Sep 2024 13:00:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3C3FC80FAE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C3FC80FAE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C3FC80FAE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Sep 2024 13:00:54 +0000 (UTC)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ZyRkMEcwOVKNDUjuvLXQfQ-1; Mon, 02 Sep 2024 09:00:52 -0400
X-MC-Unique: ZyRkMEcwOVKNDUjuvLXQfQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a83fad218so376628866b.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 02 Sep 2024 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725282051; x=1725886851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w4UjvHRX8Oj9LnIjMNRuX4yJ+xeGtxIsSsEqvGhv+ro=;
 b=mpwBqXT5xhUFORzoku9k1masMyLRJX+FvE7Nqtb1gLnqz1fgUFejE5FrF089gzHAJ+
 ghjCtRpblZgurdoXiBxxNAf59f39LXErXUOvFewfO8C6mCw6YbC+D9o+4Lj/ItR9KE4R
 EwYgYZ8ZzLfXq5a4MarhC/S0gTgIrCR414yHbv2sT9ghAjYohxILhoiqHtqgI7L48yIB
 qW3BgSLwPVmiiSGurRT7sYQimbI/vkaV3DzXCy0biNMiU7ry8H7JX/XSwCi8Sxn4Vpuz
 JlUFowVmu7TXerkyMpytKtzKf2ScT8L+Ptl5B3lkzOMKYTLtSCxaHkFHNlVOFvwrUwtT
 cPrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq3aWwIr8VgUbMQZqwvUQ++lpF1CuyrxOOKJYaP/A/VaeqpGOqKJH5tyiRtznaeDDT6Q2VNjUyreDaX49rEyA=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwIWEFN+j998fcZikYfRUrwGeKhjwpzp0/ml68ZMCOCZhG7kdFm
 g/nHg/db3gfBjSG3f0I6dT/BJcAhPvnVMg9B1M/kxkWDskRi2N8Cyd+H4RiIVanGRDXl8dNnzo2
 GjWAoV7dktVwlAcv4V+jUdIr4zQwstDWCtoT1ucdt8lYR9xdqtfyRXU4NCwI5ekG0CII=
X-Received: by 2002:a17:906:fe4b:b0:a79:82c1:a5b2 with SMTP id
 a640c23a62f3a-a89b93db796mr520933966b.9.1725282050506; 
 Mon, 02 Sep 2024 06:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV3/o7Jt5WWnvqUynDWlp723LhO4YRZNw/QT+Vx1+d+P4KGzj5Soa66/PUkMxaEKejnjlOOA==
X-Received: by 2002:a17:906:fe4b:b0:a79:82c1:a5b2 with SMTP id
 a640c23a62f3a-a89b93db796mr520931466b.9.1725282050020; 
 Mon, 02 Sep 2024 06:00:50 -0700 (PDT)
Received: from [192.168.88.248] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898900f6c4sm558071766b.68.2024.09.02.06.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 06:00:49 -0700 (PDT)
Message-ID: <7a7bffdf-b461-49a3-b410-c58d12762550@redhat.com>
Date: Mon, 2 Sep 2024 15:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jakub Kicinski <kuba@kernel.org>
References: <cover.1724944116.git.pabeni@redhat.com>
 <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
 <20240829182019.105962f6@kernel.org>
 <57ef8eb8-9534-4061-ba6c-4dadaf790c45@redhat.com>
 <20240830113900.4c5c9b2a@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240830113900.4c5c9b2a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1725282053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4UjvHRX8Oj9LnIjMNRuX4yJ+xeGtxIsSsEqvGhv+ro=;
 b=UggwA8GG4aV+faGadChsbUWaDH5y+cWNGr7ZRHVjGhMwzawlDhTkwlDtSDpZ9nhWqmlbox
 oEQUBjJD/c437T5rVVVQ5tGBLqZ5ARmiusIf7ZiWWEKyZHGqTgnJZ00kOzIFyAaCR4ewW4
 3PRWNI+C+GZYIPAznA3BlpGp/tplXT0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UggwA8GG
Subject: Re: [Intel-wired-lan] [PATCH v5 net-next 02/12] net-shapers:
 implement NL get operation
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

On 8/30/24 20:39, Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 12:55:05 +0200 Paolo Abeni wrote:
>> #define NETLINK_CTX_SIZE 48
>>
>> and use such define above and in linux/netlink.h
> 
> Aha, would be good to also have a checking macro. Maybe rename
> 
> NL_ASSERT_DUMP_CTX_FITS()
> 
> to apply more broadly? or add a new one? Weak preference for former.

I will rename it to NL_ASSERT_CTX_FITS(), in the same patch.

/P

