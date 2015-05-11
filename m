From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 11 May 2015 08:45:25 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] net: igb: add i210/i211 support
 for phy read/write
In-Reply-To: <CAJ+vNU2HFomxPd=0dds2iPHNL0gKeJ81YKA7PBS796hYM_9E0g@mail.gmail.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>	<1430417955-28252-2-git-send-email-tharvey@gateworks.com>	<554D5DB1.2000607@gmail.com>
 <CAJ+vNU2HFomxPd=0dds2iPHNL0gKeJ81YKA7PBS796hYM_9E0g@mail.gmail.com>
Message-ID: <5550CE95.206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/11/2015 08:26 AM, Tim Harvey wrote:
> On Fri, May 8, 2015 at 6:06 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>> On 04/30/2015 11:19 AM, Tim Harvey wrote:
>>> The i210/i211 uses the MDICNFG register for the phy address instead
>>> of the MDIC register.
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>
>> This patch probably is not needed.  The existing functions should work as
>> long as you have a separate means for updating the PHY addr which should
>> only need to be updated while searching for the PHY, and since the PHY isn't
>> pluggable it should probably be stored in the EEPROM.
>>
> Alexander,
>
> Thanks for the review!
>
> The i210 requires that the PHY address be in the MDICNFG register,
> whereas other earlier chips supported by the igb driver stored the phy
> in the MDIC register directly. You are probably thinking this is not
> necessary because typically you would use flash configuration control
> words to pre-load this value and that is correct. However, if we are
> to add support for phylib we need to export functions that allow a phy
> id to be passed in, and so I'm explicitly setting it up (as it was
> when the phy address was only in MDIC for earlier chips).

I think you might be interpreting things a bit to literally.  If you are 
passing only one phy address into the PHY mask which I believe you are 
via the ~(1 << phy.addr) call in your third patch there isn't much point 
in writing the PHY address since you are already locked the phylib into 
only supporting one PHY address.

