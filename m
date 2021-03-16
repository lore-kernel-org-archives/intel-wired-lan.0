From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Tue, 16 Mar 2021 16:31:29 +0000
Subject: [Intel-wired-lan] [Patch v5 16/18] iavf: Support IPv6 Flow
 Director filters
In-Reply-To: <20210309030815.5299-17-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-17-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB3795FBAEE6E42B056B7D3047F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
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
> Subject: [Patch v5 16/18] iavf: Support IPv6 Flow Director filters
> 
> Support the addition and deletion of IPv6 filters.
> 
> Supported fields are: src-ip, dst-ip, src-port, dst-port and l4proto
> Supported flow-types are: tcp6, udp6, sctp6, ip6, ah6, esp6
> 
> Example usage:
> ethtool -N ens787f0v0 flow-type tcp6 src-ip 2001::2 \
>   dst-ip CDCD:910A:2222:5498:8475:1111:3900:2020 \
>   tclass 1 src-port 22 dst-port 23 action 7
> 
> L2TPv3 over IP with 'Session ID' 17:
> ethtool -N ens787f0v0 flow-type ip6 l4proto 115 l4data 17 action 7
> 
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 122 ++++++++++++++++++
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 111 ++++++++++++++++
>  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  13 ++
>  3 files changed, 246 insertions(+)
> 

Re-send to Bo, as a new member.

> --
> 2.30.1

