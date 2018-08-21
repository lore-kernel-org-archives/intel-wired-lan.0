From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:11:15 +0000
Subject: [Intel-wired-lan] [PATCH v3 12/15] ice: Enable firmware logging
 during device initialization.
In-Reply-To: <20180809132958.23036-13-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-13-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545913@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 12/15] ice: Enable firmware logging
> during device initialization.
> 
> From: Hieu Tran <hieu.t.tran@intel.com>
> 
> To enable FW logging, the "cq_en" and "uart_en" enable bits of the "fw_log"
> element in struct ice_hw need to set accordingly based on some user-
> provided parameters during driver loading. To select which FW log events to
> be emitted, the "cfg" elements of corresponding FW modules in the "evnts"
> array member of "fw_log" need to be configured.
> 
> Signed-off-by: Hieu Tran <hieu.t.tran@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  83 ++++++++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 182 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   3 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |  19 ++
>  5 files changed, 286 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


