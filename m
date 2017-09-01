From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 2 Sep 2017 05:29:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 84/87]
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4155:5: warning: '__ret' may
 be used uninitialized in this function
Message-ID: <201709020551.8yOvxzpk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   08f91a425600cdae9ff6637b7619ef6e25aa3938
commit: 49f85995faccb903cf9256208c9caa7cb2decaf7 [84/87] i40e/i40evf: organize and re-number feature flags
config: i386-randconfig-x002-201735 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 49f85995faccb903cf9256208c9caa7cb2decaf7
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function 'i40e_set_priv_flags':
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4155:5: warning: '__ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
        ^
   In file included from arch/x86/include/asm/atomic.h:7:0,
                    from include/linux/atomic.h:4,
                    from include/linux/mm_types_task.h:12,
                    from include/linux/mm_types.h:4,
                    from include/linux/kmemcheck.h:4,
                    from include/linux/skbuff.h:18,
                    from include/linux/tcp.h:21,
                    from include/net/tcp.h:24,
                    from drivers/net/ethernet/intel/i40e/i40e.h:30,
                    from drivers/net/ethernet/intel/i40e/i40e_ethtool.c:29:
>> arch/x86/include/asm/cmpxchg.h:127:3: error: call to '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for cmpxchg
      __cmpxchg_wrong_size();     \
      ^~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cmpxchg.h:133:2: note: in expansion of macro '__raw_cmpxchg'
     __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
     ^~~~~~~~~~~~~
>> arch/x86/include/asm/cmpxchg.h:148:2: note: in expansion of macro '__cmpxchg'
     __cmpxchg(ptr, old, new, sizeof(*(ptr)))
     ^~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4155:6: note: in expansion of macro 'cmpxchg'
     if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
         ^~~~~~~
--
   drivers/net//ethernet/intel/i40e/i40e_ethtool.c: In function 'i40e_set_priv_flags':
   drivers/net//ethernet/intel/i40e/i40e_ethtool.c:4155:5: warning: '__ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
        ^
   In file included from arch/x86/include/asm/atomic.h:7:0,
                    from include/linux/atomic.h:4,
                    from include/linux/mm_types_task.h:12,
                    from include/linux/mm_types.h:4,
                    from include/linux/kmemcheck.h:4,
                    from include/linux/skbuff.h:18,
                    from include/linux/tcp.h:21,
                    from include/net/tcp.h:24,
                    from drivers/net//ethernet/intel/i40e/i40e.h:30,
                    from drivers/net//ethernet/intel/i40e/i40e_ethtool.c:29:
>> arch/x86/include/asm/cmpxchg.h:127:3: error: call to '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for cmpxchg
      __cmpxchg_wrong_size();     \
      ^~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/cmpxchg.h:133:2: note: in expansion of macro '__raw_cmpxchg'
     __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
     ^~~~~~~~~~~~~
>> arch/x86/include/asm/cmpxchg.h:148:2: note: in expansion of macro '__cmpxchg'
     __cmpxchg(ptr, old, new, sizeof(*(ptr)))
     ^~~~~~~~~
   drivers/net//ethernet/intel/i40e/i40e_ethtool.c:4155:6: note: in expansion of macro 'cmpxchg'
     if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
         ^~~~~~~

