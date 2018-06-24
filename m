From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 Jun 2018 20:33:59 +0800
Subject: [Intel-wired-lan] [PATCH v3 03/11] igc: Add netdev
In-Reply-To: <20180624084503.10065-1-sasha.neftin@intel.com>
References: <20180624084503.10065-1-sasha.neftin@intel.com>
Message-ID: <201806242041.Vf0MGPVy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sasha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.18-rc1 next-20180622]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sasha-Neftin/igc-Add-skeletal-frame-for-Intel-R-2-5G-Ethernet-Controller-support/20180624-164739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/igc/igc_main.c:37:6: sparse: symbol 'igc_reset' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:47:6: sparse: symbol 'igc_power_up_link' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:74:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:74:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:74:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:93:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:93:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:93:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:147:5: sparse: symbol 'igc_up' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:166:6: sparse: symbol 'igc_down' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:230:6: sparse: symbol 'igc_update_stats' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:289:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:289:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:289:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:291:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:291:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:291:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:350:5: sparse: symbol 'igc_open' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:379:5: sparse: symbol 'igc_close' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:443:31: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:443:31:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:443:31:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:545:21: sparse: incorrect type in assignment (different address spaces) @@    expected unsigned char [usertype] *hw_addr @@    got unsigned char [nounsigned char [usertype] *hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:545:21:    expected unsigned char [usertype] *hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:545:21:    got unsigned char [noderef] [usertype] <asn:2>*io_addr

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
