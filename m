From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:46:50 +0000
Subject: [Intel-wired-lan] [PATCH S14 11/15] ice: Create a generic name
 for the ice_rx_flg64_bits structure
In-Reply-To: <20190213185115.25877-12-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36722D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 11/15] ice: Create a generic name for
> the ice_rx_flg64_bits structure
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> This structure is used to define the packet flags. These flags are applicable for
> both TX and RX packet. Thus, this patch changes its name from
> ice_rx_flag64_bits to ice_flg64_bits, and its member definition.
> 
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c    | 26 ++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 34 +++++++++++++---------
> ----
>  2 files changed, 30 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


