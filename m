Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B9BC88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 13:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FA896081C;
	Wed, 16 Sep 2026 13:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9IbRSWNivs0; Wed, 16 Sep 2026 13:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 287C56080F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564018;
	b=XEeygLJXkyFjwzcr8+qNfkn05Q86Dki4jVMPRoAWovNil2MY78pXh/mLi7HMLKSXpsgK
	 M0MrXtXNB8lVLx95BAlKxdSxfI1tmYiTplr6AhNARTYVdSldSBM62BQv1AjSGPYXAA3wt
	 z7IgLMNcMB2w44mwFGuf6C5tA/R7g0rMyJsURehDN/XtxhR48aU5EHhBVULb65LET8pGJ
	 yBaMCGNONr3WzHDxYPwV2CRm3bPooloj66CBYKNDsZQ68/jPKdESTv4o4ao2pEOjSDUGk
	 fVatHD0Jsp6qe5smqu+QycWAa8gRVecUZdTMLVXPP8PQEMxC8ZxNRxjMcVJ+wB+7eMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564018;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KtSHIOcqGzDsGXMBO+gjFL4XAMuEjPH5tm95W3n6k6k=;
	b=J+6Te8wV+JzGn0FOs0eLGkjgsvWfCsRfb5Zc5gh5TdBb92tAji3CWWvsHI8XPYZoubtP
	 l5Vug9OaCOWyP+vXS0n5uKYBpnZXE6aeEBpQKeM0JWV3woQ+cU9SXpAQZCaTUsBRTRF8M
	 ULWDHOssf/Yx16Jdde7XWepLIe33MMHa8ZihVE9n0Vwzw3UOLTYz2/dbWiWyhr8t2zpkP
	 BL0+9nozQWTFSuevtlGbOmO93c5q79BkJD4t4Icl3CXITYhWSKoo6OiefLbD8Hdz4Gwdi
	 EyXK0nXZcBhtGqgafKYwolGmOizi1oXpBiiOd6o8Fe/DW7iNU3C2XyFr1eW0M0ErRMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789564018;
	bh=KtSHIOcqGzDsGXMBO+gjFL4XAMuEjPH5tm95W3n6k6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IEN8xp5uwFduD6FTVq/oIZ50AFDHXe/i7M6JnYJOwD3AQ9GYu08MxXmzpSkMNccE4
	 L2tnl6ORhS/CY5RDPbFKZ9fPSEhKvK8BD4/k0tYLqzpdyBB9V3VGtXwujcoiLfhtV8
	 zZuNSRwZq+p1SmTEti8hHSBeNTdcwoeq7c37lA173Vl5Ay9zma+QrI7TmcOypcSMhL
	 0QYmPtyNDtAxZ6NqQTxuYKOCi3hyOouTyGorS5bM4yfAWwUo5i9R7v1XfHZbLlMgJO
	 PI7ujYeW73/tvORYb1mWGyBBOD/01CAWSYQ8q00Zl709t7JaFK3f8/ZEBy4D4eZcid
	 TqBlpnw/X0v5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 287C56080F;
	Wed, 16 Sep 2026 13:06:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E98B388
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6416F806C7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cxutt8ItZ7Dc for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 13:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 35941806BA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789564015;
 b=KIfMxV4aB1QPzkkfBSEydx01O2LUcYVr6KJQmtnyl1l/rOyfML36/gPbks5Hnzqcm6Ox
 oa2m08k+rVCFYAN4baRp+UUrXWmt6IQtUq0GUxt+IFg2xpiKxh0SCKSSjp6+Eh29Ebgyn
 /gDb5AWEF76TZX879yYRtjW0yb1QGIqdvS9jroWMonpqhS5VArTR3d517cnSSBB3xAF7D
 k+WEfllb4noxGAndOqeSSNF6y135RY6KgKms7v08/k3+HXrneT+LaUCqsaqahx6cVUex9
 jyH9qNcHrmEgfxU9dZ56P4lwlV999XlOJdUs0QRrSrfNu3fj9zRWyC6za4Z6Oz4OV+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789564015;
 h=X-Greylist:Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=KtSHIOcqGzDsGXMBO+gjFL4XAMuEjPH5tm95W3n6k6k=;
 b=LJAc767wbDjs95hgqEWdjyPZEnGFtVR6B6B2AxXoD/ZalgjWmhBBFKhAgvUeln0tjilH
 fmIILRRSQIbsTY5KNoiM0hVgjgQM17QRDkOhZXYa/boAObYU8gCfpYIJzSmx73eapbEer
 sb4yIMXCZVeG6SQPKQgJyQX7uAiJRKYHopx47sgewdAHR61XNEfskFNSxk7uihTEW1uuz
 igwGj+IBlTHu9pvWK7p823QjL2h7Sn3QFvMkYu0gO/opzBuW3u+rqjm3udeP4JASoNOk7
 JogWK3ETnrFXHphQ7OpKYMLRsQA9b6DnLVa8US5ujkfVVrUrVc2l9WYYHi1s1YL4XlQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=mgUjUVED; 
 arc=none smtp.remote-ip=220.197.31.6
