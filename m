From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Dec 2020 20:15:42 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 8/111]
 drivers/net/ethernet/intel/i40e/i40e_txrx.c:547:6: warning: variable 'ret'
 set but not used
Message-ID: <202012112037.Q6fAKQrG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   48d91eba0c7d674de08e9c66fcd67a2b742f8b7a
commit: 0d18a45d3255af770e8bf428d3b5c0fa7071f192 [8/111] i40e: VLAN field for flow director
config: parisc-randconfig-r033-20201209 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=0d18a45d3255af770e8bf428d3b5c0fa7071f192
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 0d18a45d3255af770e8bf428d3b5c0fa7071f192
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_add_del_fdir_ip':
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:547:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     547 |  int ret;
         |      ^~~

vim +/ret +547 drivers/net/ethernet/intel/i40e/i40e_txrx.c

f223c8752a0b756 Jacob Keller          2017-02-06  524  
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  525  #define I40E_IP_DUMMY_PACKET_LEN	34
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  526  #define I40E_IP6_DUMMY_PACKET_LEN	54
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  527  /**
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  528   * i40e_add_del_fdir_ip - Add/Remove IPv4 Flow Director filters for
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  529   * a specific flow spec
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  530   * @vsi: pointer to the targeted VSI
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  531   * @fd_data: the flow director data required for the FDir descriptor
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  532   * @add: true adds a filter, false removes it
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  533   * @ipv4: true is v4, false is v6
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  534   *
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  535   * Returns 0 if the filters were successfully added or removed
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  536   **/
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  537  static int i40e_add_del_fdir_ip(struct i40e_vsi *vsi,
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  538  				struct i40e_fdir_filter *fd_data,
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  539  				bool add,
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  540  				bool ipv4)
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  541  {
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  542  	struct i40e_pf *pf = vsi->back;
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  543  	int payload_offset;
49d7d9333163756 Anjali Singhai Jain   2014-06-04  544  	u8 *raw_packet;
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  545  	int iter_start;
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  546  	int iter_end;
17a73f6b14010d4 Joseph Gasparakis     2014-02-12 @547  	int ret;
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  548  	int i;
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  549  
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  550  	if (ipv4) {
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  551  		iter_start = I40E_FILTER_PCTYPE_NONF_IPV4_OTHER;
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  552  		iter_end = I40E_FILTER_PCTYPE_FRAG_IPV4;
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  553  	} else {
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  554  		iter_start = I40E_FILTER_PCTYPE_NONF_IPV6_OTHER;
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  555  		iter_end = I40E_FILTER_PCTYPE_FRAG_IPV6;
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  556  	}
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  557  
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  558  	for (i = iter_start; i <= iter_end; i++) {
49d7d9333163756 Anjali Singhai Jain   2014-06-04  559  		raw_packet = kzalloc(I40E_FDIR_MAX_RAW_PACKET_SIZE, GFP_KERNEL);
49d7d9333163756 Anjali Singhai Jain   2014-06-04  560  		if (!raw_packet)
49d7d9333163756 Anjali Singhai Jain   2014-06-04  561  			return -ENOMEM;
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  562  
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  563  		/* IPv6 no header option differs from IPv4 */
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  564  		(void)i40e_create_dummy_packet
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  565  			(raw_packet, ipv4, (ipv4) ? IPPROTO_IP : IPPROTO_NONE,
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  566  			 fd_data);
0e588de17f086c3 Jacob Keller          2017-02-06  567  
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  568  		payload_offset = (ipv4) ? I40E_IP_DUMMY_PACKET_LEN :
7d00e937cd081ff Przemyslaw Patynowski 2020-10-21  569  			I40E_IP6_DUMMY_PACKET_LEN;
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  570  		ret = i40e_prepare_fdir_filter(pf, fd_data, add, raw_packet,
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  571  					       payload_offset, i);
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  572  	}
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  573  
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  574  	i40e_change_filter_num(ipv4, add, &pf->fd_ip4_filter_cnt,
0d18a45d3255af7 Przemyslaw Patynowski 2020-10-21  575  			       &pf->fd_ip6_filter_cnt);
097dbf52505962d Jacob Keller          2017-02-06  576  
e5187ee3ee9a95b Jacob Keller          2017-02-06  577  	return 0;
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  578  }
17a73f6b14010d4 Joseph Gasparakis     2014-02-12  579  

:::::: The code at line 547 was first introduced by commit
:::::: 17a73f6b14010d4516a05f52e3c87431e86edebb i40e: Flow Director sideband accounting

:::::: TO: Joseph Gasparakis <joseph.gasparakis@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28892 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201211/3a8b580f/attachment-0001.bin>
