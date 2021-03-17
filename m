From: Chen, BoX C <box.c.chen@intel.com>
Date: Wed, 17 Mar 2021 01:27:48 +0000
Subject: [Intel-wired-lan] [Patch v5 14/18] iavf: Add framework to
 enable ethtool ntuple filters
In-Reply-To: <BN8PR11MB3795316912F7B9B28CA10566F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-15-haiyue.wang@intel.com>
 <BN8PR11MB3795316912F7B9B28CA10566F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
Message-ID: <SN6PR11MB3101FEEFAEAEA81F3DCC6439D96A9@SN6PR11MB3101.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: March 17, 2021 0:30
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>; Liang, Cunming
> <cunming.liang@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Chen, BoX C <box.c.chen@intel.com>
> Subject: RE: [Patch v5 14/18] iavf: Add framework to enable ethtool ntuple
> filters
> 
> > -----Original Message-----
> > From: Wang, Haiyue <haiyue.wang@intel.com>
> > Sent: Tuesday, March 9, 2021 11:08
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Zhang, Qi Z <qi.z.zhang@intel.com>; Liang, Cunming
> > <cunming.liang@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Wang, Haiyue <haiyue.wang@intel.com>
> > Subject: [Patch v5 14/18] iavf: Add framework to enable ethtool ntuple
> > filters
> >
> > Enable ethtool ntuple filter support on the VF driver using the
> > virtchnl interface to the PF driver and the Flow director
> > functionality in the hardware.
> >
> > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf.h        |  12 ++
> >  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  33 ++++
> >  drivers/net/ethernet/intel/iavf/iavf_main.c   |  27 +++
> >  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 187 ++++++++++++++++++
> >  4 files changed, 259 insertions(+)
> >  create mode 100644 drivers/net/ethernet/intel/iavf/iavf_fdir.h
> >
> 
> Re-send to Bo, as a new member.
> 

Tested-by: Chen Bo <BoX.C.Chen@intel.com>

BRs,
Chen Bo

> > --
> > 2.30.1

