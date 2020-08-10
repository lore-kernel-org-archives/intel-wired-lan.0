From: kernel test robot <lkp@intel.com>
Date: Tue, 11 Aug 2020 00:56:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 15/33]
 drivers/net/ethernet/intel/i40e/i40e_ptp.c:1020:50: sparse: sparse: mixing
 different enum types:
Message-ID: <202008110052.6R7POQTe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5cf0cbb14925b7131baa959b35a2267d6bbb6651
commit: f3f1e5ce45c6c061b87b37f0c166eb63fb94e9fd [15/33] i40e: add support for PTP external synchronization clock
config: x86_64-randconfig-s022-20200810 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-141-g19506bc2-dirty
        git checkout f3f1e5ce45c6c061b87b37f0c166eb63fb94e9fd
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/i40e/i40e_ptp.c:1020:50: sparse: sparse: mixing different enum types:
>> drivers/net/ethernet/intel/i40e/i40e_ptp.c:1020:50: sparse:    unsigned int enum i40e_ptp_led_pin_state
>> drivers/net/ethernet/intel/i40e/i40e_ptp.c:1020:50: sparse:    int enum i40e_ptp_gpio_pin_state
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1021:50: sparse: sparse: mixing different enum types:
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1021:50: sparse:    unsigned int enum i40e_ptp_led_pin_state
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1021:50: sparse:    int enum i40e_ptp_gpio_pin_state
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1022:50: sparse: sparse: mixing different enum types:
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1022:50: sparse:    unsigned int enum i40e_ptp_led_pin_state
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1022:50: sparse:    int enum i40e_ptp_gpio_pin_state
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1023:50: sparse: sparse: mixing different enum types:
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1023:50: sparse:    unsigned int enum i40e_ptp_led_pin_state
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1023:50: sparse:    int enum i40e_ptp_gpio_pin_state

vim +1020 drivers/net/ethernet/intel/i40e/i40e_ptp.c

   999	
  1000	/**
  1001	 * i40e_ptp_set_pins_hw - Set HW GPIO pins
  1002	 * @pf: Board private structure
  1003	 *
  1004	 * This function sets GPIO pins for PTP
  1005	 **/
  1006	static void i40e_ptp_set_pins_hw(struct i40e_pf *pf)
  1007	{
  1008		const struct i40e_ptp_pins_settings *pins = pf->ptp_pins;
  1009		struct i40e_hw *hw = &pf->hw;
  1010	
  1011		/* pin must be disabled before it may be used */
  1012		i40e_ptp_set_pin_hw(hw, I40E_SDP3_2, off);
  1013		i40e_ptp_set_pin_hw(hw, I40E_SDP3_3, off);
  1014		i40e_ptp_set_pin_hw(hw, I40E_GPIO_4, off);
  1015	
  1016		i40e_ptp_set_pin_hw(hw, I40E_SDP3_2, pins->sdp3_2);
  1017		i40e_ptp_set_pin_hw(hw, I40E_SDP3_3, pins->sdp3_3);
  1018		i40e_ptp_set_pin_hw(hw, I40E_GPIO_4, pins->gpio_4);
  1019	
> 1020		i40e_ptp_set_led_hw(hw, I40E_LED2_0, pins->led2_0);
  1021		i40e_ptp_set_led_hw(hw, I40E_LED2_1, pins->led2_1);
  1022		i40e_ptp_set_led_hw(hw, I40E_LED3_0, pins->led3_0);
  1023		i40e_ptp_set_led_hw(hw, I40E_LED3_1, pins->led3_1);
  1024	
  1025		dev_info(&pf->pdev->dev,
  1026			 "PTP configuration set to: SDP3_2: %s,  SDP3_3: %s,  GPIO_4: %s.\n",
  1027			 i40e_ptp_gpio_pin_state2str[pins->sdp3_2],
  1028			 i40e_ptp_gpio_pin_state2str[pins->sdp3_3],
  1029			 i40e_ptp_gpio_pin_state2str[pins->gpio_4]);
  1030	}
  1031	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27644 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200811/e43dfe17/attachment-0001.bin>
