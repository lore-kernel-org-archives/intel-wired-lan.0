From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:03:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 01/13] i40evf:
	drop	i40e_type.h include
In-Reply-To: <1493663091-27870-2-git-send-email-jesse.brandeburg@intel.com>
References: <1493663091-27870-1-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-2-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA280D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v1 01/13] i40evf: drop
> i40e_type.h include
> 
> This drops the i40e_type.h include in anticipation of the next patch which
> moves this file to a location where type.h doesn't exist, and all the places this
> file is included already include i40e_type.h before this file.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
> b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
> index b0b8de5..7d6da3a 100644

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


 
