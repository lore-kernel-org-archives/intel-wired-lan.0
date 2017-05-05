From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:13:53 +0000
Subject: [Intel-wired-lan] [net-next v2 02/13] i40e/i40evf: create and
 use	new unified header file
In-Reply-To: <20170504093528.76047-3-jeffrey.t.kirsher@intel.com>
References: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
 <20170504093528.76047-3-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA2905@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next v2 02/13] i40e/i40evf: create and use
> new unified header file
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This moves a header for i40evf to include/linux/avf/virtchnl.h.
> The directory name avf is an acronym for the Intel(R) Adaptive Virtual
> Function.
> 
> This first step creates the new file, which is a rename of
> drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h to
> include/linux/avf/virtchnl.h, and should show up in git as a rename when
> using git log --follow.
> 
> To keep things building after the move, the changes to the i40evf driver are
> made to point to the new include file location.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
>  delete mode 100644 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
>  create mode 100644 include/linux/avf/virtchnl.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


