From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Jan 2016 21:31:29 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 02/15] i40e: Make the
	DCB	firmware checks for X710/XL710 only
In-Reply-To: <1452732712-12248-3-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-3-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9808EC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 02/15] i40e: Make the DCB
> firmware checks for X710/XL710 only
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> Make the DCB firmware version related checks specific to
> X710 and XL710 only. These checks are not required for
> X722 family of devices.
> 
> Introduced an inline routine to help determine if the MAC type is X710/XL710
> or not.
> 
> Moved the firmware version related checks in i40e_sw_init() and defined
> flags for different cases
> 
> Fix the version check to allow using "Set LLDP MIB" AQ for beyond FVL4 FW
> releases.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: Ib78288343de983aa0354fc28aa36e99b073662c0
> ---
> Testing Hints:
> - LLDP should get disabled on FVL with FVLSW1/2 NVM and no DCB/DCBX
> functionality should be available
> - DCB capability should be enabled for FVL3/4 NVM images
> - Once DCB is enabled for FPK builds SW functionally should be same as FVL
> DCB
> 
>  drivers/net/ethernet/intel/i40e/i40e.h      | 16 ++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 27
> ++++++++++++++++++++-------
>  2 files changed, 36 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, DCB/FCoE patch - Does not break base driver, compiles cleanly
