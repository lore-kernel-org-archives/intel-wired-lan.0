From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 4 Feb 2016 18:46:42 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 27/156]
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:417:170: error: call to
 '__compiletime_assert_417' declared with attribute error: BUILD_BUG_ON
 failed: idx != FM10K_REGS_LEN_VSI
Message-ID: <201602041840.VgN6ZKEA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   3414fa0b881883c29af690c383f9941bf6aa0b51
commit: a4defe2f481c340baafc3b09d0b917b646a42626 [27/156] fm10k: Avoid crashing the kernel
config: i386-allyesconfig (attached as .config)
reproduce:
        git checkout a4defe2f481c340baafc3b09d0b917b646a42626
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c: In function 'fm10k_get_reg_vsi':
>> drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:417:170: error: call to '__compiletime_assert_417' declared with attribute error: BUILD_BUG_ON failed: idx != FM10K_REGS_LEN_VSI

vim +/__compiletime_assert_417 +417 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c

   411		buff[idx++] = fm10k_read_reg(hw, FM10K_MRQC(i));
   412		for (j = 0; j < 10; j++)
   413			buff[idx++] = fm10k_read_reg(hw, FM10K_RSSRK(i, j));
   414		for (j = 0; j < 32; j++)
   415			buff[idx++] = fm10k_read_reg(hw, FM10K_RETA(i, j));
   416	
 > 417		BUILD_BUG_ON(idx != FM10K_REGS_LEN_VSI);
   418	}
   419	
   420	static void fm10k_get_regs(struct net_device *netdev,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 52836 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160204/d06a9e46/attachment-0001.obj>
