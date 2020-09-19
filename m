From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 19 Sep 2020 05:42:44 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 7/7] ice: convert to new
 udp_tunnel infrastructure
In-Reply-To: <20200722012716.2814777-8-kuba@kernel.org>
References: <20200722012716.2814777-1-kuba@kernel.org>
 <20200722012716.2814777-8-kuba@kernel.org>
Message-ID: <SN6PR11MB28964136A523A71959C9C1D6BC3C0@SN6PR11MB2896.namprd11.prod.outlook.com>
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
> Subject: [PATCH net-next v1 7/7] ice: convert to new udp_tunnel infrastructure
> 
> Convert ice to the new infra, use share port tables.
> 
> Leave a tiny bit more error checking in place than usual,
> because this driver really does quite a bit of magic.
> 
> We need to calculate the number of VxLAN and GENEVE entries
> the firmware has reserved.
> 
> Thanks to the conversion the driver will no longer sleep in
> an atomic section.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 228 ++++++++----------
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   8 +-
>  .../net/ethernet/intel/ice/ice_flex_type.h    |   5 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  97 +++-----
>  drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
>  5 files changed, 135 insertions(+), 206 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

