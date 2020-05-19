From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 May 2020 16:36:52 +0000
Subject: [Intel-wired-lan] [PATCH S42 4/7] ice: Support IPv6 Flow
 Director filters
In-Reply-To: <20200512010146.41303-4-anthony.l.nguyen@intel.com>
References: <20200512010146.41303-1-anthony.l.nguyen@intel.com>
 <20200512010146.41303-4-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659AC2810CACDDF5AB872178CB90@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, May 11, 2020 6:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S42 4/7] ice: Support IPv6 Flow Director
> filters
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Extend supported filters to allow for IPv6 filters.
> 
> Supported fields are: src-ip, dst-ip, src-port, and dst-port Supported flow-
> types are: tcp6, udp6, sctp6, ip6
> 
> Example usage:
> 
> ethtool -N eth0 flow-type tcp6 src-port 12 dst-port 13 \ src-ip fce0::1:34 dst-ip
> fce0::1:35 action 32
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 391 +++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_fdir.c     | 303 ++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |  19 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |   6 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>  5 files changed, 642 insertions(+), 81 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


