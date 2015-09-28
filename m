From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Sep 2015 17:44:02 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix basic support for X722
 devices
In-Reply-To: <1443133592-159225-1-git-send-email-anjali.singhai@intel.com>
References: <1443133592-159225-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1D48@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Thursday, September 24, 2015 3:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix basic support for X722 devices
> 
> Acquire NVM, before issuing an AQ read nvm command for X722.
> We need to acquire the NVM before issuing an AQ read to the NVM
> otherwise we will get EBUSY from the FW. Also release when done.
> 
> This fixes the two X722 issues with respect to eeprom checksum verify and
> reading NVM version info.
> 
> With this patch in place, i40e driver will provide basic support for X722
> devices.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c |  3 +++
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 31
> +++++++++++++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 +++
>  3 files changed, 31 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
