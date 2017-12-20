From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 20 Dec 2017 08:24:04 +0200
Subject: [Intel-wired-lan] v4.15-rc2 on thinkpad x60: ethernet stopped
 working
In-Reply-To: <077087f2-551a-c045-6b07-b1b661e53dad@intel.com>
References: <20171210083949.GA3872@amd>
 <d1ae924b-4d8f-a787-4c07-1f2db91482e5@gmail.com> <20171215092849.GB15090@amd>
 <20171215.105210.103516329605719086.davem@davemloft.net>
 <20171218102657.GB5338@amd> <5c0be4c4-5a56-cc7b-7b5a-345f446e788e@intel.com>
 <20171218115817.GA17054@amd> <077087f2-551a-c045-6b07-b1b661e53dad@intel.com>
Message-ID: <842e2aec-77c6-277c-aeef-b506296f6599@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/18/2017 17:50, Neftin, Sasha wrote:
> On 12/18/2017 13:58, Pavel Machek wrote:
>> On Mon 2017-12-18 13:24:40, Neftin, Sasha wrote:
>>> On 12/18/2017 12:26, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>>> In v4.15-rc2+, network manager can not see my ethernet card, and
>>>>>>>> manual attempts to ifconfig it up did not really help, either.
>>>>>>>>
>>>>>>>> Card is:
>>>>>>>>
>>>>>>>> 02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit 
>>>>>>>> Ethernet
>>>>>>>> Controller
>>>>>> ....
>>>>>>>> Any ideas ?
>>>>>>> Yes , 19110cfbb34d4af0cdfe14cd243f3b09dc95b013 broke it.
>>>>>>>
>>>>>>> See:
>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=198047
>>>>>>>
>>>>>>> Fix there :
>>>>>>> https://marc.info/?l=linux-kernel&m=151272209903675&w=2
>>>>>> I don't see the patch in latest mainline. Not having ethernet
>>>>>> is... somehow annoying. What is going on there?
>>>>> Generally speaking, e1000 maintainence has been handled very 
>>>>> poorly over
>>>>> the past few years, I have to say.
>>>>>
>>>>> Fixes take forever to propagate even when someone other than the
>>>>> maintainer provides a working and tested fix, just like this case.
>>>>>
>>>>> Jeff, please take e1000 maintainence seriously and get these critical
>>>>> bug fixes propagated.
>>>> No response AFAICT. I guess I should test reverting
>>>> 19110cfbb34d4af0cdfe14cd243f3b09dc95b013, then ask you for revert?
>>> Hello Pavel,
>>>
>>> Before ask for reverting 19110cfbb..., please, check if follow patch of
>>> Benjamin work for you http://patchwork.ozlabs.org/patch/846825/
>> Jacob said, in another email:
>>
>> # Digging into this, the problem is complicated. The original bug
>> # assumed behavior of the .check_for_link call, which is universally not
>> # implemented.
>> #
>> # I think the correct fix is to revert 19110cfbb34d ("e1000e: Separate
>> # signaling for link check/link up", 2017-10-10) and find a more 
>> proper solution.
>>
>> ...which makes me think that revert is preffered?
>>
>> ??????????????????????????????????? Pavel
>>
> Pavel, before ask for revert - let's check Benjamin's patch following 
> to his previous patch. Previous patch was not competed and latest one 
> come to complete changes.
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Pavel, any update? Is Benjamin's last patch solved your network problem?

