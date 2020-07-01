From: Paul Stewart <pstew@google.com>
Date: Wed, 1 Jul 2020 16:05:45 -0700
Subject: [Intel-wired-lan] ixgbe-x550 link detection after boot
In-Reply-To: <BYAPR11MB3606EAFBC4331FB21C14AEE4EF6C0@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <CAMcMvsjtsz3A+f-wA4yS7w+3dTaKO9tgCjeWPz_eAC5rMRHTNw@mail.gmail.com>
 <BYAPR11MB3606500178A5979CDCF5BCCAEF6C0@BYAPR11MB3606.namprd11.prod.outlook.com>
 <BYAPR11MB3606EAFBC4331FB21C14AEE4EF6C0@BYAPR11MB3606.namprd11.prod.outlook.com>
Message-ID: <CAMcMvsh2DGng_TEzWEvizL0i=7_sh4X3qSUBkMc34oHkCFw9pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Yes, I wouldn't be happy with half-duplex either.  It's not what I had in
mind.  I don't know what exactly a "PHY" counts as in this setup -- we're
talking about a backplane link -- SGMII to SGMII.   Both SGMII partners are
"happy" at least to the extent that they're both driving their respective
lanes.  It's just that the Intel side doesn't seem to be able to update its
state, or however the firmware on the adapter is configured doesn't have it
re-assessing its state.

As to Denverton: Literally speaking this is a CongaTec B7AC
system-on-module.  Atom(TM) CPU C3708.

On Wed, Jul 1, 2020 at 3:20 PM Fujinaka, Todd <todd.fujinaka@intel.com>
wrote:

> The response I got is ?can?t do half duplex so the PHY could be happy but
> the SGMII wont?. Put it in the actual bug tracker?.
>
>
>
> I think the best course of action is for you to contact your factory
> support. Or if you got this retail to contact support at intel.com.
>
>
>
> ?
>
>
>
> Oh, I looked, Mr. Bloom, and I think this is probably a ?clone to lan
> tenant and assign to the QV team? sort of thing. I?m not sure if it?s QV
> Maciej Bucio or Tools Kamil Bednarski.
>
>
>
> *Todd Fujinaka*
>
> Software Application Engineer
>
> Data Center Group
>
> Intel Corporation
>
> *todd.fujinaka at intel.com <todd.fujinaka@intel.com>*
>
>
>
> *From:* Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> *On Behalf
> Of *Fujinaka, Todd
> *Sent:* Wednesday, July 1, 2020 3:03 PM
> *To:* Paul Stewart <pstew@google.com>; intel-wired-lan at lists.osuosl.org
> *Subject:* Re: [Intel-wired-lan] ixgbe-x550 link detection after boot
>
>
>
> That doesn?t sound right. Denverton is x553. But I don?t generally do SOC
> so let me try to get someone else to look at this.
>
>
>
> *Todd Fujinaka*
>
> Software Application Engineer
>
> Data Center Group
>
> Intel Corporation
>
> *todd.fujinaka at intel.com <todd.fujinaka@intel.com>*
>
>
>
> *From:* Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> *On Behalf
> Of *Paul Stewart
> *Sent:* Wednesday, July 1, 2020 2:09 PM
> *To:* intel-wired-lan at lists.osuosl.org
> *Subject:* [Intel-wired-lan] ixgbe-x550 link detection after boot
>
>
>
> Hi there.  I have a system with a Denverton based chipset which has a
> built-in 4 ports of 10GBE.  It's properly configured to enumerate
> as 8086:15c6 (IXGBE_DEV_ID_X550EM_A_SGMII).  It also successfully detects
> link to its backplane partner with the stock ixgbe driver, but only if that
> partner is up and running before the driver starts up.  If the Denverton
> chipset comes up first, nothing I've tried so far as succeeded in having
> the chipset detect link.  I've tried the normal "ifconfig down/up",
> "ethtool -A eth1 autoneg off" etc, but nothing so far seems to do as much
> as just rebooting the system.  Are there any hints as to how I can get this
> going?  I've also tried "hw->mac.ops.reset_hw(hw)" and calling
> "hw->mac.ops.setup_link()" again from the kernel and that surprisingly
> didn't work either, so I'm getting curious as to what can get the system to
> re-evaluate link state.  It's really true that the Links status register
> does not mark the link as up (as shown by ethtool -d).
>
>
>
> If it's of any consequence the SGMII link partner is a Marvell 88E1512.
> MDIO is not connected.  For its part, the Marvell part detects link from
> the Denverton whether or not that understanding is reciprocal.
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200701/14bb6d1e/attachment-0001.html>
