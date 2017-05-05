From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:10:17 +0000
Subject: [Intel-wired-lan] [net-next v2 07/13] i40e/virtchnl: refactor
 code	for validate checks
In-Reply-To: <20170504093528.76047-8-jeffrey.t.kirsher@intel.com>
References: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
 <20170504093528.76047-8-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA28A2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, May 4, 2017 2:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next v2 07/13] i40e/virtchnl: refactor code for
> validate checks
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
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


