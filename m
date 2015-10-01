From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Thu, 1 Oct 2015 19:08:31 +0000
Subject: [Intel-wired-lan] [next PATCH S18 6/8] i40e: Fix an incorrect
 OEM	version string
In-Reply-To: <1443724661-92168-7-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AF91A3D@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S18 6/8] i40e: Fix an incorrect OEM
> version string
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a problem where the driver output of the oem
> version string varied from the other tools.  The mask value
> and the order of operations were incorrect, per the DCR.

Not a vital issue, but we probably shouldn't mention DCR in the external commit message.
sln

> Without this patch, the version string will appear incorrect
> from the driver.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Ie1ca6485284b4ce3b57e5a99b18b7641617c7ef7
> 
> ---
> Testing-hints: 5646237
>  drivers/net/ethernet/intel/i40e/i40e.h | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 7c2b2e8..4dd3e26 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -109,8 +109,10 @@
>  #define I40E_NVM_VERSION_LO_MASK   (0xff << I40E_NVM_VERSION_LO_SHIFT)
>  #define I40E_NVM_VERSION_HI_SHIFT  12
>  #define I40E_NVM_VERSION_HI_MASK   (0xf << I40E_NVM_VERSION_HI_SHIFT)
> -#define I40E_OEM_VER_BUILD_MASK    0xff00
> +#define I40E_OEM_VER_BUILD_MASK    0xffff
>  #define I40E_OEM_VER_PATCH_MASK    0xff
> +#define I40E_OEM_VER_BUILD_SHIFT   8
> +#define I40E_OEM_VER_SHIFT         24
> 
>  /* The values in here are decimal coded as hex as is the case in the NVM
> map*/
>  #define I40E_CURRENT_NVM_VERSION_HI 0x2
> @@ -594,6 +596,15 @@ struct i40e_device {
>  static inline char *i40e_nvm_version_str(struct i40e_hw *hw)
>  {
>  	static char buf[32];
> +	u32 full_ver;
> +	u8 ver, patch;
> +	u16 build;
> +
> +	full_ver = hw->nvm.oem_ver;
> +	ver = (u8)(full_ver >> I40E_OEM_VER_SHIFT);
> +	build = (u16)((full_ver >> I40E_OEM_VER_BUILD_SHIFT)
> +		 & I40E_OEM_VER_BUILD_MASK);
> +	patch = (u8)(full_ver & I40E_OEM_VER_PATCH_MASK);
> 
>  	snprintf(buf, sizeof(buf),
>  		 "%x.%02x 0x%x %d.%d.%d",
> @@ -601,9 +612,7 @@ static inline char *i40e_nvm_version_str(struct
> i40e_hw *hw)
>  			I40E_NVM_VERSION_HI_SHIFT,
>  		 (hw->nvm.version & I40E_NVM_VERSION_LO_MASK) >>
>  			I40E_NVM_VERSION_LO_SHIFT,
> -		 hw->nvm.eetrack, (hw->nvm.oem_ver >> 24),
> -		 (hw->nvm.oem_ver & I40E_OEM_VER_BUILD_MASK) >> 8,
> -		 hw->nvm.oem_ver & I40E_OEM_VER_PATCH_MASK);
> +		 hw->nvm.eetrack, ver, build, patch);
> 
>  	return buf;
>  }
> --
> 1.9.3
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
