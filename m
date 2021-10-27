From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 27 Oct 2021 16:56:33 +0000
Subject: [Intel-wired-lan] [next-queue v2 3/4] ice: low level support
 for tunnels
In-Reply-To: <20211012183106.2315477-4-anthony.l.nguyen@intel.com>
References: <20211012183106.2315477-1-anthony.l.nguyen@intel.com>
 <20211012183106.2315477-4-anthony.l.nguyen@intel.com>
Message-ID: <MW3PR11MB4554F88B02E021E0CF2090C99C859@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Tony Nguyen
>Sent: Wednesday, October 13, 2021 12:01 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [next-queue v2 3/4] ice: low level support for tunnels
>
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
>Add definition of UDP tunnel dummy packets. Fill destination port value in
>filter based on UDP tunnel port. Append tunnel flags to switch filter definition
>in case of matching the tunnel.
>
>Both vxlan and geneve are UDP tunnels, so only one new header is needed.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../net/ethernet/intel/ice/ice_flex_pipe.c    |  26 +-
> .../net/ethernet/intel/ice/ice_flex_type.h    |   2 +
> .../ethernet/intel/ice/ice_protocol_type.h    |   9 +
> drivers/net/ethernet/intel/ice/ice_switch.c   | 264 +++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
> 5 files changed, 300 insertions(+), 3 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
