From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Apr 2016 22:12:14 +0000
Subject: [Intel-wired-lan] [PATCH next S35 v3 7/9] i40e/i40evf:
	Remove	unused hardware receive descriptor code
In-Reply-To: <1461004429-34316-8-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-4-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-5-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-6-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-7-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-8-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D23A6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, April 18, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next S35 v3 7/9] i40e/i40evf: Remove
> unused hardware receive descriptor code
> 
> The hardware supports a 16 byte descriptor for receive, but the driver was
> never using it in production.  There was no performance benefit to the real
> driver of 16 byte descriptors, so drop a whole lot of complexity while getting
> rid of the code.
> 
> Also since the previous patch made us use no-split mode all the time, drop
> any support in the driver for any other value in dtype and assume it is always
> zero (aka no-split).
> 
> Hooray for code removal!
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I2257e902e4dad84a07b94db6d2e6f4ce69b27bc0
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  7 +------
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 16 +---------------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 18 +++++-------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 24 ++++++++++--------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 24 ++++++++++--------------
>  5 files changed, 27 insertions(+), 62 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Changes present in code, traffic passes normally
