From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 11 Jan 2018 10:28:32 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 75/107]
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4328:6: error: implicit
 declaration of function 'cmpxchg64'; did you mean 'cmpxchg'?
Message-ID: <201801111030.zy241uPe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   6438fb08f9d8f7971d394174d59e52b676299d69
commit: 7b51a837e2fa60cda07ed3be90f197aede605d47 [75/107] i40e: change flags to use 64 bits
config: mips-allyesconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7b51a837e2fa60cda07ed3be90f197aede605d47
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function 'i40e_set_priv_flags':
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4328:6: error: implicit declaration of function 'cmpxchg64'; did you mean 'cmpxchg'? [-Werror=implicit-function-declaration]
     if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
         ^~~~~~~~~
         cmpxchg
   cc1: some warnings being treated as errors

vim +4328 drivers/net/ethernet/intel/i40e/i40e_ethtool.c

  4260	
  4261	/**
  4262	 * i40e_set_priv_flags - set private flags
  4263	 * @dev: network interface device structure
  4264	 * @flags: bit flags to be set
  4265	 **/
  4266	static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
  4267	{
  4268		struct i40e_netdev_priv *np = netdev_priv(dev);
  4269		struct i40e_vsi *vsi = np->vsi;
  4270		struct i40e_pf *pf = vsi->back;
  4271		u64 orig_flags, new_flags, changed_flags;
  4272		u32 i, j;
  4273	
  4274		orig_flags = READ_ONCE(pf->flags);
  4275		new_flags = orig_flags;
  4276	
  4277		for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
  4278			const struct i40e_priv_flags *priv_flags;
  4279	
  4280			priv_flags = &i40e_gstrings_priv_flags[i];
  4281	
  4282			if (flags & BIT(i))
  4283				new_flags |= priv_flags->flag;
  4284			else
  4285				new_flags &= ~(priv_flags->flag);
  4286	
  4287			/* If this is a read-only flag, it can't be changed */
  4288			if (priv_flags->read_only &&
  4289			    ((orig_flags ^ new_flags) & ~BIT(i)))
  4290				return -EOPNOTSUPP;
  4291		}
  4292	
  4293		if (pf->hw.pf_id != 0)
  4294			goto flags_complete;
  4295	
  4296		for (j = 0; j < I40E_GL_PRIV_FLAGS_STR_LEN; j++) {
  4297			const struct i40e_priv_flags *priv_flags;
  4298	
  4299			priv_flags = &i40e_gl_gstrings_priv_flags[j];
  4300	
  4301			if (flags & BIT(i + j))
  4302				new_flags |= priv_flags->flag;
  4303			else
  4304				new_flags &= ~(priv_flags->flag);
  4305	
  4306			/* If this is a read-only flag, it can't be changed */
  4307			if (priv_flags->read_only &&
  4308			    ((orig_flags ^ new_flags) & ~BIT(i)))
  4309				return -EOPNOTSUPP;
  4310		}
  4311	
  4312	flags_complete:
  4313		/* Before we finalize any flag changes, we need to perform some
  4314		 * checks to ensure that the changes are supported and safe.
  4315		 */
  4316	
  4317		/* ATR eviction is not supported on all devices */
  4318		if ((new_flags & I40E_FLAG_HW_ATR_EVICT_ENABLED) &&
  4319		    !(pf->hw_features & I40E_HW_ATR_EVICT_CAPABLE))
  4320			return -EOPNOTSUPP;
  4321	
  4322		/* Compare and exchange the new flags into place. If we failed, that
  4323		 * is if cmpxchg returns anything but the old value, this means that
  4324		 * something else has modified the flags variable since we copied it
  4325		 * originally. We'll just punt with an error and log something in the
  4326		 * message buffer.
  4327		 */
> 4328		if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
  4329			dev_warn(&pf->pdev->dev,
  4330				 "Unable to update pf->flags as it was modified by another thread...\n");
  4331			return -EAGAIN;
  4332		}
  4333	
  4334		changed_flags = orig_flags ^ new_flags;
  4335	
  4336		/* Process any additional changes needed as a result of flag changes.
  4337		 * The changed_flags value reflects the list of bits that were
  4338		 * changed in the code above.
  4339		 */
  4340	
  4341		/* Flush current ATR settings if ATR was disabled */
  4342		if ((changed_flags & I40E_FLAG_FD_ATR_ENABLED) &&
  4343		    !(pf->flags & I40E_FLAG_FD_ATR_ENABLED)) {
  4344			pf->flags |= I40E_FLAG_FD_ATR_AUTO_DISABLED;
  4345			set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
  4346		}
  4347	
  4348		if (changed_flags & I40E_FLAG_TRUE_PROMISC_SUPPORT) {
  4349			u16 sw_flags = 0, valid_flags = 0;
  4350			int ret;
  4351	
  4352			if (!(pf->flags & I40E_FLAG_TRUE_PROMISC_SUPPORT))
  4353				sw_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
  4354			valid_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
  4355			ret = i40e_aq_set_switch_config(&pf->hw, sw_flags, valid_flags,
  4356							0, NULL);
  4357			if (ret && pf->hw.aq.asq_last_status != I40E_AQ_RC_ESRCH) {
  4358				dev_info(&pf->pdev->dev,
  4359					 "couldn't set switch config bits, err %s aq_err %s\n",
  4360					 i40e_stat_str(&pf->hw, ret),
  4361					 i40e_aq_str(&pf->hw,
  4362						     pf->hw.aq.asq_last_status));
  4363				/* not a fatal problem, just keep going */
  4364			}
  4365		}
  4366	
  4367		/* Issue reset to cause things to take effect, as additional bits
  4368		 * are added we will need to create a mask of bits requiring reset
  4369		 */
  4370		if (changed_flags & (I40E_FLAG_VEB_STATS_ENABLED |
  4371				     I40E_FLAG_LEGACY_RX |
  4372				     I40E_FLAG_SOURCE_PRUNING_DISABLED))
  4373			i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED), true);
  4374	
  4375		return 0;
  4376	}
  4377	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55390 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180111/e16f7e88/attachment-0001.bin>
