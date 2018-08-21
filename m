From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:28:21 +0000
Subject: [Intel-wired-lan] [PATCH v4 12/13] ice: Change struct members
 from bool to u8
In-Reply-To: <20180809132903.22819-13-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-13-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A00@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 12/13] ice: Change struct members from
> bool to u8
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Recent versions of checkpatch have a new warning based on a documented
> preference of Linus to not use bool in structures due to wasted space and
> the size of bool is implementation dependent.  For more information, see
> the email thread at https://lkml.org/lkml/2017/11/21/384.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        |  8 ++++----
>  drivers/net/ethernet/intel/ice/ice_switch.h |  6 +++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h   |  2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h   | 16 ++++++++--------
>  4 files changed, 16 insertions(+), 16 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


