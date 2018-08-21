From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:32:51 +0000
Subject: [Intel-wired-lan] [PATCH v4 01/13] ice: Fix multiple static
 analyser warnings
In-Reply-To: <20180809132903.22819-2-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-2-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545ABC@ORSMSX109.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 01/13] ice: Fix multiple static analyser
> warnings
> 
> This patch fixes the following smatch errors:
> 
> 1) Fix "odd binop '0x0 & 0xc'" when performing the bitwise-and with a
>    constant value of zero (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG).
>    Remove a similar bitwise-and with 0 in ice_add_marker_act() and use the
>    right mask ICE_LG_ACT_GENERIC_OFFSET_M in the expression.
> 
> 2) Fix a similar issue "odd binop '0x0 & 0x1800' in ice_req_irq_msix_misc.
> 
> 3) Fix "odd binop '0x380000 & 0x7fff8'" in ice_add_marker_act(). Also, use
>    a new define ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX instead of
> magic
>    number '7'.
> 
> 4) Fix warn: odd binop '0x0 & 0x18' in ice_set_dflt_vsi_ctx() by removing
>    unnecessary logic to explicitly unset bits 3 and 4 in port_vlan_bits.
>    These bits are unset already by the memset on ctxt->info.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   | 25 +++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_main.c     | 19 ++++++--------
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  4 +--
>  4 files changed, 25 insertions(+), 24 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


