From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 12 Apr 2019 15:29:21 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 91/96]
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:278: undefined reference to
 `__udivdi3'
In-Reply-To: <201904121214.6OCgklbP%lkp@intel.com>
References: <201904121214.6OCgklbP%lkp@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5892353FCD@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: lkp
> Sent: Thursday, April 11, 2019 9:32 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: kbuild-all at 01.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [jkirsher-next-queue:dev-queue 91/96]
> drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:278: undefined reference to `__udivdi3'
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-
> queue
> head:   fa4bbb7d289c73c9aaaf2cf4711c5b98c3f0df6b
> commit: 04a54c8cd7959b55778a0a0b2ff6fe8600999ff3 [91/96] ixgbe: implement
> support for SDP/PPS output on X550 hardware
> config: i386-randconfig-j0-201914 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 04a54c8cd7959b55778a0a0b2ff6fe8600999ff3
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.o: In function
> `ixgbe_ptp_setup_sdp_X550':
> >> drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:278: undefined reference to
> `__udivdi3'
> 
> vim +278 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> 
>    226
>    227	/**
>    228	 * ixgbe_ptp_setup_sdp_X550
>    229	 * @adapter: private adapter structure
>    230	 *
>    231	 * Enable or disable a clock output signal on SDP 0 for X550 hardware.
>    232	 *
>    233	 * Use the target time feature to align the output signal on the next full
>    234	 * second.
>    235	 *
>    236	 * This works by using the cycle counter shift and mult values in reverse, and
>    237	 * assumes that the values we're shifting will not overflow.
>    238	 */
>    239	static void ixgbe_ptp_setup_sdp_X550(struct ixgbe_adapter *adapter)
>    240	{
>    241		struct cyclecounter *cc = &adapter->hw_cc;
>    242		struct ixgbe_hw *hw = &adapter->hw;
>    243		u32 esdp, tsauxc, freqout, trgttiml, trgttimh, rem, tssdp;
>    244		u64 ns = 0, clock_edge = 0;
>    245		struct timespec64 ts;
>    246		unsigned long flags;
>    247
>    248		/* disable the pin first */
>    249		IXGBE_WRITE_REG(hw, IXGBE_TSAUXC, 0x0);
>    250		IXGBE_WRITE_FLUSH(hw);
>    251
>    252		if (!(adapter->flags2 & IXGBE_FLAG2_PTP_PPS_ENABLED))
>    253			return;
>    254
>    255		esdp = IXGBE_READ_REG(hw, IXGBE_ESDP);
>    256
>    257		/* enable the SDP0 pin as output, and connected to the
>    258		 * native function for Timesync (ClockOut)
>    259		 */
>    260		esdp |= IXGBE_ESDP_SDP0_DIR |
>    261			IXGBE_ESDP_SDP0_NATIVE;
>    262
>    263		/* enable the Clock Out feature on SDP0, and use Target Time 0 to
>    264		 * enable generation of interrupts on the clock change.
>    265		 */
>    266	#define IXGBE_TSAUXC_DIS_TS_CLEAR 0x40000000
>    267		tsauxc = (IXGBE_TSAUXC_EN_CLK | IXGBE_TSAUXC_ST0 |
>    268			  IXGBE_TSAUXC_EN_TT0 | IXGBE_TSAUXC_SDP0_INT |
>    269			  IXGBE_TSAUXC_DIS_TS_CLEAR);
>    270
>    271		tssdp = (IXGBE_TSSDP_TS_SDP0_EN |
>    272			 IXGBE_TSSDP_TS_SDP0_CLK0);
>    273
>    274		/* Determine the clock time period to use. This assumes that the
>    275		 * cycle counter shift is small enough to avoid overflowing a 32bit
>    276		 * value.
>    277		 */
>  > 278		freqout = (NS_PER_HALF_SEC << cc->shift) / cc->mult;


Oh, this should be a div_u64. I'll update the patch and submit a v2, Jeff!

Thanks,
Jake

>    279
>    280		/* Read the current clock time, and save the cycle counter value */
>    281		spin_lock_irqsave(&adapter->tmreg_lock, flags);
>    282		ns = timecounter_read(&adapter->hw_tc);
>    283		clock_edge = adapter->hw_tc.cycle_last;
>    284		spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
>    285
>    286		/* Figure out how far past the next second we are */
>    287		div_u64_rem(ns, NS_PER_SEC, &rem);
>    288
>    289		/* Figure out how many nanoseconds to add to round the clock edge
> up
>    290		 * to the next full second
>    291		 */
>    292		rem = (NS_PER_SEC - rem);
>    293
>    294		/* Adjust the clock edge to align with the next full second. This
>    295		 * assumes that the cycle counter shift is small enough to avoid
>    296		 * overflowing when shifting the remainder.
>    297		 */
>    298		clock_edge += div_u64((rem << cc->shift), cc->mult);
>    299
>    300		/* X550 hardware stores the time in 32bits of 'billions of cycles' and
>    301		 * 32bits of 'cycles'. There's no guarantee that cycles represents
>    302		 * nanoseconds. However, we can use the math from a timespec64
> to
>    303		 * convert into the hardware representation.
>    304		 *
>    305		 * See ixgbe_ptp_read_X550() for more details.
>    306		 */
>    307		ts = ns_to_timespec64(clock_edge);
>    308		trgttiml = (u32)ts.tv_nsec;
>    309		trgttimh = (u32)ts.tv_sec;
>    310
>    311		IXGBE_WRITE_REG(hw, IXGBE_FREQOUT0, freqout);
>    312		IXGBE_WRITE_REG(hw, IXGBE_TRGTTIML0, trgttiml);
>    313		IXGBE_WRITE_REG(hw, IXGBE_TRGTTIMH0, trgttimh);
>    314
>    315		IXGBE_WRITE_REG(hw, IXGBE_ESDP, esdp);
>    316		IXGBE_WRITE_REG(hw, IXGBE_TSSDP, tssdp);
>    317		IXGBE_WRITE_REG(hw, IXGBE_TSAUXC, tsauxc);
>    318
>    319		IXGBE_WRITE_FLUSH(hw);
>    320	}
>    321
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
