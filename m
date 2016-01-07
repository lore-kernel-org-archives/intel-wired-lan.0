From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 22:48:34 -0800
Subject: [Intel-wired-lan] [next PATCH 0/2] Two clean-ups for recent ixgbe
	VLAN changes
Message-ID: <20160107064516.12239.98349.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These two patches clean up some minor left-overs from the recent VLAN
changes I had submitted.  With the first patch we should be able to avoid
having the PF leave any entries in the VLVF unless one of the VFs has made
use of the VLAN in which case we end up with a shared VLVF entry being
created for both the PF and the VF.  The other patch just prevents us from
looping through the setup for VLAN 0 twice.

---

Alexander Duyck (2):
      ixgbe: Do not allow PF to add VLVF entry unless it actually needs it
      ixgbe: Avoid adding VLAN 0 twice to VLVF and VFTA


 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   12 +++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   31 +++++++++++++-----------
 2 files changed, 23 insertions(+), 20 deletions(-)

--
