From: kbuild test robot <lkp@intel.com>
Date: Tue, 2 Feb 2016 19:09:01 +0800
Subject: [Intel-wired-lan] [PATCH net-next 6/6] e1000e: call ndo_stop()
 instead of dev_close() when running offline selftest
In-Reply-To: <1454408028-16986-7-git-send-email-sassmann@kpanic.de>
Message-ID: <201602021913.dM8IZesl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Stefan,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Stefan-Assmann/net-intel-call-ndo_stop-instead-of-dev_close-when-running-offline-selftest/20160202-182015
config: i386-defconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/built-in.o: In function `e1000_close':
>> (.text+0x1c1a0): multiple definition of `e1000_close'
   drivers/net/ethernet/intel/e1000/built-in.o:(.text+0x5290): first defined here
   drivers/net/ethernet/intel/e1000e/built-in.o: In function `e1000_open':
>> (.text+0x1a950): multiple definition of `e1000_open'
   drivers/net/ethernet/intel/e1000/built-in.o:(.text+0x7b70): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24323 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160202/f4c5b3ad/attachment-0001.obj>
