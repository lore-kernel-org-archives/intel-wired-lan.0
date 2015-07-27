From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 27 Jul 2015 17:18:28 -0600
Subject: [Intel-wired-lan] [PATCH 0/2] igb/ixgbe: Fix ordering of SR-IOV
	teardown
Message-ID: <20150727223753.10121.78169.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When running a Windows 2012 R2 guest with a pair of VFs assigned
through vfio-pci, we run into a problem trying to hot-unplug those VFs
after the PF has unregistered the netdev.  This is a common scenario
if the PF is unbound from the driver while VFs are active.  In the
case of igb, the resulting guest behavior differs slightly between the
Microsoft provided and Intel add-on guest drivers.  With the Microsoft
driver, the guest seems to stumble through ejecting both VFs, but
takes longer than normal to do so.  With the Intel drivers, only one
VF is unplugged, but Device Manager still shows it as present.  The
second VF is non-functional but also still shown in Device Manager.
At this point, the guest is in such a state that it will not cleanly
shutdown.  With ixgbe VFs, both the Microsoft and Intel drivers take
on this latter behavior.

For both, I've found that disabling SR-IOV before unregistering the PF
netdev device allows the hot-unplug to proceed without interruption or
further ill behavior in the guest.  This is true regardless of which
driver is used.  I don't fully understand what dependency is broken
by unregistering the netdev prior to disabling SR-IOV, but I also
don't see the benefit in delaying SR-IOV teardown in this call path.
It could potentially be moved even earlier, but I'll let those more
familiar with the hardware and code make that determination.  In any
case, the VM behavior is substantially improved by this slight
re-ordering.

I don't have an i40e for testing, but it already appears to disable
SR-IOV much earlier in the unbind path, so I wouldn't expect to find
similar issues.  Thanks,

Alex

---

Alex Williamson (2):
      igb: Teardown SR-IOV before unregister_netdev()
      ixgbe: Teardown SR-IOV before unregister_netdev()


 drivers/net/ethernet/intel/igb/igb_main.c     |    8 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)
