From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jul 2020 23:56:23 +0000
Subject: [Intel-wired-lan] [PATCH S48 v6 15/16] ice: Add more FDIR
 filter type for AVF
In-Reply-To: <20200716133938.46921-16-qi.z.zhang@intel.com>
References: <20200716133938.46921-1-qi.z.zhang@intel.com>
 <20200716133938.46921-16-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB21456B232F0BCE1CDA854D288C770@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 16, 2020 6:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v6 15/16] ice: Add more FDIR filter type
> for AVF
> 
> FDIR for AVF can forward
> - L2TPV3 packets by matching session id.
> - IPSEC ESP packets by matching security parameter index.
> - IPSEC AH packets by matching security parameter index.
> - NAT_T ESP packets by matching security parameter index.
> - Any PFCP session packets(s field is 1).
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c          | 255 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.h          |  15 ++
>  drivers/net/ethernet/intel/ice/ice_type.h          |  13 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 280
> +++++++++++++++++++--
>  4 files changed, 545 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


