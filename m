From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:53:07 +0000
Subject: [Intel-wired-lan] [PATCH S22 07/16] ice: Disable VFs until
 reset is completed
In-Reply-To: <20190626092027.52845-7-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-7-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE18@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: [Intel-wired-lan] [PATCH S22 07/16] ice: Disable VFs until reset is
> completed
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch adds code to clear VFs enable status until reset is completed, and
> Tx/Rx rings are setup. Without this patch, the code flow request Tx queues
> to be disabled after reset, especially PFR - where VF VSI Tx rings have already
> been wiped off in the NVM and result to adminq error based on the call to
> disable Tx lan queue in ice_reset_all_vfs function call.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


