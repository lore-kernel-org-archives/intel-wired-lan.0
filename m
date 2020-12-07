From: kernel test robot <lkp@intel.com>
Date: Tue, 8 Dec 2020 03:18:17 +0800
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix for failed to init
 adminq while VF reset
In-Reply-To: <20201207114223.29030-1-mateusz.palczewski@intel.com>
References: <20201207114223.29030-1-mateusz.palczewski@intel.com>
Message-ID: <202012080348.xDUe7ilV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mateusz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net/master]

url:    https://github.com/0day-ci/linux/commits/Mateusz-Palczewski/i40e-Fix-for-failed-to-init-adminq-while-VF-reset/20201207-194429
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 10c678bd0a035ac2c64a9b26b222f20556227a53
config: alpha-randconfig-r034-20201207 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3473ae8b20a6b744f90aa0479ad4d66567f8d832
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mateusz-Palczewski/i40e-Fix-for-failed-to-init-adminq-while-VF-reset/20201207-194429
        git checkout 3473ae8b20a6b744f90aa0479ad4d66567f8d832
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/i40e/i40e_type.h:8,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:4:
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_sync_vfr_reset':
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1315:18: error: implicit declaration of function 'I40E_VFINT_ICR0_ENA'; did you mean 'I40E_PFINT_ICR0_ENA'? [-Werror=implicit-function-declaration]
    1315 |   reg = rd32(hw, I40E_VFINT_ICR0_ENA(vf_id)) &
         |                  ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_osdep.h:27:45: note: in definition of macro 'rd32'
      27 | #define rd32(a, reg)  readl((a)->hw_addr + (reg))
         |                                             ^~~
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1316:7: error: 'I40E_VFINT_ICR0_ADMINQ_MASK' undeclared (first use in this function); did you mean 'I40E_PFINT_ICR0_ADMINQ_MASK'?
    1316 |       I40E_VFINT_ICR0_ADMINQ_MASK;
         |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |       I40E_PFINT_ICR0_ADMINQ_MASK
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1316:7: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_trigger_vf_reset':
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1360:8: error: 'I40E_VFINT_ICR0_ADMINQ_MASK' undeclared (first use in this function); did you mean 'I40E_PFINT_ICR0_ADMINQ_MASK'?
    1360 |        I40E_VFINT_ICR0_ADMINQ_MASK;
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |        I40E_PFINT_ICR0_ADMINQ_MASK
   cc1: some warnings being treated as errors

vim +1315 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

  1299	
  1300	/**
  1301	* i40e_sync_vfr_reset
  1302	* @hw: pointer to hw struct
  1303	* @vf_id: VF identifier
  1304	*
  1305	* Before trigger hardware reset, we need to know if no other process has
  1306	* reserved the hardware for any reset operations. This check is done by
  1307	* examining the status of the ADMINQ bit in VF interrupt register.
  1308	**/
  1309	static int i40e_sync_vfr_reset(struct i40e_hw *hw, int vf_id)
  1310	{
  1311		u32 reg;
  1312		int i;
  1313	
  1314		for (i = 0; i < I40E_VFR_WAIT_COUNT; i++) {
> 1315			reg = rd32(hw, I40E_VFINT_ICR0_ENA(vf_id)) &
> 1316				   I40E_VFINT_ICR0_ADMINQ_MASK;
  1317			if (reg)
  1318				return 0;
  1319	
  1320			usleep_range(10, 200);
  1321		}
  1322	
  1323		return -EAGAIN;
  1324	}
  1325	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28591 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201208/5cd5ec94/attachment-0001.bin>
