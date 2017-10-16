From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 16 Oct 2017 16:20:55 +0000
Subject: [Intel-wired-lan] IPSec offload - ixgbe/i40e ..
In-Reply-To: <CAKgT0UdeCPUn0G1X0Da+3bH+q7T0YZxnYUTS-q=49mG58ysG4g@mail.gmail.com>
References: <B84047ECBD981D4B93EAE5A6245AA361013EA800@FRAEML521-MBS.china.huawei.com>
 <CAKgT0UdAY+c+GPOuUtk0s_Os+JY5nPRWxSmZS3vswcJbWncPfA@mail.gmail.com>
 <B84047ECBD981D4B93EAE5A6245AA361013ECAA8@FRAEML521-MBX.china.huawei.com>
 <CAKgT0UdDt774v5O7JNrcXCAGr1TQMW-POMThhTWnjZFOcfiTHw@mail.gmail.com>
 <B84047ECBD981D4B93EAE5A6245AA361013EEDA4@FRAEML521-MBX.china.huawei.com>
 <CAKgT0UdeCPUn0G1X0Da+3bH+q7T0YZxnYUTS-q=49mG58ysG4g@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD697A3DD09@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Avi,
I would suggest you file a ticket via IPS and your factory reps, rather than asking for help on this mailing list. This would bring a lot more support for your request.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Alexander Duyck
Sent: Monday, October 16, 2017 8:26 AM
To: Avi Cohen (A) <avi.cohen@huawei.com>
Cc: intel-wired-lan at osuosl.org
Subject: Re: [Intel-wired-lan] IPSec offload - ixgbe/i40e ..

On Mon, Oct 16, 2017 at 7:58 AM, Avi Cohen (A) <avi.cohen@huawei.com> wrote:
>
>
>> -----Original Message-----
>> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
>> Sent: Monday, 16 October, 2017 5:18 PM
>> To: Avi Cohen (A)
>> Cc: intel-wired-lan at osuosl.org
>> Subject: Re: [Intel-wired-lan] IPSec offload - ixgbe/i40e ..
>>
>> On Sun, Oct 15, 2017 at 11:47 PM, Avi Cohen (A) 
>> <avi.cohen@huawei.com>
>> wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
>> >> Sent: Monday, 16 October, 2017 3:15 AM
>> >> To: Avi Cohen (A)
>> >> Cc: intel-wired-lan at osuosl.org
>> >> Subject: Re: [Intel-wired-lan] IPSec offload - ixgbe/i40e ..
>> >>
>> >> On Sun, Oct 15, 2017 at 8:12 AM, Avi Cohen (A) 
>> >> <avi.cohen@huawei.com>
>> >> wrote:
>> >> > Hi,
>> >> > These Intel  NIC's:  X540, 82599, I40E - supports IPsec offload
>> >>
>> >> X540 and 82599 are Ethernet Silicon, but i40e is just a driver. I 
>> >> assume you mean X710 or one of the parts in that product family. 
>> >> Last I knew the X710 and
>> >> XL710 do not support ipsec, only the 82599 and X540.
>> > [Avi Cohen (A)]
>> > Yes Alex - I meant the X710 family
>> >>
>> >> > But I don't see that the drivers  supplied by Intel - handle it
>> >> > (??) Can someone tell if this is supported somewhere ?
>> >> > Best Regards
>> >> > Avi
>> >>
>> >> As far as I am aware there aren't currently any drivers available 
>> >> for Linux that support ipsec offload on the X540 or 82599.
>> > [Avi Cohen (A)]
>> > I saw that these drivers are called 'base drivers' - are there other 'enhanced'
>> drivers for linux that do support the IPSec offload ?
>> > Best Regards
>> > Avi
>>
>> Hi Avi,
>>
>> The 'base' portion of things is more in reference to the driver mode 
>> more than anything else. For example we have SR-IOV support so we also have a 'VF'
>> driver.
>>
>> At this time Intel doesn't have any 'enhanced' Linux drivers that 
>> have IPSec support.
>>
>> I hope that helps to clarify the current state of things.
>>
>> - Alex
> [Avi Cohen (A)]
> Thank You Alex
> Just to clarify: for example,  the X540 NIC HW support IPSec offload, so theoretically - I can  change/add (according the device spec) the SW driver to support this. Is that correct ?
> Best Regards
> Avi

Yes, support for IPSec could be added via patches. All I was saying is that it is not currently present in the ixgbe or i40e Linux drivers that Intel has available.

- Alex
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
