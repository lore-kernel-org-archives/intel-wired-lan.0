From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 May 2022 10:09:09 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Manual AN-37 for troublesome
 link partners for X550 SFI
In-Reply-To: <56cd0dde-600d-1bb0-1555-e66de8c37236@intel.com>
References: <20220316192710.9947-1-jeffd@silicom-usa.com>
 <56cd0dde-600d-1bb0-1555-e66de8c37236@intel.com>
Message-ID: <51308ed3-09c1-6bf2-190b-306abd42f3da@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 3/18/2022 4:47 PM, Tony Nguyen wrote:
> 
> On 3/16/2022 12:27 PM, Jeff Daly wrote:
>> Some (Juniper MX5) SFP link partners exhibit a disinclination to
>> autonegotiate with X550 configured in SFI mode.? This patch enables
>> a manual AN-37 restart to work around the problem.
> 
> Hi Jeff,
> 
> I talked to the ixgbe team about this and we need a bit more time to 
> look this over. Will keep you updated.

Hi Jeff,

Our developer is having some issues responding to this but this patch 
look ok. However, can you please address the unneeded status 
assignments. Also, replace the magic numbers for the register writes 
with meaningful define names.

Thanks,
Tony

> 
>> Signed-off-by: Jeff Daly <jeffd@silicom-usa.com>
>> ---
>> ? drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |? 3 ++
>> ? drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 50 +++++++++++++++++++
>> ? 2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h 
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> index 2647937f7f4d..dc8a259fda5f 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> @@ -3705,7 +3705,9 @@ struct ixgbe_info {
>> ? #define IXGBE_KRM_LINK_S1(P)??????? ((P) ? 0x8200 : 0x4200)
>> ? #define IXGBE_KRM_LINK_CTRL_1(P)??? ((P) ? 0x820C : 0x420C)
>> ? #define IXGBE_KRM_AN_CNTL_1(P)??????? ((P) ? 0x822C : 0x422C)
>> +#define IXGBE_KRM_AN_CNTL_4(P)??????? ((P) ? 0x8238 : 0x4238)
>> ? #define IXGBE_KRM_AN_CNTL_8(P)??????? ((P) ? 0x8248 : 0x4248)
>> +#define IXGBE_KRM_PCS_KX_AN(P)??????? ((P) ? 0x9918 : 0x5918)
>> ? #define IXGBE_KRM_SGMII_CTRL(P)??????? ((P) ? 0x82A0 : 0x42A0)
>> ? #define IXGBE_KRM_LP_BASE_PAGE_HIGH(P)??? ((P) ? 0x836C : 0x436C)
>> ? #define IXGBE_KRM_DSP_TXFFE_STATE_4(P)??? ((P) ? 0x8634 : 0x4634)
>> @@ -3715,6 +3717,7 @@ struct ixgbe_info {
>> ? #define IXGBE_KRM_PMD_FLX_MASK_ST20(P)??? ((P) ? 0x9054 : 0x5054)
>> ? #define IXGBE_KRM_TX_COEFF_CTRL_1(P)??? ((P) ? 0x9520 : 0x5520)
>> ? #define IXGBE_KRM_RX_ANA_CTL(P)??????? ((P) ? 0x9A00 : 0x5A00)
>> +#define IXGBE_KRM_FLX_TMRS_CTRL_ST31(P)??? ((P) ? 0x9180 : 0x5180)
>> ? #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA??????? ~(0x3 << 20)
>> ? #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_SR??????? BIT(20)
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c 
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
>> index e4b50c7781ff..f48a422ae83f 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
>> @@ -1725,6 +1725,56 @@ static s32 ixgbe_setup_sfi_x550a(struct 
>> ixgbe_hw *hw, ixgbe_link_speed *speed)
>> ????????????????? IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
>> ????????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
>> +??? /* change mode enforcement rules to hybrid */
>> +??? status = mac->ops.read_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_FLX_TMRS_CTRL_ST31(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
>> +??? reg_val |= 0x0400;
>> +
>> +??? status = mac->ops.write_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_FLX_TMRS_CTRL_ST31(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
> 
> I don't see a need for all the status assignments, they're not being 
> used before being overwritten.
> 
> Thanks,
> 
> Tony
> 
>> +??? /* manually control the config */
>> +??? status = mac->ops.read_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
>> +??? reg_val |= 0x20002240;
>> +
>> +??? status = mac->ops.write_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
>> +
>> +??? /* move the AN base page values */
>> +??? status = mac->ops.read_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_PCS_KX_AN(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
>> +??? reg_val |= 0x1;
>> +
>> +??? status = mac->ops.write_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_PCS_KX_AN(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
>> +
>> +??? /* set the AN37 over CB mode */
>> +??? status = mac->ops.read_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_AN_CNTL_4(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
>> +??? reg_val |= 0x20000000;
>> +
>> +??? status = mac->ops.write_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_AN_CNTL_4(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
>> +
>> +??? /* restart AN manually */
>> +??? status = mac->ops.read_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
>> +??? reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
>> +
>> +??? status = mac->ops.write_iosf_sb_reg(hw,
>> +??????????????? IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
>> +??????????????? IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
>> +
>> ????? /* Toggle port SW reset by AN reset. */
>> ????? status = ixgbe_restart_an_internal_phy_x550em(hw);
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
