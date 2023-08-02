Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39A1C04E69
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Aug 2023 16:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DE69414B4;
	Wed,  2 Aug 2023 16:00:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DE69414B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690992043;
	bh=tDxgLqLcQ61Io6VlO5rACSyjoEQSh5ywI2YztxzyMKM=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=VRsNtUBPQTPG3YnZDz8yZKhzbwPhN7SNMKPCjCs0NHBMqi4CWhkEZAUQ7GD76kLOE
	 or5UXvHGqpmOFm85/SOBrGEyY60WCF3T1wE5n2ORyzYDyFSjsr3HXnmYAGFW+W32t5
	 8dfN3uxUZ4lWHihCboJUE2O5R+/0QmQKglTafDOm7FnDbWiktQJxhZFFagC20b1asA
	 596Cu2nsj8hQPCh9uLeKiz5Si9JrF6gcfsZkyhJTwwmyXp6tqChSILH4MB7ECZIeMk
	 rLKIuazjpzZusN11c1OXcxoMvY5M+hE6f/kh4NzbKddPpoWPc/7uI/uQz/17QDpZcy
	 b4x0c5VcKHQtg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ne1xMuFNmuQz; Wed,  2 Aug 2023 16:00:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97C1840AD9;
	Wed,  2 Aug 2023 16:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97C1840AD9
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 7FFF61BF47E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 16:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0F9481314
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 16:00:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0F9481314
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tnI__8jMAM2c for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Aug 2023 16:00:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 935EE8130E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 15:59:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 935EE8130E
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-87G8UU--Oa2DZqVEaBddSQ-1; Wed, 02 Aug 2023 11:59:57 -0400
X-MC-Unique: 87G8UU--Oa2DZqVEaBddSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E4163828885;
 Wed,  2 Aug 2023 15:59:55 +0000 (UTC)
Received: from [10.45.224.238] (unknown [10.45.224.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E339E1121325;
 Wed,  2 Aug 2023 15:59:54 +0000 (UTC)
Message-ID: <434d374a-55ac-9b66-1b35-a76289734ba3@redhat.com>
Date: Wed, 2 Aug 2023 17:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: "Guo, Junfeng" <junfeng.guo@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20230605054641.2865142-1-junfeng.guo@intel.com>
 <20230605054641.2865142-16-junfeng.guo@intel.com>
 <044eba59-0880-501a-7fb5-75b84fe51b69@redhat.com>
 <DM6PR11MB3723D16B907692708C8E1F31E70BA@DM6PR11MB3723.namprd11.prod.outlook.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <DM6PR11MB3723D16B907692708C8E1F31E70BA@DM6PR11MB3723.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1690991998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XnTPE3SVMl93uFHx0sLNdWCUEMvrTFhn8yvvtKlCj+c=;
 b=AF1n4WFY4/y425ByXQWpNv2LrHQbALxPZnyQkb0sXrLkJUOi1sLPfzAzsyITTgNiPVtw84
 FzD6fgsTssj6uLiUXOFoYG8tJhSx1jLq5t2E5JgQXnVxbuTgHQyuIc4mepPdbIqpLgeuqY
 KCaXdkw2BnN61EZMU4AKqnkgbikYOfw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AF1n4WFY
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 15/15] ice: add API for
 parser profile initialization
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
Cc: "Zhang, Qi Z" <qi.z.zhang@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 02. 08. 23 9:56, Guo, Junfeng wrote:
> 
>> -----Original Message-----
>> From: Ivan Vecera<ivecera@redhat.com>
>> Sent: Monday, July 24, 2023 19:17
>> To: Guo, Junfeng<junfeng.guo@intel.com>; intel-wired-
>> lan@lists.osuosl.org
>> Cc: Zhang, Qi Z<qi.z.zhang@intel.com>; mschmidt
>> <mschmidt@redhat.com>; poros<poros@redhat.com>
>> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 15/15] ice: add API for
>> parser profile initialization
>>
>>
>>
>> On 05. 06. 23 7:46, Junfeng Guo wrote:
>>> Add API ice_parser_profile_init to init a parser profile base on
>>> a parser result and a mask buffer. The ice_parser_profile can feed to
>>> low level FXP engine to create HW profile / field vector directly.
>>>
>>> Signed-off-by: Junfeng Guo<junfeng.guo@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_parser.c | 113
>> ++++++++++++++++++++
>>>    drivers/net/ethernet/intel/ice/ice_parser.h |  24 +++++
>>>    2 files changed, 137 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c
>> b/drivers/net/ethernet/intel/ice/ice_parser.c
>>> index 1ca0886e6590..ad42dcd31cb3 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
>>> @@ -448,3 +448,116 @@ int ice_parser_ecpri_tunnel_set(struct
>> ice_parser *psr,
>>>    {
>>>    	return _tunnel_port_set(psr, "TNL_UDP_ECPRI", udp_port, on);
>>>    }
>>> +
>>> +static bool _nearest_proto_id(struct ice_parser_result *rslt, u16 offset,
>>> +			      u8 *proto_id, u16 *proto_off)
>>> +{
>>> +	u16 dist = 0xffff;
>> Use U16_MAX here...
> Sure, make sense! Will update in the coming version. Thanks!
> 
>>> +	u8 p = 0
>> Also 'proto' instead of 'p' would be better.
> Sure, make sense! Will update in the coming version. Thanks!
> 

I'm looking forward for the next version.

Thank you,

Ivan

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
