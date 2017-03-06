From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 6 Mar 2017 11:18:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 31/102]
 drivers/net/ethernet/intel/i40e/i40e_txrx.c:1844:61: error: 'lpbk'
 undeclared
Message-ID: <201703061136.8tkIisdt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   bd17d7702c8c3ef35b01d5acdad6790cecb86562
commit: c592e42ff5b7cee367b7ab8f1d129c621cbf6e4b [31/102] i40e: Add TX and RX support in switchdev mode
config: x86_64-rhel-7.2.dx (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout c592e42ff5b7cee367b7ab8f1d129c621cbf6e4b
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_clean_rx_irq':
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:1844:61: error: 'lpbk' undeclared (first use in this function)
      i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype, &lpbk);
                                                                ^~~~
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:1844:61: note: each undeclared identifier is reported only once for each function it appears in

vim +/lpbk +1844 drivers/net/ethernet/intel/i40e/i40e_txrx.c

  1838	
  1839			qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
  1840			rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
  1841				   I40E_RXD_QW1_PTYPE_SHIFT;
  1842	
  1843			/* populate checksum, VLAN, and protocol */
> 1844			i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype, &lpbk);
  1845	
  1846	#ifdef I40E_FCOE
  1847			if (unlikely(

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38644 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170306/b4914b64/attachment-0001.bin>
