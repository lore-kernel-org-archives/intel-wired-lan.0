From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 1 Apr 2019 09:55:57 +0300
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 89/89]
 drivers/net/ethernet/intel/i40e/i40e_nvm.c:581 i40e_update_nvm_checksum()
 error: uninitialized symbol 'checksum'.
Message-ID: <20190401065557.GY32613@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   bad1e96b272699629ba8f5b702e52555e39a5f2c
commit: bad1e96b272699629ba8f5b702e52555e39a5f2c [89/89] i40e: Revert ShadowRAM checksum calculation change

smatch warnings:
drivers/net/ethernet/intel/i40e/i40e_nvm.c:581 i40e_update_nvm_checksum() error: uninitialized symbol 'checksum'.

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=bad1e96b272699629ba8f5b702e52555e39a5f2c
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git remote update jkirsher-next-queue
git checkout bad1e96b272699629ba8f5b702e52555e39a5f2c
vim +/checksum +581 drivers/net/ethernet/intel/i40e/i40e_nvm.c

56a62fc8 Jesse Brandeburg  2013-09-11  565  
56a62fc8 Jesse Brandeburg  2013-09-11  566  /**
cd552cb4 Shannon Nelson    2014-07-09  567   * i40e_update_nvm_checksum - Updates the NVM checksum
cd552cb4 Shannon Nelson    2014-07-09  568   * @hw: pointer to hardware structure
cd552cb4 Shannon Nelson    2014-07-09  569   *
cd552cb4 Shannon Nelson    2014-07-09  570   * NVM ownership must be acquired before calling this function and released
cd552cb4 Shannon Nelson    2014-07-09  571   * on ARQ completion event reception by caller.
cd552cb4 Shannon Nelson    2014-07-09  572   * This function will commit SR to NVM.
cd552cb4 Shannon Nelson    2014-07-09  573   **/
cd552cb4 Shannon Nelson    2014-07-09  574  i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw)
cd552cb4 Shannon Nelson    2014-07-09  575  {
0e5229c6 Jean Sacren       2015-10-13  576  	i40e_status ret_code;
bad1e96b Maciej Paczkowski 2019-03-29  577  	u16 checksum;
dd38c583 Jesse Brandeburg  2015-08-26  578  	__le16 le_sum;
cd552cb4 Shannon Nelson    2014-07-09  579  
cd552cb4 Shannon Nelson    2014-07-09  580  	ret_code = i40e_calc_nvm_checksum(hw, &checksum);
dd38c583 Jesse Brandeburg  2015-08-26 @581  	le_sum = cpu_to_le16(checksum);
                                                         ^^^^^^^^^^^^^^^^^^^^
bad1e96b Maciej Paczkowski 2019-03-29  582  	if (!ret_code)
                                                    ^^^^^^^^^
This is obvoiusly not a real bug, but Smatch complains.

cd552cb4 Shannon Nelson    2014-07-09  583  		ret_code = i40e_write_nvm_aq(hw, 0x00, I40E_SR_SW_CHECKSUM_WORD,
dd38c583 Jesse Brandeburg  2015-08-26  584  					     1, &le_sum, true);
cd552cb4 Shannon Nelson    2014-07-09  585  
cd552cb4 Shannon Nelson    2014-07-09  586  	return ret_code;
cd552cb4 Shannon Nelson    2014-07-09  587  }
cd552cb4 Shannon Nelson    2014-07-09  588  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
