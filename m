From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 17:56:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 02/14] i40e/i40evf: create
 and	use new unified header file
In-Reply-To: <20170511182321.147850-3-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-3-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA30EA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, May 11, 2017 11:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 02/14] i40e/i40evf: create and
> use new unified header file
> 
> This moves a header for i40evf to include/linux/avf/virtchnl.h.
> The directory name avf is an acronym for the Intel(R) Adaptive Virtual
> Function.
> 
> This first step creates the new file, which is a rename of
> drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h to
> include/linux/avf/virtchnl.h, and should show up in git as a rename when
> using git log --follow.
> 
> To keep things building after the move, the changes to the i40evf driver are
> made to point to the new include file location.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
>  delete mode 100644 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
>  create mode 100644 include/linux/avf/virtchnl.h
> ---
>  MAINTAINERS                                                             | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_common.c                         | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h                      | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h                              | 2 +-
>  .../intel/i40evf/i40e_virtchnl.h => include/linux/avf/virtchnl.h        | 0
>  5 files changed, 4 insertions(+), 3 deletions(-)  rename

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


