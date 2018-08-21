From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:16:02 +0000
Subject: [Intel-wired-lan] [PATCH v3 01/15] ice: Rework flex descriptor
 programming
In-Reply-To: <20180809132958.23036-2-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-2-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261954599A@ORSMSX109.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 01/15] ice: Rework flex descriptor
> programming
> 
> The driver can support two flex descriptor profiles, ICE_RXDID_FLEX_NIC and
> ICE_RXDID_FLEX_NIC_2. This patch reworks the current flex programming
> logic to add support for the latter profile.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   | 102 ++++++++++++++----
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  24 +++--
>  2 files changed, 92 insertions(+), 34 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


