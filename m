From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 12 May 2015 15:37:16 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] net: igb: register mii_bus for
 SerDes w/ external phy
In-Reply-To: <555114B5.9060505@redhat.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
 <1430417955-28252-4-git-send-email-tharvey@gateworks.com>
 <554D5D58.4080300@gmail.com>
 <CAJ+vNU0q+MayxY6taEJNS-vr+jkQAnpVBdb-KisFHYOkNfia-Q@mail.gmail.com>
 <555114B5.9060505@redhat.com>
Message-ID: <CAJ+vNU1zFXTnaTi2ME7V6C_ucOukDwVTd3_Ne52DOz_0aHyn3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 11, 2015 at 1:44 PM, Alexander Duyck <
alexander.h.duyck@redhat.com> wrote:
> On 05/11/2015 11:42 AM, Tim Harvey wrote:
>>
>> On Fri, May 8, 2015 at 6:05 PM, Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>>>
>>> On 04/30/2015 11:19 AM, Tim Harvey wrote:
>>>>
>>>> If an i210 is configured for 1000BASE-BX link_mode and has an external
>>>> phy specified, then register an mii bus using the external phy address
>>>> as
>>>> a mask.
>>>>
>>>> An i210 hooked to an external standard phy will be configured with a
>>>> link_mode of SGMII in which case phy ops will be configured and used
>>>> internal in the igb driver for link status. However, in certain cases
>>>> one might be using a backplane SerDes connection to something that
talks
>>>> on the mdio bus but is not a standard phy, such as a switch. In this
>>>> case
>>>> by registering an mdio bus a phy driver can manage the device.
>>>>
>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>>
>>>
>>>
>>> So I think I am staring to see a pattern here between the i210 and the
>>> i354
>>> it looks like the EEPROMs for these interfaces are not getting set up
>>> correctly.  Unfortunately for the i210 you cannot change the EEPROM from
>>> ethtool so you would need to work out with your manufacturer how to get
>>> that
>>> fixed for your device.
>>
>> Alexander,
>>
>> Thanks for the review!
>>
>> I think much of my patchset is more clear if I give a bit more
>> background of how we use the i210 on our GW16083
>> (http://www.gateworks.com/product/item/ventana-gw16083-mezzanine).
>> This board is an i210 connected to a Marvell MV88E6176 6-port switch
>> via SGMII and MDIO. The MV88E6176 uses MDIO for its control access and
>> instead of having a register interface that utilizes a single phy
>> address, it uses several addresses between 0x10 and 0x1d. The link
>> between the two chips is thus 1gbps full-duplex without the need of
>> link management (why I consider it phy-less).
>
>
> Okay, so this is likely much more complicated then your original patch let
> on.  What you are actually doing is enabling phylib so that you can
enable a
> DSA switch on top of the i210 interface, do I have that right?

correct but note that the MV88E6176 data interface to the i210 is SERDES,
not SGMII.

>
<snip>
>
> The 1000BASE-KX is really meant for pure SerDes configuration where there
> will be no PHY attached at all.  So for example if you were going to
connect
> directly to another 1000BASE-KX port on either a backplane switch or
another
> adapter.  It is implied that by using this you aren't going to use the
MDIO
> interface at all.  There are essentially 3 modes that do external 1gbs
> 'phy-less' and the problem is that KX implies a special mode that is
> typically used for backplane w/o any link negotiation.  Since there is a
PHY
> like entity on the other end you would want SGMII, and in this case the
> variant that uses the MDIO registers for configuration.
>
> The 1000Base-BX was probably closer to what you had envisioned. That is
> meant to be used for pure SerDes with some sort of transceiver in between.
> As such it is normally used for configurations such as fiber since it
> supports standard 1Gb/s Ethernet over fiber.
>
> Really if you were planning to connect to an external switch or PHY that
> required MDIO configuration you should have gone with SGMII as it is
> essentially the same as the 1000Base-BX however it includes the
> configuration bits for managing an external PHY over either I2C or the
MDIO
> interfaces.
>
<snip>
>
> The problem is the link mode doesn't tell you anything other than the type
> of interface being used.  So in your case you want to advertise the
> interface as SGMII because you will want SerDes and to perform
configuration
> via the external MDIO interface.
>
>
<snip
>>>> --- a/drivers/net/ethernet/intel/igb/e1000_82575.c
>>>> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
>>>> @@ -598,13 +598,26 @@ static s32 igb_get_invariants_82575(struct
>>>> e1000_hw
>>>> *hw)
>>>>          switch (link_mode) {
>>>>          case E1000_CTRL_EXT_LINK_MODE_1000BASE_KX:
>>>>                  hw->phy.media_type = e1000_media_type_internal_serdes;
>>>> +               if (igb_sgmii_uses_mdio_82575(hw)) {
>>>> +                       u32 mdicnfg = rd32(E1000_MDICNFG);
>>>> +
>>>> +                       mdicnfg &= E1000_MDICNFG_PHY_MASK;
>>>> +                       hw->phy.addr = mdicnfg >>
>>>> E1000_MDICNFG_PHY_SHIFT;
>>>> +                       hw_dbg("1000BASE_KX w/ external MDIO device at
>>>> 0x%x\n",
>>>> +                              hw->phy.addr);
>>>> +               } else {
>>>> +                       hw_dbg("1000BASE_KX");
>>>> +               }
>>>>                  break;
>>>
>>>
<snip>
>
> The problem is KX has a very specific meaning, and is supposed to be
> reserved for backplane Ethernet connections between MACs.  It makes
> assumptions about things that could have an impact on link negotiation.
> Odds are if it is working for you it is because it is "good enough"
however
> it isn't really meant for the type of connection you are using it for.

For clarity, our whole discussion about EEPROM configuration (link-mode,
external MDIO, and phy-address) revolves around the patch above.

I initially did try to go with link-mode of SGMII but I find that
hw->phy.media_type = e1000_media_type_copper just plain doesn't work for my
configuration and I need hw->phy.media_type =
e1000_media_type_internal_serdes. That's when I realized that SERDES !=
RGMII and that the i210 SerDes interface needs to be powered up instead of
setting up the internal phy.ops.read/write/reset media-detect functions.
Even though the MV88E6176 has a phy-like interface it uses SerDes wired on
the PCB instead of link negotiation.

The MAC<->MAC case you describe 1000BASE_KX being intended for is truely
what I have but I do want an external MDIO for the purpose of phylib to the
switch. I don't know who is currently using 1000BASE_KX but if they are not
using external MDIO then my changes should not affect them and the use of
MDICNFG.Destination (what igb_sgmii_uses_mdio_82575 uses for i210) makes
sense for enabling phylib.

The way I read the use of link_mode in igb_get_invariants_82575 before my
patch is:
- 1000BASE_KX: uses internal serdes instead of copper with phy
read/write/reset hooks
- SGMII: uses copper with phy read/write/reset hooks and phy negotiation
and can be internal or external MDIO
- SERDES - reads SFP info via i2c to determine media type

I still can see the logic in using a return of -E1000_PHY_ERR from
get_invariants also as a condition for enabling phylib support and that my
be what Johnathan needs for his phy.

>
> You might try working things out with Intel to see if you get get either a
> driver quirk directly added to igb, or possibly have something added to
the
> PCI quirks in the Linux kernel.  All that really needs to happen is to
> update the KX go SGMII at driver load, or during PCI bus probe as the
value
> should be persistent through reboots.  In your EEPROM implementation did
you
> do anything that could be used to uniquely identify your device.  For
> example, is there a sub-device or sub-vendor ID registered in the PCI
> config?
>
>> We have been shipping boards for a year supported by a phylib driver
>> and it would not be easy to field update these because the i210 nvram
>> is only supported via the non-redistributable licensed eepromARMtool
>> (yuck!). One of the key U-Boot developers tried to get Intel to allow
>> him to add source to U-Boot for EEPROM programming and was denied.
>> (again... yuck!).
>
>
> Yeah, very yuck indeed.  Unfortunately you are adding PHY support to a
link
> mode that doesn't support external PHYs.  The likelihood of that causing
> regressions for other implementations is very high. That is why if nothing
> else it would be better to add a specific quirk for your i210 w/ KX than
> something that just takes all KX and converts it into something like
SGMII.
>

Assuming you are able to convince me that my EEPROM/NVRAM config 'is' wrong
and we somehow figure out how to make it work with SGMII and external PHY
support, I can see either a device-tree binding link-mode property being
added that overrides EEPROM/NVRAM or a PCI quirk/fixup working.

>
<snip>
>
> Okay, so in the case of your switch the phy_mask applies to probe only
then.
> I was thinking of traditional PHYs where there is usually only one address
> that applies to the PHY belonging to a given MAC.
>
> What you may want to do is look at adding your own igb_mii_write/read
> functions based off of something like the igb_(write/read)_phy_reg_82580
> code.  The gs40g has some very specific logic built into it to convert a
32b
> register into a page and offset which you likely don't need.  The only
> change you would need from the 82580 functions would be to add a few lines
> for configuring the MDICNFG address.

Yes this is where I need advise from people like you that know the various
chipsets supported by igb. I have no idea what is old, what is new, what is
fragile and shouldn't be touched. The igb driver is a big mysterious (hate
to say mess) of chip identifiers and its difficult to understand exactly
what Intel chipsets are supported (would love to see a list/table in
Kconfig or source!).

So I patched the generic igb_{read,write}_phy_reg_mdic to accept an addr
which are called by both igb_read_phy_reg_82580 and igb_read_phy_reg_gs40g.
I have no idea what the gs40g is, but note that
igb_{read,write}_phy_reg_gs40g are used for i210/i211 for copper media mode
phy negotiation. What enum e1000_mac_type values are capable of MDIO and
applicable for phylib? Do some/all of these have a register bit such as the
i210 MDICNFG.Destination that indicates external MDIO vs internal that can
be used?

What is the difference between an 82580 and 82585 and how do i350/i354 and
i210/i211 relate to them?

>
> I wouldn't bother with restoring the address after you have performed your
> operation.  There is always a possible scenario where something gets hung
or
> crashes in the middle of your operation and that will foul up the MDICNFG
> register.  Instead I would recommend looking at something like modifying
> igb_reset_mdicnfg_82580 as it might be preferable to have it apply to all
> hardware 82580 and newer instead of just limiting it to 82580.  That way
the
> value is restored on reset or driver load so that as long as the EEPROM is
> there you will always read the correct value.

Makes sense, but this would involve the chip information that I'm asking
for above - I only know the i210.

When you say '82580 and newer' I don't know what that means. It sounds like
your talking about various enum e1000_mac_type values.

>
>
>>>> +/* Probe the mdio bus for phys and connect them */
>>>> +static int igb_enet_mii_probe(struct net_device *netdev)
>>>> +{
>>>> +       struct igb_adapter *adapter = netdev_priv(netdev);
>>>> +       struct e1000_hw *hw = &adapter->hw;
>>>> +       struct phy_device *phy_dev = NULL;
>>>> +       int phy_id;
>>>> +
>>>> +       /* check for attached phy */
>>>> +       for (phy_id = 0; (phy_id < PHY_MAX_ADDR); phy_id++) {
>>>> +               if (hw->mii_bus->phy_map[phy_id]) {
>>>> +                       phy_dev = hw->mii_bus->phy_map[phy_id];
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>
>>>
>>> There is code that should have already figured this out in the driver.
We
>>> just need to check the PHY addr after get_invarians has been called,
>>> assuming the EEPROM is correct.  So you should be able to just get the
>>> phy.addr from the e1000_hw struct.
>>
>> It is true that in igb_enet_mii_init() where the mii bus is registered
>> with phylib that I set the phy_mask to include only the phy address
>> from the eeprom. In my case I put 0x10 in the EEPROM as the phy
>> address as that is the first phy address that the switch responds to
>> and so I use that as a way to detect the phy.
>>
>> I can remove the loop and just set phy_dev =
>> hw->mii_bus->phy_map[hw->phy.addr] in this case.
>
>
> Yes, that probably would be cleaner.

this is in my pending v2 changes

>
>
<snip>
>
> I really think you would be better off just performing any kind of check
in
> igb_probe.  Specifically if the link_mode is SGMII, and there is a PHY,
but
> it is unrecognized then we should be using phylib and should setup an
> mii_bus.  That way it should play well with other implementations such as
> the stuff the Cumulus guys will need.  Otherwise the mii_bus should not be
> configured.  Then all of the other calls can simply check to see if the
> mii_bus exists and queue off of that for the phylib calls.
>

agreed - this is in my pending v2 changes to make the decision to register
the MDIO bus in igb_probe (as a field in struct igb_adapter now) of the and
the other places that operate on it just check for a non-null
adapter->mii_bus.

>
<snip>
>
> The problem with SIOCSMIIREG is that you are basically opening the door
for
> a user-space driver of some sort to manage the PHY, or at least that is
what
> I would assume.  The Cumulus guys had a similar patch that they have
> withdrawn as it was mostly just for debugging. You might want to pull this
> block out and place it in some sort of separate patch.  You would need to
> justify why you need to expose this functionality.

agreed - I will separate this into a different patch. I think
SIOCGMIIREG/SIOCSMIIREG are useful for debugging and various userspace
tools like ethtool and others that allow direct mii register access. I'm
not clear what the general consusus is but there do seem to be many
ethernet drivers that support SIOCMIIREG including the phylib default ioctl
handler.

Regards,

Tim
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150512/8c1f0dc0/attachment-0001.html>
