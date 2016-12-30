From: David Miller <davem@davemloft.net>
Date: Thu, 29 Dec 2016 21:53:56 -0500 (EST)
Subject: [Intel-wired-lan] [net-next PATCH 0/6] i40e: Add VF port
 representator support or SR-IOV VFs
In-Reply-To: <1483078863-22026-1-git-send-email-sridhar.samudrala@intel.com>
References: <1483078863-22026-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <20161229.215356.2143143534347167491.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu, 29 Dec 2016 22:20:57 -0800

> - Patch 1 introduces devlink interface to get/set the mode of SRIOV switch.
> - Patch 2 adds support to create VF port representor(VFPR) netdevs associated
>   with SR-IOV VFs that can be used to control/configure VFs from PF name space.
> - Patch 3 enables syncing link state between VFs and VFPRs.
> - Patch 4 adds a new type to metadata_dst to allow passing VF id to lower device.
> - Patch 5 adds TX and RX support to VFPR netdevs.
> - Patch 6 enables HW and SW VFPR statistics to be exposed via netlink on VFPR
>   netdevs.

Patch 4 did not show up on the lists.

The computer you did this work on is configured with a time in the future.