>>> ---
>>>    drivers/net/ethernet/intel/igb/e1000_phy.c | 71
>>> ++++++++++++++++++++++++++----
>>>    1 file changed, 62 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c
>>> b/drivers/net/ethernet/intel/igb/e1000_phy.c
>>> index c1bb64d..2307ac6 100644
>>> --- a/drivers/net/ethernet/intel/igb/e1000_phy.c
>>> +++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
>>> @@ -135,7 +135,7 @@ out:
>>>    s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
>>>    {
>>>          struct e1000_phy_info *phy = &hw->phy;
>>> -       u32 i, mdic = 0;
>>> +       u32 i, mdicnfg, mdic = 0;
>>>          s32 ret_val = 0;
>>>
>>>          if (offset > MAX_PHY_REG_ADDRESS) {
>>> @@ -148,11 +148,25 @@ s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u32
>>> offset, u16 *data)
>>>           * Control register.  The MAC will take care of interfacing with
>>> the
>>>           * PHY to retrieve the desired data.
>>>           */
>>> -       mdic = ((offset << E1000_MDIC_REG_SHIFT) |
>>> -               (phy->addr << E1000_MDIC_PHY_SHIFT) |
>>> -               (E1000_MDIC_OP_READ));
>>> +       switch (hw->mac.type) {
>>> +       case e1000_i210:
>>> +       case e1000_i211:
>>> +               mdicnfg = rd32(E1000_MDICNFG);
>>> +               mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
>>> +               mdicnfg |= (phy->addr << E1000_MDICNFG_PHY_SHIFT);
>>> +               wr32(E1000_MDICNFG, mdicnfg);
>>> +               mdic = ((offset << E1000_MDIC_REG_SHIFT) |
>>> +                       (E1000_MDIC_OP_READ));
>>> +               break;
>>> +       default:
>>> +               mdic = ((offset << E1000_MDIC_REG_SHIFT) |
>>> +                       (phy->addr << E1000_MDIC_PHY_SHIFT) |
>>> +                       (E1000_MDIC_OP_READ));
>>> +               break;
>>> +       }
>>>
>>>          wr32(E1000_MDIC, mdic);
>>> +       wrfl();
>>>
>>>          /* Poll the ready bit to see if the MDI read completed
>>>           * Increasing the time out as testing showed failures with
>>
>> I'm not really a fan of this section of code.  Why is it that you need to be
>> able to change the phy address?  It should be something that is set once for
>> the device once you have your PHY and stays that way.
> I'm not changing the phy address - I'm putting it in the correct
> register for the i210/i211.

This code was kind of an undocumented hack.  Basically with the phy addr 
bits of the mdic register being reserved zero it didn't actually hurt 
things to write to them as the hardware has ignored them since the 82850 
if I recall correctly.

>>
>>> @@ -177,6 +191,18 @@ s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u32
>>> offset, u16 *data)
>>>          *data = (u16) mdic;
>>>
>>>    out:
>>> +       switch (hw->mac.type) {
>>> +       /* restore MDICNFG to have phy's addr */
>>> +       case e1000_i210:
>>> +       case e1000_i211:
>>> +               mdicnfg = rd32(E1000_MDICNFG);
>>> +               mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
>>> +               mdicnfg |= (hw->phy.addr << E1000_MDICNFG_PHY_SHIFT);
>>> +               wr32(E1000_MDICNFG, mdicnfg);
>>> +               break;
>>> +       default:
>>> +               break;
>>> +       }
>>>          return ret_val;
>>>    }
>>>
>>> @@ -191,7 +217,7 @@ out:
>>>    s32 igb_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>>>    {
>>>          struct e1000_phy_info *phy = &hw->phy;
>>> -       u32 i, mdic = 0;
>>> +       u32 i, mdicnfg, mdic = 0;
>>>          s32 ret_val = 0;
>>>
>>>          if (offset > MAX_PHY_REG_ADDRESS) {
>>> @@ -204,12 +230,27 @@ s32 igb_write_phy_reg_mdic(struct e1000_hw *hw, u32
>>> offset, u16 data)
>>>           * Control register.  The MAC will take care of interfacing with
>>> the
>>>           * PHY to retrieve the desired data.
>>>           */
>>> -       mdic = (((u32)data) |
>>> -               (offset << E1000_MDIC_REG_SHIFT) |
>>> -               (phy->addr << E1000_MDIC_PHY_SHIFT) |
>>> -               (E1000_MDIC_OP_WRITE));
>>> +       switch (hw->mac.type) {
>>> +       case e1000_i210:
>>> +       case e1000_i211:
>>> +               mdicnfg = rd32(E1000_MDICNFG);
>>> +               mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
>>> +               mdicnfg |= (phy->addr << E1000_MDICNFG_PHY_SHIFT);
>>> +               wr32(E1000_MDICNFG, mdicnfg);
>>> +               mdic = (((u32)data) |
>>> +                       (offset << E1000_MDIC_REG_SHIFT) |
>>> +                       (E1000_MDIC_OP_WRITE));
>>> +               break;
>>
>> You could just fall though.  The area covered by the PHY_SHIFT should be
>> read/only and will not be impacted if any value is placed there.
> The i210 Programming Interface document specifies that MDIC[25:21] are
> 'Reserved' and should be written with 0.

Yes, int this case the "should" is not a must, and writing something to 
it has no effect.  That is why the legacy code was left in place to 
write to the register.

> I would tend to agree that these bits are likely ignored on the
> i210/i211 but I'm just following the documentation here and not
> chancing it. If its agree'd that I don't need to do this, I can
> simplify the code by falling through.
>
> I can also rename the mdic to reg and use it for both registers if its
> desired to not have an additional variable on the stack.

The fact is this was how it was done before you modified the code. If 
anything changing it at this point risks introducing regressions.  If 
you look in the documentation the MDICNFG register has been around since 
the 82580.  There was one errata against the 82580 that required 
rewriting the register after reset, but the implementations of hardware 
since then have wanted to leave this register value static.

>>> +       default:
>>> +               mdic = (((u32)data) |
>>> +                       (offset << E1000_MDIC_REG_SHIFT) |
>>> +                       (phy->addr << E1000_MDIC_PHY_SHIFT) |
>>> +                       (E1000_MDIC_OP_WRITE));
>>> +               break;
>>> +       }
>>>
>>>          wr32(E1000_MDIC, mdic);
>>> +       wrfl();
>>>
>>>          /* Poll the ready bit to see if the MDI read completed
>>>           * Increasing the time out as testing showed failures with
>>
>> Same thing for this one.  You shouldn't need to do anything fancy to write
>> it.
>>
>>> @@ -233,6 +274,18 @@ s32 igb_write_phy_reg_mdic(struct e1000_hw *hw, u32
>>> offset, u16 data)
>>>          }
>>>
>>>    out:
>>> +       switch (hw->mac.type) {
>>> +       /* restore MDICNFG to have phy's addr */
>>> +       case e1000_i210:
>>> +       case e1000_i211:
>>> +               mdicnfg = rd32(E1000_MDICNFG);
>>> +               mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
>>> +               mdicnfg |= (hw->phy.addr << E1000_MDICNFG_PHY_SHIFT);
>>> +               wr32(E1000_MDICNFG, mdicnfg);
>>> +               break;
>>> +       default:
>>> +               break;
>>> +       }
>>>          return ret_val;
>>>    }
>>>
>>>
>> This bit doesn't add any value.  You could definitely drop this.
> This is likely more relevant to the 2nd patch that allows a phy
> address to be passed in.
>
> Tim

What I was trying to get at is in the 3rd patch you pretty much locked 
down the PHY address by setting a mask that excludes everything but the 
address contained in the MDICNFG register.  So instead of rewriting the 
register every time you access the PHY you could probably just skip 
these first two patches, and ignore the PHY address passed to you from 
phylib.

- Alex
