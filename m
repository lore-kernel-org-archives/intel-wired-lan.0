From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 1 Feb 2018 15:46:15 -0800
Subject: [Intel-wired-lan] Possible read-modify-write bug in ixgbe x550 phy
 setup
Message-ID: <59b6e262-8027-675c-f75e-3a95d3a97e4f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Emil,

I was looking through a set of ixgbe patches and came across this commit

     commit 410a494902777c11f95031d9ed757d7f8f09c5c6
     ixgbe: add write flush when configuring CS4223/7

and am wondering about the setting of reg_phy_ext in the middle of 
ixgbe_setup_mac_link_sfp_x550a().  It looks like it is read from the 
PHY, modified to remove the CX1 and SR mode bits, but then those bits 
are overwritten in the "if (setup_linear)" block immediately following, 
and that is what gets written back out.

	ret_val = hw->phy.ops.read_reg(hw, reg_slice,
				       IXGBE_MDIO_ZERO_DEV_TYPE, &reg_phy_ext);
	if (ret_val)
		return ret_val;

	reg_phy_ext &= ~((IXGBE_CS4227_EDC_MODE_CX1 << 1) |
			 (IXGBE_CS4227_EDC_MODE_SR << 1));

	if (setup_linear)
		reg_phy_ext = (IXGBE_CS4227_EDC_MODE_CX1 << 1) | 1;
	else
		reg_phy_ext = (IXGBE_CS4227_EDC_MODE_SR << 1) | 1;

	ret_val = hw->phy.ops.write_reg(hw, reg_slice,
					IXGBE_MDIO_ZERO_DEV_TYPE, reg_phy_ext);
	if (ret_val)
		return ret_val;


The assignments to reg_phy_ext look wrong to me - perhaps those should 
be '|=' rather than '='?

sln

-- 
==================================================
Shannon Nelson           shannon.nelson at oracle.com
Parents can't afford to be squeamish
