From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:48:59 +0000
Subject: [Intel-wired-lan] [PATCH S14 15/15] ice: Implement
 pci_error_handler ops
In-Reply-To: <20190213185115.25877-16-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36726E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S14 15/15] ice: Implement
> pci_error_handler ops
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> This patch implements the following pci_error_handler ops:
> 	.error_detected = ice_pci_err_detected
> 	.slot_reset = ice_pci_err_slot_reset
> 	.reset_notify = ice_pci_err_reset_notify
> 	.reset_prepare = ice_pci_err_reset_prepare
> 	.reset_done = ice_pci_err_reset_done
> 	.resume = ice_pci_err_resume
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message] [Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com> fixed build failures]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 151
> ++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


