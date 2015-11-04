From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 4 Nov 2015 18:40:22 +0000
Subject: [Intel-wired-lan] [net-next PATCH 3/3] ixgbe: Allow FDB entries
 access to more RAR filters
In-Reply-To: <20151022232642.24612.46212.stgit@ahduyck-vm-fedora22>
References: <20151022232228.24612.81341.stgit@ahduyck-vm-fedora22>
 <20151022232642.24612.46212.stgit@ahduyck-vm-fedora22>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D375211201@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Thursday, October 22, 2015 4:27 PM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
Subject: [Intel-wired-lan] [net-next PATCH 3/3] ixgbe: Allow FDB entries access to more RAR filters

This change makes it so that we allow the PF to make use of all free RAR entries for FDB use if needed.

Previously the code limited us to 16 unicast entries, however this was shared between MACVLAN which wasn't limited and the FDB code which was.  So instead of treating the FDB code as a second class citizen I have updated it so that it has access to just as many entries as the MACVLAN filters.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>

