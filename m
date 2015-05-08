From: Jonathan Toppins <jtoppins@cumulusnetworks.com>
Date: Fri, 08 May 2015 17:42:40 -0400
Subject: [Intel-wired-lan] [PATCH v1 net-next 1/2] igb: add PHY support
 for Broadcom 5461S
In-Reply-To: <554D2B7D.7050209@redhat.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1430999388.32618.21.camel@jtkirshe-mobl>
 <CAPg-hwmB-=fd_OjMbtL_Am5e9znX36KOnMnHNdwTMnCmQBeHPw@mail.gmail.com>
 <D38E8E86660E514AB505863C19C9287C74192484@ORSMSX102.amr.corp.intel.com>
 <CAPg-hwmQgK6fibE-=RvCxESx3TzOyHnxsG+_NC4=vE3=o3SxEg@mail.gmail.com>
 <554D2B7D.7050209@redhat.com>
Message-ID: <554D2DD0.5070008@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/8/15 5:32 PM, Alexander Duyck wrote:
>
>
> On 05/08/2015 10:46 AM, Andy Gospodarek wrote:
>> On Fri, May 8, 2015 at 12:39 PM, Ronciak, John
>> <john.ronciak@intel.com> wrote:
>>>> I think we would be willing to take on this task, but I would not
>>>> like that to be a
>>>> gating factor for upstream acceptance of the functionality added
>>>> with this
>>>> patch.  I see that Aaron has commented that no regressions were
>>>> found with
>>>> this patch, but based on current status in patchwork, it looks like
>>>> Dave is
>>>> waiting for something a bit more definitive before accepting it.
>>>> Can you ACK it
>>>> first so we have support for this platform upstream and then we can
>>>> go take a
>>>> stab at phylib support for igb?
>>> So Andy, are you wanting us to accept the patch and that you will
>>> then redo things to move to PHYlib in the near future?  What's the
>>> time line for that work?  What happens if you guys don't get around
>>> to doing it?  This can become very problematic for us as you can
>>> imagine.  This also really isn't the upstream way of doing something
>>> like this.  So I'm a bit hesitant to do it this way.
>>>
>>> Can you explain your urgency?
>>>
>>> Cheers,
>>> John
>>>
>> John,
>>
>> It is somewhat urgent as we would like to do some upstream kernel
>> development on these platforms.  I would rather not have to coach
>> everyone/constantly rebase this patch for at least one more kernel
>> release and supply it to anyone (internal to Cumulus or outside) just
>> to run net-next on these platforms.  Once this is added ONIE kernels
>> could also use a pure upstream kernel for booting and installing
>> various distros on it, so I see inclusion as a nice feature for the
>> community as well.
>>
>> I was not aware of the patch from Tim Harvey that was adding phylib
>> support into igb when I sent the first email, so that may change the
>> scope of this effort a bit.  Of course we would now be reliant on that
>> patch being included in Dave's tree before we can do our work and that
>> appears to have the status of 'changes requested' on the
>> intel-wired-lan list, so I see no guarantee that those will be added
>> by the time the merge window closes.
>>
>> Thanks,
>>
>> -andy
>
> Andy,
>
> The patch as-is seems to have a number of issues since the interface you
> are using has a misconfigured EEPROM.  If you got that addressed you
> could then probably cut down significantly on the code changes needed
> since much of it seems to be just workarounds for stuff that should have
> been taken care of in the EEPROM.  For example, the PHY address and
> external MDIO value are controlled via Initialization Control 3 & 4. The
> configuration for the hardware should be there.  The same goes for the
> LED configuration.  That is something that should start working at
> power-on, not after the driver is loaded.  I really think you should
> work to get those resolved with Quanta then it would probably make your
> driver work much easier.
>
> Also it looks like the bcm5461 is already supported by PHYdev so there
> shouldn't be much to do other than update igb to register a mii_bus, and
> with any luck the PHYdev code already implemented would take care of the
> rest (assuming the EEPROM is fixed).

Alex, appreciate your comments on the EEPROM. I forwarded them to our 
platform team to inquire on the Quanta side. The initial thinking seems 
to be Quanta is not going to change a shipping product. Is the EEPROM 
field upgradable from software or does it require a manufacturing line 
change?

-Jon

>
> - Alex

