From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:35:00 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 12/15] ice: Make print
 statements more compact
In-Reply-To: <20200206092013.23388-12-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-12-anthony.l.nguyen@intel.com>
Message-ID: <16d50c0bac064d5ca24e2bf3c5d94a9c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 12/15] ice: Make print statements
> more compact
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Formatting strings in print function calls (like dev_info, dev_err, etc.) can
> exceed 80 columns without making checkpatch unhappy. So remove
> newlines where applicable and make print statements more compact.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |  22 +--
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   7 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |  10 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  42 ++---
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  36 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c     | 167 +++++++-----------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  62 +++----
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |   4 +-
>  8 files changed, 123 insertions(+), 227 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


