From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 14:39:09 +0000
Subject: [Intel-wired-lan] [PATCH v3 net 2/2] net: ixgbe: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <87618083B2453E4A8714035B62D67992B4095D65@FMSMSX105.amr.corp.intel.com>
References: <1503037265-11144-1-git-send-email-dingtianhong@huawei.com>
 <1503037265-11144-3-git-send-email-dingtianhong@huawei.com>
 <87618083B2453E4A8714035B62D67992B4095D65@FMSMSX105.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F252@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tantilov, Emil S
> Sent: Monday, August 21, 2017 10:36 AM
> To: Ding Tianhong <dingtianhong@huawei.com>; davem at davemloft.net;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; keescook at chromium.org;
> linux-kernel at vger.kernel.org; sparclinux at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; alexander.duyck at gmail.com; netdev at vger.kernel.org;
> linuxarm at huawei.com
> Subject: Re: [Intel-wired-lan] [PATCH v3 net 2/2] net: ixgbe: Use new
> PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
> 
> >-----Original Message-----
> >From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> >owner at vger.kernel.org] On Behalf Of Ding Tianhong
> >Sent: Thursday, August 17, 2017 11:21 PM
> >To: davem at davemloft.net; Kirsher, Jeffrey T
> ><jeffrey.t.kirsher@intel.com>; keescook at chromium.org;
> >linux-kernel at vger.kernel.org; sparclinux at vger.kernel.org;
> >intel-wired-lan at lists.osuosl.org; alexander.duyck at gmail.com;
> >netdev at vger.kernel.org; linuxarm at huawei.com
> >Cc: Ding Tianhong <dingtianhong@huawei.com>
> >Subject: [PATCH v3 net 2/2] net: ixgbe: Use new
> >PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
> >
> >The ixgbe driver use the compile check to determine if it can send TLPs
> >to Root Port with the Relaxed Ordering Attribute set, this is too
> >inconvenient, now the new flag PCI_DEV_FLAGS_NO_RELAXED_ORDERING
> has
> >been added to the kernel and we could check the bit4 in the PCIe Device
> >Control register to determine whether we should use the Relaxed
> >Ordering Attributes or not, so use this new way in the ixgbe driver.
> >
> >Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> >---
> > drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c  | 22
> >---------------------
> >-
> > drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 19
> >-------------------
> > 2 files changed, 41 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


