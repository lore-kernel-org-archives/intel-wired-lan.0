From: kbuild test robot <lkp@intel.com>
Date: Tue, 24 Jul 2018 05:04:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:XDP-hints-EXPERIMENTAL 1/1]
 drivers/net/ethernet/intel/i40e/i40e_txrx.c:2299:14: sparse: symbol
 'len_ethhdr' was not declared. Should it be static?
Message-ID: <201807240548.0XzJcSzH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git XDP-hints-EXPERIMENTAL
head:   58e0270bb7ac94a31ff0fe372385cfce4198b56c
commit: 58e0270bb7ac94a31ff0fe372385cfce4198b56c [1/1] i40e: Initial support to add hw hints for xdp
reproduce:
        # apt-get install sparse
        git checkout 58e0270bb7ac94a31ff0fe372385cfce4198b56c
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/i40e/i40e_txrx.c:1118:23: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:1118:23: sparse: expression using sizeof(void)
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2299:14: sparse: symbol 'len_ethhdr' was not declared. Should it be static?
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2300:14: sparse: symbol 'len_ipv4hdr' was not declared. Should it be static?
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2301:14: sparse: symbol 'len_ipv6hdr' was not declared. Should it be static?
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2346:38: sparse: missing braces around initializer
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2350:47: sparse: incorrect type in initializer (different base types) @@    expected unsigned long long [unsigned] [usertype] stserr @@    got g long [unsigned] [usertype] stserr @@
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:2350:47:    expected unsigned long long [unsigned] [usertype] stserr
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:2350:47:    got restricted __le64 [usertype] status_error_len
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2438:36: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [assigned] [usertype] hash @@    got igned] [assigned] [usertype] hash @@
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:2438:36:    expected unsigned int [unsigned] [assigned] [usertype] hash
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:2438:36:    got restricted __le32 [usertype] rss
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:2761:27: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:2809:16: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:2809:16: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
