From: Kai Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 26 Jun 2019 13:49:13 +0800
Subject: [Intel-wired-lan] Opportunistic S0ix blocked by e1000e when
 ethernet is in use
In-Reply-To: <dfd57ef4-08bd-53cf-1f0a-86edc5bc0a67@intel.com>
References: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
 <E2D5225B-D683-4895-AC4F-EE01C339262B@canonical.com>
 <95f88f45-fd6c-52e4-de8c-2db1b4c6c04e@intel.com>
 <E8C45269-819C-41E0-A3D3-AA98710DBA4C@canonical.com>
 <dfd57ef4-08bd-53cf-1f0a-86edc5bc0a67@intel.com>
Message-ID: <8C7BCE85-D027-4C0C-BD46-619FAD0E6AB8@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

at 6:25 PM, Neftin, Sasha <sasha.neftin@intel.com> wrote:

> On 6/24/2019 18:06, Kai-Heng Feng wrote:
>> at 19:56, Neftin, Sasha <sasha.neftin@intel.com> wrote:
[Snipped]
> Current HW have a limitation. Please, try follow workaround on your  
> platform: echo 3 > /sys/kernel/debug/pmc_core/ltr_ignore

Yes, this does the trick.

On 4.15 based kernel I can see the SoC enters PC10 but SLP_S0 is not  
asserted.

On mainline kernel the SoC, PC10 is hit and SLP_S0 is asserted. Once SLP_S0  
is asserted the SSH connection becomes really sluggish.

>> >> S0ix support is under discussion with our architecture. We will try
>>> enable S0ix in our e1000e OOT driver as first step.
>> Is it possible to add Dynamic LTR as an option so users and downstream  
>> distros can still benefit from it?
> As I said before, this is not a stable solution. No guarantee that HW  
> will work as properly.

Can you describe the symptom of "HW will work as properly?? Is this the  
sluggish connection I observed?

Kai-Heng

>> Kai-Heng
>>>> Kai-Heng
>>>>> Kai-Heng
>>>> _______________________________________________
>>>> Intel-wired-lan mailing list
>>>> Intel-wired-lan at osuosl.org
>>>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>>
>>> Thanks
>>> Sasha


