From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:11:16 +0000
Subject: [Intel-wired-lan] [PATCH S24 v2 07/12] ice: reject VF attempts
 to enable head writeback
In-Reply-To: <20190729090454.5501-7-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
 <20190729090454.5501-7-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E8AD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, July 29, 2019 2:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 v2 07/12] ice: reject VF attempts to
> enable head writeback
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The virtchnl interface provides a mechanism for a VF driver to request head
> writeback support. This feature is deprecated as of AVF 1.0, but older
> versions of a VF driver may still attempt to request the mode.
> 
> Since the ice hardware does not support head writeback, we should not
> accept Tx queue configuration which attempts to enable it.
> 
> Currently, the driver simply assumes that the headwb_enabled bit will never
> be set.
> 
> If a VF driver does request head writeback, the configuration will return
> successfully, even though head writeback is not enabled. This leaves the VF
> driver in a non functional state since it is assuming to be operating in head
> writeback mode.
> 
> Fix the PF driver to reject any attempt to setup headwb_enabled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


