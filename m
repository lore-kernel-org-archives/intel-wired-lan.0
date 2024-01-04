Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2814EC47074
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Jan 2024 12:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0D3F4012A;
	Thu,  4 Jan 2024 12:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0D3F4012A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1704372321;
	bh=S5kXcRjxlEhfR8k8osz+MXbXKnJqn+MHEl+YiaTHP6Y=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bGS4gem7uiDHslsk+q/2o82jFK3yYkkSh3EFFZEHXW16a/z3s95Md+sC9aZA+edF0
	 9pzWoFbSdSCNaqdtFkSvFNvYQXq6mXImZiR/sQPh+CMbRyack6OC0jpZD2Qpeglr2k
	 MDzxBcpYezPOnJL62o8mhrDhg+Cm7YJP3/UGe+HRVc7kxedU4tylkofRw+lI2L44ZH
	 OWdTfI+6gmZNYjzwpaSAoNh73sJRylSP4pQseYIDcbWgDbFIEtFWRxnZWLledycWu/
	 dM80p/5BkA8FNUcv6nRWpxsQZVTsiZ4TG+K2rZhM8XeCtv+nNHJ6BWvS4Rl9rFrp8o
	 CU+4MUXRAAycw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 62rRMo_7nKBr; Thu,  4 Jan 2024 12:45:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82187409E7;
	Thu,  4 Jan 2024 12:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82187409E7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2FA031BF427
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 12:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 070F6409E7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 12:45:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 070F6409E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZpmhpdsCBAuc for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Jan 2024 12:45:17 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03E884012A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 12:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03E884012A
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EE35461E5FE04;
 Thu,  4 Jan 2024 13:44:05 +0100 (CET)
Message-ID: <89022e98-a984-40a1-b59f-f2c3cfb36f54@molgen.mpg.de>
Date: Thu, 4 Jan 2024 13:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240104101904.18267-1-przemyslaw.kitszel@intel.com>
 <a27c1c87-4668-4166-9e0e-1005b2244f7a@molgen.mpg.de>
 <a15e6427-c7c5-44ec-b767-035f46649776@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <a15e6427-c7c5-44ec-b767-035f46649776@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Intel-wired-lan] [linux-firmware] ice: update ice DDP package
 to 1.3.36.0
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
Cc: Shekhar Deb <shekhar.deb@intel.com>, intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Priya Limaye <priya.limaye@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Przemek,


Thank you for your quick reply.

Am 04.01.24 um 12:28 schrieb Przemek Kitszel:
> On 1/4/24 12:16, Paul Menzel wrote:

>> Am 04.01.24 um 11:18 schrieb Przemek Kitszel:
>>> Change log since 1.3.35.0:
>>> - add support for E825C device family support
>>
>> The last *support* sounds strange. Maybe just:
>>
>> Support E825C device family
>>
>> or
>>
>> Add support for E825C device family
> 
> thanks, will do
> 
>>
>>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> ---
>>>   WHENCE                                        |   4 ++--
>>>   .../{ice-1.3.35.0.pkg => ice-1.3.36.0.pkg}    | Bin 692776 -> 692776 
> 
> [above]
> 
>>> bytes
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>   rename intel/ice/ddp/{ice-1.3.35.0.pkg => ice-1.3.36.0.pkg} (98%)
>>>
>>> diff --git a/WHENCE b/WHENCE
>>> index 06fb7a45aa33..43f3916638b9 100644
>>> --- a/WHENCE
>>> +++ b/WHENCE
>>> @@ -6138,8 +6138,8 @@ Licence: Redistributable. See 
>>> LICENSE.amlogic_vdec for details.
>>>   Driver: ice - Intel(R) Ethernet Connection E800 Series
>>> -File: intel/ice/ddp/ice-1.3.35.0.pkg
>>> -Link: intel/ice/ddp/ice.pkg -> ice-1.3.35.0.pkg
>>> +File: intel/ice/ddp/ice-1.3.36.0.pkg
>>> +Link: intel/ice/ddp/ice.pkg -> ice-1.3.36.0.pkg
>>>   File: intel/ice/ddp-lag/ice_lag-1.3.1.0.pkg
>>
>> Should the old version be removed?
>>
> 
> it is, see [above] that git recognized it nicely as a file rename

Sorry for being unclear. I meant, shouldn’t the old version stay as 
seems to be done for a lot of firmware files in the git archive.

>> […]


Kind regards,

Paul
