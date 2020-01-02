From: kbuild test robot <lkp@intel.com>
Date: Thu, 2 Jan 2020 14:18:08 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 11/76]
 drivers/net/ethernet/intel/igc/igc_main.c:143:13: error: redefinition of
 'igc_power_down_link'
Message-ID: <202001021405.ZRJt5NUL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   74c2ae1254468e2c3db1ff410175525a465488a3
commit: 9f6846ba9643830c95a59ec950c1e4ba2afb08fc [11/76] igc: Remove no need declaration of the igc_power_down_link
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        git checkout 9f6846ba9643830c95a59ec950c1e4ba2afb08fc
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/igc/igc_main.c:143:13: error: redefinition of 'igc_power_down_link'
    static void igc_power_down_link(struct igc_adapter *adapter)
                ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:82:13: note: previous definition of 'igc_power_down_link' was here
    static void igc_power_down_link(struct igc_adapter *adapter)
                ^~~~~~~~~~~~~~~~~~~

vim +/igc_power_down_link +143 drivers/net/ethernet/intel/igc/igc_main.c

c9a11c23ceb65d Sasha Neftin 2018-10-11  138  
c9a11c23ceb65d Sasha Neftin 2018-10-11  139  /**
684ea87cc312c9 Sasha Neftin 2019-12-02  140   * igc_power_down_link - Power down the phy link
c9a11c23ceb65d Sasha Neftin 2018-10-11  141   * @adapter: address of board private structure
c9a11c23ceb65d Sasha Neftin 2018-10-11  142   */
c9a11c23ceb65d Sasha Neftin 2018-10-11 @143  static void igc_power_down_link(struct igc_adapter *adapter)
c9a11c23ceb65d Sasha Neftin 2018-10-11  144  {
5586838fe9ced0 Sasha Neftin 2018-10-11  145  	if (adapter->hw.phy.media_type == igc_media_type_copper)
5586838fe9ced0 Sasha Neftin 2018-10-11  146  		igc_power_down_phy_copper_base(&adapter->hw);
c9a11c23ceb65d Sasha Neftin 2018-10-11  147  }
c9a11c23ceb65d Sasha Neftin 2018-10-11  148  

:::::: The code at line 143 was first introduced by commit
:::::: c9a11c23ceb65db7ecc5735e7428311d70e74ba9 igc: Add netdev

:::::: TO: Sasha Neftin <sasha.neftin@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 70432 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200102/1562f7f6/attachment-0001.bin>
