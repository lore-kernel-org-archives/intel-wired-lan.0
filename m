From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 11 Sep 2017 23:54:51 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 102/105]
 i40e_main.c:undefined reference to `__aeabi_uldivmod'
Message-ID: <201709112348.Pe99z3A4%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   41b1c9748ccae5d2f00d6f9e4d723906641a8ec3
commit: a52f4470a49ba8605b8e9e2195f9e27e3e6a5f13 [102/105] i40e: Refactor VF BW rate limiting
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a52f4470a49ba8605b8e9e2195f9e27e3e6a5f13
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
Size: 63184 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170911/8d1c7daa/attachment-0001.bin>
