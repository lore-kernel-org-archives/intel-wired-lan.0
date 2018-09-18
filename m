From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 15:02:41 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 12/14] iavf: rename most
 of i40e strings
In-Reply-To: <20180915003757.169108-13-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-13-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED492@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Friday, September 14, 2018 5:38 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 12/14] iavf: rename most of
> i40e strings
> 
> This is the big rename patch, it takes most of the i40e_
> and I40E_ strings and renames them to iavf_ and IAVF_.
> 
> Some of the adminq code, as well as most of the client
> interface code used by RDMA is left unchanged in order
> to indicate that the driver is talking to non-internal to
> iavf code.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/i40e_adminq.c     |  96 ++--
>  drivers/net/ethernet/intel/iavf/i40e_adminq.h     |  24 +-
>  drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h |   4 +-
>  drivers/net/ethernet/intel/iavf/i40e_alloc.h      |  38 +-
>  drivers/net/ethernet/intel/iavf/i40e_common.c     | 590 ++++++++++--------
> --
>  drivers/net/ethernet/intel/iavf/i40e_osdep.h      |  20 +-
>  drivers/net/ethernet/intel/iavf/i40e_prototype.h  |  13 +-
>  drivers/net/ethernet/intel/iavf/i40e_status.h     |   8 +-
>  drivers/net/ethernet/intel/iavf/i40e_type.h       | 633 +++++++++++----------
> -
>  drivers/net/ethernet/intel/iavf/iavf.h            |  59 +-
>  drivers/net/ethernet/intel/iavf/iavf_client.c     |  26 +-
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c    | 142 +++--
>  drivers/net/ethernet/intel/iavf/iavf_main.c       | 107 ++--
>  drivers/net/ethernet/intel/iavf/iavf_trace.h      |  36 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c       | 616 ++++++++++-----------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.h       | 341 ++++++------
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c   |  20 +-
>  17 files changed, 1366 insertions(+), 1407 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


