From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:13:22 +0000
Subject: [Intel-wired-lan] [net-next v2 03/13] i40e: use new
	unified	virtchnl header file
In-Reply-To: <20170504093528.76047-4-jeffrey.t.kirsher@intel.com>
References: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
 <20170504093528.76047-4-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA28F2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next v2 03/13] i40e: use new unified virtchnl
> header file
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This patch changes the i40e driver to start using the new virtchnl interface
> header file, and removes an already existing duplicate of the i40e_virtchnl.h
> file contained in the i40e directory.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
>  delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


