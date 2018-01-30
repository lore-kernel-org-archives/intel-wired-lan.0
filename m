From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 30 Jan 2018 08:38:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE 6/15]
 drivers/net//ethernet/intel/i40e/i40e_ethtool.c:4326:6: error: implicit
 declaration of function 'cmpxchg64'; did you mean 'cmpxchg'?
Message-ID: <201801300838.qu2sGTtG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git 40GbE
head:   1563f2d2e01242f05dd523ffd56fe104bc1afd58
commit: 60f481b9703867330dc6010868054f68f6d52f7a [6/15] i40e: change flags to use 64 bits
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 60f481b9703867330dc6010868054f68f6d52f7a
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/net//ethernet/intel/i40e/i40e_ethtool.c: In function 'i40e_set_priv_flags':
>> drivers/net//ethernet/intel/i40e/i40e_ethtool.c:4326:6: error: implicit declaration of function 'cmpxchg64'; did you mean 'cmpxchg'? [-Werror=implicit-function-declaration]
     if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
         ^~~~~~~~~
         cmpxchg
   cc1: some warnings being treated as errors

vim +4326 drivers/net//ethernet/intel/i40e/i40e_ethtool.c

  4258	
  4259	/**
  4260	 * i40e_set_priv_flags - set private flags
  4261	 * @dev: network interface device structure
  4262	 * @flags: bit flags to be set
  4263	 **/
  4264	static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
  4265	{
  4266		struct i40e_netdev_priv *np = netdev_priv(dev);
  4267		struct i40e_vsi *vsi = np->vsi;
  4268		struct i40e_pf *pf = vsi->back;
  4269		u64 orig_flags, new_flags, changed_flags;
  4270		u32 i, j;
  4271	
  4272		orig_flags = READ_ONCE(pf->flags);
  4273		new_flags = orig_flags;
  4274	
  4275		for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
  4276			const struct i40e_priv_flags *priv_flags;
  4277	
  4278			priv_flags = &i40e_gstrings_priv_flags[i];
  4279	
  4280			if (flags & BIT(i))
  4281				new_flags |= priv_flags->flag;
  4282			else
  4283				new_flags &= ~(priv_flags->flag);
  4284	
  4285			/* If this is a read-only flag, it can't be changed */
  4286			if (priv_flags->read_only &&
  4287			    ((orig_flags ^ new_flags) & ~BIT(i)))
  4288				return -EOPNOTSUPP;
  4289		}
  4290	
  4291		if (pf->hw.pf_id != 0)
  4292			goto flags_complete;
  4293	
  4294		for (j = 0; j < I40E_GL_PRIV_FLAGS_STR_LEN; j++) {
  4295			const struct i40e_priv_flags *priv_flags;
  4296	
  4297			priv_flags = &i40e_gl_gstrings_priv_flags[j];
  4298	
  4299			if (flags & BIT(i + j))
  4300				new_flags |= priv_flags->flag;
  4301			else
  4302				new_flags &= ~(priv_flags->flag);
  4303	
  4304			/* If this is a read-only flag, it can't be changed */
  4305			if (priv_flags->read_only &&
  4306			    ((orig_flags ^ new_flags) & ~BIT(i)))
  4307				return -EOPNOTSUPP;
  4308		}
  4309	
  4310	flags_complete:
  4311		/* Before we finalize any flag changes, we need to perform some
  4312		 * checks to ensure that the changes are supported and safe.
  4313		 */
  4314	
  4315		/* ATR eviction is not supported on all devices */
  4316		if ((new_flags & I40E_FLAG_HW_ATR_EVICT_ENABLED) &&
  4317		    !(pf->hw_features & I40E_HW_ATR_EVICT_CAPABLE))
  4318			return -EOPNOTSUPP;
  4319	
  4320		/* Compare and exchange the new flags into place. If we failed, that
  4321		 * is if cmpxchg returns anything but the old value, this means that
  4322		 * something else has modified the flags variable since we copied it
  4323		 * originally. We'll just punt with an error and log something in the
  4324		 * message buffer.
  4325		 */
> 4326		if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
  4327			dev_warn(&pf->pdev->dev,
  4328				 "Unable to update pf->flags as it was modified by another thread...\n");
  4329			return -EAGAIN;
  4330		}
  4331	
  4332		changed_flags = orig_flags ^ new_flags;
  4333	
  4334		/* Process any additional changes needed as a result of flag changes.
  4335		 * The changed_flags value reflects the list of bits that were
  4336		 * changed in the code above.
  4337		 */
  4338	
  4339		/* Flush current ATR settings if ATR was disabled */
  4340		if ((changed_flags & I40E_FLAG_FD_ATR_ENABLED) &&
  4341		    !(pf->flags & I40E_FLAG_FD_ATR_ENABLED)) {
  4342			pf->flags |= I40E_FLAG_FD_ATR_AUTO_DISABLED;
  4343			set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
  4344		}
  4345	
  4346		if (changed_flags & I40E_FLAG_TRUE_PROMISC_SUPPORT) {
  4347			u16 sw_flags = 0, valid_flags = 0;
  4348			int ret;
  4349	
  4350			if (!(pf->flags & I40E_FLAG_TRUE_PROMISC_SUPPORT))
  4351				sw_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
  4352			valid_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
  4353			ret = i40e_aq_set_switch_config(&pf->hw, sw_flags, valid_flags,
  4354							0, NULL);
  4355			if (ret && pf->hw.aq.asq_last_status != I40E_AQ_RC_ESRCH) {
  4356				dev_info(&pf->pdev->dev,
  4357					 "couldn't set switch config bits, err %s aq_err %s\n",
  4358					 i40e_stat_str(&pf->hw, ret),
  4359					 i40e_aq_str(&pf->hw,
  4360						     pf->hw.aq.asq_last_status));
  4361				/* not a fatal problem, just keep going */
  4362			}
  4363		}
  4364	
  4365		/* Issue reset to cause things to take effect, as additional bits
  4366		 * are added we will need to create a mask of bits requiring reset
  4367		 */
  4368		if (changed_flags & (I40E_FLAG_VEB_STATS_ENABLED |
  4369				     I40E_FLAG_LEGACY_RX |
  4370				     I40E_FLAG_SOURCE_PRUNING_DISABLED))
  4371			i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED), true);
  4372	
  4373		return 0;
  4374	}
  4375	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55272 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180130/eb041e91/attachment-0001.bin>
