From: Paul Stewart <pstew@google.com>
Date: Thu, 2 Jul 2020 14:52:28 -0700
Subject: [Intel-wired-lan] ixgbe-x550 link detection after boot
In-Reply-To: <CAMcMvsh2DGng_TEzWEvizL0i=7_sh4X3qSUBkMc34oHkCFw9pA@mail.gmail.com>
References: <CAMcMvsjtsz3A+f-wA4yS7w+3dTaKO9tgCjeWPz_eAC5rMRHTNw@mail.gmail.com>
 <BYAPR11MB3606500178A5979CDCF5BCCAEF6C0@BYAPR11MB3606.namprd11.prod.outlook.com>
 <BYAPR11MB3606EAFBC4331FB21C14AEE4EF6C0@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CAMcMvsh2DGng_TEzWEvizL0i=7_sh4X3qSUBkMc34oHkCFw9pA@mail.gmail.com>
Message-ID: <CAMcMvsiJNsmhT0=YorPuvs-RovN0h4RJAV=c+0a9DT1peo_zMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

At the risk of over-sharing, I'd like to add that mail to "support at intel.com"
is bouncing.  Here's what I had sent, for the record:

Hello Intel.  I have an issue using an Atom C3708 in an SGMII backplane.
My setup:

   - CongaTec B7AC system-on-module (Atom C3708 model)
   - Connected one 10GBit port over SGMII to Marvell 88E1512 SGMII

Essentially the design is:

Embedded ARM host  -> RGMII -> Marvell 88E1512 -> SGMII -> Atom C3708

Both are running Linux 4.x (4.14.28 on ARM, 4.19.129 on the Atom).  The
system is configured so the ARM + Marvell can be powered on separately from
the Atom C3708.  Ethtool reports on the Ethernet interface:

localhost ~ # ethtool -i eth1
driver: ixgbe
version: 5.1.0-k
firmware-version: 0x8000084f
expansion-rom-version:
bus-info: 0000:0b:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

The shared EEPROM is changed on the Atom so that it is configured for
SGMII.  Therefore "lspci -nn" reports:

0b:00.0 Ethernet controller [0200]: Intel Corporation Device [8086:15c6]
(rev 11)
0b:00.1 Ethernet controller [0200]: Intel Corporation Device [8086:15c6]
(rev 11)
0c:00.0 Ethernet controller [0200]: Intel Corporation Device [8086:15c6]
(rev 11)
0c:00.1 Ethernet controller [0200]: Intel Corporation Device [8086:15c6]
(rev 11)

The scenario that works is if the ARM host + Marvell is powered and running
before the Atom starts up.  In this scenario, both sides detect link and
bidirectional communication is established.  If the ARM + Marvell is
rebooted, the Atom reports link down then back up, and communication
re-establishes.  if the Atom is rebooted, the Marvel reports link down, and
then back up, and communication re-establishes.

The scenario that doesn't work is if the Atom is powered up and fully
booted before the ARM/Marvell turns on.  At this point the ARM/Marvell
reports link up, but the Atom never reports link up, seemingly no matter
what I do apart from rebooting the Atom.  Rebooting does re-establish the
link.  Things I've tried that don't work:

   - On the Atom: ifconfig down / up
   - Rebooting the ARM/Marvell
   - On the Atom: ethtool -A eth1 autoneg off / on
   - On the Atom:
      - echo 1 > '/sys/devices/pci0000:00/0000:00:16.0/0000:0b:00.0/remove'
      - echo 1 > '/sys/devices/pci0000:00/0000:00:16.0/rescan'
      - (Driver reloads but link still not detected)

It's fairly clear from that last test that there is something stored within
the peripheral itself at startup.  Note that rebooting the Atom does
restore the link.  Are there any suggestions as to what to do in order to
establish a link short of reboot?


On Wed, Jul 1, 2020 at 4:05 PM Paul Stewart <pstew@google.com> wrote:

