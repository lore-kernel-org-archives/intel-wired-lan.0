From: Miller, Darin J <darin.j.miller@intel.com>
Date: Thu, 29 Oct 2015 01:32:19 +0000
Subject: [Intel-wired-lan] [net PATCH v2] ixgbe: Reset interface
	after	enabling SR-IOV
In-Reply-To: <20151020202715.2955.88128.stgit@ahduyck-vm-fedora22>
References: <20151020202715.2955.88128.stgit@ahduyck-vm-fedora22>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D37520DF03@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Tuesday, October 20, 2015 1:28 PM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org
Subject: [Intel-wired-lan] [net PATCH v2] ixgbe: Reset interface after enabling SR-IOV

Enabling SR-IOV and then bringing the interface up was resulting in the PF MAC addresses getting into a bad state.  Specifically the MAC address was enabled for both VF 0 and the PF.  This resulted in some odd behaviors such as VF 0 receiving a copy of the PFs traffic, which in turn enables the ability for VF 0 to spoof the PF.

A workaround for this issue appears to be to bring up the interface first and then enable SR-IOV as this way the reset is then triggered in the existing code.

In order to correct this I have added a change to ixgbe_setup_tc where if the interface is down we still will at least call ixgbe_reset so that the MAC addresses for the device are reset to the correct pools.

Steps to reproduce issue:
modprobe ixgbe
echo 7 > /sys/bus/pci/devices/0000\:01\:00.1/sriov_numvfs
ifconfig enp1s0f1 up
ethregs -s 1:00.1 | grep MPSAR | grep -v 00000000

Result:
	MPSAR[0]               00000081
	MPSAR[254]             00000001

Expected Result, behavior after patch:
	MPSAR[0]               00000080
	MPSAR[254]             00000080

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Tested-by: Darin Miller <darin.j.miller@intel.com>