X-Greylist: delayed 90135 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 16 Sep 2026 13:06:54 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=mgUjUVED
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35941806BA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=KtSHIOcqGzDsGXMBO+gjFL4XAMuEjPH5tm95W3n6k6k=;
 b=mgUjUVEDrIaP4OWzIYbjBx4vEOctZ4UrhdBTy7CEK8elNJZssho25LJ/8g0oC2
 T4NSIBYDxwAMvIMm3qDCrXxqm+dz3EyheFr68NDQQwpbwbA8T0ByGXM+Jto7lcc2
 q8Ha9xbPl+9zQzRyhX0PdAbrlFMeB9QWZzizUdS4JTB1Q=
Message-ID: <3ab21824-7863-4fb5-9e13-cf0dfd1aa4df@126.com>
Date: Wed, 16 Sep 2026 21:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile count
 returned by the firmware
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20260915120354.610499-1-xiaolinkui@126.com>
 <IA3PR11MB898605544C71BB998C0FA35DE5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <IA3PR11MB898605544C71BB998C0FA35DE5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: PikvCgAHFus_lKpqwxjiHw--.21203S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw17Cr1fKFWfKw4DtF1UWrg_yoWrKFWxpa
 y5Ga1UGFn5JF1jgw1Uta17CFy09a4IyryYgayagas8Xrn8tFs5WryDKrWF9FnFvrWkGr15
 tF4v9r92yF4qqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uuv38UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAF6UWqqlEGHzwAA3f
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



On 2026/9/16 14:03, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Linkui Xiao <xiaolinkui@126.com>
>> Sent: Tuesday, September 15, 2026 2:04 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
>> Subject: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile
>> count returned by the firmware
>>
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer,
>> which is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries
>> plus the 4 byte p_count header. i40e_ddp_does_profile_exist() and
>> i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
>> without bounding it, so a firmware reporting more than 16 profiles
>> makes both helpers walk past the end of the on-stack buff[] and
>> compare against whatever happens to follow it on the stack.
>>
>> Clamp the count to the number of entries the buffer can actually hold
>> and make the loop counter unsigned to match the field type.
>>
>> Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_ddp.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
>> b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
>> index daa9f2c42f70..1d6d8b3835a3 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
>> @@ -55,7 +55,7 @@ static int i40e_ddp_does_profile_exist(struct
>> i40e_hw *hw,
>>   	struct i40e_ddp_profile_list *profile_list;
>>   	u8 buff[I40E_PROFILE_LIST_SIZE];
>>   	int status;
>> -	int i;
>> +	u32 i, p_count;
> RCT please
> 
>>
>>   	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE,
>> 0,
>>   				      NULL);
>> @@ -63,7 +63,12 @@ static int i40e_ddp_does_profile_exist(struct
>> i40e_hw *hw,
>>   		return -1;
>>
>>   	profile_list = (struct i40e_ddp_profile_list *)buff;
>> -	for (i = 0; i < profile_list->p_count; i++) {
>> +	/* Never walk past the end of buff[], the profile count
>> reported by
>> +	 * the firmware is not guaranteed to fit into the buffer we
>> gave it.
>> +	 */
>> +	p_count = min_t(u32, profile_list->p_count,
>> I40E_MAX_PROFILE_NUM);
>> +
>> +	for (i = 0; i < p_count; i++) {
>>   		if (i40e_ddp_profiles_eq(pinfo, &profile_list-
>>> p_info[i]))
>>   			return 1;
>>   	}
>> @@ -110,7 +115,7 @@ static int i40e_ddp_does_profile_overlap(struct
>> i40e_hw *hw,
>>   	struct i40e_ddp_profile_list *profile_list;
>>   	u8 buff[I40E_PROFILE_LIST_SIZE];
>>   	int status;
>> -	int i;
>> +	u32 i, p_count;
> RCT please
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Hi,

Thanks for the review and for the Reviewed-by tag.

Just to make sure I understand the "RCT please" comments correctly: are 
they referring to the Reverse Christmas Tree (RCT) variable declaration 
ordering convention, i.e. the local variables should be declared in 
decreasing order of line length? In both functions I currently have:
         struct i40e_ddp_profile_list *profile_list;
         u8 buff[I40E_PROFILE_LIST_SIZE];
         int status;
         u32 i, p_count;

If I understand RCT correctly, the expected order would be something like:
         struct i40e_ddp_profile_list *profile_list;
         u8 buff[I40E_PROFILE_LIST_SIZE];
         u32 i, p_count;
         int status;

Could you please confirm whether that is what is being asked for, and 
whether there are any other RCT-related issues in this patch?
Also, should I send a v2 with the RCT ordering fixed, or would you 
prefer to keep the current version as-is since the change is purely 
stylistic? I am happy to send a v2 if that is preferred.

Thanks,
Linkui
> 
>>
>>   	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE,
>> 0,
>>   				      NULL);
>> @@ -118,7 +123,12 @@ static int i40e_ddp_does_profile_overlap(struct
>> i40e_hw *hw,
>>   		return -EIO;
>>
>>   	profile_list = (struct i40e_ddp_profile_list *)buff;
>> -	for (i = 0; i < profile_list->p_count; i++) {
>> +	/* Never walk past the end of buff[], the profile count
>> reported by
>> +	 * the firmware is not guaranteed to fit into the buffer we
>> gave it.
>> +	 */
>> +	p_count = min_t(u32, profile_list->p_count,
>> I40E_MAX_PROFILE_NUM);
>> +
>> +	for (i = 0; i < p_count; i++) {
>>   		if (i40e_ddp_profiles_overlap(pinfo,
>>   					      &profile_list->p_info[i]))
>>   			return 1;
>> --
>> 2.25.1
> 

