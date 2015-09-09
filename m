From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 18:00:24 +0000
Subject: [Intel-wired-lan] [next PATCH S12 04/15] i40e/i40evf: remove
 unused	opcode
In-Reply-To: <1440690163-128213-5-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5D64@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 04/15] i40e/i40evf: remove
> unused opcode
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> This opcode is not required. VFs that program RSS through the firmware do it
> by interacting directly with the firmware, and do not need to use the virtual
> channel for this functionality.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Iaf17d2600e28ff1b6be8653f2fe9df1facd23b0e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 1 -
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 1 -
>  2 files changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
