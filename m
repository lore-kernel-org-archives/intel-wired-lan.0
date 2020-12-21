From: Ben Greear <greearb@candelatech.com>
Date: Mon, 21 Dec 2020 08:04:51 -0800
Subject: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link
 negotiation?
In-Reply-To: <BYAPR11MB360628704A4938C481F6EA41EFC00@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
 <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
 <3bcba0ca-8f3b-8428-861a-86aaff1688b6@molgen.mpg.de>
 <c54c8f2c-a295-c691-466e-07ae8f41b0ac@candelatech.com>
 <3c8510fb-af8c-b5f9-2af1-64584a667ac8@molgen.mpg.de>
 <BYAPR11MB36060F3889C66AE55092DA01EFC20@BYAPR11MB3606.namprd11.prod.outlook.com>
 <8635a2db-0d38-c088-321b-27bc4bb21ec4@candelatech.com>
 <MN2PR11MB3614FD0C52705864C05EFDF8EFC20@MN2PR11MB3614.namprd11.prod.outlook.com>
 <2108932e-ee2e-cadf-52cd-0cd11a6aeba4@candelatech.com>
 <BYAPR11MB3606A702240D0A1614AA6585EFC00@BYAPR11MB3606.namprd11.prod.outlook.com>
 <1d9e12e5-56a5-7921-e4b6-b67bcc180942@candelatech.com>
 <BYAPR11MB360628704A4938C481F6EA41EFC00@BYAPR11MB3606.namprd11.prod.outlook.com>
