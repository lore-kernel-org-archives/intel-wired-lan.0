From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 May 2020 16:36:22 +0000
Subject: [Intel-wired-lan] [PATCH S42 3/7] ice: Support IPv4 Flow
 Director filters
In-Reply-To: <20200512010146.41303-3-anthony.l.nguyen@intel.com>
References: <20200512010146.41303-1-anthony.l.nguyen@intel.com>
 <20200512010146.41303-3-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16590DC1F635227ECC0878C58CB90@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S42 3/7] ice: Support IPv4 Flow Director
> filters
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Support the addition and deletion of IPv4 filters.
> 
> Supported fields are: src-ip, dst-ip, src-port, and dst-port
> Supported flow-types are: tcp4, udp4, sctp4, ip4
> 
> Example usage:
> 
> ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 dst-ip 172.16.0.55 \
> src-port 16 dst-port 12 action 32
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   4 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   4 +
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 658 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.c     | 513 ++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |  79 +++
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |  34 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   3 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   6 +
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 101 +++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  82 +++
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   6 +
>  12 files changed, 1493 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


