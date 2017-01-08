From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 8 Jan 2017 17:34:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 91/94]
 drivers/net/ethernet/intel/igb/igb_main.c:6999:7: error: invalid operands
 to binary - (have 'unsigned char *' and 'void *')
Message-ID: <201701081738.B9cF5dao%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   9411d80b16a0693f4e3557cdfeddb61dac150dc3
commit: 621f9f6c3a16b125e7adc91987ba4dad5b9f912e [91/94] igb: Add support for padding packet
config: i386-randconfig-x007-201702 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 621f9f6c3a16b125e7adc91987ba4dad5b9f912e
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the jkirsher-next-queue/dev-queue HEAD 9411d80b16a0693f4e3557cdfeddb61dac150dc3 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_add_rx_frag':
>> drivers/net/ethernet/intel/igb/igb_main.c:6999:7: error: invalid operands to binary - (have 'unsigned char *' and 'void *')
       va - page_address(page), size, truesize);
          ^

vim +6999 drivers/net/ethernet/intel/igb/igb_main.c

  6993		/* update all of the pointers */
  6994		va += pull_len;
  6995		size -= pull_len;
  6996	
  6997	add_tail_frag:
  6998		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
> 6999				va - page_address(page), size, truesize);
  7000	
  7001		return igb_can_reuse_rx_page(rx_buffer, page, truesize);
  7002	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29745 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170108/81fbb7ba/attachment-0001.bin>
