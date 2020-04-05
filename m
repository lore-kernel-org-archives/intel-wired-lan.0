From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sun, 5 Apr 2020 09:46:26 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when
 ME un-configure ULP mode
In-Reply-To: <1c0e602f-1fe7-62b1-2283-b98783782e87@canonical.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <4f9f1ad0-e66a-d3c8-b152-209e9595e5d7@redhat.com>
 <1c0e602f-1fe7-62b1-2283-b98783782e87@canonical.com>
Message-ID: <00b477c9-ef20-be95-1748-44efba18ebd3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/3/2020 06:15, Aaron Ma wrote:
> Hi Jeffrey:
> 
> I have received the email that you apply this patch to next-queue branch
> dev-queue.
> 
> But after this branch is rebased to v5.6, I can't find it.
> 
> Will you apply again?
Aaron, Kai,
S0ix flow supported only on none ME system. Our PAE works to communicate 
this to OS vendors. You should get BIOS option to disable ME on your system.
This fix just will mask real problem on specific system - won't be solve 
the problem. I suggest recall this patch and Lenovo Carbon in DMI black 
list.
> 
> Thanks,
> Aaron
> 
> On 4/2/20 8:31 PM, Hans de Goede wrote:
>>
>> This fix fixes a real problem, on a popular model laptop
>> and since it just extends a timeout it is a pretty harmless
>> (no chance of regressions) fix. As such since there seems
>> to be no other solution in sight, can we please move forward
>> with this fix for now ?
Thanks,
Sasha
