From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:30:08 +0000
Subject: [Intel-wired-lan] [PATCH S43 03/15] ice: Fix Tx timeout when
 link is toggled on a VF's interface
In-Reply-To: <20200516003644.4658-3-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-3-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659E8C89DB6C616831412498CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 03/15] ice: Fix Tx timeout when link is
> toggled on a VF's interface
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if the iavf is loaded and a VF link transitions from up to down to up
> again a Tx timeout will be triggered. This happens because Tx/Rx queue
> interrupts are only enabled when receiving the
> VIRTCHNL_OP_CONFIG_MAP_IRQ message, which happens on reset or
> initial iavf driver load, but not when bringing link up. This is problematic
> because they are disabled on the VIRTCHNL_OP_DISABLE_QUEUES message,
> which is part of bringing a VF's link down. However, they are not enabled on
> the VIRTCHNL_OP_ENABLE_QUEUES message, which is part of bringing a
> VF's link up.
> 
> Fix this by re-enabling the VF's Rx and Tx queue interrupts when they were
> previously configured. This is done by first checking to make sure the
> previous value in QINT_[R|T]QCTL.MSIX_INDX is not 0, which is used to
> represent the OICR in the VF's interrupt space. If the MSIX_INDX is non-zero
> then enable the interrupt by setting the QINT_[R|T]CTL.CAUSE_ENA bit to 1.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


