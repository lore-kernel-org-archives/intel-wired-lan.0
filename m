From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Apr 2017 23:03:42 +0000
Subject: [Intel-wired-lan] [next PATCH S71 09/10] i40evf:
	remove	I40E_FLAG_FDIR_ATR_ENABLED
In-Reply-To: <20170419132559.20459-9-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
 <20170419132559.20459-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA11A1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 09/10] i40evf: remove
> I40E_FLAG_FDIR_ATR_ENABLED
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The flag used by the common code and PF code is
> I40E_FLAG_FD_ATR_ENABLED, not *FDIR*. It turns out none of the txrx code
> actually shared with the VF driver actually checks the ATR flag. This is made
> even more obvious by the typo in the VF header file.
> 
> Let's just remove the flag from the VF driver since it's not needed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


