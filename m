From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:05:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 03/13] i40e: use new
 unified	virtchnl header file
In-Reply-To: <1493663091-27870-4-git-send-email-jesse.brandeburg@intel.com>
References: <1493663091-27870-1-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-2-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-3-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-4-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA282E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, May 1, 2017 11:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v1 03/13] i40e: use new unified
> virtchnl header file
> 
> This patch changes the i40e driver to start using the new virtchnl interface
> header file, and removes an already existing duplicate of the i40e_virtchnl.h
> file contained in the i40e directory.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
>  delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


