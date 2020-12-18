From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sat, 19 Dec 2020 00:19:22 +0100
Subject: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link
 negotiation?
In-Reply-To: <c54c8f2c-a295-c691-466e-07ae8f41b0ac@candelatech.com>
References: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
 <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
 <3bcba0ca-8f3b-8428-861a-86aaff1688b6@molgen.mpg.de>
 <c54c8f2c-a295-c691-466e-07ae8f41b0ac@candelatech.com>
Message-ID: <3c8510fb-af8c-b5f9-2af1-64584a667ac8@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[+cc Radoslaw, Aleksandr, Piotr]

Am 19.12.20 um 00:07 schrieb Ben Greear:
> On 12/18/20 11:43 AM, Paul Menzel wrote:

>> Am 18.12.20 um 20:27 schrieb Fujinaka, Todd:
>>> Yes, and I'm plugging the hole in the README right now. Here's the 
>>> proposed text:
>>>
>>> Advertisements for 2.5G and 5G on the x550 were turned off by default 
>>> due to
>>> interoperability issues with certain switches. To turn them back on, use
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
>> What commit introduced this regression. Please bear in mind, that this 
>> contradicts Linux? no-regression policy, and the commit should 
>> therefore be reverted as soon as possible.
> 
> Looks like it is at the end of this patch, though the description doesn't
> mention changing defaults:
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
