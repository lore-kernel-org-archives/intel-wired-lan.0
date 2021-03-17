From: Chen, BoX C <box.c.chen@intel.com>
Date: Wed, 17 Mar 2021 01:28:00 +0000
Subject: [Intel-wired-lan] [Patch v5 15/18] iavf: Support IPv4 Flow
 Director filters
In-Reply-To: <BN8PR11MB3795903520731FBE05EFA539F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-16-haiyue.wang@intel.com>
 <BN8PR11MB3795903520731FBE05EFA539F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
Message-ID: <SN6PR11MB31015B03081DE204F82E348FD96A9@SN6PR11MB3101.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: March 17, 2021 0:31
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>; Liang, Cunming
> <cunming.liang@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Chen, BoX C <box.c.chen@intel.com>
> Subject: RE: [Patch v5 15/18] iavf: Support IPv4 Flow Director filters
> 
> > -----Original Message-----
> > From: Wang, Haiyue <haiyue.wang@intel.com>
> > Sent: Tuesday, March 9, 2021 11:08
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Zhang, Qi Z <qi.z.zhang@intel.com>; Liang, Cunming
> > <cunming.liang@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Wang, Haiyue <haiyue.wang@intel.com>
> > Subject: [Patch v5 15/18] iavf: Support IPv4 Flow Director filters
> >
> > Support the addition and deletion of IPv4 filters.
> >
> > Supported fields are: src-ip, dst-ip, src-port, dst-port and l4proto
> > Supported flow-types are: tcp4, udp4, sctp4, ip4, ah4, esp4
> >
> > Example usage:
> > ethtool -N ens787f0v0 flow-type tcp4 src-ip 192.168.0.20 \
> >   dst-ip 192.168.0.21 tos 4 src-port 22 dst-port 23 action 8
> >
> > L2TPv3 over IP with 'Session ID' 17:
> > ethtool -N ens787f0v0 flow-type ip4 l4proto 115 l4data 17 action 3
> >
> > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/Makefile      |   2 +-
> >  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 404 +++++++++++++++++
> >  drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 428 ++++++++++++++++++
> >  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  40 ++
> >  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   8 +
> >  5 files changed, 881 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/net/ethernet/intel/iavf/iavf_fdir.c
> >
> 
> Re-send to Bo, as a new member.
> 

Tested-by: Chen Bo <BoX.C.Chen@intel.com>

BRs,
Chen Bo

> > --
> > 2.30.1

