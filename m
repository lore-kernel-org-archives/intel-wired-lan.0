From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:41:23 +0000
Subject: [Intel-wired-lan] [PATCH S10 13/15] ice: Offload SCTP checksum
In-Reply-To: <20181219180334.1104-14-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A9D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 13/15] ice: Offload SCTP checksum
> 
> This patch adds the ability to offload SCTP checksum calculations to the NIC.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h           | 1 +
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 +
>  drivers/net/ethernet/intel/ice/ice_main.c      | 1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c      | 6 ++++++
>  4 files changed, 9 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


