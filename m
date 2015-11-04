From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 4 Nov 2015 18:39:51 +0000
Subject: [Intel-wired-lan] [net-next PATCH 2/3] ixgbe: Use __dev_uc_sync
 and __dev_uc_unsync for unicast addresses
In-Reply-To: <20151022232636.24612.12045.stgit@ahduyck-vm-fedora22>
References: <20151022232228.24612.81341.stgit@ahduyck-vm-fedora22>
 <20151022232636.24612.12045.stgit@ahduyck-vm-fedora22>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D3752111EE@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Thursday, October 22, 2015 4:27 PM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
Subject: [Intel-wired-lan] [net-next PATCH 2/3] ixgbe: Use __dev_uc_sync and __dev_uc_unsync for unicast addresses

This change replaces the ixgbe_write_uc_addr_list call in ixgbe_set_rx_mode with a call to __dev_uc_sync instead.  This works much better with the MAC addr list code that was already in place and solves an issue in which you couldn't remove an fdb address without having to reset the port.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   28 ++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>

