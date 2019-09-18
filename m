From: kbuild test robot <lkp@intel.com>
Date: Wed, 18 Sep 2019 09:23:39 +0800
Subject: [Intel-wired-lan] [PATCH] ethernet/intel: release the local
 packet buffer
In-Reply-To: <20190918000013.32083-1-navid.emamdoost@gmail.com>
References: <20190918000013.32083-1-navid.emamdoost@gmail.com>
Message-ID: <201909180905.RsHmoV4Y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Navid,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3 next-20190917]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Navid-Emamdoost/ethernet-intel-release-the-local-packet-buffer/20190918-080148
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from include/linux/if_ether.h:19:0,
                    from include/uapi/linux/ethtool.h:19,
                    from include/linux/ethtool.h:18,
                    from include/linux/netdevice.h:37,
                    from drivers/net/ethernet/intel/e100.c:140:
   drivers/net/ethernet/intel/e100.c: In function 'e100_loopback_test':
>> include/linux/skbuff.h:1149:26: warning: 'skb' may be used uninitialized in this function [-Wmaybe-uninitialized]
    #define dev_kfree_skb(a) consume_skb(a)
                             ^~~~~~~~~~~
   drivers/net/ethernet/intel/e100.c:2347:18: note: 'skb' was declared here
     struct sk_buff *skb;
                     ^~~
--
   In file included from include/linux/if_ether.h:19:0,
                    from include/uapi/linux/ethtool.h:19,
                    from include/linux/ethtool.h:18,
                    from include/linux/netdevice.h:37,
                    from drivers/net//ethernet/intel/e100.c:140:
   drivers/net//ethernet/intel/e100.c: In function 'e100_loopback_test':
>> include/linux/skbuff.h:1149:26: warning: 'skb' may be used uninitialized in this function [-Wmaybe-uninitialized]
    #define dev_kfree_skb(a) consume_skb(a)
                             ^~~~~~~~~~~
   drivers/net//ethernet/intel/e100.c:2347:18: note: 'skb' was declared here
     struct sk_buff *skb;
                     ^~~

vim +/skb +1149 include/linux/skbuff.h

cd0a137acbb662 Florian Fainelli 2017-08-22  1133  
cd0a137acbb662 Florian Fainelli 2017-08-22  1134  /**
cd0a137acbb662 Florian Fainelli 2017-08-22  1135   *	skb_pad			-	zero pad the tail of an skb
cd0a137acbb662 Florian Fainelli 2017-08-22  1136   *	@skb: buffer to pad
cd0a137acbb662 Florian Fainelli 2017-08-22  1137   *	@pad: space to pad
cd0a137acbb662 Florian Fainelli 2017-08-22  1138   *
cd0a137acbb662 Florian Fainelli 2017-08-22  1139   *	Ensure that a buffer is followed by a padding area that is zero
cd0a137acbb662 Florian Fainelli 2017-08-22  1140   *	filled. Used by network drivers which may DMA or transfer data
cd0a137acbb662 Florian Fainelli 2017-08-22  1141   *	beyond the buffer end onto the wire.
cd0a137acbb662 Florian Fainelli 2017-08-22  1142   *
cd0a137acbb662 Florian Fainelli 2017-08-22  1143   *	May return error in out of memory cases. The skb is freed on error.
cd0a137acbb662 Florian Fainelli 2017-08-22  1144   */
cd0a137acbb662 Florian Fainelli 2017-08-22  1145  static inline int skb_pad(struct sk_buff *skb, int pad)
cd0a137acbb662 Florian Fainelli 2017-08-22  1146  {
cd0a137acbb662 Florian Fainelli 2017-08-22  1147  	return __skb_pad(skb, pad, true);
cd0a137acbb662 Florian Fainelli 2017-08-22  1148  }
ead2ceb0ec9f85 Neil Horman      2009-03-11 @1149  #define dev_kfree_skb(a)	consume_skb(a)
^1da177e4c3f41 Linus Torvalds   2005-04-16  1150  

:::::: The code at line 1149 was first introduced by commit
:::::: ead2ceb0ec9f85cff19c43b5cdb2f8a054484431 Network Drop Monitor: Adding kfree_skb_clean for non-drops and modifying end-of-line points for skbs

:::::: TO: Neil Horman <nhorman@tuxdriver.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58748 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190918/1bb11564/attachment-0001.bin>
