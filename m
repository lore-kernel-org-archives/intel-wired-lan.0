From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Aug 2017 19:16:52 +0000
Subject: [Intel-wired-lan] [PATCH v3 net 1/2] Revert commit
	1a8b6d76dc5b	("net:add one common config...")
In-Reply-To: <1503037265-11144-2-git-send-email-dingtianhong@huawei.com>
References: <1503037265-11144-1-git-send-email-dingtianhong@huawei.com>
 <1503037265-11144-2-git-send-email-dingtianhong@huawei.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F0FA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Ding Tianhong
> Sent: Thursday, August 17, 2017 11:21 PM
> To: davem at davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> keescook at chromium.org; linux-kernel at vger.kernel.org;
> sparclinux at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> alexander.duyck at gmail.com; netdev at vger.kernel.org;
> linuxarm at huawei.com
> Cc: Ding Tianhong <dingtianhong@huawei.com>
> Subject: [Intel-wired-lan] [PATCH v3 net 1/2] Revert commit 1a8b6d76dc5b
> ("net:add one common config...")
> 
> The new flag PCI_DEV_FLAGS_NO_RELAXED_ORDERING has been added to
> indicate that Relaxed Ordering Attributes (RO) should not be used for
> Transaction Layer Packets (TLP) targeted toward these affected Root Port, it
> will clear the bit4 in the PCIe Device Control register, so the PCIe device
> drivers could query PCIe configuration space to determine if it can send TLPs
> to Root Port with the Relaxed Ordering Attributes set.
> 
> With this new flag  we don't need the config ARCH_WANT_RELAX_ORDER to
> control the Relaxed Ordering Attributes for the ixgbe drivers just like the
> commit 1a8b6d76dc5b ("net:add one common config...") did, so revert this
> commit.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  arch/Kconfig                                    | 3 ---
>  arch/sparc/Kconfig                              | 1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
>  3 files changed, 1 insertion(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
