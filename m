From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 7 Dec 2016 22:22:15 +0000
Subject: [Intel-wired-lan] [PATCH V2 0/4] ixgbe: Firmware-controlled
	PHY	enablement
In-Reply-To: <148114788660.130011.4413036825097860499.stgit@mdrustad-wks.jf.intel.com>
References: <148114788660.130011.4413036825097860499.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <5AFBB3C5-8114-4E9F-B628-BEA33EF0F141@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Mark D Rustad <mark.d.rustad@intel.com> wrote:

> The following patches enable firmware-controlled PHYs. The first two
> patches resolve some issues uncovered while working on the other
> patches. The third adds the firmware interface for controlling PHYs.
> The last patch implements everything else for the new devices.
>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>
> ---
> Changes in V2:
> - Fixed some oversights related to the 10M link speed
>
> ---
>
> Mark D Rustad (4):
>       ixgbe: Fix issues with EEPROM access
>       ixgbe: Remove unused firmware version functions and method
>       ixgbe: Implement firmware interface to access some PHYs
>       ixgbe: Implement support for firmware-controlled PHYs
>
>
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    4
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c   |    2
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |    2
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |  104 +++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h  |    3
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  156 +++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   45 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     |   37 --
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h     |    4
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   74 +++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c    |    1
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |  508 ++++++++++++++++++++--
>  12 files changed, 807 insertions(+), 133 deletions(-)

Sorry. Just found another problem, so a V3 will be coming.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161207/c9762027/attachment.asc>
