From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 18:00:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 10/14] i40e/virtchnl:
	move	function to virtchnl
In-Reply-To: <20170511182321.147850-11-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-11-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA3148@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 10/14] i40e/virtchnl: move
> function to virtchnl
> 
> This moves a function that is needed for the virtchnl interface from the i40e
> PF driver over to the virtchnl.h file.
> 
> It was manually verified that the function in question is unchanged except for
> the function name and function header, which explains the slight difference
> in the number of lines removed/added.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 150 +--------------------
>  include/linux/avf/virtchnl.h                       | 147 ++++++++++++++++++++
>  2 files changed, 148 insertions(+), 149 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


