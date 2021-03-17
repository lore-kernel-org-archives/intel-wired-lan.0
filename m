From: Chen, BoX C <box.c.chen@intel.com>
Date: Wed, 17 Mar 2021 01:28:32 +0000
Subject: [Intel-wired-lan] [Patch v5 18/18] iavf: Enable flex-bytes
 support
In-Reply-To: <BN8PR11MB3795A5F55D3DA1581C7D46F1F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-19-haiyue.wang@intel.com>
 <BN8PR11MB3795A5F55D3DA1581C7D46F1F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
Message-ID: <SN6PR11MB3101CE811DBD49B748300E23D96A9@SN6PR11MB3101.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: March 17, 2021 0:32
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>; Liang, Cunming
> <cunming.liang@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Chen, BoX C <box.c.chen@intel.com>
> Subject: RE: [Patch v5 18/18] iavf: Enable flex-bytes support
> 
> > -----Original Message-----
> > From: Wang, Haiyue <haiyue.wang@intel.com>
> > Sent: Tuesday, March 9, 2021 11:08
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Zhang, Qi Z <qi.z.zhang@intel.com>; Liang, Cunming
> > <cunming.liang@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Wang, Haiyue <haiyue.wang@intel.com>
> > Subject: [Patch v5 18/18] iavf: Enable flex-bytes support
> >
> > Flex-bytes allows for packet matching based on an offset and value.
> > This is supported via the ethtool user-def option.
> >
> > The user-def 0xAAAABBBBCCCCDDDD: BBBB is the 2 byte pattern while
> AAAA
> > corresponds to its offset in the packet. Similarly DDDD is the 2 byte
> > pattern with CCCC being the corresponding offset. The offset ranges
> > from
> > 0x0 to 0x1F7 (up to 504 bytes into the packet). The offset starts from
> > the beginning of the packet.
> >
> > This feature can be used to allow customers to set flow director rules
> > for protocols headers that are beyond standard ones supported by
> > ethtool (e.g. PFCP or GTP-U).
> >
> > Like for matching GTP-U's TEID value 0x10203040:
> > ethtool -N ens787f0v0 flow-type udp4 dst-port 2152 \ user-def
> > 0x002e102000303040 action 13
> >
> > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > ---
> >  .../net/ethernet/intel/iavf/iavf_ethtool.c    |  93 ++++++++
> >  drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 217 +++++++++++++++++-
> >  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  19 ++
> >  3 files changed, 327 insertions(+), 2 deletions(-)
> >
> 
> Re-send to Bo, as a new member.
> 

Tested-by: Chen Bo <BoX.C.Chen@intel.com>

BRs,
Chen Bo

> > --
> > 2.30.1

