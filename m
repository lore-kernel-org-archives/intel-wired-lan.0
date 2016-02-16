From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 16 Feb 2016 12:10:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 151/154]
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:1119:3: error: implicit
 declaration of function 'FM10K_WRITE_REG'
Message-ID: <201602161227.R20yga4r%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   c72b5dfa8ce58dc105ed3b31fc7a44664cbbb62f
commit: 63b8ecfecdb2e7222cd3e99f169b68f6b5d00b62 [151/154] fm10k: use ethtool_rxfh_indir_default for default redirection table
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 63b8ecfecdb2e7222cd3e99f169b68f6b5d00b62
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c: In function 'fm10k_write_reta':
>> drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:1119:3: error: implicit declaration of function 'FM10K_WRITE_REG' [-Werror=implicit-function-declaration]
      FM10K_WRITE_REG(hw, FM10K_RETA(0, i), reta);
      ^
   cc1: some warnings being treated as errors

vim +/FM10K_WRITE_REG +1119 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c

  1113				   (indir[3] << 24);
  1114	
  1115			if (interface->reta[i] == reta)
  1116				continue;
  1117	
  1118			interface->reta[i] = reta;
> 1119			FM10K_WRITE_REG(hw, FM10K_RETA(0, i), reta);
  1120		}
  1121	}
  1122	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44070 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160216/9fa3e52d/attachment-0001.obj>