> Yes, I wouldn't be happy with half-duplex either.  It's not what I had in
> mind.  I don't know what exactly a "PHY" counts as in this setup -- we're
> talking about a backplane link -- SGMII to SGMII.   Both SGMII partners are
> "happy" at least to the extent that they're both driving their respective
> lanes.  It's just that the Intel side doesn't seem to be able to update its
> state, or however the firmware on the adapter is configured doesn't have it
> re-assessing its state.
>
> As to Denverton: Literally speaking this is a CongaTec B7AC
> system-on-module.  Atom(TM) CPU C3708.
>
> On Wed, Jul 1, 2020 at 3:20 PM Fujinaka, Todd <todd.fujinaka@intel.com>
> wrote:
>
>> The response I got is ?can?t do half duplex so the PHY could be happy but
>> the SGMII wont?. Put it in the actual bug tracker?.
>>
>>
>>
>> I think the best course of action is for you to contact your factory
>> support. Or if you got this retail to contact support at intel.com.
>>
>>
>>
>> ?
>>
>>
>>
>> Oh, I looked, Mr. Bloom, and I think this is probably a ?clone to lan
>> tenant and assign to the QV team? sort of thing. I?m not sure if it?s QV
>> Maciej Bucio or Tools Kamil Bednarski.
>>
>>
>>
>> *Todd Fujinaka*
>>
>> Software Application Engineer
>>
>> Data Center Group
>>
>> Intel Corporation
>>
>> *todd.fujinaka at intel.com <todd.fujinaka@intel.com>*
>>
>>
>>
>> *From:* Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> *On Behalf
>> Of *Fujinaka, Todd
>> *Sent:* Wednesday, July 1, 2020 3:03 PM
>> *To:* Paul Stewart <pstew@google.com>; intel-wired-lan at lists.osuosl.org
>> *Subject:* Re: [Intel-wired-lan] ixgbe-x550 link detection after boot
>>
>>
>>
>> That doesn?t sound right. Denverton is x553. But I don?t generally do SOC
>> so let me try to get someone else to look at this.
>>
>>
>>
>> *Todd Fujinaka*
>>
>> Software Application Engineer
>>
>> Data Center Group
>>
>> Intel Corporation
>>
>> *todd.fujinaka at intel.com <todd.fujinaka@intel.com>*
>>
>>
>>
>> *From:* Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> *On Behalf
>> Of *Paul Stewart
>> *Sent:* Wednesday, July 1, 2020 2:09 PM
>> *To:* intel-wired-lan at lists.osuosl.org
>> *Subject:* [Intel-wired-lan] ixgbe-x550 link detection after boot
>>
>>
>>
>> Hi there.  I have a system with a Denverton based chipset which has a
>> built-in 4 ports of 10GBE.  It's properly configured to enumerate
>> as 8086:15c6 (IXGBE_DEV_ID_X550EM_A_SGMII).  It also successfully detects
>> link to its backplane partner with the stock ixgbe driver, but only if that
>> partner is up and running before the driver starts up.  If the Denverton
>> chipset comes up first, nothing I've tried so far as succeeded in having
>> the chipset detect link.  I've tried the normal "ifconfig down/up",
>> "ethtool -A eth1 autoneg off" etc, but nothing so far seems to do as much
>> as just rebooting the system.  Are there any hints as to how I can get this
>> going?  I've also tried "hw->mac.ops.reset_hw(hw)" and calling
>> "hw->mac.ops.setup_link()" again from the kernel and that surprisingly
>> didn't work either, so I'm getting curious as to what can get the system to
>> re-evaluate link state.  It's really true that the Links status register
>> does not mark the link as up (as shown by ethtool -d).
>>
>>
>>
>> If it's of any consequence the SGMII link partner is a Marvell 88E1512.
>> MDIO is not connected.  For its part, the Marvell part detects link from
>> the Denverton whether or not that understanding is reciprocal.
>>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200702/621b6cb4/attachment.html>
