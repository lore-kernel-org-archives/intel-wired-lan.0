From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Mon, 4 Apr 2016 14:40:20 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 12/13] i40e: Input set
 mask	constants for RSS, flow director, and flex bytes
In-Reply-To: <1459508173-22777-13-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-13-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6265018F439@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Friday, April 01, 2016 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v3 next PATCH S32 12/13] i40e: Input set mask
> constants for RSS, flow director, and flex bytes
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Defines for input set mask (RSS, flow director, flexible payload).
> Also renames some defines related to RSS and flow-director. This
> patch adds defines specific to IPv6 flex mask needed to support
> change of RSS hash input set for flows such as TCP6 and UDP6.

Combining the squished messages looks strangely 
Repetitive.  Suggest change of patch message to this: 
Add defines for input set mask (RSS, flow director, flexible payload), 
including defines specific to IPv6. 

> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Ie95ef7d0916a4d6ca011c194283f959774c8dce9
> ---
> Testing Hints: This patch applies and compiles
> cleanly. Preparation patch for implementing features such as changing
> input set mask for RSS, and flow director.
> 
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 33 +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 42
> +++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h
> b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index bf693580..793036b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -1534,4 +1534,37 @@ struct i40e_lldp_variables {
> 
>  /* RSS Hash Table Size */
>  #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
> +
> +/* INPUT SET MASK for RSS, flow director, and flexible payload */
> +#define I40E_L3_SRC_SHIFT		47
> +#define I40E_L3_SRC_MASK		(0x3ULL << I40E_L3_SRC_SHIFT)
> +#define I40E_L3_V6_SRC_SHIFT		43
> +#define I40E_L3_V6_SRC_MASK		(0xFFULL <<
> I40E_L3_V6_SRC_SHIFT)
> +#define I40E_L3_DST_SHIFT		35
> +#define I40E_L3_DST_MASK		(0x3ULL << I40E_L3_DST_SHIFT)
> +#define I40E_L3_V6_DST_SHIFT		35
> +#define I40E_L3_V6_DST_MASK		(0xFFULL <<
> I40E_L3_V6_DST_SHIFT)
> +#define I40E_L4_SRC_SHIFT		34
> +#define I40E_L4_SRC_MASK		(0x1ULL << I40E_L4_SRC_SHIFT)
> +#define I40E_L4_DST_SHIFT		33
> +#define I40E_L4_DST_MASK		(0x1ULL << I40E_L4_DST_SHIFT)
> +#define I40E_VERIFY_TAG_SHIFT		31
> +#define I40E_VERIFY_TAG_MASK		(0x3ULL <<
> I40E_VERIFY_TAG_SHIFT)
> +
> +#define I40E_FLEX_50_SHIFT		13
> +#define I40E_FLEX_50_MASK		(0x1ULL << I40E_FLEX_50_SHIFT)
> +#define I40E_FLEX_51_SHIFT		12
> +#define I40E_FLEX_51_MASK		(0x1ULL << I40E_FLEX_51_SHIFT)
> +#define I40E_FLEX_52_SHIFT		11
> +#define I40E_FLEX_52_MASK		(0x1ULL << I40E_FLEX_52_SHIFT)
> +#define I40E_FLEX_53_SHIFT		10
> +#define I40E_FLEX_53_MASK		(0x1ULL << I40E_FLEX_53_SHIFT)
> +#define I40E_FLEX_54_SHIFT		9
> +#define I40E_FLEX_54_MASK		(0x1ULL << I40E_FLEX_54_SHIFT)
> +#define I40E_FLEX_55_SHIFT		8
> +#define I40E_FLEX_55_MASK		(0x1ULL << I40E_FLEX_55_SHIFT)
> +#define I40E_FLEX_56_SHIFT		7
> +#define I40E_FLEX_56_MASK		(0x1ULL << I40E_FLEX_56_SHIFT)
> +#define I40E_FLEX_57_SHIFT		6
> +#define I40E_FLEX_57_MASK		(0x1ULL << I40E_FLEX_57_SHIFT)
>  #endif /* _I40E_TYPE_H_ */
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h
> b/drivers/net/ethernet/intel/i40evf/i40e_type.h
> index d68e017..4a78c18 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
> @@ -1330,4 +1330,46 @@ enum i40e_reset_type {
> 
>  /* RSS Hash Table Size */
>  #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
> +
> +/* INPUT SET MASK for RSS, flow director and flexible payload */
> +#define I40E_FD_INSET_L3_SRC_SHIFT		47
> +#define I40E_FD_INSET_L3_SRC_WORD_MASK		(0x3ULL << \
> +
> I40E_FD_INSET_L3_SRC_SHIFT)
> +#define I40E_FD_INSET_L3_DST_SHIFT		35
> +#define I40E_FD_INSET_L3_DST_WORD_MASK		(0x3ULL << \
> +
> I40E_FD_INSET_L3_DST_SHIFT)
> +#define I40E_FD_INSET_L4_SRC_SHIFT		34
> +#define I40E_FD_INSET_L4_SRC_WORD_MASK		(0x1ULL << \
> +
> I40E_FD_INSET_L4_SRC_SHIFT)
> +#define I40E_FD_INSET_L4_DST_SHIFT		33
> +#define I40E_FD_INSET_L4_DST_WORD_MASK		(0x1ULL << \
> +
> I40E_FD_INSET_L4_DST_SHIFT)
> +#define I40E_FD_INSET_VERIFY_TAG_SHIFT		31
> +#define I40E_FD_INSET_VERIFY_TAG_WORD_MASK	(0x3ULL << \
> +
> I40E_FD_INSET_VERIFY_TAG_SHIFT)
> +
> +#define I40E_FD_INSET_FLEX_WORD50_SHIFT		17
> +#define I40E_FD_INSET_FLEX_WORD50_MASK		(0x1ULL << \
> +
> 	I40E_FD_INSET_FLEX_WORD50_SHIFT)
> +#define I40E_FD_INSET_FLEX_WORD51_SHIFT		16
> +#define I40E_FD_INSET_FLEX_WORD51_MASK		(0x1ULL << \
> +
> 	I40E_FD_INSET_FLEX_WORD51_SHIFT)
> +#define I40E_FD_INSET_FLEX_WORD52_SHIFT		15
> +#define I40E_FD_INSET_FLEX_WORD52_MASK		(0x1ULL << \
> +
> 	I40E_FD_INSET_FLEX_WORD52_SHIFT)
> +#define I40E_FD_INSET_FLEX_WORD53_SHIFT		14
> +#define I40E_FD_INSET_FLEX_WORD53_MASK		(0x1ULL << \
> +
> 	I40E_FD_INSET_FLEX_WORD53_SHIFT)
> +#define I40E_FD_INSET_FLEX_WORD54_SHIFT		13
> +#define I40E_FD_INSET_FLEX_WORD54_MASK		(0x1ULL << \
> +
> 	I40E_FD_INSET_FLEX_WORD54_SHIFT)
> +#define I40E_FD_INSET_FLEX_WORD55_SHIFT		12
> +#define I40E_FD_INSET_FLEX_WORD55_MASK		(0x1ULL << \
> +
> 	I40E_FD_INSET_FLEX_WORD55_SHIFT)
> +#define I40E_FD_INSET_FLEX_WORD56_SHIFT		11
> +#define I40E_FD_INSET_FLEX_WORD56_MASK		(0x1ULL << \
> +
> 	I40E_FD_INSET_FLEX_WORD56_SHIFT)
> +#define I40E_FD_INSET_FLEX_WORD57_SHIFT		10
> +#define I40E_FD_INSET_FLEX_WORD57_MASK		(0x1ULL << \
> +
> 	I40E_FD_INSET_FLEX_WORD57_SHIFT)
>  #endif /* _I40E_TYPE_H_ */
> --
> 2.4.3
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
