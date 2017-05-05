From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:11:26 +0000
Subject: [Intel-wired-lan] [net-next v2 12/13] virtchnl: Add compile
 time	static asserts to validate structure sizes
In-Reply-To: <20170504093528.76047-13-jeffrey.t.kirsher@intel.com>
References: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
 <20170504093528.76047-13-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA28C1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next v2 12/13] virtchnl: Add compile time
> static asserts to validate structure sizes
> 
> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> This uses preprocessor tricks to make sure that a divide by zero occurs if a
> struct changes size outside the expected number of bytes.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


