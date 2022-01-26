From: kernel test robot <lkp@intel.com>
Date: Thu, 27 Jan 2022 02:11:14 +0800
Subject: [Intel-wired-lan] [PATCH net-next v2 1/2] iavf: Stop leaking
 iavf_status as "errno" values
In-Reply-To: <20220126145938.26500-1-mateusz.palczewski@intel.com>
References: <20220126145938.26500-1-mateusz.palczewski@intel.com>
Message-ID: <202201270125.z5yiy42k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mateusz,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Mateusz-Palczewski/iavf-Fix-return-values-in-driver/20220126-230536
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git ab14f1802cfb2d7ca120bbf48e3ba6712314ffc3
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201270125.z5yiy42k-lkp at intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d0d06ad4899a5e86feef8a2fca3f8f0bf6937767
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mateusz-Palczewski/iavf-Fix-return-values-in-driver/20220126-230536
        git checkout d0d06ad4899a5e86feef8a2fca3f8f0bf6937767
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/intel/iavf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/iavf/iavf_main.c:2141:60: warning: variable 'err' is uninitialized when used here [-Wuninitialized]
                   dev_err(&pdev->dev, "Failed to init Admin Queue (%d)\n", err);
                                                                            ^~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                          ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
   drivers/net/ethernet/intel/iavf/iavf_main.c:2115:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   1 warning generated.


vim +/err +2141 drivers/net/ethernet/intel/iavf/iavf_main.c

8afadd1cd8ba1d Brett Creeley      2021-11-29  2101  
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2102  /**
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2103   * iavf_startup - first step of driver startup
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2104   * @adapter: board private structure
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2105   *
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2106   * Function process __IAVF_STARTUP driver state.
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2107   * When success the state is changed to __IAVF_INIT_VERSION_CHECK
59756ad6948be9 Mateusz Palczewski 2021-08-19  2108   * when fails the state is changed to __IAVF_INIT_FAILED
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2109   **/
59756ad6948be9 Mateusz Palczewski 2021-08-19  2110  static void iavf_startup(struct iavf_adapter *adapter)
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2111  {
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2112  	struct pci_dev *pdev = adapter->pdev;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2113  	struct iavf_hw *hw = &adapter->hw;
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2114  	enum iavf_status status;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2115  	int err;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2116  
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2117  	WARN_ON(adapter->state != __IAVF_STARTUP);
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2118  
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2119  	/* driver loaded, probe complete */
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2120  	adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2121  	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2122  	status = iavf_set_mac_type(hw);
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2123  	if (status) {
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2124  		dev_err(&pdev->dev, "Failed to set MAC type (%d)\n", status);
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2125  		goto err;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2126  	}
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2127  
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2128  	status = iavf_check_reset_complete(hw);
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2129  	if (status) {
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2130  		dev_info(&pdev->dev, "Device is still in reset (%d), retrying\n",
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2131  			 status);
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2132  		goto err;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2133  	}
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2134  	hw->aq.num_arq_entries = IAVF_AQ_LEN;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2135  	hw->aq.num_asq_entries = IAVF_AQ_LEN;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2136  	hw->aq.arq_buf_size = IAVF_MAX_AQ_BUF_SIZE;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2137  	hw->aq.asq_buf_size = IAVF_MAX_AQ_BUF_SIZE;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2138  
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2139  	status = iavf_init_adminq(hw);
d0d06ad4899a5e Mateusz Palczewski 2022-01-26  2140  	if (status) {
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14 @2141  		dev_err(&pdev->dev, "Failed to init Admin Queue (%d)\n", err);
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2142  		goto err;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2143  	}
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2144  	err = iavf_send_api_ver(adapter);
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2145  	if (err) {
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2146  		dev_err(&pdev->dev, "Unable to send to PF (%d)\n", err);
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2147  		iavf_shutdown_adminq(hw);
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2148  		goto err;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2149  	}
45eebd62999d37 Mateusz Palczewski 2021-08-19  2150  	iavf_change_state(adapter, __IAVF_INIT_VERSION_CHECK);
59756ad6948be9 Mateusz Palczewski 2021-08-19  2151  	return;
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2152  err:
59756ad6948be9 Mateusz Palczewski 2021-08-19  2153  	iavf_change_state(adapter, __IAVF_INIT_FAILED);
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2154  }
b66c7bc1cd4d72 Jakub Pawlak       2019-05-14  2155  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
