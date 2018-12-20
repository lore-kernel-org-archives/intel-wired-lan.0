From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:39:16 +0000
Subject: [Intel-wired-lan] [PATCH S10 09/15] ice: Move aggregator list
 into ice_hw instance
In-Reply-To: <20181219180334.1104-10-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A58@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 09/15] ice: Move aggregator list into
> ice_hw instance
> 
> The aggregator list needs to be preserved for use after a reset. This patch
> moves it out of the port_info instance and into the ice_hw instance.
> 
> Signed-off-by: Tarun Singh <tarun.k.singh@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c |  2 ++
> drivers/net/ethernet/intel/ice/ice_sched.c  | 34 ++++++++++++++++++------
> -----  drivers/net/ethernet/intel/ice/ice_sched.h  |  2 ++
>  drivers/net/ethernet/intel/ice/ice_type.h   |  2 +-
>  4 files changed, 26 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


