From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 18:01:21 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 12/14] virtchnl: Add
 compile	time static asserts to validate structure sizes
In-Reply-To: <20170511182321.147850-13-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-13-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA326E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 12/14] virtchnl: Add compile
> time static asserts to validate structure sizes
> 
> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> This uses preprocessor tricks to make sure that a divide by zero occurs if a
> struct changes size outside the expected number of bytes.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 50
> ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


