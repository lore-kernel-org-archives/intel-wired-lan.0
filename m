From: Liwei Song <liwei.song@windriver.com>
Date: Thu, 6 May 2021 09:54:30 +0800
Subject: [Intel-wired-lan] [PATCH] ice: set the value of global config
 lock timeout longer
In-Reply-To: <fa7cd362645763d382719f8ab0e72f429156444b.camel@intel.com>
References: <20210419093106.6487-1-liwei.song@windriver.com>
 <7d85412de58342e4469efdfdc6196925ce770993.camel@intel.com>
 <fca32ba9-ad20-0994-de7c-b3bf8425a07b@windriver.com>
 <8d6eb1116cac38c764fce754a9fa272ac4509bbb.camel@intel.com>
 <fa7cd362645763d382719f8ab0e72f429156444b.camel@intel.com>
Message-ID: <5504b7a4-643f-642c-a22d-844566fd253d@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/4/21 08:44, Nguyen, Anthony L wrote:
> On Thu, 2021-04-22 at 11:16 -0700, Tony Nguyen wrote:
>> On Wed, 2021-04-21 at 10:29 +0800, Liwei Song wrote:
>>>
>>> On 4/21/21 06:48, Nguyen, Anthony L wrote:
>>>> On Mon, 2021-04-19 at 17:31 +0800, Liwei Song wrote:
>>>>> It may need hold Global Config Lock a longer time when download
>>>>> DDP
>>>>> package file, extend the timeout value to 5000ms to ensure that
>>>>> download can be finished before other AQ command got time to
>>>>> run,
>>>>> this will fix the issue below when probe the device, 5000ms is
>>>>> a
>>>>> test
>>>>> value that work with both Backplane and BreakoutCable NVM
>>>>> image:
>>>>>
>>>>> ice 0000:f4:00.0: VSI 12 failed lan queue config, error
>>>>> ICE_ERR_CFG
>>>>> ice 0000:f4:00.0: Failed to delete VSI 12 in FW - error:
>>>>> ICE_ERR_AQ_TIMEOUT
>>>>> ice 0000:f4:00.0: probe failed due to setup PF switch: -12
>>>>> ice: probe of 0000:f4:00.0 failed with error -12
>>>>
>>>> Hi Liwei,
>>>>
>>>> We haven't encountered this issue before. Can you provide some
>>>> more
>>>> info on your setup or how you're coming across this issue?
>>>>
>>>> Perhaps, lspci output and some more of the dmesg log? We'd like
>>>> to
>>>> try
>>>> to reproduce this so we can invesitgate it further.
>>>
>>> Hi Tony,
>>>
>>> My board is Idaville ICE-D platform, it can be reproduced when
>>> there is no QSFP Transceiver Module setup on it, it is not
>>> happened on each "modprobe ice", about 1/8 rate to got that
>>> error message when I loop run "modprobe -r ice && modprobe ice".
>>> the port type is Backplane, and I haven't reproduce
>>> it with Breakout mode. 
>>
>> Hi Liwei, 
>>
>> Thanks for the additional information. I've provided this to our
>> validation team and asked they try to reproduce so we can look into
>> it further.
> 
> Hi Liwei,
> 
> We were able to reproduce the issue. We found that this doesn't occur
> on newer NVMs, however, it will still be awhile until those newer ones
> are available.
> 
> In the interim, I'm going to have this patch tested to ensure it
> doesn't cause any issues. If so, we'll use this value until the new
> NVMs become available.

Hi Tony,

Got it, and thanks for the update.

Liwei.


> 
> Thanks,
> Tony
> 
