From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 23:19:26 +0000
Subject: [Intel-wired-lan] [PATCH S19 07/15] ice: Refactor the LLDP MIB
 change event handling
In-Reply-To: <20190416172439.27908-8-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39B05D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 07/15] ice: Refactor the LLDP MIB
> change event handling
> 
> From: Usha Ketineni <usha.k.ketineni@intel.com>
> 
> This patch fixes the LLDP MIB change event handling code by removing the
> workarounds in the current code. Added ice_dcb_need_recfg() to print the
> DCB configuration changes detected via MIB change event.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.c     |   5 +-
>  drivers/net/ethernet/intel/ice/ice_dcb.h     |   4 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 153 ++++++++++++++++---
>  3 files changed, 140 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
