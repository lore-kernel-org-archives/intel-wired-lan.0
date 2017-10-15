From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 15 Oct 2017 10:33:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE 5/9]
 i40e_main.c:undefined reference to `__aeabi_uldivmod'
Message-ID: <201710151042.QpG11BMa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git 40GbE
head:   17a9422de78c3a59b490b400f555635c477f1476
commit: 5ecae4120a6b50fb8a31d2f335eab390bcf5ad66 [5/9] i40e: Refactor VF BW rate limiting
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5ecae4120a6b50fb8a31d2f335eab390bcf5ad66
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.o: In function `i40e_set_bw_limit':
>> i40e_main.c:(.text+0xac38): undefined reference to `__aeabi_uldivmod'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63402 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171015/380355e4/attachment-0001.bin>
