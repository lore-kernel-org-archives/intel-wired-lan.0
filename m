From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 21:59:24 +0000
Subject: [Intel-wired-lan] [PATCH S8 10/16] ice: Fix the bytecount sent
 to netdev_tx_sent_queue
In-Reply-To: <20181026174105.11628-11-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328D1A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 10/16] ice: Fix the bytecount sent to
> netdev_tx_sent_queue
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if the driver does a TSO offload the bytecount sent to
> netdev_tx_sent_queue will be incorrect. This is because in ice_tso we
> overwrite the initial value that we set in ice_tx_map. This creates a mismatch
> between the Tx and Tx clean flow. In the Tx clean flow we calculate the
> bytecount (called total_bytes) as we clean the descriptors so the value used
> in the Tx clean path is correct. Fix this by using += in ice_tso instead of =. This
> fixes the mismatch in bytecount mentioned above.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


