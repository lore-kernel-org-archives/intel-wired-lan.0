From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:18:32 +0000
Subject: [Intel-wired-lan] [PATCH S20 15/15] ice: Use GLINT_DYN_CTL to
 disable VF's interrupts
In-Reply-To: <20190416173052.28928-16-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AD15@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 15/15] ice: Use GLINT_DYN_CTL to
> disable VF's interrupts
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently in ice_free_vf_res() we are writing to the VFINT_DYN_CTLN
> register in the PF's function space to disable all VF's interrupts. This is
> incorrect because this register is only for use in the VF's function space. This
> becomes obvious when seeing that the valid indices used for the
> VFINT_DYN_CTLN register is from 0-63, which is the maximum number of
> interrupts for a VF (not including the OICR interrupt). Fix this by writing to the
> GLINT_DYN_CTL register for each VF. We can do this because we keep track
> of each VF's first_vector_idx inside of the PF's function space and the
> number of interrupts given to each VF.
> 
> Also in ice_free_vfs() we were disabling Rx/Tx queues after calling
> pci_disable_sriov(). One part of disabling the Tx queues causes the PF driver
> to trigger a software interrupt, which causes the VF's napi routine to run. This
> doesn't currently work because pci_disable_sriov() causes iavf_remove() to
> be called which disables interrupts. Fix this by disabling Rx/Tx queues prior to
> pci_disable_sriov().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 41 ++++++-------------
>  1 file changed, 13 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


