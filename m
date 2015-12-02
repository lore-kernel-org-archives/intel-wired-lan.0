From: Chris Friesen <chris.friesen@windriver.com>
Date: Wed, 2 Dec 2015 09:37:43 -0600
Subject: [Intel-wired-lan] PCI ACS quirk for X710/XL710?
In-Reply-To: <1449069694.15753.31.camel@redhat.com>
References: <565DC5D4.70300@windriver.com> <565DC875.1020902@windriver.com>	
 <1448992637.15753.8.camel@redhat.com> <565DF592.7090606@windriver.com>
 <1449069694.15753.31.camel@redhat.com>
Message-ID: <565F1047.1090405@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/02/2015 09:21 AM, Alex Williamson wrote:
> On Tue, 2015-12-01 at 13:31 -0600, Chris Friesen wrote:
>> On 12/01/2015 11:57 AM, Alex Williamson wrote:
>>> On Tue, 2015-12-01 at 10:19 -0600, Chris Friesen wrote:
>>>> On 12/01/2015 10:07 AM, Chris Friesen wrote:
>>>>> Hi all,
>>>>> We've got an X710 device (PCI device 0x1572, driver version 1.3.1-k, firmware
>>>>> 4.40) and we're seeing all the ports being assigned to the same IOMMU group.
 >>>>
>>>> Looking at the datasheet (I suppose I should have done that first, sorry) it
>>>> looks like this device supports ACS.  However, we're still seeing all the ports
>>>> being placed into the same IOMMU group.
>>>
>>> Are you sure the grouping isn't caused by the root port and not the X710
>>> endpoints?  Please provide:
>>>
>>> $ find /sys/kernel/iommu_groups/ -type l
>>>
>>> $ sudo lspci -vvv
>>>
>>
>> Now that you mention it, no I'm not sure it's not caused by the root port.
>> Can you describe what to look for?
>>
>> I've got the data that you asked for.  The raw results are quite large,
>> so I trimmed the lspci output somewhat.  IOMMU groups 11 and 13 correspond
>> to the 0x1572 devices.
>>
>> I should mention that this is a 3.10-based kernel.

<data snipped>

> The root ports support ACS and so does the endpoint.  I believe this
> empty ACS capability on the endpoint should be all we need per the spec
> to indicate no internal peer-to-peer is possible.  What 3.10-based
> kernel are you using?  RHEL?  Can you see what happens with an upstream
> kernel?  Thanks,

This is our own custom kernel (Wind River Linux) based off of 
linux-stable/linux-3.10.y with additional patches applied.

I'll see about trying an upstream kernel.

Chris

