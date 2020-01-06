From: kbuild test robot <lkp@intel.com>
Date: Mon, 6 Jan 2020 11:48:57 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 41/42]
 drivers/net/ethernet/intel/i40e/i40e_adminq.c:542:27: error:
 'I40E_MINOR_VER_GET_LINK_INFO_X722' undeclared;
 did you mean 'I40E_MINOR_VER_GET_LINK_INFO_XL710'?
Message-ID: <202001061134.jUCIboIJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   77be7962ad5b5f8a0e63b4fe7327f73e14fbabfc
commit: 90f02f03929d9be6369526831745bc8cdddd9262 [41/42] i40e: remove unused defines
config: x86_64-lkp (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        git checkout 90f02f03929d9be6369526831745bc8cdddd9262
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_adminq.c: In function 'i40e_set_hw_flags':
>> drivers/net/ethernet/intel/i40e/i40e_adminq.c:542:27: error: 'I40E_MINOR_VER_GET_LINK_INFO_X722' undeclared (first use in this function); did you mean 'I40E_MINOR_VER_GET_LINK_INFO_XL710'?
           aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_X722))
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                              I40E_MINOR_VER_GET_LINK_INFO_XL710
   drivers/net/ethernet/intel/i40e/i40e_adminq.c:542:27: note: each undeclared identifier is reported only once for each function it appears in

vim +542 drivers/net/ethernet/intel/i40e/i40e_adminq.c

56a62fc8689509 Jesse Brandeburg 2013-09-11  509  
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  510  /**
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  511   *  i40e_set_hw_flags - set HW flags
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  512   *  @hw: pointer to the hardware structure
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  513   **/
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  514  static void i40e_set_hw_flags(struct i40e_hw *hw)
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  515  {
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  516  	struct i40e_adminq_info *aq = &hw->aq;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  517  
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  518  	hw->flags = 0;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  519  
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  520  	switch (hw->mac.type) {
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  521  	case I40E_MAC_XL710:
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  522  		if (aq->api_maj_ver > 1 ||
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  523  		    (aq->api_maj_ver == 1 &&
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  524  		     aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710)) {
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  525  			hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  526  			hw->flags |= I40E_HW_FLAG_FW_LLDP_STOPPABLE;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  527  			/* The ability to RX (not drop) 802.1ad frames */
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  528  			hw->flags |= I40E_HW_FLAG_802_1AD_CAPABLE;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  529  		}
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  530  		break;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  531  	case I40E_MAC_X722:
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  532  		hw->flags |= I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE |
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  533  			     I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  534  
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  535  		if (aq->api_maj_ver > 1 ||
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  536  		    (aq->api_maj_ver == 1 &&
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  537  		     aq->api_min_ver >= I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722))
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  538  			hw->flags |= I40E_HW_FLAG_FW_LLDP_STOPPABLE;
414d89be0b7dfb Adam Ludkiewicz  2020-01-04  539  
414d89be0b7dfb Adam Ludkiewicz  2020-01-04  540  		if (aq->api_maj_ver > 1 ||
414d89be0b7dfb Adam Ludkiewicz  2020-01-04  541  		    (aq->api_maj_ver == 1 &&
414d89be0b7dfb Adam Ludkiewicz  2020-01-04 @542  		     aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_X722))
414d89be0b7dfb Adam Ludkiewicz  2020-01-04  543  			hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  544  		/* fall through */
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  545  	default:
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  546  		break;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  547  	}
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  548  
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  549  	/* Newer versions of firmware require lock when reading the NVM */
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  550  	if (aq->api_maj_ver > 1 ||
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  551  	    (aq->api_maj_ver == 1 &&
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  552  	     aq->api_min_ver >= 5))
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  553  		hw->flags |= I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  554  
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  555  	if (aq->api_maj_ver > 1 ||
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  556  	    (aq->api_maj_ver == 1 &&
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  557  	     aq->api_min_ver >= 8)) {
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  558  		hw->flags |= I40E_HW_FLAG_FW_LLDP_PERSISTENT;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  559  		hw->flags |= I40E_HW_FLAG_DROP_MODE;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  560  	}
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  561  
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  562  	if (aq->api_maj_ver > 1 ||
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  563  	    (aq->api_maj_ver == 1 &&
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  564  	     aq->api_min_ver >= 9))
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  565  		hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_EXTENDED;
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  566  }
a3e09ded6a6d4b Piotr Azarewicz  2019-09-20  567  

:::::: The code at line 542 was first introduced by commit
:::::: 414d89be0b7dfb698280dabe223c8ca5059cf493 i40e: Set PHY Access flag on X722

:::::: TO: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28829 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200106/6d897908/attachment-0001.bin>
