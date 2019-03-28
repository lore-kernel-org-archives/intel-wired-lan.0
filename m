From: Xuguizhu (Guzhu Xu, Intelligent Computing Business Dept) <xuguizhu@huawei.com>
Date: Thu, 28 Mar 2019 12:34:12 +0000
Subject: [Intel-wired-lan] =?gb2312?b?tPC4tDogW3F1ZXN0aW9uXSBpNDBlOiBR?=
 =?gb2312?b?dWVzdGlvbiBhYm91dCB0aGUgaTQwZV9jbGVhcl9weGVfbW9kZSgpIGZ1bmN0?=
 =?gb2312?b?aW9u?=
Message-ID: <315E3AFC3F1FCC4A88C68B5581547E0682A9E03A@dggemm513-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Today's test found that I40E_GLLAN_RCTL_0 and Clear PXE Mode Admin Command (Opcode: 0x0110) must be consistent. The i40e_clear_pxe_mode function in the I40E driver released in the Linux community clears the I40E_GLLAN_RCTL_0 register first. The i40e_probe() function calls the i40e_pf_reset() function, and the i40e_pf_reset() function calls the i40e_clear_pxe_mode() function. At this time, since the Admin Queue has not been created, the i40e_clear_pxe_mode() function does not call the i40e_aq_clear_pxe_mode() function, but it clears the value of the I40E_GLLAN_RCTL_0 register. The i40e_probe() function then calls the i40e_clear_pxe_mode() function to send the Clear PXE Mode Admin Command (Opcode: 0x0110). This will lead to the problem I mentioned in the previous email.

Next, I adjusted the code to look like this, after testing it can solve the problem I found before:
void i40e_clear_pxe_mode(struct i40e_hw *hw) {
	u32 reg;

	if (i40e_check_asq_alive(hw)) {
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
}



-----????-----
???: Xuguizhu (Guzhu Xu, Intelligent Computing Business Dept) 
????: 2019?3?27? 18:59
???: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
??: Zoujingzhou (Eitan, Intelligent Computing R&D) <zoujingzhou.zoujingzhou@huawei.com>; tangkun <tangkun1@huawei.com>; chenliyong (A) <chenliyong1@huawei.com>
??: [Intel-wired-lan][question] i40e: Question about the i40e_clear_pxe_mode() function

In the process of testing the NCSI function of the X722 NIC, when we started the ubuntu 18.04 system using the legacy mode, the system was put into the panic state by injecting a fault into the system through the "echo c > /proc/sysrq-trigger" command. When using the i40e driver in the ubuntu system, NCSI is broken after the injection failure. After upgrading the kernel to 5.1-rc2, the problem still exists. After using the driver released in sourceforge.net, the same test is performed and the NSCI function is normal.

After comparing the drivers of the two branches, we found that this problem may be related to the i40e_clear_pxe_mode() function. The code for the I40E driver released in the kernel community is as follows:
void i40e_clear_pxe_mode(struct i40e_hw *hw) {
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
void i40e_clear_pxe_mode(struct i40e_hw *hw) {
	if (i40e_check_asq_alive(hw))
		i40e_aq_clear_pxe_mode(hw, NULL);
}

We only modify the code of the i40e_clear_pxe_mode() function based on the code released by sourceforge.net. After testing, we can still reproduce the issue of NCSI break.

Our question is: what is the reason for adding this code, how to solve the problem we are now facing.




