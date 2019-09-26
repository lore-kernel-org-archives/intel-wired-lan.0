From: kbuild test robot <lkp@intel.com>
Date: Thu, 26 Sep 2019 10:09:56 +0800
Subject: [Intel-wired-lan] [net-next 2/2] net: reject ptp requests with
 unsupported flags
In-Reply-To: <20190925233312.13977-3-jacob.e.keller@intel.com>
References: <20190925233312.13977-3-jacob.e.keller@intel.com>
Message-ID: <201909261037.jN6whzSn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jacob,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net/master]
[cannot apply to v5.3 next-20190924]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Jacob-Keller/ptp-correctly-disable-flags-on-old-ioctls/20190926-073546
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/phy/dp83640.c: In function 'ptp_dp83640_enable':
>> drivers/net/phy/dp83640.c:473:27: error: 'PTP_FEATURE_ENABLE' undeclared (first use in this function); did you mean 'DCB_FEATCFG_ENABLE'?
      if (rq->extts.flags & ~(PTP_FEATURE_ENABLE |
                              ^~~~~~~~~~~~~~~~~~
                              DCB_FEATCFG_ENABLE
   drivers/net/phy/dp83640.c:473:27: note: each undeclared identifier is reported only once for each function it appears in

vim +473 drivers/net/phy/dp83640.c

   460	
   461	static int ptp_dp83640_enable(struct ptp_clock_info *ptp,
   462				      struct ptp_clock_request *rq, int on)
   463	{
   464		struct dp83640_clock *clock =
   465			container_of(ptp, struct dp83640_clock, caps);
   466		struct phy_device *phydev = clock->chosen->phydev;
   467		unsigned int index;
   468		u16 evnt, event_num, gpio_num;
   469	
   470		switch (rq->type) {
   471		case PTP_CLK_REQ_EXTTS:
   472			/* Reject requests with unsupported flags */
 > 473			if (rq->extts.flags & ~(PTP_FEATURE_ENABLE |
   474						PTP_RISING_EDGE |
   475						PTP_FALLING_EDGE))
   476				return -EOPNOTSUPP;
   477			index = rq->extts.index;
   478			if (index >= N_EXT_TS)
   479				return -EINVAL;
   480			event_num = EXT_EVENT + index;
   481			evnt = EVNT_WR | (event_num & EVNT_SEL_MASK) << EVNT_SEL_SHIFT;
   482			if (on) {
   483				gpio_num = 1 + ptp_find_pin(clock->ptp_clock,
   484							    PTP_PF_EXTTS, index);
   485				if (gpio_num < 1)
   486					return -EINVAL;
   487				evnt |= (gpio_num & EVNT_GPIO_MASK) << EVNT_GPIO_SHIFT;
   488				if (rq->extts.flags & PTP_FALLING_EDGE)
   489					evnt |= EVNT_FALL;
   490				else
   491					evnt |= EVNT_RISE;
   492			}
   493			mutex_lock(&clock->extreg_lock);
   494			ext_write(0, phydev, PAGE5, PTP_EVNT, evnt);
   495			mutex_unlock(&clock->extreg_lock);
   496			return 0;
   497	
   498		case PTP_CLK_REQ_PEROUT:
   499			/* Reject requests with unsupported flags */
   500			if (rq->perout.flags)
   501				return -EOPNOTSUPP;
   502			if (rq->perout.index >= N_PER_OUT)
   503				return -EINVAL;
   504			return periodic_output(clock, rq, on, rq->perout.index);
   505	
   506		default:
   507			break;
   508		}
   509	
   510		return -EOPNOTSUPP;
   511	}
   512	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 69878 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190926/080fb7fd/attachment-0001.bin>
