From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Sat, 19 Dec 2020 00:09:15 +0000
Subject: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link
 negotiation?
In-Reply-To: <3c8510fb-af8c-b5f9-2af1-64584a667ac8@molgen.mpg.de>
References: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
 <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
 <3bcba0ca-8f3b-8428-861a-86aaff1688b6@molgen.mpg.de>
 <c54c8f2c-a295-c691-466e-07ae8f41b0ac@candelatech.com>
 <3c8510fb-af8c-b5f9-2af1-64584a667ac8@molgen.mpg.de>
Message-ID: <BYAPR11MB36060F3889C66AE55092DA01EFC20@BYAPR11MB3606.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

What do you consider a regression? Having to enable 2.5G and 5G using ethtool which can be done at boot time?

We had more than a few datacenters with issues because of competing standards. I checked with our marketing people and, on the whole, no one could think of a large number of 2.5G or 5G customers.

We had several escalations from major OEMs and this was the solution they wanted.

We consider this necessary for interoperability.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Paul Menzel <pmenzel@molgen.mpg.de> 
Sent: Friday, December 18, 2020 3:19 PM
To: Ben Greear <greearb@candelatech.com>; Fujinaka, Todd <todd.fujinaka@intel.com>
Cc: intel-wired-lan at lists.osuosl.org; Greg KH <gregkh@linuxfoundation.org>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; Tyl, RadoslawX <radoslawx.tyl@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Mclean, Arthur F <arthur.f.mclean@intel.com>; Skajewski, PiotrX <piotrx.skajewski@intel.com>
Subject: Re: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link negotiation?

[+cc Radoslaw, Aleksandr, Piotr]

Am 19.12.20 um 00:07 schrieb Ben Greear:
> On 12/18/20 11:43 AM, Paul Menzel wrote:

>> Am 18.12.20 um 20:27 schrieb Fujinaka, Todd:
>>> Yes, and I'm plugging the hole in the README right now. Here's the 
>>> proposed text:
>>>
>>> Advertisements for 2.5G and 5G on the x550 were turned off by 
>>> default due to interoperability issues with certain switches. To 
>>> turn them back on, use
>>>
>>> ethtool -s <ethX> advertise N
>>>
>>> where N is a combination of the following.
>>>
>>> 100baseTFull??? 0x008
>>> 1000baseTFull?? 0x020
>>> 2500baseTFull?? 0x800000000000
>>> 5000baseTFull?? 0x1000000000000
>>> 10000baseTFull? 0x1000
>>>
>>> For example, to turn on all modes:
>>> ethtool -s <ethX> advertise 0x1800000001028
>>>
>>> For more details please see the ethtool man page.
>>
>> What commit introduced this regression. Please bear in mind, that 
>> this contradicts Linux? no-regression policy, and the commit should 
>> therefore be reverted as soon as possible.
> 
> Looks like it is at the end of this patch, though the description 
> doesn't mention changing defaults:
> 
> Commit a296d665eae1e8ec6445683bfb999c884058426a
> Author: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Date:?? Fri Jun 26 15:28:14 2020 +0200
> 
>  ??? ixgbe: Add ethtool support to enable 2.5 and 5.0 Gbps support
> 
>  ??? Added full support for new version Ethtool API. New API allow use
>  ??? 2500Gbase-T and 5000base-T supported and advertised link speed modes.
> 
>  ??? Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
>  ??? Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
>  ??? Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Thanks,
> Ben
