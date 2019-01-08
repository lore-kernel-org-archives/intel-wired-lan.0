From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 8 Jan 2019 10:31:41 +0200
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: ignore status during
 auto-negotiation
In-Reply-To: <8b89511a-68a6-71e1-82bf-64cadfbbb0ae@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
 <1546608667-25498-1-git-send-email-glogow@fbihome.de>
 <1546608667-25498-3-git-send-email-glogow@fbihome.de>
 <67d195a8-0b04-ee72-71fb-f194c009107e@intel.com>
 <880FE4A8-009D-43BE-AB18-FD237652F497@fbihome.de>
 <bef81e20-0981-354f-ac58-5a04689b2c5b@intel.com>
 <f43ff4d1-10aa-29b0-7286-32e899df0de4@fbihome.de>
 <4f26de6f-b266-0e76-c3b8-e971d021a73e@fbihome.de>
 <de4d97aa-ab86-75e6-a6f3-8da2240acf29@intel.com>
 <8b89511a-68a6-71e1-82bf-64cadfbbb0ae@fbihome.de>
Message-ID: <5f209eda-ba57-4882-cebe-3f1bfbf0a317@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/7/2019 18:37, Jan-Marek Glogowski wrote:
> 
> 
> Am 07.01.19 um 16:49 schrieb Neftin, Sasha:
>> On 1/7/2019 16:15, Jan-Marek Glogowski wrote:
>>>
>>>
>>> Am 07.01.19 um 10:00 schrieb Jan-Marek Glogowski:
>>>>
>>>>
>>>> Am 07.01.19 um 07:32 schrieb Neftin, Sasha:
>>>>> On 1/6/2019 21:53, Jan-Marek Glogowski wrote:
>>>>>> Am 6. Januar 2019 16:28:42 MEZ schrieb "Neftin, Sasha" <sasha.neftin@intel.com>:
>>>>>>> On 1/4/2019 15:31, Jan-Marek Glogowski wrote:
>>>>>>>> My problem is the fallback of the hardware to 10 Mbps after a
>>>>>>>> re-connect, which happens almost all times. In the broken case
>>>>>>>> the status field has always the 0x40000000 bit set.
>>>>>>>>
>>>>>>>> Still the naming for the status flag is just a guess. Ignoring
>>>>>>>> the status, when this bit is set, solves my problem. But I just
>>>>>>>> have one notebook hardware (I219-LM, rev 21), which exhibits the
>>>>>>>> problem. It doesn't happen for my other notebook with I219-V
>>>>>>>> (rev 21) hardware (or it's just much more unlikely).
>>>>>>>>
>>>>>>>> Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
>>>>>>>> ---
>>>>>>>>  ??? drivers/net/ethernet/intel/e1000e/defines.h | 1 +
>>>>>>>>  ??? drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 ++-
>>>>>>>>  ??? drivers/net/ethernet/intel/e1000e/mac.c???? | 2 ++
>>>>>>>>  ??? 3 files changed, 5 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h
>>>>>>> b/drivers/net/ethernet/intel/e1000e/defines.h
>>>>>>>> index fd550de..3cd9f99 100644
>>>>>>>> --- a/drivers/net/ethernet/intel/e1000e/defines.h
>>>>>>>> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
>>>>>>>> @@ -221,6 +221,7 @@
>>>>>>>>  ??? #define E1000_STATUS_LAN_INIT_DONE 0x00000200?? /* Lan Init
>>>>>>> Completion by NVM */
>>>>>>>>  ??? #define E1000_STATUS_PHYRA????? 0x00000400????? /* PHY Reset
>>>>>>> Asserted */
>>>>>>>>  ??? #define E1000_STATUS_GIO_MASTER_ENABLE??? 0x00080000??? /* Master Req
>>>>>>> status */
>>>>>>>> +#define E1000_STATUS_AUTONEG??? 0x40000000????? /* in
>>>>>>> auto-negotiation */
>>>>>>>>      
>>>>>>> There is no such indication. Should be removed.
>>>>>>>>  ??? #define HALF_DUPLEX 1
>>>>>>>>  ??? #define FULL_DUPLEX 2
>>>>>>>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>>> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>>>> index fd59970..8588eb7 100644
>>>>>>>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>>>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>>>> @@ -1390,7 +1390,8 @@ static s32
>>>>>>> e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>>>>>>>>  ??????????? u16 speed;
>>>>>>>>  ??????????? u8 duplex;
>>>>>>>>  ??? -??????? e1000e_get_speed_and_duplex_copper(hw, &speed, &duplex);
>>>>>>>> +??????? if (e1000e_get_speed_and_duplex_copper(hw, &speed, &duplex))
>>>>>>>> +??????????? goto out;
>>>>>>>>  ??????????? tipg_reg = er32(TIPG);
>>>>>>>>  ??????????? tipg_reg &= ~E1000_TIPG_IPGT_MASK;
>>>>>>>>  ??? diff --git a/drivers/net/ethernet/intel/e1000e/mac.c
>>>>>>> b/drivers/net/ethernet/intel/e1000e/mac.c
>>>>>>>> index 19c816c..ada8fbb 100644
>>>>>>>> --- a/drivers/net/ethernet/intel/e1000e/mac.c
>>>>>>>> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
>>>>>>>> @@ -1310,6 +1310,8 @@ s32 e1000e_get_speed_and_duplex_copper(struct
>>>>>>> e1000_hw *hw, u16 *speed,
>>>>>>>>  ??? ?????? status = er32(STATUS);
>>>>>>>>  ??? +??? if (status & E1000_STATUS_AUTONEG)
>>>>>>>> +??????? return 1;
>>>>>>> This is wrong. We have no AUTONEG indication in bit 30 of E1000_STATUS
>>>>>>> (0x0008) register. These code piece should be removed.
>>>>>>>>  ??????? if (!(status & E1000_STATUS_LU))
>>>>>>>>  ??????????? return 1;
>>>>>>>>     
>>>>>>> Hello Jan-Marek,
>>>>>>> That's okay to use u8 size for a duplex indication and u16 size for a
>>>>>>> link indication, as you refer in previous patch.
>>>>>>> But use the 'autoneg status' is wrong.
>>>>>>
>>>>>> Just as a reminder: I have no idea what this bit actually indicates. This is just a guess I had
>>>>>> when looking into the problem. I don't know if the device was still negotiating at this point, but
>>>>>> this bit was set in the status register.
>>>>>>
>>>>>>> I wonder how this can solve the problem. Do you
>>>>>>> encountered with this problem on other platforms with our devices? (I meant different, no similar
>>>>>>> HW)
>>>>>>
>>>>>> Other platforms as Windows? I'm just doing Linux development, but I'll ask the Windows people and
>>>>>> can check, if this problem also happens there.
>>>>>>
>>>>>> I don't see this problem with older HW (Fujitsu E7x6, also Skylake based, but I219-V). It happens
>>>>>> with both of my U7x7 test notebooks. I have some older Haswell based HW (E7x4), which I didn't yet
>>>>>> test. Google tells me they have "Intel 82579LM Gigabit" ethernet.
>>>>>>
>>>>>> All of these three series are in use and we have a few hundred or even thousand of them. This
>>>>>> problem was found during the tests for our next Ubuntu 18.04 based release. This just seems to
>>>>>> happen with the "new" U-series. I'm not aware of any problems like this with the older E-series
>>>>>> HW.
>>>>>> And it probably just happens more often now for whatever reason.
>>>>>>
>>>>>>> Anyway, 0x40000000 indication is not relevant to the auto-negotiation.
>>>>>>> May I ask do your experiments with ME disable (via BIOS) and see if
>>>>>>> same problem still happen.
>>>>>>
>>>>>> Disabling ME shouldn't be a problem to test.
>>>>>>
>>>>> You have mentioned that there is no problem on I219-V. The main difference between I219-LM and
>>>>> I219-V is 'Intel Standard Manageability' feature. So, I suggest to disable ME and re-check.
>>>>>> I'll continue testing all the HW tomorrow, with both our releases, and report back. And maybe
>>>>>> there is an easier way to trigger the problem then re-plugging the cable all the time (maybe
>>>>>> better to get a switch and power cycle that...).
>>>>>>
>>>>>> Please tell me if there is anything else I should look for or test.
>>>>>> Further step more likely should be dump registers and try access to a
>>>>> PHY. But let's check ME disabled as the first step.
>>>>
>>>> According to the BIOS ME is actually disabled.
>>>> Nevertheless I selected "UnConfigure ME", which didn'tr change anything in the BIOS (ME
>>>> v11.8.50.3425 FWIW). I did look for vendor BIOS updates, as you think this problem might be ME
>>>> related. There is an update available.
>>>
>>> So I did the BIOS update - no changes regarding the network auto-negotiation behavior.
>>>
>>> I also tried both of my E-Series. The old Haswell series (E7x4) also has a disabled ME and as
>>> suspected the following HW:
>>>
>>> 00:19.0 Ethernet controller: Intel Corporation Ethernet Connection I217-LM (rev 04)
>>>  ???????? Subsystem: Fujitsu Limited. Ethernet Connection I217-LM
>>>  ???????? Flags: bus master, fast devsel, latency 0, IRQ 27
>>>  ???????? Memory at f0500000 (32-bit, non-prefetchable) [size=128K]
>>>  ???????? Memory at f053f000 (32-bit, non-prefetchable) [size=4K]
>>>  ???????? I/O ports at 3080 [size=32]
>>>  ???????? Capabilities: [c8] Power Management version 2
>>>  ???????? Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>  ???????? Capabilities: [e0] PCI Advanced Features
>>>  ???????? Kernel driver in use: e1000e
>>>  ???????? Kernel modules: e1000e
>>>
>>> I tried the patched module on both E-series HW and they always have the 0x40000000 bit set when
>>> decoding the speed from the status register (always 0x40080083), either with or without the ME
>>> available. So my patch breaks my older HW, as you probably suspected. I removed the 0x40000000 test
>>> from the module, and they always negotiated 1000 Mbps just fine.
>>>
>>> I've attached logs for all three notebooks with my patched module (without the? 0x40000000 test) and
>>> a debug filter for all files of the module (echo "file */e1000e-20/* +p;" >
>>> /sys/kernel/debug/dynamic_debug/control).
>>>
>>> My test consisted of rmmod'ing, sleep 1, insmod'ing, set debug filter + two reconnects.
>>>
>>> So I'm basically back to square one.
>>>
>>> How to proceed?
>>>
>> ME disabled - good. How long time you wait for 1000Mbps after a re connection of the cable? Could
>> please, wait 5-10s and see if link back to the 1000Mbps?
> 
>  From the U757 logs attached to the last mail:
> 
> [11750.669940] e1000e 0000:00:1f.6 enp0s31f6: reading PHY page 0 (or 0x0 shifted) reg 0x1
> [11750.670054] e1000e 0000:00:1f.6 enp0s31f6: reading PHY page 0 (or 0x0 shifted) reg 0x1
> [11750.670165] e1000e 0000:00:1f.6 enp0s31f6: ARC subsystem not valid.
> [11750.670166] e1000e: enp0s31f6 NIC Link is Down
> [11752.925934] e1000e 0000:00:1f.6 enp0s31f6: reading PHY page 0 (or 0x0 shifted) reg 0x1
> [11752.926065] e1000e 0000:00:1f.6 enp0s31f6: reading PHY page 0 (or 0x0 shifted) reg 0x1
> [11752.926193] e1000e 0000:00:1f.6 enp0s31f6: ARC subsystem not valid.
> ...
> [11754.813959] e1000e 0000:00:1f.6 enp0s31f6: reading PHY page 0 (or 0x0 shifted) reg 0x1
> [11754.814034] e1000e 0000:00:1f.6 enp0s31f6: reading PHY page 0 (or 0x0 shifted) reg 0x1
> [11754.814106] e1000e 0000:00:1f.6 enp0s31f6: ARC subsystem not valid.
> ...
> [11768.142020] e1000e 0000:00:1f.6 enp0s31f6: status 0x40080003 => 10 Mbps, Full Duplex
> ...
> [11768.151411] e1000e: enp0s31f6 NIC Link is Up 10 Mbps Full Duplex, Flow Control: None
> 
> Which is something about 16s.
> 
> Actually IMHO there is a larger chance to fall to 10 Mbits if you wait longer disconnected.
> Still reloading the module remedies this condition.
> 
>> Unfortunately we have no such HW in our labs. I will try ask if our PAE can help with more debug if
>> need.
> 
> Hmmm.
> 
Since you still read 0x40000000 value in the status register it is 
causing me to think that ME works. Another way I think you should to go 
ask your vendors for last updated NVM (or with ME disabled if possible) 
for your HW. Since I219V works as properly, I expected I219-LM without 
ME works too.
Let's do follow experiments on your side. Please, do rmmod e1000e.ko, 
bring up the machine without the driver. Then re-connect the cable few 
times and see what is link's speed up. You can be trusted on the LED 
indicators.
> JMG
> 
Sasha
