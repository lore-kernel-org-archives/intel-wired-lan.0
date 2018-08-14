From: kbuild test robot <lkp@intel.com>
Date: Tue, 14 Aug 2018 13:31:29 +0800
Subject: [Intel-wired-lan] [PATCH next-queue 3/8] ixgbe: add VF ipsec
 management
In-Reply-To: <1534185825-12451-4-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-4-git-send-email-shannon.nelson@oracle.com>
Message-ID: <201808141311.4srvjTmi%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Shannon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[also build test ERROR on v4.18 next-20180813]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shannon-Nelson/ixgbe-ixgbevf-IPsec-offload-support-for-VFs/20180814-074800
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: x86_64-randconfig-v0-08131550 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.o: In function `ixgbe_ipsec_vf_add_sa':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:917: undefined reference to `xfrm_aead_get_byname'
   make[1]: *** [vmlinux] Error 1
   make[1]: Target '_all' not remade because of errors.

vim +917 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c

   862	
   863	/**
   864	 * ixgbe_ipsec_vf_add_sa - translate VF request to SA add
   865	 * @adapter: board private structure
   866	 * @msgbuf: The message buffer
   867	 * @vf: the VF index
   868	 *
   869	 * Make up a new xs and algorithm info from the data sent by the VF.
   870	 * We only need to sketch in just enough to set up the HW offload.
   871	 * Put the resulting offload_handle into the return message to the VF.
   872	 *
   873	 * Returns 0 or error value
   874	 **/
   875	int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
   876	{
   877		struct ixgbe_ipsec *ipsec = adapter->ipsec;
   878		struct xfrm_algo_desc *algo;
   879		struct sa_mbx_msg *sam;
   880		struct xfrm_state *xs;
   881		size_t aead_len;
   882		u16 sa_idx;
   883		u32 pfsa;
   884		int err;
   885	
   886		sam = (struct sa_mbx_msg *)(&msgbuf[1]);
   887		if (!adapter->vfinfo[vf].trusted) {
   888			e_warn(drv, "VF %d attempted to add an IPsec SA\n", vf);
   889			err = -EACCES;
   890			goto err_out;
   891		}
   892	
   893		/* Tx IPsec offload doesn't seem to work on this
   894		 * device, so block these requests for now.
   895		 */
   896		if (!(sam->flags & XFRM_OFFLOAD_INBOUND)) {
   897			err = -ENXIO;
   898			goto err_out;
   899		}
   900	
   901		xs = kzalloc(sizeof(*xs), GFP_KERNEL);
   902		if (unlikely(!xs)) {
   903			err = -ENOMEM;
   904			goto err_out;
   905		}
   906	
   907		xs->xso.flags = sam->flags;
   908		xs->id.spi = sam->spi;
   909		xs->id.proto = sam->proto;
   910		xs->props.family = sam->family;
   911		if (xs->props.family == AF_INET6)
   912			memcpy(&xs->id.daddr.a6, sam->addr, sizeof(xs->id.daddr.a6));
   913		else
   914			memcpy(&xs->id.daddr.a4, sam->addr, sizeof(xs->id.daddr.a4));
   915		xs->xso.dev = adapter->netdev;
   916	
 > 917		algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
   918		if (unlikely(!algo)) {
   919			err = -ENOENT;
   920			goto err_xs;
   921		}
   922	
   923		aead_len = sizeof(*xs->aead) + IXGBE_IPSEC_KEY_BITS / 8;
   924		xs->aead = kzalloc(aead_len, GFP_KERNEL);
   925		if (unlikely(!xs->aead)) {
   926			err = -ENOMEM;
   927			goto err_xs;
   928		}
   929	
   930		xs->props.ealgo = algo->desc.sadb_alg_id;
   931		xs->geniv = algo->uinfo.aead.geniv;
   932		xs->aead->alg_icv_len = IXGBE_IPSEC_AUTH_BITS;
   933		xs->aead->alg_key_len = IXGBE_IPSEC_KEY_BITS;
   934		memcpy(xs->aead->alg_key, sam->key, sizeof(sam->key));
   935		memcpy(xs->aead->alg_name, aes_gcm_name, sizeof(aes_gcm_name));
   936	
   937		/* set up the HW offload */
   938		err = ixgbe_ipsec_add_sa(xs);
   939		if (err)
   940			goto err_aead;
   941	
   942		pfsa = xs->xso.offload_handle;
   943		if (pfsa < IXGBE_IPSEC_BASE_TX_INDEX) {
   944			sa_idx = pfsa - IXGBE_IPSEC_BASE_RX_INDEX;
   945			ipsec->rx_tbl[sa_idx].vf = vf;
   946			ipsec->rx_tbl[sa_idx].mode |= IXGBE_RXTXMOD_VF;
   947		} else {
   948			sa_idx = pfsa - IXGBE_IPSEC_BASE_TX_INDEX;
   949			ipsec->tx_tbl[sa_idx].vf = vf;
   950			ipsec->tx_tbl[sa_idx].mode |= IXGBE_RXTXMOD_VF;
   951		}
   952	
   953		msgbuf[1] = xs->xso.offload_handle;
   954	
   955		return 0;
   956	
   957	err_aead:
   958		memset(xs->aead, 0, sizeof(*xs->aead));
   959		kfree(xs->aead);
   960	err_xs:
   961		memset(xs, 0, sizeof(*xs));
   962		kfree(xs);
   963	err_out:
   964		msgbuf[1] = err;
   965		return err;
   966	}
   967	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32985 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180814/b7719f9d/attachment-0001.bin>
