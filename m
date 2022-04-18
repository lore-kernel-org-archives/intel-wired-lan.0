From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 18 Apr 2022 15:58:23 -0700
Subject: [Intel-wired-lan] [PATCH net-next 2/6] ice: always check VF VSI
 pointer values
In-Reply-To: <d9142a13-1b0f-6a01-c69d-727f4c76cb04@molgen.mpg.de>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
 <20220411232907.1022602-3-jacob.e.keller@intel.com>
 <e079ab74-48fc-65d1-4d3f-2c0cdd4ffcb9@molgen.mpg.de>
 <987480f6-9fc1-bd67-8803-9b88645b514c@intel.com>
 <d9142a13-1b0f-6a01-c69d-727f4c76cb04@molgen.mpg.de>
Message-ID: <4ebe06d5-814b-4277-1d5f-8916376a8fff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 4/12/2022 10:50 AM, Paul Menzel wrote:
> Dear Jacob,
> 
> 
> Am 12.04.22 um 19:35 schrieb Jacob Keller:
> 
>> On 4/11/2022 10:38 PM, Paul Menzel wrote:
> 
>>> Am 12.04.22 um 01:29 schrieb Jacob Keller:
>>>> The ice_get_vf_vsi function can return NULL in some cases, such as if
>>>> handling messages during a reset where the VSI is being removed and
>>>> recreated.
>>>>
>>>> Several places throughout the driver do not bother to check whether this
>>>> VSI pointer is valid. Static analysis tools maybe report issues because
>>>> they detect paths where a potentially NULL pointer could be
>>>> dereferenced.
>>>
>>> (side note: scripts/checkpatch.pl checks for 75 characters per line, and
>>> you seem to use 72 characters per line.)
>>
>> For commit message wrapping? I use some default from a vim plugin which
>> I guess decided that 72 was a good choice. Technically thats 8
>> characters less than 80 which is one full tabstop if you render tabs as
>> 8 spaces, which is sometimes used as a method of indenting commits from
>> git tools..
> 
> Yes, but the git tools indent with four spaces. See commit 2a076f40d8c9 
> (checkpatch, SubmittingPatches: suggest line wrapping commit messages at 
> 75 columns) [1]:
> 

I fixed my local editor config to use 75 characters going forward. I
also requested Tony fix the commits as he applied them to his tree, so
this should be corrected with what is applied to his next-queue now.

Thanks,
Jake
