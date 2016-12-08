From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 18:22:03 +0000
Subject: [Intel-wired-lan] [PATCH V3 1/4] ixgbe: Fix issues with
	EEPROM	access
In-Reply-To: <148115000030.19165.11435235530381069939.stgit@mdrustad-wks.jf.intel.com>
References: <148114991608.19165.8749732086590634860.stgit@mdrustad-wks.jf.intel.com>
 <148115000030.19165.11435235530381069939.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39B5D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Wednesday, December 07, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V3 1/4] ixgbe: Fix issues with EEPROM
> access
> 
> There are two problems with EEPROM access. One is that it needs to hold the
> semaphore until the entire response is read or else the response can be
> corrupted by other firmware accesses. The second problem is that acquiring
> and releasing the semaphore is slow, so it should be taken and released once
> when multiple EEPROM accesses will be done.
> 
> Both of these issues can be solved by adding a new function,
> ixgbe_hic_unlocked, to issue firmware commands that will assume that the
> caller has acquired the needed semaphore.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   97
> +++++++++++++++--------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    1
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |   75 +++++++-----------
>  3 files changed, 91 insertions(+), 82 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


