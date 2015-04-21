From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2015 02:38:32 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Cleanup handling of VLAN_HLEN
 as a part of max frame size
In-Reply-To: <20150408204630.4643.37880.stgit@ahduyck-vm-fedora22>
References: <alpine.NEB.2.11.1504081019220.3388@chris.i8u.org>
 <20150408204630.4643.37880.stgit@ahduyck-vm-fedora22>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DA689A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, April 08, 2015 2:03 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> Cc: netdev at vger.kernel.org; mike at cchtml.com; htodd at twofifty.com
> Subject: [Intel-wired-lan] [PATCH] e1000e: Cleanup handling of VLAN_HLEN
> as a part of max frame size
> 
> When the VLAN_HLEN was added to the calculation for the maximum frame size
> there seems to have been a number of issues added to the driver.
> 
> The first issue is that in some cases the maximum frame size for a device
> never really reached the actual maximum frame size as the VLAN header
> length was not included the calculation for that value.  As a result some
> parts only supported a maximum frame size of either 1496 in the case of
> parts that didn't support jumbo frames, and 8996 in the case of the parts
> that do.
> 
> The second issue is the fact that there were several checks that weren't
> updated so as a result setting an MTU of 1500 was treated as enabling
> jumbo
> frames as the calculated value was 1522 instead of 1518.  I have addressed
> those by replacing ETH_FRAME_LEN with VLAN_ETH_FRAME_LEN where
> appropriate.
> 
> The final issue was the fact that lowering the MTU below 1500 would cause
> the driver to allocate 2K buffers for the rings.  This is an old issue
> that
> was fixed several years ago in igb/ixgbe and I am addressing now by just
> replacing == with a <= so that we always just round up to 1522 for
> anything
> that isn't a jumbo frame.
> 
> Fixes: c751a3d58cf2d ("e1000e: Correctly include VLAN_HLEN when changing
> interface MTU")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
> 
> I have only build tested this though I am 99% sure the fixes here are
> correct.  This patch should fix issues on 82573 and ich8 w/ setting an MTU
> of 1500, and for the PCH series w/ setting an MTU of 9000.
> 
> I assume I can get away with bumping the max_hw_frame_size for the PCH
> parts from 9018 to 9022 based on the fact that the Windows INF for the
> parts
> lists supporting either 1514, 4088, and 9014 all of which exclude the 8
> bytes for CRC and VLAN header.
> 
>  drivers/net/ethernet/intel/e1000e/82571.c   |    2 +-
>  drivers/net/ethernet/intel/e1000e/ich8lan.c |   10 +++++-----
>  drivers/net/ethernet/intel/e1000e/netdev.c  |   18 ++++++++----------
>  3 files changed, 14 insertions(+), 16 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

