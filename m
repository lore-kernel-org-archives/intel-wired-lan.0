From: kbuild test robot <lkp@intel.com>
Date: Sat, 27 Oct 2018 02:46:23 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:master 12/14]
 drivers/net/ethernet/mellanox/mlx4/en_rx.c:586:20: error: dereferencing
 pointer to incomplete type 'struct iphdr'
Message-ID: <201810270220.mdBPprX4%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git master
head:   bf4cc40e9343bbe6c7400ff6f4feb46fb9338087
commit: 55469bc6b5770ffdf0f87c38ce2573f8ddbaa33f [12/14] drivers: net: remove <net/busy_poll.h> inclusion when not needed
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 55469bc6b5770ffdf0f87c38ce2573f8ddbaa33f
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx4/en_rx.c:582:18: warning: 'struct iphdr' declared inside parameter list will not be visible outside of this definition or declaration
              struct iphdr *iph)
                     ^~~~~
   drivers/net/ethernet/mellanox/mlx4/en_rx.c: In function 'get_fixed_ipv4_csum':
>> drivers/net/ethernet/mellanox/mlx4/en_rx.c:586:20: error: dereferencing pointer to incomplete type 'struct iphdr'
     __u8 ipproto = iph->protocol;
                       ^~

vim +586 drivers/net/ethernet/mellanox/mlx4/en_rx.c

f8c6455bb Shani Michaeli 2014-11-09  576  
f8c6455bb Shani Michaeli 2014-11-09  577  /* Although the stack expects checksum which doesn't include the pseudo
f8c6455bb Shani Michaeli 2014-11-09  578   * header, the HW adds it. To address that, we are subtracting the pseudo
f8c6455bb Shani Michaeli 2014-11-09  579   * header checksum from the checksum value provided by the HW.
f8c6455bb Shani Michaeli 2014-11-09  580   */
e718fe450 Davide Caratti 2017-08-03  581  static int get_fixed_ipv4_csum(__wsum hw_checksum, struct sk_buff *skb,
f8c6455bb Shani Michaeli 2014-11-09 @582  			       struct iphdr *iph)
f8c6455bb Shani Michaeli 2014-11-09  583  {
f8c6455bb Shani Michaeli 2014-11-09  584  	__u16 length_for_csum = 0;
f8c6455bb Shani Michaeli 2014-11-09  585  	__wsum csum_pseudo_header = 0;
e718fe450 Davide Caratti 2017-08-03 @586  	__u8 ipproto = iph->protocol;
e718fe450 Davide Caratti 2017-08-03  587  
e718fe450 Davide Caratti 2017-08-03  588  	if (unlikely(ipproto == IPPROTO_SCTP))
e718fe450 Davide Caratti 2017-08-03  589  		return -1;
f8c6455bb Shani Michaeli 2014-11-09  590  
f8c6455bb Shani Michaeli 2014-11-09  591  	length_for_csum = (be16_to_cpu(iph->tot_len) - (iph->ihl << 2));
f8c6455bb Shani Michaeli 2014-11-09  592  	csum_pseudo_header = csum_tcpudp_nofold(iph->saddr, iph->daddr,
e718fe450 Davide Caratti 2017-08-03  593  						length_for_csum, ipproto, 0);
f8c6455bb Shani Michaeli 2014-11-09  594  	skb->csum = csum_sub(hw_checksum, csum_pseudo_header);
e718fe450 Davide Caratti 2017-08-03  595  	return 0;
f8c6455bb Shani Michaeli 2014-11-09  596  }
f8c6455bb Shani Michaeli 2014-11-09  597  

:::::: The code at line 586 was first introduced by commit
:::::: e718fe450e616227b74d27a233cdf37b4df0c82b net/mlx4_en: don't set CHECKSUM_COMPLETE on SCTP packets

:::::: TO: Davide Caratti <dcaratti@redhat.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23972 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181027/840c3395/attachment-0001.bin>
