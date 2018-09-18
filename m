From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Sep 2018 15:02:09 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 11/14] iavf: tracing
 infrastructure rename
In-Reply-To: <20180915003757.169108-12-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
 <20180915003757.169108-12-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ED481@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 11/14] iavf: tracing
> infrastructure rename
> 
> Rename the i40e_trace file and fix up all the callers to the new names inside
> the iavf_trace.h file.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c        |  2 +-
>  .../intel/iavf/{i40e_trace.h => iavf_trace.h}      | 28 +++++++++++-----------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c        | 14 +++++------
>  3 files changed, 22 insertions(+), 22 deletions(-)  rename

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


