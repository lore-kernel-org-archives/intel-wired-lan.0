Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE7BC54E65
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 May 2025 19:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FE9B60A8D;
	Wed, 21 May 2025 19:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9nYDZ-S9APD; Wed, 21 May 2025 19:58:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A08C960E22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1747857485;
	bh=aPZxz+dtpFxQT466iF5goj1/hRi50weBs3Kt0jbco+A=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pQw/rpzM5SmF3nPj97NP1BU5b2KqWxs29Y23t4ri6IsEB069qkH0RStsNQK69fkd4
	 PvaVUgh0unMY/w0a5RVKCeoHUXJzsaza72TvIVfWW6Ue5jPQ+fb9ZYKM6Zjyj2NwoL
	 jaE7QJfZ31+ooBM3Tjch59iJ8VZC1+euy5D3IL6QouTrY1Iyr6a1uKN6X/WBLu4Cyu
	 e3scdoI7UqlB9fKtG+KZK8Wbesz28V1Y5zOULR9ztQTS8n9ycfwoEdyYWboIsP2EZ4
	 0Kh5P/x7orBgpJuVRLeiWL5D1Lz5SRAwKn340jdf+2Zo3dUMkvpOpUM32TIaAnK99O
	 P9S3AAyeRNLcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A08C960E22;
	Wed, 21 May 2025 19:58:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CFFB1BF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 May 2025 19:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E24A560C14
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 May 2025 19:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mMhlTodlAjVC for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 May 2025 19:58:02 +0000 (UTC)
X-Greylist: delayed 405 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 21 May 2025 19:58:01 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6C5E760A8D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C5E760A8D
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a02:e00:ffe7:c::2;
 helo=mail.valdk.tel; envelope-from=iam@valdikss.org.ru; receiver=<UNKNOWN> 
Received: from mail.valdk.tel (mail.valdk.tel [IPv6:2a02:e00:ffe7:c::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C5E760A8D
 for <intel-wired-lan@osuosl.org>; Wed, 21 May 2025 19:58:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6DA001A4E446; Wed, 21 May 2025 22:51:09 +0300 (MSK)
Message-ID: <de86c75b-b204-483f-a5fc-6a1410b24738@valdikss.org.ru>
Date: Wed, 21 May 2025 22:51:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>, intel-wired-lan@osuosl.org
References: <b946ccd3-3f7e-4c8b-ac07-0283be19e952@intel.com>
 <803760bf-04ff-4b23-8343-5e21f3ad9f63@valdikss.org.ru>
 <de3512b3-d3cd-4102-a047-71859a517fe9@valdikss.org.ru>
 <15248b4f-3271-42dd-8e35-02bfc92b25e1@intel.com>
Content-Language: ru, en-US
From: ValdikSS <iam@valdikss.org.ru>
Autocrypt: addr=iam@valdikss.org.ru; keydata=
 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
 OEcVmRU/pw5/zoQyQg==
In-Reply-To: <15248b4f-3271-42dd-8e35-02bfc92b25e1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=valdikss.org.ru; s=msrv; t=1747857072;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
 bh=aPZxz+dtpFxQT466iF5goj1/hRi50weBs3Kt0jbco+A=;
 b=kq9pSXK0jRg57V+rdg5/qMYiRwGR0JRVdoB2e3zf8A0y5sHd0lN3mel/V6p4/fg7Mka/ZG
 pKDCa2EAlCVRD/3XdGAvCMfF5bzl9qWvVZD3b3vQY6SFdL71UlCEakkUz/Sv51o+tuX3I9
 y8bz68WB15jGClRWf0o4E0XGiMGmA0V6Fb0lLbs5JPa7N2Veb5yG5SBpARna+ah/ZmUv6c
 U/TfFHgHcAXhqMbgy9e/cGlF6wfwsyLIZF9Tm1AVtWie7MIITn0bWkY4rrc54Eefpb3oUr
 lI7m3tqux84k90b416PSOSjbERqNI+VhFPf2fg/rOrvcE+BLLiqNLLrOiBjVGg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=valdikss.org.ru
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=valdikss.org.ru header.i=@valdikss.org.ru
 header.a=rsa-sha256 header.s=msrv header.b=kq9pSXK0
Subject: Re: [Intel-wired-lan] I226-V 1G limited to ~250Mbit with ASPM
 enabled
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

On 22.01.2025 7:15 PM, Lifshits, Vitaly wrote:
> 
> 
> On 1/22/2025 4:57 PM, ValdikSS wrote:
>> On 09.12.2024 12:21 PM, ValdikSS wrote:
>>>>> After (presumably) latest UEFI v0033 update for the NUC, my network 
>>>>> is limited to ~250 Mbit/s download unless I disable PCIE ASPM 
>>>>> option in UEFI settings.
>>>>> 56:00.0 Ethernet controller [0200]: Intel Corporation Ethernet 
>>>>> Controller I226-V [8086:125c] (rev 04)
>>>>
>>>> Hello,
>>>>
>>>> I believe that the issue you are facing is related to PCIE L1.2 
>>>> state exit latency. To confirm this please try to reproduce it after 
>>>> making the following changes in the igc code:
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/ 
>>>> net/ ethernet/intel/igc/igc_i225.c
>>>> index 0dd61719f1ed..1c0c3d665a0c 100644
>>>> --- a/drivers/net/ethernet/intel/igc/igc_i225.c
>>>> +++ b/drivers/net/ethernet/intel/igc/igc_i225.c
>>>> @@ -612,6 +612,10 @@ s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
>>>>                   */
>>>>                  ltr_min = (1000 * size) / speed;
>>>>                  ltr_max = ltr_min + tw_system;
>>>> +               if (speed == SPEED_1000) {
>>>> +                       ltr_min = ltr_max = 100 * 1000;
>>>> +               }
>>>> +
>>>>                  scale_min = (ltr_min / 1024) < 1024 ? 
>>>> IGC_LTRMINV_SCALE_1024 :
>>>>                              IGC_LTRMINV_SCALE_32768;
>>>>                  scale_max = (ltr_max / 1024) < 1024 ? 
>>>> IGC_LTRMAXV_SCALE_1024 :
>>>
>>> That instantly fixed the issue, thanks!
>>>
>>> With the patch:
>>>
>>> $ curl -o /dev/null http://speedtest.selectel.ru/1GB -4
>>>    % Total    % Received % Xferd  Average Speed   Time    Time Time 
>>> Current
>>>                                   Dload  Upload   Total   Spent Left 
>>> Speed
>>> 100 1024M  100 1024M    0     0  55.3M      0  0:00:18  0:00:18 
>>> --:--:-- 59.5M
>>>
>>> Without the patch:
>>>
>>> $ curl -o /dev/null http://speedtest.selectel.ru/1GB -4
>>>    % Total    % Received % Xferd  Average Speed   Time    Time Time 
>>> Current
>>>                                   Dload  Upload   Total   Spent Left 
>>> Speed
>>> 100 1024M  100 1024M    0     0  21.8M      0  0:00:46  0:00:46 
>>> --:--:-- 20.1M
>>
>> Vitaly, this patch doesn't seem to be sent to the kernel. Is this fix 
>> final, or was it intended only for the test?
>>
> 
> It was intended mainly for testing to understand if it is the same issue 
> that we faced in the Windows driver.
> 
> We haven't yes submitted this patch to the kernel, since we are still 
> evaluating whether this solution is robust enough and doesn't cause any 
> new issues.
> 

Hello, are there any updates on upstreaming this change?

If there haven't been much testing, could it be put behind the module 
option and disabled by default?

