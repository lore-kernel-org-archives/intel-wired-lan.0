From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:56:21 +0000
Subject: [Intel-wired-lan] [PATCH 11/16] ice: Implement VSI replay
 framework
In-Reply-To: <20180920002319.10971-12-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC4C9@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 11/16] ice: Implement VSI replay
> framework
> 
> Currently, switch filters get replayed after reset. In addition to filters, other
> VSI attributes (like RSS configuration, Tx scheduler configuration, etc.) also
> need to be replayed after reset.
> 
> Thus, instead of replaying based on functional blocks (i.e. replay all filters for
> all VSIs, followed by RSS configuration replay for all VSIs, and so on), it makes
> more sense to have the replay centered around a VSI. In other words, replay
> all configurations for a VSI before moving on to rebuilding the next VSI.
> 
> To that effect, this patch introduces a VSI replay framework in a new function
> ice_vsi_replay_all. Currently it only replays switch filters, but it will be
> expanded in the future to replay additional VSI attributes.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c |  65 ++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_common.h |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c   |  44 +++++++++++-
>  drivers/net/ethernet/intel/ice/ice_switch.c | 107 ++++++++++++++++-------
> -----
>  drivers/net/ethernet/intel/ice/ice_switch.h |   8 ++-
>  drivers/net/ethernet/intel/ice/ice_type.h   |   3 +
>  6 files changed, 178 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


