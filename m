From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Tue, 16 Mar 2021 06:56:32 +0000
Subject: [Intel-wired-lan] [net-next PATCH 02/10] intel: Update drivers
 to use ethtool_sprintf
In-Reply-To: <161557129416.10304.13389129491117212311.stgit@localhost.localdomain>
References: <161557111604.10304.1798900949114188676.stgit@localhost.localdomain>
 <161557129416.10304.13389129491117212311.stgit@localhost.localdomain>
Message-ID: <BN8PR11MB37957A1DA6915E9E6A532A69F76B9@BN8PR11MB3795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Alexander Duyck
> Sent: Saturday, March 13, 2021 01:48
> To: davem at davemloft.net; kuba at kernel.org
> Cc: doshir at vmware.com; mst at redhat.com; oss-drivers at netronome.com; jasowang at redhat.com;
> alexanderduyck at fb.com; akiyano at amazon.com; wei.liu at kernel.org; sthemmin at microsoft.com; pv-
> drivers at vmware.com; intel-wired-lan at lists.osuosl.org; Kernel-team at fb.com; yisen.zhuang at huawei.com;
> gtzalik at amazon.com; simon.horman at netronome.com; haiyangz at microsoft.com; drivers at pensando.io;
> salil.mehta at huawei.com; GR-Linux-NIC-Dev at marvell.com; rmody at marvell.com; netdev at vger.kernel.org;
> netanel at amazon.com; saeedb at amazon.com; snelson at pensando.io; skalluru at marvell.com
> Subject: [Intel-wired-lan] [net-next PATCH 02/10] intel: Update drivers to use ethtool_sprintf
> 
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Update the Intel drivers to make use of ethtool_sprintf. The general idea
> is to reduce code size and overhead by replacing the repeated pattern of
> string printf statements and ETH_STRING_LEN counter increments.
                                   ^
                               ETH_GSTRING_LEN
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---


> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
