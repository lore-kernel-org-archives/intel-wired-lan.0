From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 29 Aug 2017 10:29:46 +0300
Subject: [Intel-wired-lan] Fixes in intel-wired-lan for e1000e link
	flapping
In-Reply-To: <20170823215311.6tqi7zoe4xxkpgyy@f1.synalogic.ca>
References: <B5B77A26-C5CE-4F06-808A-39D854AA5A0F@redfish-solutions.com>
 <1503482882.43048.29.camel@intel.com>
 <89d5567d-3cad-b9ac-94fc-f5dd2c55ad6b@intel.com>
 <B1C1DF2ACD01FD4881736AA51731BAB201EFF83F@ORSMSX114.amr.corp.intel.com>
 <20170823215311.6tqi7zoe4xxkpgyy@f1.synalogic.ca>
Message-ID: <9edf393d-87b8-0685-54b3-4dd4be7e2a8b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/24/2017 00:53, Benjamin Poirier wrote:
> On 2017/08/23 15:36, Duyck, Alexander H wrote:
>>> -----Original Message-----
>>> From: Neftin, Sasha
>>> Sent: Wednesday, August 23, 2017 3:41 AM
>>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Philip Prindeville
>>> <philipp@redfish-solutions.com>
>>> Cc: Benjamin Poirier <bpoirier@suse.com>; Lennart Sorensen
>>> <lsorense@csclub.uwaterloo.ca>; Duyck, Alexander H
>>> <alexander.h.duyck@intel.com>; Avargil, Raanan <raanan.avargil@intel.com>;
>>> Ruinskiy, Dima <dima.ruinskiy@intel.com>
>>> Subject: Re: Fixes in intel-wired-lan for e1000e link flapping
>>>
>>> On 8/23/2017 13:08, Jeff Kirsher wrote:
>>>> On Tue, 2017-08-22 at 11:48 -0600, Philip Prindeville wrote:
>>>>> Hi Jeff,
>>>>>
>>>>> I?m running these on top of 4.9.40:
>>>>>
>>>>> http://patchwork.ozlabs.org/patch/792259/
>>>>> http://patchwork.ozlabs.org/patch/792257/
>>>>> http://patchwork.ozlabs.org/patch/792258/
>>>>> http://patchwork.ozlabs.org/patch/792262/
>>>>> http://patchwork.ozlabs.org/patch/792260/
>>>>>
>>>>> in both production and in a burn-in lab under heavy load (1G
>>>>> saturation with iperf3) and have yet to see the link flap once in
>>>>> dozens of hours of testing.
>>>>>
>>>>> It?s been a month since these patches were submitted.
>>>>>
>>>>> When do you think they?ll get an merged/rejected?
>>>> There has been a lot of internal discussion on these patches, that is
>>>> why I have held off on applying them.  I think for the most part they
>>>> are fine, but I want Sasha Neftin (e1000e maintainer) to publically
>>>> ACK or NACK the patches, before I apply them.
>>> Hello,
>>>
>>> Please, give us another few days for a consultation with my colleagues.
>>> I will reply since we will done.
>>>
>>> Thanks,
>>>
>>> Sasha
>> Sorry for just now getting to these but I have been on Sabbatical for
>> the last couple months. Do we have any bugzillas associated with this
>> series available for review?
> Welcome back.
>
> The issue was reported upstream by Lennart:
> https://www.spinics.net/lists/netdev/msg444904.html
>
> It was introduced in an earlier patch series of mine:
> 16ecba59bc33 e1000e: Do not read ICR in Other interrupt (v4.5-rc1)
>
>> The first 3 patches look fine to me. If nothing else we may want to
>> have those resubmitted and we could probably push them for net/stable
>> so we can get them in ASAP.
>>
>> As far as patch 4 I am assuming the issue there was that the link
>> would be up but the interrupt noise of the overruns was forcing the
>> link to flap down, do I have that right? Is there any reason why we
> Sounds like it. The high interrupt rate increases the likelihood of
> hitting the race condition between the watchdog task and the Other
> interrupt.
> Lennart originally explained the race condition:
> https://www.spinics.net/lists/netdev/msg445048.html
>
>> would need this if you had put patch 5 in place before patch 4? Just
> Sasha raised more or less the same concern, which Lennart answered:
> https://www.spinics.net/lists/netdev/msg447210.html
>
>> wondering since a LSC event would indicate that the link has flapped
>> and if the true LSC events are coming fast enough to trigger the race
>> pointed out then maybe we should just bring the link down until the
>> link stops transitioning.
>>
>> In the case of patch 5 I think we need to look over the part in
>> question to see if there isn't a way to disable the Rx overrun
>> interrupt via a mask and avoid having to process overrun interrupts
>> since that is pretty much just going to be noise. Although I think it
> That would be the preferred solution indeed. After looking at the
> datasheet, neither Lennart nor I found a way to prevent receiver
> overruns from raising the Other interrupt.
>
> I referred to the table in ?10.2.4.1 which lists the causes mapped to
> the Other interrupt and searched in the rest of the datasheet. As it is,
> E1000_ICR_RXO is not set in IMS but Other still triggers for that
> condition.
>
>> might be worthwhile to split out the LSC bits you added as there would
>> be value to preventing link flap for any of the other "other" causes
>> that can trigger an interrupt. I just don't know if we need to be
>> processing the Rx overrun though since in theory we are already in
>> NAPI and rescheduling it isn't going to make things go any faster,
>> quite the opposite really.
> With patch 5, RXO in the Other interrupt schedules napi once (actually,
> it is most likely to already be scheduled since we're in a high traffic
> situation) and then the interrupt is not re-enabled until rx interrupts
> are also re-enabled at the end of napi polling. So that's just once per
> traffic burst. The alternative is to process thousands of Other
> interrupts per second.

Just added Alex's comments to the thread. Probably we need HW engineer 
consultation here - I will try get HW engineer vision here.

