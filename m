From: Yanjun Zhu <yanjun.zhu@linux.dev>
Date: Mon, 18 Oct 2021 22:22:28 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] ice: compact the file ice_nvm.c
In-Reply-To: <10c80bab-db74-b567-505c-95d74763248f@molgen.mpg.de>
References: <20211018131713.3478-1-yanjun.zhu@linux.dev>
 <c1903730-9508-1fef-4232-3a5b62f28d7c@molgen.mpg.de>
 <087710e9-2aeb-c070-cebb-82ae9cb5c20e@linux.dev>
 <10c80bab-db74-b567-505c-95d74763248f@molgen.mpg.de>
Message-ID: <2b0dbaf8-1033-b1a3-8976-83a785fbe682@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


? 2021/10/18 22:05, Paul Menzel ??:
> Dear Yanjun,
>
>
> Am 18.10.21 um 16:00 schrieb Yanjun Zhu:
>
>> ? 2021/10/18 21:44, Paul Menzel ??:
>
>>> Am 18.10.21 um 15:17 schrieb yanjun.zhu at linux.dev:
>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>
>>>> The function ice_aq_nvm_update_empr is not used, so remove it.
>>>
>>> Thank you for the patch. Could you please make the commit message 
>>> summary more descriptive? Maybe:
>>>
>>>> ice: Remove unused `ice_aq_nvm_update_empr()`
>>>
>>> If you find out, what commit removed the usage, that would be also 
>>> good to document, but it?s not that important.
>>
>> Thanks for your suggestion.
>>
>> IMO, removing the unused function is one method of compact file.
>>
>> I agree with you that the commit message summary is not important.
>
> Sorry, you misunderstood me. The commit message summary is my opinion 
> very important, as it?s what shown in `git log --oneline`, and in this 
> case everybody has to read the full commit message to know what the 
> commit actually as *compact* is not conveying this meaning and is 
> ambiguous.
>
> Not as important is finding the commit removing the last user, and 
> adding a Fixes tag with it.
Got it.
>
>> If someone finds more important problem in this commit, I will resend 
>> the
>>
>> patch and change the commit message summary based on your suggestion.
>
> It?d be great, if you sent an improved version.

I will resend the latest version.

Zhu Yanjun

>
>
> Kind regards,
>
> Paul
