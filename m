From: kernel test robot <lkp@intel.com>
Date: Tue, 21 Sep 2021 01:31:16 +0800
Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Add support for
 50G/100G in AIM algorithm
In-Reply-To: <20210920132539.24114-1-mateusz.palczewski@intel.com>
References: <20210920132539.24114-1-mateusz.palczewski@intel.com>
Message-ID: <202109210109.W9g9s6gc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mateusz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Mateusz-Palczewski/iavf-Add-support-for-50G-100G-in-AIM-algorithm/20210920-213856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 85c698863c15176f743fd1d1fcf39ceb9172c820
config: mips-randconfig-r036-20210920 (attached as .config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6f12aa40bda9bca31be044bc237866edb637992e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mateusz-Palczewski/iavf-Add-support-for-50G-100G-in-AIM-algorithm/20210920-213856
        git checkout 6f12aa40bda9bca31be044bc237866edb637992e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):



vim +/342 +404 drivers/net/ethernet/intel/iavf/iavf_txrx.c

   383	
   384	static unsigned int iavf_mbps_itr_multiplier(u32 speed_mbps)
   385	{
   386		switch (speed_mbps) {
   387		case SPEED_100000:
   388			return IAVF_AIM_MULTIPLIER_100G;
   389		case SPEED_50000:
   390			return IAVF_AIM_MULTIPLIER_50G;
   391		case SPEED_40000:
   392			return IAVF_AIM_MULTIPLIER_40G;
   393		case SPEED_25000:
   394		case SPEED_20000:
   395			return IAVF_AIM_MULTIPLIER_20G;
   396		case SPEED_10000:
   397		default:
   398			return IAVF_AIM_MULTIPLIER_10G;
   399		case SPEED_1000:
   400		case SPEED_100:
   401			return IAVF_AIM_MULTIPLIER_1G;
   402		}
   403	}
 > 404	?
   405	static unsigned int
   406	iavf_virtchnl_itr_multiplier(enum virtchnl_link_speed speed_virtchnl)
   407	{
   408		switch (speed_virtchnl) {
   409		case VIRTCHNL_LINK_SPEED_40GB:
   410			return IAVF_AIM_MULTIPLIER_40G;
   411		case VIRTCHNL_LINK_SPEED_25GB:
   412		case VIRTCHNL_LINK_SPEED_20GB:
   413			return IAVF_AIM_MULTIPLIER_20G;
   414		case VIRTCHNL_LINK_SPEED_10GB:
   415		default:
   416			return IAVF_AIM_MULTIPLIER_10G;
   417		case VIRTCHNL_LINK_SPEED_1GB:
   418		case VIRTCHNL_LINK_SPEED_100MB:
   419			return IAVF_AIM_MULTIPLIER_1G;
   420		}
   421	}
   422	?
   423	static unsigned int iavf_itr_divisor(struct iavf_adapter *adapter)
   424	{
   425		if (ADV_LINK_SUPPORT(adapter))
   426			return IAVF_ITR_ADAPTIVE_MIN_INC *
   427				iavf_mbps_itr_multiplier(adapter->link_speed_mbps);
   428		else
   429			return IAVF_ITR_ADAPTIVE_MIN_INC *
   430				iavf_virtchnl_itr_multiplier(adapter->link_speed);
   431	}
   432	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34623 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210921/7b2463e2/attachment-0001.bin>
