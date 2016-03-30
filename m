From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 30 Mar 2016 13:07:46 -0700
Subject: [Intel-wired-lan] [PATCH V4 09/11] ixgbe: Add support for SGMII
 backplane interface
In-Reply-To: <20160329235812.68428.4760.stgit@mdrustad-wks.jf.intel.com>
References: <20160329235544.68428.93935.stgit@mdrustad-wks.jf.intel.com>
 <20160329235812.68428.4760.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <1459368466.2903.12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-03-29 at 16:58 -0700, Mark D Rustad wrote:
> Add support for an SGMII backplane interface.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |??? 2 +
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |??? 9 ++++
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |?? 58
> +++++++++++++++++++++++++
> ?3 files changed, 69 insertions(+)
> 

...
Please use the BIT() macro for the added defines below. ?Eventually we
should probably convert all of the defines to BIT(), but that is for a
later discussion.

> @@ -3594,6 +3598,8 @@ struct ixgbe_info {
> ?#define IXGBE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_MASK????(0x7 << 8)
> ?#define IXGBE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_1G??????(2 << 8)
> ?#define IXGBE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_10G?????(4 << 8)
> +#define IXGBE_KRM_LINK_CTRL_1_TETH_AN_SGMII_EN?????????(1 << 12)
> +#define IXGBE_KRM_LINK_CTRL_1_TETH_AN_CLAUSE_37_EN?????(1 << 13)
> ?#define IXGBE_KRM_LINK_CTRL_1_TETH_AN_FEC_REQ??????????(1 << 14)
> ?#define IXGBE_KRM_LINK_CTRL_1_TETH_AN_CAP_FEC??????????(1 << 15)
> ?#define IXGBE_KRM_LINK_CTRL_1_TETH_AN_CAP_KX???????????(1 << 16)
> @@ -3609,6 +3615,9 @@ struct ixgbe_info {
> ?#define IXGBE_KRM_AN_CNTL_8_LINEAR?????????????????????BIT(0)
> ?#define IXGBE_KRM_AN_CNTL_8_LIMITING???????????????????BIT(1)
> ?
> +#define IXGBE_KRM_SGMII_CTRL_MAC_TAR_FORCE_100_D???????(1 << 12)
> +#define IXGBE_KRM_SGMII_CTRL_MAC_TAR_FORCE_10_D????????????????(1 <<
> 19)
> +
> ?#define IXGBE_KRM_DSP_TXFFE_STATE_C0_EN????????????????????????(1 <<
> 6)
> ?#define IXGBE_KRM_DSP_TXFFE_STATE_CP1_CN1_EN???????????(1 << 15)
> ?#define IXGBE_KRM_DSP_TXFFE_STATE_CO_ADAPT_EN??????????(1 << 16)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160330/696a864e/attachment-0001.asc>
