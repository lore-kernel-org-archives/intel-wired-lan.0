From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 13 Aug 2021 16:32:30 +0000
Subject: [Intel-wired-lan] [PATCH] igb: handle vlan types with checker
 enabled
In-Reply-To: <20210813074536.15624-1-zhaoxiao@uniontech.com>
References: <20210813074536.15624-1-zhaoxiao@uniontech.com>
Message-ID: <dcac5bb5598fcb1b6ce09aca2ac718f8e9c6e4ad.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-08-13 at 15:45 +0800, zhaoxiao wrote:
> The sparse build (C=2) finds some issues with how the driver
> dealt with the (very difficult) hardware that in some generations
> uses little-endian, and in others uses big endian, for the VLAN
> field. The code as written picks __le16 as a type and for some
> hardware revisions we override it to __be16 as done in this
> patch.
> 
> drivers/net/ethernet/intel/igb/igb_main.c:2676:48: warning: incorrect
> type in assignment (different base types)
> drivers/net/ethernet/intel/igb/igb_main.c:2676:48:    expected
> restricted __be16 [usertype] vlan_tci
> drivers/net/ethernet/intel/igb/igb_main.c:2676:48:    got unsigned
> short [usertype] vlan_priority:3

Thanks for the patch, but this has already been resolved [1].

Thanks,
Tony

[1]
https://patchwork.kernel.org/project/netdevbpf/patch/20210526172346.351
5587-6-anthony.l.nguyen at intel.com/
