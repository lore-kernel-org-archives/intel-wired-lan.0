From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:24:15 +0000
Subject: [Intel-wired-lan] [PATCH S49 13/15] ice: add AQC get link
 topology handle support
In-Reply-To: <20200709161614.61098-13-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-13-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145D78E376F7BF33CD2BA768C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, July 9, 2020 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S49 13/15] ice: add AQC get link topology
> handle support
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Add AQC get link topology handle support. This is needed to determine
> Direct Attach (DA) or backplane media type for PHY types that support
> either. Get link topology handle cage node type request can be used to
> determine if a cage is present or not. If a cage is present for PHY types that
> supports both DA and backplane media type, then the media type is DA, else
> the media type is backplane.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 53 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 66 ++++++++++++++++++-
>  2 files changed, 118 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


