From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:52:33 +0000
Subject: [Intel-wired-lan] [PATCH S15 11/14] ice: Remove "2 BITS" comment
In-Reply-To: <20190219230414.25627-12-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
 <20190219230414.25627-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367621@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 19, 2019 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 11/14] ice: Remove "2 BITS" comment
> 
> Some enums in ice_tx_desc_cmd_bits have a trailing /* 2 BITS */ comment,
> but the value has just one bit set (ex. ICE_TX_DESC_CMD_L4T_EOFT_SCTP
> has the value 0x200 (i.e. only bit 9 is set). This is confusing and misleading. So
> remove the comment.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


