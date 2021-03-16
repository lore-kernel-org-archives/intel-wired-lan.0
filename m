From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Tue, 16 Mar 2021 16:31:53 +0000
Subject: [Intel-wired-lan] [Patch v5 17/18] iavf: Support Ethernet Type
 Flow Director filters
In-Reply-To: <20210309030815.5299-18-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-18-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB3795C42ADD6041DAD7B8EE31F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: Tuesday, March 9, 2021 11:08
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>; Liang, Cunming <cunming.liang@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Wang, Haiyue <haiyue.wang@intel.com>
> Subject: [Patch v5 17/18] iavf: Support Ethernet Type Flow Director filters
> 
> Support the addition and deletion of Ethernet filters.
> 
> Supported fields are: proto
> Supported flow-types are: ether
> 
> Example usage:
> ethtool -N ens787f0v0 flow-type ether proto 0x8863 action 6
> ethtool -N ens787f0v0 flow-type ether proto 0x8864 action 7
> 
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 12 ++++++++++
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 23 ++++++++++++++++++-
>  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  8 +++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 

Re-send to Bo, as a new member.

> --
> 2.30.1

