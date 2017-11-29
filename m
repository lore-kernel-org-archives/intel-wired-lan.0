From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:00:46 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 02/16] ixgbe:
 Perform reinit any time number of VFs change
In-Reply-To: <20171122185622.29785.67698.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185622.29785.67698.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC33@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 02/16] ixgbe: Perform
> reinit any time number of VFs change
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> If the number of VFs are changed we need to reinitialize the part since the
> offset for the device and the number of pools will be incorrect. Without this
> change we can end up seeing Tx hangs and dropped Rx frames for incoming
> traffic.
> 
> In addition we should drop the code that is arbitrarily changing the default
> pool and queue configuration. Instead we should wait until the port is reset
> and reconfigured via ixgbe_sriov_reinit.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


