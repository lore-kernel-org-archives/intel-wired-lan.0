From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:19:07 +0000
Subject: [Intel-wired-lan] [PATCH S9 02/15] ice: Call pci_disable_sriov
 before stopping queues for VF
In-Reply-To: <20181026184447.13547-3-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
 <20181026184447.13547-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328DA9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 11:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S9 02/15] ice: Call pci_disable_sriov before
> stopping queues for VF
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Previous to this commit the driver was immediately stopping Tx/Rx queues
> when doing the following "echo 0 > sriov_numvfs" and then it was calling
> pci_disable_sriov if the VFs are not assigned. This was causing the
> VIRTCHNL_OP_DISABLE_QUEUES to fail because it was trying to stop the
> queues for a second time.
> 
> Fix this by calling pci_disable_sriov before stopping the Tx/Rx queues.
> This allows the VIRTCHNL_OP_DISABLE_QUEUES to get processed before the
> driver tries to stop the Rx/Tx queues in ice_free_vfs.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


