From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 21:42:20 +0000
Subject: [Intel-wired-lan] [PATCH v4] igc: add support to interrupt,
 eeprom, registers and link self-tests
In-Reply-To: <DM6PR11MB28909C9B5CE19650132FB7B0BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
References: <20200405121604.36654-1-vitaly.lifshits@intel.com>
 <DM6PR11MB28909C9B5CE19650132FB7B0BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
Message-ID: <DM6PR11MB28904C37A37D025A95494FBBBCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Friday, May 1, 2020 2:26 PM
> To: Vitaly Lifshits <vitaly.lifshits@intel.com>; intel-wired-lan at osuosl.org
> Subject: RE: [Intel-wired-lan] [PATCH v4] igc: add support to interrupt,
> eeprom, registers and link self-tests
> 
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> > Vitaly Lifshits
> > Sent: Sunday, April 5, 2020 5:16 AM
> > To: intel-wired-lan at osuosl.org
> > Subject: [Intel-wired-lan] [PATCH v4] igc: add support to interrupt, eeprom,
> > registers and link self-tests
> >
> > Introduced igc_diag.c and igc_diag.h, these files have the
> > diagnostics functionality of igc driver. For the time being
> > these files are being used by ethtool self-test callbacks.
> > Which mean that interrupt, eeprom, registers and link self-tests for
> > ethtool were implemented.
> >
> > Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > v2: Fix return 0/1 to boolean value in igc_reg_test function
> > v3: Address community comments
> > v4: Fix interrupt test and address community comments
> > ---
> >  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
> >  drivers/net/ethernet/intel/igc/igc.h         |   4 +
> >  drivers/net/ethernet/intel/igc/igc_diag.c    | 336
> > +++++++++++++++++++++++++++
> >  drivers/net/ethernet/intel/igc/igc_diag.h    |  37 +++
> >  drivers/net/ethernet/intel/igc/igc_ethtool.c |  63 +++++
> >  drivers/net/ethernet/intel/igc/igc_main.c    |   4 +-
> >  drivers/net/ethernet/intel/igc/igc_regs.h    |   2 +
> >  7 files changed, 445 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/net/ethernet/intel/igc/igc_diag.c
> >  create mode 100644 drivers/net/ethernet/intel/igc/igc_diag.h
> >
> 
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Sorry, I was intending the apply this to a different patch.  This is the patch that enables ethtool diags, which causes the call trace I sent out earlier today.
