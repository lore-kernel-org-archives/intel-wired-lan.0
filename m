From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 2 Sep 2017 09:41:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 84/87]
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4165:14: error: call to
 '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for
 cmpxchg
Message-ID: <201709020913.pcw87O2v%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   08f91a425600cdae9ff6637b7619ef6e25aa3938
commit: 49f85995faccb903cf9256208c9caa7cb2decaf7 [84/87] i40e/i40evf: organize and re-number feature flags
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 49f85995faccb903cf9256208c9caa7cb2decaf7
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function 'i40e_set_priv_flags':
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4155:5: warning: '__ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
        ^
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4165:14: error: call to '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for cmpxchg
      * changed in the code above.
                 ^~~~~~~~~~~~~~~~~     

vim +/__cmpxchg_wrong_size +4165 drivers/net/ethernet/intel/i40e/i40e_ethtool.c

7e45ab44 Greg Rose           2015-02-06  4087  
9ac77266 Shannon Nelson      2015-08-27  4088  /**
9ac77266 Shannon Nelson      2015-08-27  4089   * i40e_set_priv_flags - set private flags
9ac77266 Shannon Nelson      2015-08-27  4090   * @dev: network interface device structure
9ac77266 Shannon Nelson      2015-08-27  4091   * @flags: bit flags to be set
9ac77266 Shannon Nelson      2015-08-27  4092   **/
9ac77266 Shannon Nelson      2015-08-27  4093  static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
9ac77266 Shannon Nelson      2015-08-27  4094  {
9ac77266 Shannon Nelson      2015-08-27  4095  	struct i40e_netdev_priv *np = netdev_priv(dev);
9ac77266 Shannon Nelson      2015-08-27  4096  	struct i40e_vsi *vsi = np->vsi;
9ac77266 Shannon Nelson      2015-08-27  4097  	struct i40e_pf *pf = vsi->back;
49f85995 Jacob Keller        2017-09-01  4098  	u32 orig_flags, new_flags, changed_flags;
aca955d8 Alexander Duyck     2017-03-10  4099  	u32 i, j;
827de392 Jesse Brandeburg    2015-11-06  4100  
841c950d Jacob Keller        2017-06-23  4101  	orig_flags = READ_ONCE(pf->flags);
841c950d Jacob Keller        2017-06-23  4102  	new_flags = orig_flags;
827de392 Jesse Brandeburg    2015-11-06  4103  
aca955d8 Alexander Duyck     2017-03-10  4104  	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
aca955d8 Alexander Duyck     2017-03-10  4105  		const struct i40e_priv_flags *priv_flags;
aca955d8 Alexander Duyck     2017-03-10  4106  
aca955d8 Alexander Duyck     2017-03-10  4107  		priv_flags = &i40e_gstrings_priv_flags[i];
aca955d8 Alexander Duyck     2017-03-10  4108  
aca955d8 Alexander Duyck     2017-03-10  4109  		if (flags & BIT(i))
841c950d Jacob Keller        2017-06-23  4110  			new_flags |= priv_flags->flag;
aca955d8 Alexander Duyck     2017-03-10  4111  		else
841c950d Jacob Keller        2017-06-23  4112  			new_flags &= ~(priv_flags->flag);
841c950d Jacob Keller        2017-06-23  4113  
841c950d Jacob Keller        2017-06-23  4114  		/* If this is a read-only flag, it can't be changed */
841c950d Jacob Keller        2017-06-23  4115  		if (priv_flags->read_only &&
841c950d Jacob Keller        2017-06-23  4116  		    ((orig_flags ^ new_flags) & ~BIT(i)))
841c950d Jacob Keller        2017-06-23  4117  			return -EOPNOTSUPP;
aca955d8 Alexander Duyck     2017-03-10  4118  	}
aca955d8 Alexander Duyck     2017-03-10  4119  
aca955d8 Alexander Duyck     2017-03-10  4120  	if (pf->hw.pf_id != 0)
aca955d8 Alexander Duyck     2017-03-10  4121  		goto flags_complete;
aca955d8 Alexander Duyck     2017-03-10  4122  
aca955d8 Alexander Duyck     2017-03-10  4123  	for (j = 0; j < I40E_GL_PRIV_FLAGS_STR_LEN; j++) {
aca955d8 Alexander Duyck     2017-03-10  4124  		const struct i40e_priv_flags *priv_flags;
aca955d8 Alexander Duyck     2017-03-10  4125  
aca955d8 Alexander Duyck     2017-03-10  4126  		priv_flags = &i40e_gl_gstrings_priv_flags[j];
aca955d8 Alexander Duyck     2017-03-10  4127  
aca955d8 Alexander Duyck     2017-03-10  4128  		if (flags & BIT(i + j))
841c950d Jacob Keller        2017-06-23  4129  			new_flags |= priv_flags->flag;
9ac77266 Shannon Nelson      2015-08-27  4130  		else
841c950d Jacob Keller        2017-06-23  4131  			new_flags &= ~(priv_flags->flag);
841c950d Jacob Keller        2017-06-23  4132  
841c950d Jacob Keller        2017-06-23  4133  		/* If this is a read-only flag, it can't be changed */
841c950d Jacob Keller        2017-06-23  4134  		if (priv_flags->read_only &&
841c950d Jacob Keller        2017-06-23  4135  		    ((orig_flags ^ new_flags) & ~BIT(i)))
841c950d Jacob Keller        2017-06-23  4136  			return -EOPNOTSUPP;
aca955d8 Alexander Duyck     2017-03-10  4137  	}
aca955d8 Alexander Duyck     2017-03-10  4138  
aca955d8 Alexander Duyck     2017-03-10  4139  flags_complete:
841c950d Jacob Keller        2017-06-23  4140  	/* Before we finalize any flag changes, we need to perform some
841c950d Jacob Keller        2017-06-23  4141  	 * checks to ensure that the changes are supported and safe.
841c950d Jacob Keller        2017-06-23  4142  	 */
841c950d Jacob Keller        2017-06-23  4143  
841c950d Jacob Keller        2017-06-23  4144  	/* ATR eviction is not supported on all devices */
841c950d Jacob Keller        2017-06-23  4145  	if ((new_flags & I40E_FLAG_HW_ATR_EVICT_ENABLED) &&
841c950d Jacob Keller        2017-06-23  4146  	    !(pf->hw_features & I40E_HW_ATR_EVICT_CAPABLE))
841c950d Jacob Keller        2017-06-23  4147  		return -EOPNOTSUPP;
841c950d Jacob Keller        2017-06-23  4148  
841c950d Jacob Keller        2017-06-23  4149  	/* Compare and exchange the new flags into place. If we failed, that
49f85995 Jacob Keller        2017-09-01  4150  	 * is if cmpxchg returns anything but the old value, this means that
841c950d Jacob Keller        2017-06-23  4151  	 * something else has modified the flags variable since we copied it
841c950d Jacob Keller        2017-06-23  4152  	 * originally. We'll just punt with an error and log something in the
841c950d Jacob Keller        2017-06-23  4153  	 * message buffer.
841c950d Jacob Keller        2017-06-23  4154  	 */
49f85995 Jacob Keller        2017-09-01 @4155  	if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
841c950d Jacob Keller        2017-06-23  4156  		dev_warn(&pf->pdev->dev,
841c950d Jacob Keller        2017-06-23  4157  			 "Unable to update pf->flags as it was modified by another thread...\n");
841c950d Jacob Keller        2017-06-23  4158  		return -EAGAIN;
841c950d Jacob Keller        2017-06-23  4159  	}
841c950d Jacob Keller        2017-06-23  4160  
841c950d Jacob Keller        2017-06-23  4161  	changed_flags = orig_flags ^ new_flags;
9ac77266 Shannon Nelson      2015-08-27  4162  
aca955d8 Alexander Duyck     2017-03-10  4163  	/* Process any additional changes needed as a result of flag changes.
aca955d8 Alexander Duyck     2017-03-10  4164  	 * The changed_flags value reflects the list of bits that were
aca955d8 Alexander Duyck     2017-03-10 @4165  	 * changed in the code above.
ef17178c Jesse Brandeburg    2015-09-03  4166  	 */
234dc4e6 Jacob Keller        2016-09-06  4167  
aca955d8 Alexander Duyck     2017-03-10  4168  	/* Flush current ATR settings if ATR was disabled */
aca955d8 Alexander Duyck     2017-03-10  4169  	if ((changed_flags & I40E_FLAG_FD_ATR_ENABLED) &&
aca955d8 Alexander Duyck     2017-03-10  4170  	    !(pf->flags & I40E_FLAG_FD_ATR_ENABLED)) {
47994c11 Jacob Keller        2017-04-19  4171  		pf->flags |= I40E_FLAG_FD_ATR_AUTO_DISABLED;
0da36b97 Jacob Keller        2017-04-19  4172  		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
ef17178c Jesse Brandeburg    2015-09-03  4173  	}
ef17178c Jesse Brandeburg    2015-09-03  4174  
aca955d8 Alexander Duyck     2017-03-10  4175  	if (changed_flags & I40E_FLAG_TRUE_PROMISC_SUPPORT) {
aca955d8 Alexander Duyck     2017-03-10  4176  		u16 sw_flags = 0, valid_flags = 0;
aca955d8 Alexander Duyck     2017-03-10  4177  		int ret;
1cdfd88f Shannon Nelson      2015-09-28  4178  
b5569892 Anjali Singhai Jain 2016-05-03  4179  		if (!(pf->flags & I40E_FLAG_TRUE_PROMISC_SUPPORT))
b5569892 Anjali Singhai Jain 2016-05-03  4180  			sw_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
b5569892 Anjali Singhai Jain 2016-05-03  4181  		valid_flags = I40E_AQ_SET_SWITCH_CFG_PROMISC;
b5569892 Anjali Singhai Jain 2016-05-03  4182  		ret = i40e_aq_set_switch_config(&pf->hw, sw_flags, valid_flags,
b5569892 Anjali Singhai Jain 2016-05-03  4183  						NULL);
b5569892 Anjali Singhai Jain 2016-05-03  4184  		if (ret && pf->hw.aq.asq_last_status != I40E_AQ_RC_ESRCH) {
b5569892 Anjali Singhai Jain 2016-05-03  4185  			dev_info(&pf->pdev->dev,
b5569892 Anjali Singhai Jain 2016-05-03  4186  				 "couldn't set switch config bits, err %s aq_err %s\n",
b5569892 Anjali Singhai Jain 2016-05-03  4187  				 i40e_stat_str(&pf->hw, ret),
b5569892 Anjali Singhai Jain 2016-05-03  4188  				 i40e_aq_str(&pf->hw,
b5569892 Anjali Singhai Jain 2016-05-03  4189  					     pf->hw.aq.asq_last_status));
b5569892 Anjali Singhai Jain 2016-05-03  4190  			/* not a fatal problem, just keep going */
b5569892 Anjali Singhai Jain 2016-05-03  4191  		}
b5569892 Anjali Singhai Jain 2016-05-03  4192  	}
b5569892 Anjali Singhai Jain 2016-05-03  4193  
aca955d8 Alexander Duyck     2017-03-10  4194  	/* Issue reset to cause things to take effect, as additional bits
aca955d8 Alexander Duyck     2017-03-10  4195  	 * are added we will need to create a mask of bits requiring reset
aca955d8 Alexander Duyck     2017-03-10  4196  	 */
04322606 Mitch Williams      2017-09-01  4197  	if (changed_flags & (I40E_FLAG_VEB_STATS_ENABLED |
04322606 Mitch Williams      2017-09-01  4198  			     I40E_FLAG_LEGACY_RX |
04322606 Mitch Williams      2017-09-01  4199  			     I40E_FLAG_SOURCE_PRUNING_DISABLED))
373149fc Maciej Sosin        2017-04-05  4200  		i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED), true);
827de392 Jesse Brandeburg    2015-11-06  4201  
9ac77266 Shannon Nelson      2015-08-27  4202  	return 0;
9ac77266 Shannon Nelson      2015-08-27  4203  }
9ac77266 Shannon Nelson      2015-08-27  4204  

:::::: The code at line 4165 was first introduced by commit
:::::: aca955d831a644dc1dc22b60b30ff669567580f9 i40e: Clean up handling of private flags

:::::: TO: Alexander Duyck <alexander.h.duyck@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59910 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170902/d6c935a6/attachment-0001.bin>
