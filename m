From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Tue, 14 Sep 2021 18:28:24 +0000
Subject: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
In-Reply-To: <20210914142419.GA32324@codemonkey.org.uk>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
 <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
 <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com>
 <367cc748-d411-8cf8-ff95-07715c55e899@gmail.com>
 <20210914142419.GA32324@codemonkey.org.uk>
Message-ID: <CO6PR11MB5652A825C25D4675649BA43FEFDA9@CO6PR11MB5652.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wow, I'm waiting for the hardware guy to look at this but this is an off-brand 10Gtek NIC from Amazon that just has nonsense data in the VPD as far as I can tell (3's).

I'll let you know if I find out that the critical settings are bad, but I would just ignore any VPD errors.

Todd Fujinaka
Software Application Engineer
Ethernet Products Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Dave Jones <davej@codemonkey.org.uk> 
Sent: Tuesday, September 14, 2021 7:24 AM
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; linux-pci at vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; intel-wired-lan <intel-wired-lan@lists.osuosl.org>; Bjorn Helgaas <bhelgaas@google.com>; Fujinaka, Todd <todd.fujinaka@intel.com>; Hisashi T Fujinaka <htodd@twofifty.com>
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue

On Tue, Sep 14, 2021 at 07:51:22AM +0200, Heiner Kallweit wrote:
 
 > > Sorry to reply from my personal account. If I did it from my work  > > account I'd be top-posting because of Outlook and that goes over like a  > > lead balloon.
 > >
 > > Anyway, can you send us a dump of your eeprom using ethtool -e? You can  > > either send it via a bug on e1000.sourceforge.net or try sending it to  > > todd.fujinaka at intel.com  > >  > > The other thing is I'm wondering is what the subvendor device ID you  > > have is referring to because it's not in the pci database. Some ODMs  > > like getting creative with what they put in the NVM.
 > >
 > > Todd Fujinaka (todd.fujinaka at intel.com)  >  > Thanks for the prompt reply. Dave, could you please provide the requested  > information?

sent off-list.

	Dave
