From: kbuild test robot <lkp@intel.com>
Date: Sun, 6 Aug 2017 15:02:14 +0800
Subject: [Intel-wired-lan] [next PATCH S78-V4 01/12] i40e: use admin
 queue for setting LEDs behavior
In-Reply-To: <20170804135222.46684-1-alice.michael@intel.com>
Message-ID: <201708061420.mbwAW0z3%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mariusz,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[also build test ERROR on v4.13-rc3 next-20170804]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alice-Michael/i40e-use-admin-queue-for-setting-LEDs-behavior/20170806-044014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the linux-review/Alice-Michael/i40e-use-admin-queue-for-setting-LEDs-behavior/20170806-044014 HEAD e6b14a85521c0cd2de206efff3ed84a86f94b5e2 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_common.c: In function 'i40e_led_get_phy':
>> drivers/net/ethernet/intel/i40e/i40e_common.c:4856:9: error: implicit declaration of function 'i40e_aq_get_phy_register' [-Werror=implicit-function-declaration]
            i40e_aq_get_phy_register(hw,
            ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_common.c:4857:13: error: 'I40E_AQ_PHY_REG_ACCESS_EXTERNAL' undeclared (first use in this function)
                I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_common.c:4857:13: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/i40e/i40e_common.c: In function 'i40e_led_set_phy':
   drivers/net/ethernet/intel/i40e/i40e_common.c:4910:13: error: 'I40E_AQ_PHY_REG_ACCESS_EXTERNAL' undeclared (first use in this function)
                I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_common.c:4930:13: error: implicit declaration of function 'i40e_aq_set_phy_register' [-Werror=implicit-function-declaration]
       status = i40e_aq_set_phy_register(hw,
                ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/i40e_aq_get_phy_register +4856 drivers/net/ethernet/intel/i40e/i40e_common.c

  4834	
  4835	/**
  4836	 * i40e_led_get_phy - return current on/off mode
  4837	 * @hw: pointer to the hw struct
  4838	 * @led_addr: address of led register to use
  4839	 * @val: original value of register to use
  4840	 *
  4841	 **/
  4842	i40e_status i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
  4843				     u16 *val)
  4844	{
  4845		i40e_status status = 0;
  4846		u16 gpio_led_port;
  4847		u8 phy_addr = 0;
  4848		u16 reg_val;
  4849		u16 temp_addr;
  4850		u8 port_num;
  4851		u32 i;
  4852		u32 reg_val_aq;
  4853	
  4854		if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
  4855			status =
> 4856			      i40e_aq_get_phy_register(hw,
> 4857						       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
  4858						       I40E_PHY_COM_REG_PAGE,
  4859						       I40E_PHY_LED_PROV_REG_1,
  4860						       &reg_val_aq, NULL);
  4861			if (status)
  4862				return status;
  4863			*val = (u16)reg_val_aq;
  4864		} else {
  4865			temp_addr = I40E_PHY_LED_PROV_REG_1;
  4866			i = rd32(hw, I40E_PFGEN_PORTNUM);
  4867			port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
  4868			phy_addr = i40e_get_phy_address(hw, port_num);
  4869	
  4870			for (gpio_led_port = 0; gpio_led_port < 3; gpio_led_port++,
  4871			     temp_addr++) {
  4872				status =
  4873				 i40e_read_phy_register_clause45(hw,
  4874								 I40E_PHY_COM_REG_PAGE,
  4875								 temp_addr, phy_addr,
  4876								 &reg_val);
  4877				if (status)
  4878					return status;
  4879				*val = reg_val;
  4880				if (reg_val & I40E_PHY_LED_LINK_MODE_MASK) {
  4881					*led_addr = temp_addr;
  4882					break;
  4883				}
  4884			}
  4885		}
  4886		return status;
  4887	}
  4888	
  4889	/**
  4890	 * i40e_led_set_phy
  4891	 * @hw: pointer to the HW structure
  4892	 * @on: true or false
  4893	 * @mode: original val plus bit for set or ignore
  4894	 * Set led's on or off when controlled by the PHY
  4895	 *
  4896	 **/
  4897	i40e_status i40e_led_set_phy(struct i40e_hw *hw, bool on,
  4898				     u16 led_addr, u32 mode)
  4899	{
  4900		i40e_status status = 0;
  4901		u32 led_ctl = 0;
  4902		u32 led_reg = 0;
  4903		u8 phy_addr = 0;
  4904		u8 port_num;
  4905		u32 i;
  4906	
  4907		if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
  4908			status =
  4909			      i40e_aq_get_phy_register(hw,
  4910						       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
  4911						       I40E_PHY_COM_REG_PAGE,
  4912						       I40E_PHY_LED_PROV_REG_1,
  4913						       &led_reg, NULL);
  4914		} else {
  4915			i = rd32(hw, I40E_PFGEN_PORTNUM);
  4916			port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
  4917			phy_addr = i40e_get_phy_address(hw, port_num);
  4918			status = i40e_read_phy_register_clause45(hw,
  4919								 I40E_PHY_COM_REG_PAGE,
  4920								 led_addr, phy_addr,
  4921								 (u16 *)&led_reg);
  4922		}
  4923		if (status)
  4924			return status;
  4925		led_ctl = led_reg;
  4926		if (led_reg & I40E_PHY_LED_LINK_MODE_MASK) {
  4927			led_reg = 0;
  4928			if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
  4929			    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
> 4930				status = i40e_aq_set_phy_register(hw,
  4931						I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
  4932						I40E_PHY_COM_REG_PAGE,
  4933						I40E_PHY_LED_PROV_REG_1,
  4934						led_reg, NULL);
  4935			} else {
  4936				status = i40e_write_phy_register_clause45(hw,
  4937								I40E_PHY_COM_REG_PAGE,
  4938								led_addr, phy_addr,
  4939								(u16)led_reg);
  4940			}
  4941			if (status)
  4942				return status;
  4943		}
  4944		if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
  4945			status =
  4946			      i40e_aq_get_phy_register(hw,
  4947						       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
  4948						       I40E_PHY_COM_REG_PAGE,
  4949						       I40E_PHY_LED_PROV_REG_1,
  4950						       &led_reg, NULL);
  4951		} else {
  4952			status = i40e_read_phy_register_clause45(hw,
  4953								 I40E_PHY_COM_REG_PAGE,
  4954								 led_addr, phy_addr,
  4955								 (u16 *)&led_reg);
  4956		}
  4957		if (status)
  4958			goto restore_config;
  4959		if (on)
  4960			led_reg = I40E_PHY_LED_MANUAL_ON;
  4961		else
  4962			led_reg = 0;
  4963	
  4964		if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
  4965			status =
  4966			      i40e_aq_set_phy_register(hw,
  4967						       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
  4968						       I40E_PHY_COM_REG_PAGE,
  4969						       I40E_PHY_LED_PROV_REG_1,
  4970						       led_reg, NULL);
  4971		} else {
  4972			status =
  4973			    i40e_write_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
  4974							     led_addr, phy_addr,
  4975							     (u16)led_reg);
  4976		}
  4977		if (status)
  4978			goto restore_config;
  4979		if (mode & I40E_PHY_LED_MODE_ORIG) {
  4980			led_ctl = (mode & I40E_PHY_LED_MODE_MASK);
  4981			if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
  4982				status = i40e_aq_set_phy_register(hw,
  4983						I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
  4984						I40E_PHY_COM_REG_PAGE,
  4985						I40E_PHY_LED_PROV_REG_1,
  4986						led_ctl, NULL);
  4987			} else {
  4988				status = i40e_write_phy_register_clause45(hw,
  4989								 I40E_PHY_COM_REG_PAGE,
  4990								 led_addr, phy_addr,
  4991								 (u16)led_ctl);
  4992			}
  4993		}
  4994		return status;
  4995	restore_config:
  4996		if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
  4997			status =
  4998			      i40e_aq_set_phy_register(hw,
  4999						       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
  5000						       I40E_PHY_COM_REG_PAGE,
  5001						       I40E_PHY_LED_PROV_REG_1,
  5002						       led_ctl, NULL);
  5003		} else {
  5004			status =
  5005				i40e_write_phy_register_clause45(hw,
  5006								 I40E_PHY_COM_REG_PAGE,
  5007								 led_addr, phy_addr,
  5008								 (u16)led_ctl);
  5009		}
  5010		return status;
  5011	}
  5012	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39611 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170806/8d56bd6a/attachment-0001.bin>
