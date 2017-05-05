From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:07:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 10/13] i40e/virtchnl:
	move	function to virtchnl
In-Reply-To: <1493663091-27870-11-git-send-email-jesse.brandeburg@intel.com>
References: <1493663091-27870-1-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-2-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-3-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-4-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-5-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-6-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-7-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-8-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-9-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-10-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-11-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA285F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v1 10/13] i40e/virtchnl: move
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

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


