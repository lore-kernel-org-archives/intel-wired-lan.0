From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:17:42 +0000
Subject: [Intel-wired-lan] [PATCH S31 03/15] ice: Add support for FW
 recovery mode detection
In-Reply-To: <20191009140953.14087-3-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-3-anthony.l.nguyen@intel.com>
Message-ID: <ce4e132b64224b7fbd28d017183bc4c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 03/15] ice: Add support for FW
> recovery mode detection
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> This patch adds support for firmware recovery mode detection.
> 
> The idea behind FW recovery mode is to recover from a bad FW state, due to
> corruption or misconfiguration. The FW triggers recovery mode by setting the
> right bits in the GL_MNG_FWSM register and issuing an EMP reset.
> 
> The driver may or may not be loaded when recovery mode is triggered. So on
> module load, the driver first checks if the FW is already in recovery mode. If
> so, it drops into recovery mode as well, where it creates and registers a single
> netdev that only allows a very small set of repair/ diagnostic operations (like
> updating the FW, checking version, etc.) through ethtool.
> 
> If recovery mode is triggered when the driver is loaded/operational, the first
> indication of this in the driver is via the EMP reset event.
> As part of processing the reset event, the driver checks the GL_MNG_FWSM
> register to determine if recovery mode was triggered. If so, traffic is stopped,
> peers are closed and the ethtool ops are updated to allow only
> repair/diagnostic operations.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   3 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  52 ++++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   9 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  20 ++
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 179 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   6 +
>  7 files changed, 259 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


