From: Xuguizhu (Guzhu Xu, Intelligent Computing Business Dept) <xuguizhu@huawei.com>
Date: Wed, 27 Mar 2019 10:58:35 +0000
Subject: [Intel-wired-lan] [question] i40e: Question about the
 i40e_clear_pxe_mode() function
Message-ID: <315E3AFC3F1FCC4A88C68B5581547E0682A9D1D5@dggemm513-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the process of testing the NCSI function of the X722 NIC, when we started the ubuntu 18.04 system using the legacy mode, the system was put into the panic state by injecting a fault into the system through the "echo c > /proc/sysrq-trigger" command. When using the i40e driver in the ubuntu system, NCSI is broken after the injection failure. After upgrading the kernel to 5.1-rc2, the problem still exists. After using the driver released in sourceforge.net, the same test is performed and the NSCI function is normal.

After comparing the drivers of the two branches, we found that this problem may be related to the i40e_clear_pxe_mode() function. The code for the I40E driver released in the kernel community is as follows:
void i40e_clear_pxe_mode(struct i40e_hw *hw)
{
	u32 reg;

	if (i40e_check_asq_alive(hw))
		i40e_aq_clear_pxe_mode(hw, NULL);

	/* Clear single descriptor fetch/write-back mode */
	reg = rd32(hw, I40E_GLLAN_RCTL_0);

	if (hw->revision_id == 0) {
		/* As a work around clear PXE_MODE instead of setting it */
		wr32(hw, I40E_GLLAN_RCTL_0, (reg & (~I40E_GLLAN_RCTL_0_PXE_MODE_MASK)));
	} else {
		wr32(hw, I40E_GLLAN_RCTL_0, (reg | I40E_GLLAN_RCTL_0_PXE_MODE_MASK));
	}
}

The code for the i40e_clear_pxe_mode() function in the driver released in sourceforge.net is as follows:
void i40e_clear_pxe_mode(struct i40e_hw *hw)
{
	if (i40e_check_asq_alive(hw))
		i40e_aq_clear_pxe_mode(hw, NULL);
}

We only modify the code of the i40e_clear_pxe_mode() function based on the code released by sourceforge.net. After testing, we can still reproduce the issue of NCSI break.

Our question is: what is the reason for adding this code, how to solve the problem we are now facing.




