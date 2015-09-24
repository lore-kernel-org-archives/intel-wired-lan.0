From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 24 Sep 2015 09:04:20 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 0/3] i40e/i40evf: Fixes for
	netpoll
Message-ID: <20150924160027.22015.15754.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patch series is meant to address the fact that i40e and
i40evf had several issues in regards to netpoll.  First was the fact that
they were forcing their budgets to increase to 1.  Second was the fact they
were incorrectly thinking they were in NAPI context when they weren't.
Finally, I also noticed that i40evf didn't even support netpoll so I went
through and added support for it.

These patches are compile tested only since I don't actually have access to
the i40e hardware.

---

Alexander Duyck (3):
      i40e/i40evf: Fix handling of napi budget
      i40e/i40evf: Drop useless "IN_NETPOLL" flag
      i40evf: Add support for netpoll


 drivers/net/ethernet/intel/i40e/i40e.h          |    1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c     |    2 --
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     |   12 +++++------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |   12 +++++------
 drivers/net/ethernet/intel/i40evf/i40evf.h      |    2 --
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   26 +++++++++++++++++++++++
 6 files changed, 38 insertions(+), 17 deletions(-)

--