Message-ID: <3bdd2db6-bbc8-9d25-4d24-013e4382a0ef@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/21/20 7:58 AM, Fujinaka, Todd wrote:
> For the standalone driver? I can certainly ask for the change. It might take a while (knowing what's going on here) but I can champion that.
> 
> As for in-kernel, I think Intel wants to keep it this way. Not saying Intel won't be outvoted, but this is what has been demanded by the customer so far.

Out of kernel driver doesn't help me personally.

I'll let you all figure it out, will just patch my own accordingly.

Thanks for the quick response to my original query.

--Ben

> 
> Todd Fujinaka
> Software Application Engineer
> Data Center Group
> Intel Corporation
> todd.fujinaka at intel.com
> 
> -----Original Message-----
> From: Ben Greear <greearb@candelatech.com>
> Sent: Monday, December 21, 2020 7:53 AM
> To: Fujinaka, Todd <todd.fujinaka@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: intel-wired-lan at lists.osuosl.org; Greg KH <gregkh@linuxfoundation.org>
> Subject: Re: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link negotiation?
> 
> On 12/21/20 7:20 AM, Fujinaka, Todd wrote:
>> Nope. The timing of the PHYs means the switch times out while we're trying 2.5G and 5G and the switch goes to its default lowest speed of 1G. Then we go to 1G and by that time bonding is broken in several of the cases we ran into.
>>
>> Basically, we can have that switch work, or we can have 2.5G and 5G on by default. Not both. And since we're selling a 10G device with other speeds as a bonus, we're prioritizing the highest speed. That plus the very high profile customers who wanted this solution.
>>
>> The solution for one camp or the other is to use the ethtool command at boot (I've forgotten exactly what that was) but the high profile customers refused to do that. Sounds like you're refusing as well?
> 
> I'm not refusing, I just would rather patch my kernels than use ethtool, that way my older user-space would work fine on newer kernels.
> 
> Would you accept a patch that makes this a module option, defaulted to disable 2.5/5, but which a user could enabled to enable 2.5/5 by default?
> 
> I'd find that easier to use that the ethtool modification, and of course ethtool could still override things as desired.
> 
> Thanks,
> Ben
> 
>>
>> Todd Fujinaka
>> Software Application Engineer
>> Data Center Group
>> Intel Corporation
>> todd.fujinaka at intel.com
>>
>> -----Original Message-----
>> From: Ben Greear <greearb@candelatech.com>
>> Sent: Saturday, December 19, 2020 8:48 AM
>> To: Fujinaka, Todd <todd.fujinaka@intel.com>; Paul Menzel
>> <pmenzel@molgen.mpg.de>
>> Cc: intel-wired-lan at lists.osuosl.org; Greg KH
>> <gregkh@linuxfoundation.org>
>> Subject: Re: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link negotiation?
>>
>> On 12/19/20 8:19 AM, Fujinaka, Todd wrote:
>>> This is a bad case with no ideal solution. Detecting the case is not possible as autonegotiation happens in the hardware without software involvement.
>>>
>>
>> So, after it negotiates to 2.5, what happens?  Do you see lots of low-level crc errors or similar?
>> Maybe you can use that to determine link is bad and force it back to 1Gbps and re-negotiate link?
>>
>> (And with nice visible warning in dmesg about what is going on)
>>
>>> One solution was to update the switch firmware for the a switch that is is the link partner that give us the most trouble. The issue appears to be in competing or half-implemented standards. 2.5G and 5G were initially non-IEEE standards that different manufacturers hacked onto 1G in different ways. We implemented it to one of the standards which should be interoperable, but the corner case of the widely-deployed switch will take the link from 10G to 1G with no automated way to fix it.
>>>
>>> Updating switches means a lot of downtime for a lot of datacenters and the OEMs we deal with would not accept that answer.
>>>
>>> Our solution was to disable 2.5G and 5G by default. This fixes 10G linking at 1G on that switch, but 2.5G and 5G will link at 1G by default. And, as I said, I've had very little contact with people using 2.5G and 5G and I'm the guy on all the mailing lists. I apologize for making your life harder, but it seems like it's just you so far. Paul seems to be arguing with me just for the fun of it.
>>
>> Well, when things work, no one talks about it. :)
>>
>> Are you able to determine that peer is advertising 2.5, and local NIC is forced to 1G, and then put a visible warning in dmesg about this case and link to how to enable 2.5/5G rates?  That might help people realize what is going on.  And when you do this commit, put a lot of notes about why and about what commit changed things since it is not at all obvious from the original commit message.
>>
>> Thanks,
>> Ben
>>
>>>
>>> Todd Fujinaka
>>> Software Application Engineer
>>> Data Center Group
>>> Intel Corporation
>>> todd.fujinaka at intel.com
>>>
>>> -----Original Message-----
>>> From: Ben Greear <greearb@candelatech.com>
>>> Sent: Friday, December 18, 2020 4:47 PM
>>> To: Fujinaka, Todd <todd.fujinaka@intel.com>; Paul Menzel
>>> <pmenzel@molgen.mpg.de>
>>> Cc: intel-wired-lan at lists.osuosl.org; Greg KH
>>> <gregkh@linuxfoundation.org>
>>> Subject: Re: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link negotiation?
>>>
>>> On 12/18/20 4:09 PM, Fujinaka, Todd wrote:
>>>> What do you consider a regression? Having to enable 2.5G and 5G using ethtool which can be done at boot time?
>>>>
>>>> We had more than a few datacenters with issues because of competing standards. I checked with our marketing people and, on the whole, no one could think of a large number of 2.5G or 5G customers.
>>>>
>>>> We had several escalations from major OEMs and this was the solution they wanted.
>>>>
>>>> We consider this necessary for interoperability.
>>>
>>> Can you detect this case somehow and automatically fall-back to 1Gbps?
>>>
>>> For my own purposes, I will just hack that commit, but it is likely to be confusing to other people who had a system that worked at 2.5 previously and then suddenly it is slower.  There is no easy way to know from the symptom that you need to dig up an obscure readme and run an obscure ethtool command.
>>>
>>> Thanks,
>>> Ben
>>>
>>>>
>>>> Todd Fujinaka
>>>> Software Application Engineer
>>>> Data Center Group
>>>> Intel Corporation
>>>> todd.fujinaka at intel.com
>>>>
>>>> -----Original Message-----
>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>> Sent: Friday, December 18, 2020 3:19 PM
>>>> To: Ben Greear <greearb@candelatech.com>; Fujinaka, Todd
>>>> <todd.fujinaka@intel.com>
>>>> Cc: intel-wired-lan at lists.osuosl.org; Greg KH
>>>> <gregkh@linuxfoundation.org>; Nguyen, Anthony L
>>>> <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
>>>> <jesse.brandeburg@intel.com>; Tyl, RadoslawX
>>>> <radoslawx.tyl@intel.com>; Loktionov, Aleksandr
>>>> <aleksandr.loktionov@intel.com>; Mclean, Arthur F
>>>> <arthur.f.mclean@intel.com>; Skajewski, PiotrX
>>>> <piotrx.skajewski@intel.com>
>>>> Subject: Re: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link negotiation?
>>>>
>>>> [+cc Radoslaw, Aleksandr, Piotr]
>>>>
>>>> Am 19.12.20 um 00:07 schrieb Ben Greear:
>>>>> On 12/18/20 11:43 AM, Paul Menzel wrote:
>>>>
>>>>>> Am 18.12.20 um 20:27 schrieb Fujinaka, Todd:
>>>>>>> Yes, and I'm plugging the hole in the README right now. Here's
>>>>>>> the proposed text:
>>>>>>>
>>>>>>> Advertisements for 2.5G and 5G on the x550 were turned off by
>>>>>>> default due to interoperability issues with certain switches. To
>>>>>>> turn them back on, use
>>>>>>>
>>>>>>> ethtool -s <ethX> advertise N
>>>>>>>
>>>>>>> where N is a combination of the following.
>>>>>>>
>>>>>>> 100baseTFull??? 0x008
>>>>>>> 1000baseTFull?? 0x020
>>>>>>> 2500baseTFull?? 0x800000000000
>>>>>>> 5000baseTFull?? 0x1000000000000
>>>>>>> 10000baseTFull? 0x1000
>>>>>>>
>>>>>>> For example, to turn on all modes:
>>>>>>> ethtool -s <ethX> advertise 0x1800000001028
>>>>>>>
>>>>>>> For more details please see the ethtool man page.
>>>>>>
>>>>>> What commit introduced this regression. Please bear in mind, that
>>>>>> this contradicts Linux? no-regression policy, and the commit
>>>>>> should therefore be reverted as soon as possible.
>>>>>
>>>>> Looks like it is at the end of this patch, though the description
>>>>> doesn't mention changing defaults:
>>>>>
>>>>> Commit a296d665eae1e8ec6445683bfb999c884058426a
>>>>> Author: Radoslaw Tyl <radoslawx.tyl@intel.com>
>>>>> Date:?? Fri Jun 26 15:28:14 2020 +0200
>>>>>
>>>>>      ??? ixgbe: Add ethtool support to enable 2.5 and 5.0 Gbps
>>>>> support
>>>>>
>>>>>      ??? Added full support for new version Ethtool API. New API allow use
>>>>>      ??? 2500Gbase-T and 5000base-T supported and advertised link speed modes.
>>>>>
>>>>>      ??? Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
>>>>>      ??? Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
>>>>>      ??? Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>>>
>>>>> Thanks,
>>>>> Ben
>>>
>>>
>>> --
>>> Ben Greear <greearb@candelatech.com>
>>> Candela Technologies Inc  http://www.candelatech.com
>>>
>>
>>
>> --
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com
>>
> 
> 
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
