From: kbuild test robot <lkp@intel.com>
Date: Wed, 7 Oct 2015 06:09:28 +0800
Subject: [Intel-wired-lan] [PATCH] igb: improve handling of disconnected
	adapters
In-Reply-To: <1444168362-39101-1-git-send-email-jarod@redhat.com>
Message-ID: <201510070652.mFIXT2AO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jarod,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: i386-randconfig-x009-201540 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_request_msix':
>> drivers/net/ethernet/intel/igb/igb_main.c:962:35: error: 'struct igb_adapter' has no member named 'io_addr'
      q_vector->itr_register = adapter->io_addr + E1000_EITR(vector);
                                      ^
>> drivers/net/ethernet/intel/igb/igb_main.c:949:19: warning: unused variable 'hw' [-Wunused-variable]
     struct e1000_hw *hw = &adapter->hw;
                      ^
   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_alloc_q_vector':
   drivers/net/ethernet/intel/igb/igb_main.c:1233:34: error: 'struct igb_adapter' has no member named 'io_addr'
     q_vector->itr_register = adapter->io_addr + E1000_EITR(0);
                                     ^
   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_configure_tx_ring':
   drivers/net/ethernet/intel/igb/igb_main.c:3282:22: error: 'struct igb_adapter' has no member named 'io_addr'
     ring->tail = adapter->io_addr + E1000_TDT(reg_idx);
                         ^
   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_configure_rx_ring':
   drivers/net/ethernet/intel/igb/igb_main.c:3638:22: error: 'struct igb_adapter' has no member named 'io_addr'
     ring->tail = adapter->io_addr + E1000_RDT(reg_idx);
                         ^

vim +962 drivers/net/ethernet/intel/igb/igb_main.c

   943	 *  igb_request_msix allocates MSI-X vectors and requests interrupts from the
   944	 *  kernel.
   945	 **/
   946	static int igb_request_msix(struct igb_adapter *adapter)
   947	{
   948		struct net_device *netdev = adapter->netdev;
 > 949		struct e1000_hw *hw = &adapter->hw;
   950		int i, err = 0, vector = 0, free_vector = 0;
   951	
   952		err = request_irq(adapter->msix_entries[vector].vector,
   953				  igb_msix_other, 0, netdev->name, adapter);
   954		if (err)
   955			goto err_out;
   956	
   957		for (i = 0; i < adapter->num_q_vectors; i++) {
   958			struct igb_q_vector *q_vector = adapter->q_vector[i];
   959	
   960			vector++;
   961	
 > 962			q_vector->itr_register = adapter->io_addr + E1000_EITR(vector);
   963	
   964			if (q_vector->rx.ring && q_vector->tx.ring)
   965				sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24334 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151007/212bf100/attachment-0001.obj>
