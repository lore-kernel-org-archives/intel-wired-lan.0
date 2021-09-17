From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 17 Sep 2021 10:09:52 -0500
Subject: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
In-Reply-To: <e5518a29-efe7-1d84-1671-4dc170f6bc53@twofifty.com>
Message-ID: <20210917150952.GA1716923@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 15, 2021 at 04:46:54PM -0700, Hisashi T Fujinaka wrote:
> On Wed, 15 Sep 2021, Bjorn Helgaas wrote:
> 
> > On Wed, Sep 15, 2021 at 09:16:47AM -0700, Hisashi T Fujinaka wrote:
> > > On Wed, 15 Sep 2021, Heiner Kallweit wrote:

> > > > In an earlier mail in this thread was stated that subvendor id is unknown.
> > > > Checking here https://pcisig.com/membership/member-companies?combine=1dcf
> > > > it says: Beijing Sinead Technology Co., Ltd.
> > > 
> > > Huh. I didn't realize there was an official list beyond pciids.ucw.cz.
> > > 
> > > In any case, that's who you need to talk to about the unlisted (to
> > > Linux) vendor ID and also the odd VPD data.
> > 
> > https://pci-ids.ucw.cz/ is definitely unofficial in the sense that it
> > is basically crowd-sourced data, not the "official" Vendor IDs
> > controlled by the PCI SIG.
> > 
> > I submitted an addition to https://pci-ids.ucw.cz/
> > 
> > Bjorn
> 
> Just for my edumacation, do they keep track of device IDs, subvendor IDs
> (which are probably just the same as vendor IDs), and subdevice IDs in
> the PCI SIG? Or even the branding strings?

The PCI SIG does not manage Device IDs.  That's the responsibility of
the vendor.
