From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 19 Sep 2020 05:40:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 6/7] ice: remove unused
 args from ice_get_open_tunnel_port()
In-Reply-To: <20200722012716.2814777-7-kuba@kernel.org>
References: <20200722012716.2814777-1-kuba@kernel.org>
 <20200722012716.2814777-7-kuba@kernel.org>
Message-ID: <SN6PR11MB2896C431060BD976DDC92DE2BC3C0@SN6PR11MB2896.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org> On
> Behalf Of Jakub Kicinski
> Sent: Tuesday, July 21, 2020 6:27 PM
> To: davem at davemloft.net
> Cc: netdev at vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> intel-wired-lan at lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>
> Subject: [PATCH net-next v1 6/7] ice: remove unused args from
> ice_get_open_tunnel_port()
> 
> ice_get_open_tunnel_port() is always passed TNL_ALL
> as the second parameter.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 6 ++----
>  drivers/net/ethernet/intel/ice/ice_fdir.c         | 2 +-
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c    | 7 ++-----
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.h    | 3 +--
>  4 files changed, 6 insertions(+), 12 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

