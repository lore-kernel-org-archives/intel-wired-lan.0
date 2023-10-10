Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9EACD80BE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Oct 2023 12:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2961141B3C;
	Tue, 10 Oct 2023 12:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2961141B3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696940564;
	bh=/ijZSgz+EXe6wH6DnRvJgTF72svUHPEcgmHIvY1tUUM=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=7NtKej4TH4sbh1Ww3awVOxi0McZ6a9k5JKwKi94CTNYTORop/Vf89hwyxMeL5clkq
	 TAzMssqmeTOvVh7D1+TdLxk4ZFZgtvxAd+R38jiv3TPKSzupUP/qLzvFfYr4du5zBm
	 aTqABnzI7Ars7ZW/2tLCaffOcUPB61Zkpjs8bKzoef90/YkJQyVc6kwvBQcUSPMo9M
	 TNrQn6h6i2OW5e+NRGBNZCsoAunVXuGssw0xQfufDoYDHdRun7rxT6GOojE8GRlIKe
	 QsfNigt9nMZLWtrj8SkhH3MZ2IgrrZcpgT9EhIAY6AUI1ct92GH28ZA5N9YqrL5ZfL
	 tL0xr99VofNng==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwVlVWkzH4IU; Tue, 10 Oct 2023 12:22:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9ECC41934;
	Tue, 10 Oct 2023 12:22:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9ECC41934
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 3BD6C1BF344
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 12:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 134276073F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 12:22:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 134276073F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fiY5QQ3PjR2Q for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Oct 2023 12:22:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAFF0605AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 12:22:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DAFF0605AC
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-aJ_0RGUJMsiCTUTD6cCL7g-1; Tue, 10 Oct 2023 08:22:31 -0400
X-MC-Unique: aJ_0RGUJMsiCTUTD6cCL7g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b9ecd8c351so409187666b.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 05:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696940549; x=1697545349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eAfSHCsY6j7FDYYamvRIka3RlifCM0gqDVlTWRgj88A=;
 b=gc8eY9QHeHWSrsLjvCr08dQefR4ZNCf89UUsnSg6BjbtXdlAXc1hp5WUSPDZZ6HtST
 QS2wBk5WmrmxthQgRfdb15JmUfPwfF5HE/R5Wh+8IkN7MU42pTq3EQpB9UOPCI5G5J60
 GQ7hihLzBUCyRoffXixc230Z+zXBcF3C0ZuznfAs3gyGr98MA1uXpfFHefHWuOsWuOYc
 fc6HlSHDjzWJ4bPuOKiqQcct8cmnGLuvlhDYfaoGhSKXmE1K34NMB2A4zlUHSCoRzE8z
 AvpgPugPMuv4STP+9TFGH21xUVGyCw4np83eAef6OQ0nkzZjIAIWWtce75NxIBDvfyB2
 HpoA==
X-Gm-Message-State: AOJu0YyrPKTHc++g+U3ssL0kz9QlOoOkddAtpX2bIok1ck/DcsJ0OOmT
 Ll788M63txawf/lHGxdGGcerP58NsB2TqAoCOyvVpCcIH9GJPInBtay+9XjKSQPu0bcwQWq1e8b
 FwyEfAiULERjm8tBlamHN94J/riaCgQ==
X-Received: by 2002:a17:907:7817:b0:9b2:b7f3:6850 with SMTP id
 la23-20020a170907781700b009b2b7f36850mr14959568ejc.62.1696940549219; 
 Tue, 10 Oct 2023 05:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqu7fu5xxBSYv8gIsnNyPrT68wA0EDbRsIuVPSPVvSu5dAUlZZJ8eaAdD0m7QhwOF1tYOeoA==
X-Received: by 2002:a17:907:7817:b0:9b2:b7f3:6850 with SMTP id
 la23-20020a170907781700b009b2b7f36850mr14959555ejc.62.1696940548912; 
 Tue, 10 Oct 2023 05:22:28 -0700 (PDT)
Received: from [10.43.2.47] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 si5-20020a170906cec500b009b97d9ae329sm8398425ejb.198.2023.10.10.05.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:22:28 -0700 (PDT)
Message-ID: <33589ae3-77d2-4e70-846e-09192efce402@redhat.com>
Date: Tue, 10 Oct 2023 14:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20231010002444.43507-1-mschmidt@redhat.com>
 <20231010002444.43507-5-mschmidt@redhat.com>
 <MW4PR11MB5776E18B4699E7FFE49BE3E3FDCDA@MW4PR11MB5776.namprd11.prod.outlook.com>
From: Michal Schmidt <mschmidt@redhat.com>
In-Reply-To: <MW4PR11MB5776E18B4699E7FFE49BE3E3FDCDA@MW4PR11MB5776.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1696940558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAfSHCsY6j7FDYYamvRIka3RlifCM0gqDVlTWRgj88A=;
 b=UFOf+Jrl4fSY4Si53fP54xbwASiyxhrU4+7xCXzkzHSJwqdNjZN+DL3NmiE7TQBo6u3zA9
 +C8EhhrNqVBkC62VqDUrB0kxV9Igi5PdhyhW729o7u2qmINkBgz/2cLKix1L57soVMTanq
 KuP/WVIacJRxj/MRLv4ulEjwub7JHeY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UFOf+Jrl
Subject: Re: [Intel-wired-lan] [PATCH net-next 4/5] iavf: in iavf_down,
 disable queues when removing the driver
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
Cc: Radoslaw Tyl <radoslawx.tyl@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Brandeburg,
 Jesse" <jesse.brandeburg@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dne 10. 10. 23 v 13:39 Drewek, Wojciech napsal:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Michal Schmidt
>> Sent: Tuesday, October 10, 2023 2:25 AM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Radoslaw Tyl
>> <radoslawx.tyl@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>
>> Subject: [Intel-wired-lan] [PATCH net-next 4/5] iavf: in iavf_down, disable
>> queues when removing the driver
>>
>> In iavf_down, we're skipping the scheduling of certain operations if
>> the driver is being removed. However, the IAVF_FLAG_AQ_DISABLE_QUEUES
>> request must not be skipped in this case, because iavf_close waits
>> for the transition to the __IAVF_DOWN state, which happens in
>> iavf_virtchnl_completion after the queues are released.
>>
>> Without this fix, "rmmod iavf" takes half a second per interface that's
>> up and prints the "Device resources not yet released" warning.
>>
>> Fixes: c8de44b577eb ("iavf: do not process adminq tasks when
>> __IAVF_IN_REMOVE_TASK is set")
>> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> 
> Looks like a fix, could be a separate patch with net as a target.

I did not want to separate it from patch 3/5, because it changes the 
logic when IAVF_FLAG_PF_COMMS_FAILED is set. But on second thought, it 
should still work fine in that case too. aq_required would just get 
reset to zero in iavf_watchdog_task in the __IAVF_COMM_FAILED state.

Michal

> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> index 0b808fa34801..2ab08b015b85 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> @@ -1440,9 +1440,9 @@ void iavf_down(struct iavf_adapter *adapter)
>>   			adapter->aq_required |=
>> IAVF_FLAG_AQ_DEL_FDIR_FILTER;
>>   		if (!list_empty(&adapter->adv_rss_list_head))
>>   			adapter->aq_required |=
>> IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
>> -		adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
>>   	}
>>
>> +	adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
>>   	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
>>   }
>>
>> --
>> 2.41.0
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan@osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
