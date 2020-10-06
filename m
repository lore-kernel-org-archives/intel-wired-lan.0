From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 6 Oct 2020 02:04:11 +0000
Subject: [Intel-wired-lan] [linux-firmware] ice: update package file to
 1.3.16.0
In-Reply-To: <24d88c2b9093052aa7fe5c010542f6a51732687c.camel@intel.com>
References: <20200918215024.87809-1-anthony.l.nguyen@intel.com>
 <DM6PR11MB2890A6325CB4C08893503919BC3B0@DM6PR11MB2890.namprd11.prod.outlook.com>
 <24d88c2b9093052aa7fe5c010542f6a51732687c.camel@intel.com>
Message-ID: <DM6PR11MB2890CBEC85332A00C18D4B19BC0D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Sent: Monday, October 5, 2020 9:09 AM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [linux-firmware] ice: update package file to
> 1.3.16.0
> 
> On Tue, 2020-09-22 at 21:09 +0000, Brown, Aaron F wrote:
> > > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
> > > Behalf Of
> > > Tony Nguyen
> > > Sent: Friday, September 18, 2020 2:50 PM
> > > To: intel-wired-lan at lists.osuosl.org
> > > Subject: [Intel-wired-lan] [linux-firmware] ice: update package
> > > file to 1.3.16.0
> > >
> > > Update the package file and WHENCE entry for the ice driver to
> > > version
> > > 1.3.16.0.
> > >
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > ---
> > >  WHENCE                                        |   4 ++--
> > >  .../ddp/{ice-1.3.4.0.pkg => ice-1.3.16.0.pkg} | Bin 577796 ->
> > > 659716 bytes
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >  rename intel/ice/ddp/{ice-1.3.4.0.pkg => ice-1.3.16.0.pkg} (52%)
> > >
> > > diff --git a/WHENCE b/WHENCE
> > > index 0bdb19ca938e..8b92bd39d735 100644
> > > --- a/WHENCE
> > > +++ b/WHENCE
> > > @@ -5062,8 +5062,8 @@ Licence: Redistributable. See
> > > LICENSE.amlogic_vdec
> > > for details.
> > >
> > >  Driver: ice - Intel(R) Ethernet Connection E800 Series
> > >
> > > -File: intel/ice/ddp/ice-1.3.4.0.pkg
> > > -Link: intel/ice/ddp/ice.pkg -> ice-1.3.4.0.pkg
> > > +File: intel/ice/ddp/ice-1.3.16.0.pkg
> > > +Link: intel/ice/ddp/ice.pkg -> ice-1.3.16.0.pkg
> >
> > I see the link being created in the patch, however I am not seeing it
> > in the file structure when I pull the kernel and check the
> > firmware/intel/ddp directory.  Everything else seems to work.  The
> > ddp package is there and a diff shows me it is the same ice-
> > 1.3.16.0.pkg we have been using internally.  A `copy-firmware
> > /lib/firmware/` command runs the script and places the new ddp
> > package in the correct directory, but no link to the file is
> > created.  The /lib/firmware directory still has a link to the old
> > firmware and that older firmware still gets loaded unless I go in and
> > move the link by hand.
> >
> > After moving the link to point to the new ddp package it loads and
> > functions as expected.
> 
> Hi Aaron,
> 
> There was a patch accepted [1] that changes the behavior to ensure the
> symlink is updated. If you rebase, you should get patch that properly
> updates the symlink.
> 
> Thanks,
> Tony
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-
> firmware.git/commit/?id=c1bef9e01060f157f95496f0cbd4edb7b68a3dc8

Binary image is still the expected bits and with this patch in place the script works for me in all the combinations I tried (upgrade ddp package, no ddp package, overwrite existing)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

