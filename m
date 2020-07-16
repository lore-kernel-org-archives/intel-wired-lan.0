From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:47:45 +0000
Subject: [Intel-wired-lan] [PATCH S50 08/15] ice: Adjust scheduler
 default BW weight
In-Reply-To: <20200713205318.32425-8-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-8-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21450CF17F47943150D0F4B48C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 08/15] ice: Adjust scheduler default BW
> weight
> 
> From: Tarun Singh <tarun.k.singh@intel.com>
> 
> By default the queues are configured in legacy mode. The default BW
> settings for legacy/advanced modes are different. The existing code was
> using the advanced mode default value of 1 which was incorrect. This caused
> the unbalanced BW sharing among siblings.
> The recommneded default value is applied.
> 
> Signed-off-by: Tarun Singh <tarun.k.singh@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 13 ++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_type.h   |  2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


