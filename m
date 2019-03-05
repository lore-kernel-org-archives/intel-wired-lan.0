From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:31:34 +0000
Subject: [Intel-wired-lan] [PATCH S16 10/11] ice: Add code to control FW
 LLDP and DCBX
In-Reply-To: <20190228232432.31659-11-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368B84@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S16 10/11] ice: Add code to control FW
> LLDP and DCBX
> 
> This patch adds code to start or stop LLDP and DCBX in firmware through use
> of ethtool private flags.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  2 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 12 ++++
>  drivers/net/ethernet/intel/ice/ice_dcb.c        | 28 +++++++-
>  drivers/net/ethernet/intel/ice/ice_dcb.h        | 23 ++++++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    | 96
> ++++++++++++++++++++++++-
>  5 files changed, 159 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


