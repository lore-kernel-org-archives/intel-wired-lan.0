From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 08 May 2015 16:06:17 -0700
Subject: [Intel-wired-lan] [PATCH v1 net-next 1/2] igb: add PHY support
 for Broadcom 5461S
In-Reply-To: <554D38F8.7060500@cumulusnetworks.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1430999388.32618.21.camel@jtkirshe-mobl>
 <CAPg-hwmB-=fd_OjMbtL_Am5e9znX36KOnMnHNdwTMnCmQBeHPw@mail.gmail.com>
 <D38E8E86660E514AB505863C19C9287C74192484@ORSMSX102.amr.corp.intel.com>
 <CAPg-hwmQgK6fibE-=RvCxESx3TzOyHnxsG+_NC4=vE3=o3SxEg@mail.gmail.com>
 <554D2B7D.7050209@redhat.com> <554D2DD0.5070008@cumulusnetworks.com>
 <554D3319.8090508@redhat.com> <554D38F8.7060500@cumulusnetworks.com>
Message-ID: <554D4169.8010208@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/08/2015 03:30 PM, Jonathan Toppins wrote:
> On 5/8/15 6:05 PM, Alexander Duyck wrote:
>>
>>
>> On 05/08/2015 02:42 PM, Jonathan Toppins wrote:
>>> On 5/8/15 5:32 PM, Alexander Duyck wrote:
>>>>
>>>>
>>>> On 05/08/2015 10:46 AM, Andy Gospodarek wrote:
>>>>> On Fri, May 8, 2015 at 12:39 PM, Ronciak, John
>>>>> <john.ronciak@intel.com> wrote:
>>>>>>> I think we would be willing to take on this task, but I would not
>>>>>>> like that to be a
>>>>>>> gating factor for upstream acceptance of the functionality added
>>>>>>> with this
>>>>>>> patch.  I see that Aaron has commented that no regressions were
>>>>>>> found with
>>>>>>> this patch, but based on current status in patchwork, it looks like
>>>>>>> Dave is
>>>>>>> waiting for something a bit more definitive before accepting it.
>>>>>>> Can you ACK it
>>>>>>> first so we have support for this platform upstream and then we can
>>>>>>> go take a
>>>>>>> stab at phylib support for igb?
>>>>>> So Andy, are you wanting us to accept the patch and that you will
>>>>>> then redo things to move to PHYlib in the near future? What's the
>>>>>> time line for that work?  What happens if you guys don't get around
>>>>>> to doing it?  This can become very problematic for us as you can
>>>>>> imagine.  This also really isn't the upstream way of doing something
>>>>>> like this.  So I'm a bit hesitant to do it this way.
>>>>>>
>>>>>> Can you explain your urgency?
>>>>>>
>>>>>> Cheers,
>>>>>> John
>>>>>>
>>>>> John,
>>>>>
>>>>> It is somewhat urgent as we would like to do some upstream kernel
>>>>> development on these platforms.  I would rather not have to coach
>>>>> everyone/constantly rebase this patch for at least one more kernel
>>>>> release and supply it to anyone (internal to Cumulus or outside) just
>>>>> to run net-next on these platforms.  Once this is added ONIE kernels
>>>>> could also use a pure upstream kernel for booting and installing
>>>>> various distros on it, so I see inclusion as a nice feature for the
>>>>> community as well.
>>>>>
>>>>> I was not aware of the patch from Tim Harvey that was adding phylib
>>>>> support into igb when I sent the first email, so that may change the
>>>>> scope of this effort a bit.  Of course we would now be reliant on 
>>>>> that
>>>>> patch being included in Dave's tree before we can do our work and 
>>>>> that
>>>>> appears to have the status of 'changes requested' on the
>>>>> intel-wired-lan list, so I see no guarantee that those will be added
>>>>> by the time the merge window closes.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> -andy
>>>>
>>>> Andy,
>>>>
>>>> The patch as-is seems to have a number of issues since the 
>>>> interface you
>>>> are using has a misconfigured EEPROM.  If you got that addressed you
>>>> could then probably cut down significantly on the code changes needed
>>>> since much of it seems to be just workarounds for stuff that should 
>>>> have
>>>> been taken care of in the EEPROM.  For example, the PHY address and
>>>> external MDIO value are controlled via Initialization Control 3 & 
>>>> 4. The
>>>> configuration for the hardware should be there.  The same goes for the
>>>> LED configuration.  That is something that should start working at
>>>> power-on, not after the driver is loaded.  I really think you should
>>>> work to get those resolved with Quanta then it would probably make 
>>>> your
>>>> driver work much easier.
>>>>
>>>> Also it looks like the bcm5461 is already supported by PHYdev so there
>>>> shouldn't be much to do other than update igb to register a 
>>>> mii_bus, and
>>>> with any luck the PHYdev code already implemented would take care 
>>>> of the
>>>> rest (assuming the EEPROM is fixed).
>>>
>>> Alex, appreciate your comments on the EEPROM. I forwarded them to our
>>> platform team to inquire on the Quanta side. The initial thinking
>>> seems to be Quanta is not going to change a shipping product. Is the
>>> EEPROM field upgradable from software or does it require a
>>> manufacturing line change?
>>>
>>> -Jon
>>
>> It should be field upgradable assuming they didn't do anything too goofy
>> with the design.  If I recall correctly it can be modified via "ethtool
>> -E ".  The i350 datasheet
>> (http://www.intel.com/content/www/us/en/ethernet-controllers/ethernet-controller-i350-datasheet.html) 
>>
>> should cover Init Ctrl 3 & 4 in section 6.2 of the data sheet, that
>> piece is pretty strait forward since those are just a few single byte
>> replacements.  The tricky bit would be the PHY configuration Structure
>> (section 6.3.13) which you would probably need to take care of the LED
>> initialization at power-on.  I recall having to deal with some of this
>> when the work was done to get the external Marvell PHY working in a
>> similar configuration.  The fact is I am a bit rusty when it comes to
>> this stuff since I last worked on it several years ago so my information
>> may be out of date, and I am assuming the i354 EEPROM follows the same
>> layout as the i350 which may or may not be the case.
>>
>> - Alex
>>
>
> Alex, appreciate the info, this seems like a possible alternative and 
> something we could handle all inside our distribution. If any of your 
> other Intel friends have more recent info would much appreciate it.
>
> On the topic of phylib support, a point of clarification for me. Is 
> the thinking to ADD or USE phylib for igb? By this I mean:
> ADD == igb keeps its current phy support but adds support for using
>        phys provided by phylib.
> USE == igb uses phylib and gets rid of the phy support igb currently
>        has, this would obviously require enhancing phylib for any gaps
>        between igb phy support and phylib.
>
> ADD seems like the middle ground but from a design perspective it 
> seems like USE would be the ultimate goal. Thoughts?
>
> Thanks!
> -Jon

I agree with ADD, but it gets a bit messy.  The problem is how to split 
off the SGMII PHYs without impacting any other platforms.

My thought would be to just split off everything that uses SGMII and is 
i354 and newer.  Then that covers the cases both you and Tim Harvey 
have, but I am not sure what PHYs are in use with those devices already 
so we would need to make sure they have support in phylib.

- Alex




