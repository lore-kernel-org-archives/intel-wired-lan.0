From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Mon, 11 May 2015 13:44:37 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] net: igb: register mii_bus for
 SerDes w/ external phy
In-Reply-To: <CAJ+vNU0q+MayxY6taEJNS-vr+jkQAnpVBdb-KisFHYOkNfia-Q@mail.gmail.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
 <1430417955-28252-4-git-send-email-tharvey@gateworks.com>
 <554D5D58.4080300@gmail.com>
 <CAJ+vNU0q+MayxY6taEJNS-vr+jkQAnpVBdb-KisFHYOkNfia-Q@mail.gmail.com>
Message-ID: <555114B5.9060505@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/11/2015 11:42 AM, Tim Harvey wrote:
> On Fri, May 8, 2015 at 6:05 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>> On 04/30/2015 11:19 AM, Tim Harvey wrote:
>>> If an i210 is configured for 1000BASE-BX link_mode and has an external
>>> phy specified, then register an mii bus using the external phy address as
>>> a mask.
>>>
>>> An i210 hooked to an external standard phy will be configured with a
>>> link_mode of SGMII in which case phy ops will be configured and used
>>> internal in the igb driver for link status. However, in certain cases
>>> one might be using a backplane SerDes connection to something that talks
>>> on the mdio bus but is not a standard phy, such as a switch. In this case
>>> by registering an mdio bus a phy driver can manage the device.
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>
>>
>> So I think I am staring to see a pattern here between the i210 and the i354
>> it looks like the EEPROMs for these interfaces are not getting set up
>> correctly.  Unfortunately for the i210 you cannot change the EEPROM from
>> ethtool so you would need to work out with your manufacturer how to get that
>> fixed for your device.
> Alexander,
>
> Thanks for the review!
>
> I think much of my patchset is more clear if I give a bit more
> background of how we use the i210 on our GW16083
> (http://www.gateworks.com/product/item/ventana-gw16083-mezzanine).
> This board is an i210 connected to a Marvell MV88E6176 6-port switch
> via SGMII and MDIO. The MV88E6176 uses MDIO for its control access and
> instead of having a register interface that utilizes a single phy
> address, it uses several addresses between 0x10 and 0x1d. The link
> between the two chips is thus 1gbps full-duplex without the need of
> link management (why I consider it phy-less).

Okay, so this is likely much more complicated then your original patch 
let on.  What you are actually doing is enabling phylib so that you can 
enable a DSA switch on top of the i210 interface, do I have that right?

> I configured the EEPROM with the following details:
>   - link-mode: 1000BASE-KX for phy-less operation
>   - external-mdio
>   - phy_addr 0x10 (the first one used by the MV88E6176 and the one that
> maps more closely to standard phy registers than any others)
>   - device_id: 0x157C (SerDes flashless - looking back perhaps this
> should have been 0x1537 but then this isn't used in igb to distinguish
> any details so its a don't-care)
>
> The i210 datasheet defines the following link-modes:
> 0 - Internal PHY
> 1 - 1000BASE-KX
> 2 - SGMII
> 3 - SerDes/1000BASE-BX
>
> The differences are still not crystal clear to me and is really all
> about how the igb driver uses this value. When I wrote support for the
> GW16083 a year ago I sent out a query to the e1000-devel list
> regarding link_mode and how I should proceed but I received no reply's
> (http://permalink.gmane.org/gmane.linux.drivers.e1000.devel/13942) and
> unfortunately am only now getting back to a point of having any
> bandwidth to try to mainline my changes.

It looks like you are learning the same lesson many have when it comes 
to this kind of stuff.  Upstream first is usually a much better policy 
because then you figure out all of these issues much earlier and you 
aren't stuck supporting something that has implementation issues you 
weren't aware of.

> I would have to dig a bit to find where I got this info but my
> understanding was that 1000BASE-KX was for fixed 1gbps 'phy-less'
> SerDes links (requiring no link negotiation) and because I have the
> i210 connected in to a port on the MV88E6176 that is always 1gpbs
> full-duplex this made sense to me to let the driver treat it as
> 'phy-less'.

The 1000BASE-KX is really meant for pure SerDes configuration where 
there will be no PHY attached at all.  So for example if you were going 
to connect directly to another 1000BASE-KX port on either a backplane 
switch or another adapter.  It is implied that by using this you aren't 
going to use the MDIO interface at all.  There are essentially 3 modes 
that do external 1gbs 'phy-less' and the problem is that KX implies a 
special mode that is typically used for backplane w/o any link 
negotiation.  Since there is a PHY like entity on the other end you 
would want SGMII, and in this case the variant that uses the MDIO 
registers for configuration.

The 1000Base-BX was probably closer to what you had envisioned. That is 
meant to be used for pure SerDes with some sort of transceiver in 
between.  As such it is normally used for configurations such as fiber 
since it supports standard 1Gb/s Ethernet over fiber.

Really if you were planning to connect to an external switch or PHY that 
required MDIO configuration you should have gone with SGMII as it is 
essentially the same as the 1000Base-BX however it includes the 
configuration bits for managing an external PHY over either I2C or the 
MDIO interfaces.

>> As far as the code below I think there may be an easy way to work around a
>> bunch of this code.  The quick trick for most of this would be to update
>> igb_init_phy_params_82575 to return a new value, maybe make up something
>> like E1000_ERR_PHY_UNKNOWN when the PHY ID is unrecognized. Then you could
>> add the phylib code as a handler for if you encounter that error code.
> Are you sure this shouldn't be based off of link mode? It seems to me
> that if your link-mode indicates an external phy then this is exactly
> when you would want to register an mii bus with phylib. However, also
> doing so as a fallback if PHY ID can't be recognized also makes sense
> in general for perhaps boards with mis-programmed EEPROM's.

The problem is the link mode doesn't tell you anything other than the 
type of interface being used.  So in your case you want to advertise the 
interface as SGMII because you will want SerDes and to perform 
configuration via the external MDIO interface.

>>> ---
>>>    drivers/net/ethernet/intel/igb/e1000_82575.c |  16 +++
>>>    drivers/net/ethernet/intel/igb/e1000_hw.h    |   7 ++
>>>    drivers/net/ethernet/intel/igb/igb_main.c    | 163
>>> ++++++++++++++++++++++++++-
>>>    3 files changed, 181 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c
>>> b/drivers/net/ethernet/intel/igb/e1000_82575.c
>>> index d2afd7b..e80617b 100644
>>> --- a/drivers/net/ethernet/intel/igb/e1000_82575.c
>>> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
>>> @@ -598,13 +598,26 @@ static s32 igb_get_invariants_82575(struct e1000_hw
>>> *hw)
>>>          switch (link_mode) {
>>>          case E1000_CTRL_EXT_LINK_MODE_1000BASE_KX:
>>>                  hw->phy.media_type = e1000_media_type_internal_serdes;
>>> +               if (igb_sgmii_uses_mdio_82575(hw)) {
>>> +                       u32 mdicnfg = rd32(E1000_MDICNFG);
>>> +
>>> +                       mdicnfg &= E1000_MDICNFG_PHY_MASK;
>>> +                       hw->phy.addr = mdicnfg >> E1000_MDICNFG_PHY_SHIFT;
>>> +                       hw_dbg("1000BASE_KX w/ external MDIO device at
>>> 0x%x\n",
>>> +                              hw->phy.addr);
>>> +               } else {
>>> +                       hw_dbg("1000BASE_KX");
>>> +               }
>>>                  break;
>>
>> You should not be running SGMII under KX mode.  If you are then you have an
>> EEPROM bug.  The correct link mode is SGMII below.  Unfortunately you would
>> need to check with your vendor on that one as I believe the EEPROMs for
>> i210/i211 parts are not writable via ethtool.
>>
>> As for a hack workaround for now what you could do is use a
>> !igb_sgmii_uses_mdio_82575() check to determine if you want to break, or to
>> clear the LINK_MODE field and rewrite it as SGMII and then just fall though
>> to SGMII which will help to clear up many issues you are probably seeing.
>> You might keep that as a separate local patch until you can get the EEPROM
>> issue resolved.
> I certainly hope this isn't considered an EEPROM programming issue
> because at the time I could get no clarification from the community or
> my Intel FAE on what mode we should be using (the FAE understandably
> likely didn't know because this is an implementation detail within the
> driver the way I see it).

The problem is KX has a very specific meaning, and is supposed to be 
reserved for backplane Ethernet connections between MACs.  It makes 
assumptions about things that could have an impact on link negotiation.  
Odds are if it is working for you it is because it is "good enough" 
however it isn't really meant for the type of connection you are using 
it for.

You might try working things out with Intel to see if you get get either 
a driver quirk directly added to igb, or possibly have something added 
to the PCI quirks in the Linux kernel.  All that really needs to happen 
is to update the KX go SGMII at driver load, or during PCI bus probe as 
the value should be persistent through reboots.  In your EEPROM 
implementation did you do anything that could be used to uniquely 
identify your device.  For example, is there a sub-device or sub-vendor 
ID registered in the PCI config?

> We have been shipping boards for a year supported by a phylib driver
> and it would not be easy to field update these because the i210 nvram
> is only supported via the non-redistributable licensed eepromARMtool
> (yuck!). One of the key U-Boot developers tried to get Intel to allow
> him to add source to U-Boot for EEPROM programming and was denied.
> (again... yuck!).

Yeah, very yuck indeed.  Unfortunately you are adding PHY support to a 
link mode that doesn't support external PHYs.  The likelihood of that 
causing regressions for other implementations is very high. That is why 
if nothing else it would be better to add a specific quirk for your i210 
w/ KX than something that just takes all KX and converts it into 
something like SGMII.

>>> +static int igb_enet_mdio_write(struct mii_bus *bus, int mii_id, int
>>> regnum,
>>> +                              u16 val)
>>> +{
>>> +       struct e1000_hw *hw = bus->priv;
>>> +
>>> +       return igb_write_reg_gs40g(hw, mii_id, regnum, val);
>>> +}
>>> +
>>
>> There shouldn't be any need to actually pass the PHY address assuming you
>> let the driver code take care of pulling the address of the PHY from the
>> EEPROM before hand.  As such you can probably just not use the mii_id value.
> Again, the reason for not using the address from the EEPROM is this
> use case where there is not a single phy address. This is also why I'm
> patching the mdio read/write functions to take a parameter instead of
> using the internal value (and creating wrappers for when they are used
> internally in igb).

Okay, so in the case of your switch the phy_mask applies to probe only 
then.  I was thinking of traditional PHYs where there is usually only 
one address that applies to the PHY belonging to a given MAC.

What you may want to do is look at adding your own igb_mii_write/read 
functions based off of something like the igb_(write/read)_phy_reg_82580 
code.  The gs40g has some very specific logic built into it to convert a 
32b register into a page and offset which you likely don't need.  The 
only change you would need from the 82580 functions would be to add a 
few lines for configuring the MDICNFG address.

I wouldn't bother with restoring the address after you have performed 
your operation.  There is always a possible scenario where something 
gets hung or crashes in the middle of your operation and that will foul 
up the MDICNFG register.  Instead I would recommend looking at something 
like modifying igb_reset_mdicnfg_82580 as it might be preferable to have 
it apply to all hardware 82580 and newer instead of just limiting it to 
82580.  That way the value is restored on reset or driver load so that 
as long as the EEPROM is there you will always read the correct value.

>>> +/* Probe the mdio bus for phys and connect them */
>>> +static int igb_enet_mii_probe(struct net_device *netdev)
>>> +{
>>> +       struct igb_adapter *adapter = netdev_priv(netdev);
>>> +       struct e1000_hw *hw = &adapter->hw;
>>> +       struct phy_device *phy_dev = NULL;
>>> +       int phy_id;
>>> +
>>> +       /* check for attached phy */
>>> +       for (phy_id = 0; (phy_id < PHY_MAX_ADDR); phy_id++) {
>>> +               if (hw->mii_bus->phy_map[phy_id]) {
>>> +                       phy_dev = hw->mii_bus->phy_map[phy_id];
>>> +                       break;
>>> +               }
>>> +       }
>>
>> There is code that should have already figured this out in the driver. We
>> just need to check the PHY addr after get_invarians has been called,
>> assuming the EEPROM is correct.  So you should be able to just get the
>> phy.addr from the e1000_hw struct.
> It is true that in igb_enet_mii_init() where the mii bus is registered
> with phylib that I set the phy_mask to include only the phy address
> from the eeprom. In my case I put 0x10 in the EEPROM as the phy
> address as that is the first phy address that the switch responds to
> and so I use that as a way to detect the phy.
>
> I can remove the loop and just set phy_dev =
> hw->mii_bus->phy_map[hw->phy.addr] in this case.

Yes, that probably would be cleaner.

>
>>
>>> +       if (!phy_dev) {
>>> +               netdev_err(netdev, "no PHY found\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       hw->phy_interface = PHY_INTERFACE_MODE_RGMII;
>>> +       phy_dev = phy_connect(netdev, dev_name(&phy_dev->dev),
>>> +                             igb_enet_mii_link, hw->phy_interface);
>>> +       if (IS_ERR(phy_dev)) {
>>> +               netdev_err(netdev, "could not attach to PHY\n");
>>> +               return PTR_ERR(phy_dev);
>>> +       }
>>> +
>>> +       hw->phy_dev = phy_dev;
>>> +       netdev_info(netdev, "igb PHY driver [%s] (mii_bus:phy_addr=%s)\n",
>>> +                   hw->phy_dev->drv->name, dev_name(&hw->phy_dev->dev));
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +/* Create and register mdio bus */
>>> +static int igb_enet_mii_init(struct pci_dev *pdev)
>>> +{
>>> +       struct mii_bus *mii_bus;
>>> +       struct net_device *netdev = pci_get_drvdata(pdev);
>>> +       struct igb_adapter *adapter = netdev_priv(netdev);
>>> +       struct e1000_hw *hw = &adapter->hw;
>>> +       int err;
>>> +
>>> +       mii_bus = mdiobus_alloc();
>>> +       if (!mii_bus) {
>>> +               err = -ENOMEM;
>>> +               goto err_out;
>>> +       }
>>> +
>>> +       mii_bus->name = "igb_enet_mii_bus";
>>> +       mii_bus->read = igb_enet_mdio_read;
>>> +       mii_bus->write = igb_enet_mdio_write;
>>> +       mii_bus->reset = igb_enet_mdio_reset;
>>> +       snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
>>> +                pci_name(pdev), hw->device_id + 1);
>>> +       mii_bus->priv = hw;
>>> +       mii_bus->parent = &pdev->dev;
>>> +       mii_bus->phy_mask = ~(1 << hw->phy.addr);
>>> +
>>> +       err = mdiobus_register(mii_bus);
>>> +       if (err) {
>>> +               netdev_err(netdev, "failed to register mii_bus: %d\n",
>>> err);
>>> +               goto err_out_free_mdiobus;
>>> +       }
>>> +       hw->mii_bus = mii_bus;
>>> +
>>> +       return 0;
>>> +
>>> +err_out_free_mdiobus:
>>> +       mdiobus_free(mii_bus);
>>> +err_out:
>>> +       return err;
>>> +}
>>> +
>>> +static void igb_enet_mii_remove(struct e1000_hw *hw)
>>> +{
>>> +       if (hw->mii_bus) {
>>> +               mdiobus_unregister(hw->mii_bus);
>>> +               mdiobus_free(hw->mii_bus);
>>> +       }
>>> +}
>>> +#endif /* CONFIG_PHYLIB */
>>> +
>>>    /**
>>>     *  igb_probe - Device Initialization Routine
>>>     *  @pdev: PCI device information struct
>>> @@ -2645,6 +2761,13 @@ static int igb_probe(struct pci_dev *pdev, const
>>> struct pci_device_id *ent)
>>>                  }
>>>          }
>>>          pm_runtime_put_noidle(&pdev->dev);
>>> +
>>> +#ifdef CONFIG_PHYLIB
>>> +       /* create and register the mdio bus if using ext phy */
>>> +       if (rd32(E1000_MDICNFG) & E1000_MDICNFG_EXT_MDIO)
>>> +               igb_enet_mii_init(pdev);
>>> +#endif
>>> +
>>>          return 0;
>>>
>>>    err_register:
>>
>> The MDICNFG register doesn't exist for all devices as I recall.  What you
>> may want to do is make enabling the mii_bus optional dependent on
>> get_invariants returning an error that the PHY is not recognized.
>>
>>> @@ -2788,6 +2911,10 @@ static void igb_remove(struct pci_dev *pdev)
>>>          struct e1000_hw *hw = &adapter->hw;
>>>
>>>          pm_runtime_get_noresume(&pdev->dev);
>>> +#ifdef CONFIG_PHYLIB
>>> +       if (rd32(E1000_MDICNFG) & E1000_MDICNFG_EXT_MDIO)
>>> +               igb_enet_mii_remove(hw);
>>> +#endif
>>>    #ifdef CONFIG_IGB_HWMON
>>>          igb_sysfs_exit(adapter);
>>>    #endif
>>
>> Same thing here.  I would say what you could do is just check to see if a
>> mii_bus is allocated and if so remove it.  You could probably push the check
>> inside of igb_mii_remove.
>>
>>> @@ -3093,6 +3220,12 @@ static int __igb_open(struct net_device *netdev,
>>> bool resuming)
>>>          if (!resuming)
>>>                  pm_runtime_put(&pdev->dev);
>>>
>>> +#ifdef CONFIG_PHYLIB
>>> +       /* Probe and connect to PHY if using ext phy */
>>> +       if (rd32(E1000_MDICNFG) & E1000_MDICNFG_EXT_MDIO)
>>> +               igb_enet_mii_probe(netdev);
>>> +#endif
>>> +
>>>          /* start the watchdog. */
>>>          hw->mac.get_link_status = 1;
>>>          schedule_work(&adapter->watchdog_task);
>>
>> Same here, use the existance of a mii_bus, not the register check.
>>
> This goes back to the discussion on how to decide if we should
> register with phylib and will depend on how that discussion plays out.
> There are about 4 places I need to know if we're using phylib and
> whatever mechanism is agree'd upon can be used in all these cases:
>   igb_probe() - register the mii bus with phylib
>   igb_remove() - remove the mii bus
>   igb_open() - to call the mii probe
>   igb_mii_ioctl() - to know to use the mdio read/write wrappers

I really think you would be better off just performing any kind of check 
in igb_probe.  Specifically if the link_mode is SGMII, and there is a 
PHY, but it is unrecognized then we should be using phylib and should 
setup an mii_bus.  That way it should play well with other 
implementations such as the stuff the Cumulus guys will need.  Otherwise 
the mii_bus should not be configured.  Then all of the other calls can 
simply check to see if the mii_bus exists and queue off of that for the 
phylib calls.

>>> @@ -7127,21 +7260,41 @@ void igb_alloc_rx_buffers(struct igb_ring
>>> *rx_ring, u16 cleaned_count)
>>>    static int igb_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
>>> int cmd)
>>>    {
>>>          struct igb_adapter *adapter = netdev_priv(netdev);
>>> +       struct e1000_hw *hw = &adapter->hw;
>>>          struct mii_ioctl_data *data = if_mii(ifr);
>>>
>>> -       if (adapter->hw.phy.media_type != e1000_media_type_copper)
>>> +       if (adapter->hw.phy.media_type != e1000_media_type_copper &&
>>> +           !(rd32(E1000_MDICNFG) & E1000_MDICNFG_EXT_MDIO))
>>>                  return -EOPNOTSUPP;
>>>
>>>          switch (cmd) {
>>>          case SIOCGMIIPHY:
>>> -               data->phy_id = adapter->hw.phy.addr;
>>> +               data->phy_id = hw->phy.addr;
>>>                  break;
>>>          case SIOCGMIIREG:
>>> -               if (igb_read_phy_reg(&adapter->hw, data->reg_num & 0x1F,
>>> -                                    &data->val_out))
>>> -                       return -EIO;
>>> +               if (hw->mac.type == e1000_i210 || hw->mac.type ==
>>> e1000_i211) {
>>> +                       if (igb_read_reg_gs40g(&adapter->hw, data->phy_id,
>>> +                                              data->reg_num & 0x1F,
>>> +                                              &data->val_out))
>>> +                               return -EIO;
>>> +               } else {
>>> +                       if (igb_read_phy_reg(&adapter->hw, data->reg_num &
>>> 0x1F,
>>> +                                            &data->val_out))
>>> +                               return -EIO;
>>> +               }
>>>                  break;
>>>          case SIOCSMIIREG:
>>> +               if (hw->mac.type == e1000_i210 || hw->mac.type ==
>>> e1000_i211) {
>>> +                       if (igb_write_reg_gs40g(hw, data->phy_id,
>>> +                                               data->reg_num & 0x1F,
>>> +                                               data->val_in))
>>> +                               return -EIO;
>>> +               } else {
>>> +                       if (igb_write_phy_reg(hw, data->reg_num & 0x1F,
>>> +                                             data->val_in))
>>> +                               return -EIO;
>>> +               }
>>> +               break;
>>>          default:
>>>                  return -EOPNOTSUPP;
>>>          }
>>>
>> These changes just shouldn't be needed.  I'd say they could be dropped.  The
>> phy_id should be static and configured by the hardware before the driver is
>> even loaded.
> The above also adds SIOCGMIIREG which previously was not supported,
> but I also need to allow multiple phy addresses here and thus can't
> just default to igb_write_phy_reg() which uses the single phy addr
> from the EEPROM (unless I move multi-addr support there).
>
> Tim

The problem with SIOCSMIIREG is that you are basically opening the door 
for a user-space driver of some sort to manage the PHY, or at least that 
is what I would assume.  The Cumulus guys had a similar patch that they 
have withdrawn as it was mostly just for debugging. You might want to 
pull this block out and place it in some sort of separate patch.  You 
would need to justify why you need to expose this functionality.
