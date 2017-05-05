From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:12:46 +0000
Subject: [Intel-wired-lan] [net-next v2 09/13] virtchnl: finish
 conversion	to virtchnl interface
In-Reply-To: <20170504093528.76047-10-jeffrey.t.kirsher@intel.com>
References: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
 <20170504093528.76047-10-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA28E2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next v2 09/13] virtchnl: finish conversion to
> virtchnl interface
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This patch implements the complete version of the virtchnl.h file with final
> renames, and fixes the related code in i40e and i40evf.
> 
> It also expands comments, and adds details on the usage of certain fields.
> 
> In addition, due to the changes a couple of casts are needed to prevent
> errors found by sparse after renaming some fields.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


