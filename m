From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:56:41 +0000
Subject: [Intel-wired-lan] [PATCH S22 11/16] ice: Add stats for Rx drops
 at the port level
In-Reply-To: <20190626092027.52845-11-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-11-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE58@ORSMSX104.amr.corp.intel.com>
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
> Cc: Creeley, Brett <brett.creeley@intel.com>
> Subject: [Intel-wired-lan] [PATCH S22 11/16] ice: Add stats for Rx drops at the
> port level
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we are not reporting dropped counts at the port level to ethtool or
> netlink. This was found when debugging Rx dropped issues and the total
> packets sent did not equal the total packets received minus the rx_dropped,
> which was very confusing. To determine dropped counts at the port level we
> need to read the PRTRPB_RDPC register.
> To fix reporting we will store the dropped counts in the PF's rx_discards. This
> will be reported to netlink by storing it in the PF VSI's rx_missed_errors
> signaling that the receiver missed the packet. Also, we will report this to
> ethtool in the rx_dropped.nic field.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 1 +
>  drivers/net/ethernet/intel/ice/ice_main.c       | 6 ++++++
>  2 files changed, 7 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