vim +/__ret +4155 drivers/net/ethernet/intel/i40e/i40e_ethtool.c

  4087	
  4088	/**
  4089	 * i40e_set_priv_flags - set private flags
  4090	 * @dev: network interface device structure
  4091	 * @flags: bit flags to be set
  4092	 **/
  4093	static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
  4094	{
  4095		struct i40e_netdev_priv *np = netdev_priv(dev);
  4096		struct i40e_vsi *vsi = np->vsi;
  4097		struct i40e_pf *pf = vsi->back;
  4098		u32 orig_flags, new_flags, changed_flags;
  4099		u32 i, j;
  4100	
  4101		orig_flags = READ_ONCE(pf->flags);
  4102		new_flags = orig_flags;
  4103	
  4104		for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
  4105			const struct i40e_priv_flags *priv_flags;
  4106	
  4107			priv_flags = &i40e_gstrings_priv_flags[i];
  4108	
  4109			if (flags & BIT(i))
  4110				new_flags |= priv_flags->flag;
  4111			else
  4112				new_flags &= ~(priv_flags->flag);
  4113	
  4114			/* If this is a read-only flag, it can't be changed */
  4115			if (priv_flags->read_only &&
  4116			    ((orig_flags ^ new_flags) & ~BIT(i)))
  4117				return -EOPNOTSUPP;
  4118		}
  4119	
  4120		if (pf->hw.pf_id != 0)
  4121			goto flags_complete;
  4122	
  4123		for (j = 0; j < I40E_GL_PRIV_FLAGS_STR_LEN; j++) {
  4124			const struct i40e_priv_flags *priv_flags;
  4125	
  4126			priv_flags = &i40e_gl_gstrings_priv_flags[j];
  4127	
  4128			if (flags & BIT(i + j))
  4129				new_flags |= priv_flags->flag;
  4130			else
  4131				new_flags &= ~(priv_flags->flag);
  4132	
  4133			/* If this is a read-only flag, it can't be changed */
  4134			if (priv_flags->read_only &&
  4135			    ((orig_flags ^ new_flags) & ~BIT(i)))
  4136				return -EOPNOTSUPP;
  4137		}
  4138	
  4139	flags_complete:
  4140		/* Before we finalize any flag changes, we need to perform some
  4141		 * checks to ensure that the changes are supported and safe.
  4142		 */
  4143	
  4144		/* ATR eviction is not supported on all devices */
  4145		if ((new_flags & I40E_FLAG_HW_ATR_EVICT_ENABLED) &&
  4146		    !(pf->hw_features & I40E_HW_ATR_EVICT_CAPABLE))
  4147			return -EOPNOTSUPP;
  4148	
  4149		/* Compare and exchange the new flags into place. If we failed, that
  4150		 * is if cmpxchg returns anything but the old value, this means that
  4151		 * something else has modified the flags variable since we copied it
  4152		 * originally. We'll just punt with an error and log something in the
  4153		 * message buffer.
  4154		 */
> 4155		if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
  4156			dev_warn(&pf->pdev->dev,
  4157				 "Unable to update pf->flags as it was modified by another thread...\n");
  4158			return -EAGAIN;
  4159		}
  4160	
  4161		changed_flags = orig_flags ^ new_flags;
  4162	
  4163		/* Process any additional changes needed as a result of flag changes.
  4164		 * The changed_flags value reflects the list of bits that were
  4165		 * changed in the code above.
  4166		 */
  4167	
  4168		/* Flush current ATR settings if ATR was disabled */
  4169		if ((changed_flags & I40E_FLAG_FD_ATR_ENABLED) &&
  4170		    !(pf->flags & I40E_FLAG_FD_ATR_ENABLED)) {
  4171			pf->flags |= I40E_FLAG_FD_ATR_AUTO_DISABLED;
  4172			set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
  4173		}
  4174	
  4175		if (changed_flags & I40E_FLAG_TRUE_PROMISC_SUPPORT) {
  4176			u16 sw_flags = 0, valid_flags = 0;
  4177			int ret;
  4178	
  4179			if (!(pf->flags & I40E_FLAG_TRUE_PROMISC_SUPPORT))
  4180				sw_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
  4181			valid_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
  4182			ret = i40e_aq_set_switch_config(&pf->hw, sw_flags, valid_flags,
  4183							NULL);
  4184			if (ret && pf->hw.aq.asq_last_status != I40E_AQ_RC_ESRCH) {
  4185				dev_info(&pf->pdev->dev,
  4186					 "couldn't set switch config bits, err %s aq_err %s\n",
  4187					 i40e_stat_str(&pf->hw, ret),
  4188					 i40e_aq_str(&pf->hw,
  4189						     pf->hw.aq.asq_last_status));
  4190				/* not a fatal problem, just keep going */
  4191			}
  4192		}
  4193	
  4194		/* Issue reset to cause things to take effect, as additional bits
  4195		 * are added we will need to create a mask of bits requiring reset
  4196		 */
  4197		if (changed_flags & (I40E_FLAG_VEB_STATS_ENABLED |
  4198				     I40E_FLAG_LEGACY_RX |
  4199				     I40E_FLAG_SOURCE_PRUNING_DISABLED))
  4200			i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED), true);
  4201	
  4202		return 0;
  4203	}
  4204	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29141 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170902/34fa3411/attachment-0001.bin>
