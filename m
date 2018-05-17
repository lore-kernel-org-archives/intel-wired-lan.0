From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 17 May 2018 11:22:44 -0700
Subject: [Intel-wired-lan] [RFC PATCH 0/6] ixgbe/ixgbevf: IPsec hardware
 offload for 10Gbe VF
Message-ID: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This RFC patchset looks at adding IPsec hardware offload capabilities to
ixgbevf, Intel's 10Gbe VF driver.

I'm publishing this code as a way to start conversations on (a) is this
is something that people want, and (b) how can we manage the potential
security issues this can bring up?

I intend to leave this code as an RFC for now for a number of reasons.
Firstly, it raises some interesting security issues, discussed below.
Secondly, this code only "mostly" works: I haven't done a lot of testing
on it, but I do know that the VF's Tx encryption doesn't happen - the
registers and descriptors seem to be set up correctly, just as in the
PF, but the outbound encryption engine doesn't engage, and there is no
error reporting available.  If there is sufficient interest in further
work on these patches, I'll spend more time to track down this issue.
It's likely something simple.

Points to consider include:

 - Do VFs even need IPsec hardware offload?
 	Is there anyone who actually might find this useful, either in
	a cloud setting or possibly in a security appliance?

 - Sharing SPI/SA space with PF and other VFs
	In a particular IPsec "peer" (VM or bare-metal or hypervisor),
	the SPIs chosen for each SA are unique to each conversation
	that is being encrypted, and the choosing of the SPIs is usually
	orchestrated by the userland software such as StrongSwan or
	LibreSwan running on that peer.

	The Intel NIC has only one set of IPsec offload registers for use
	with PF and VFs.  Because of this, when multiple peers on that
	same host are each trying to run their own constellations of SPIs,
	we have the opportunity for number space collisions.

	The SPI collisions might be moot if the VMs are coordinated enough
	to be using different networks: for example VM1 on 14.0.0.0/24
	and VM2 on 15.0.0.0/24.  A typical way to keep VMs separate
	is to put them on different tunnels and not worry about their
	specific networks.  However, on something like Intel's 10gbe NIC,
	the Rx decryption happens on the tunneled packet with no regard
	for the tunnel id - if both VMs use the same network spaces inside
	their tunnels, only separated by different tunnels, then their
	SPI/IP spaces will collide.

 - Trusting the VF
	To attempt a simple mitigation of security issues, I'm assuming
	in this implementation that a VF with the offload must part of a
	solution where all parts are managed together, and thus the VF is
	"trusted".  Therefore, the 'trusted' bit must be enabled on the
	VF, e.g.:
	    ip link set dev ${PF} vf ${vf_id} trust on
	This is probably more useful in an appliance that uses VFs for
	specific traffic management rather than someone's cloud VM servers.

 - Other issues?
 	What other issues am I missing in this?

I would appreciate hearing your thoughts and concerns.

Thanks,
sln



Shannon Nelson (6):
  ixgbe: prep ipsec constants for later use
  ixgbe: add VF ipsec management
  ixgbe: add VF IPsec offload request message handling
  ixgbevf: add defines for IPsec offload request
  ixgbevf: add VF ipsec offload code
  ixgbevf: enable VF ipsec offload operations

 drivers/net/ethernet/intel/ixgbe/ixgbe.h          |   9 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 251 ++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h    |  13 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h      |   5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  17 +-
 drivers/net/ethernet/intel/ixgbevf/Makefile       |   1 +
 drivers/net/ethernet/intel/ixgbevf/defines.h      |  10 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |   2 +
 drivers/net/ethernet/intel/ixgbevf/ipsec.c        | 623 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbevf/ipsec.h        |  66 +++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  28 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  71 ++-
 drivers/net/ethernet/intel/ixgbevf/mbx.h          |   5 +
 13 files changed, 1067 insertions(+), 34 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbevf/ipsec.c
 create mode 100644 drivers/net/ethernet/intel/ixgbevf/ipsec.h

-- 
2.7.4

