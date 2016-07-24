From: kbuild test robot <lkp@intel.com>
Date: Mon, 25 Jul 2016 04:30:18 +0800
Subject: [Intel-wired-lan] [PATCH net] e1000e: fix PTP on e1000_pch_lpt
 variants
In-Reply-To: <1468959902-25071-1-git-send-email-jarod@redhat.com>
Message-ID: <201607250439.jvkdGqDT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test ERROR on net/master]

url:    https://github.com/0day-ci/linux/commits/Jarod-Wilson/e1000e-fix-PTP-on-e1000_pch_lpt-variants/20160725-040850
config: i386-randconfig-x001-201630 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/netdev.c: In function 'e1000e_cyclecounter_read':
>> drivers/net/ethernet/intel/e1000e/netdev.c:4342:3: error: a label can only be part of a statement and a declaration is not a statement
      u64 time_delta, rem, temp;
      ^~~
>> drivers/net/ethernet/intel/e1000e/netdev.c:4343:3: error: expected expression before 'u32'
      u32 incvalue;
      ^~~
>> drivers/net/ethernet/intel/e1000e/netdev.c:4344:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      int i;
      ^~~
>> drivers/net/ethernet/intel/e1000e/netdev.c:4350:3: error: 'incvalue' undeclared (first use in this function)
      incvalue = er32(TIMINCA) & E1000_TIMINCA_INCVALUE_MASK;
      ^~~~~~~~
   drivers/net/ethernet/intel/e1000e/netdev.c:4350:3: note: each undeclared identifier is reported only once for each function it appears in

vim +4342 drivers/net/ethernet/intel/e1000e/netdev.c

ab507c9a Denys Vlasenko 2016-04-20  4336  	systim |= (cycle_t)systimeh << 32;
b67e1913 Bruce Allan    2012-12-27  4337  
cf608919 Jarod Wilson   2016-07-19  4338  	switch (hw->mac.type) {
cf608919 Jarod Wilson   2016-07-19  4339  	case e1000_82574:
cf608919 Jarod Wilson   2016-07-19  4340  	case e1000_82583:
cf608919 Jarod Wilson   2016-07-19  4341  	case e1000_pch_lpt:
fb5277f2 Denys Vlasenko 2016-04-20 @4342  		u64 time_delta, rem, temp;
fb5277f2 Denys Vlasenko 2016-04-20 @4343  		u32 incvalue;
5e7ff970 Todd Fujinaka  2014-05-03 @4344  		int i;
5e7ff970 Todd Fujinaka  2014-05-03  4345  
5e7ff970 Todd Fujinaka  2014-05-03  4346  		/* errata for 82574/82583 possible bad bits read from SYSTIMH/L
5e7ff970 Todd Fujinaka  2014-05-03  4347  		 * check to see that the time is incrementing at a reasonable
5e7ff970 Todd Fujinaka  2014-05-03  4348  		 * rate and is a multiple of incvalue
5e7ff970 Todd Fujinaka  2014-05-03  4349  		 */
5e7ff970 Todd Fujinaka  2014-05-03 @4350  		incvalue = er32(TIMINCA) & E1000_TIMINCA_INCVALUE_MASK;
5e7ff970 Todd Fujinaka  2014-05-03  4351  		for (i = 0; i < E1000_MAX_82574_SYSTIM_REREADS; i++) {
5e7ff970 Todd Fujinaka  2014-05-03  4352  			/* latch SYSTIMH on read of SYSTIML */
5e7ff970 Todd Fujinaka  2014-05-03  4353  			systim_next = (cycle_t)er32(SYSTIML);

:::::: The code at line 4342 was first introduced by commit
:::::: fb5277f2c2e4db4a29740ff071072a688892d2df e1000e: e1000e_cyclecounter_read(): incvalue is 32 bits, not 64

:::::: TO: Denys Vlasenko <dvlasenk@redhat.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27508 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160725/8d465673/attachment-0001.obj>
