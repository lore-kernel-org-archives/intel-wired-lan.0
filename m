From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:06:09 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 07/13] i40e/virtchnl:
 refactor	code for validate checks
In-Reply-To: <1493663091-27870-8-git-send-email-jesse.brandeburg@intel.com>
References: <1493663091-27870-1-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-2-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-3-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-4-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-5-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-6-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-7-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-8-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA283E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v1 07/13] i40e/virtchnl: refactor
> code for validate checks
> 
> This change updates the arguments passed to the validate function and fixes
> the caller, as well as uses the new return values added to virtchnl.h
> 
> One other minor tweak, remove a duplicate set to zero of valid_len.
> 
> This is in preparation for moving the function to virtchnl.h.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


