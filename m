From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:29:21 +0000
Subject: [Intel-wired-lan] [PATCH S16 05/11] ice: Add code to process
 LLDP MIB change events
In-Reply-To: <20190228232432.31659-6-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368B2F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S16 05/11] ice: Add code to process LLDP
> MIB change events
> 
> This patch adds support to process LLDP MIB change notifications sent by the
> firmware.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.c     |  5 ++--
>  drivers/net/ethernet/intel/ice/ice_dcb.h     |  2 ++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 36
> ++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  4 ++++
>  drivers/net/ethernet/intel/ice/ice_main.c    |  3 +++
>  5 files changed, 47 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


