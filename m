From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 2 May 2016 21:37:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next V5 1/2] ethernet: intel: Add
 the	device ID's presented while running on Hyper-V
In-Reply-To: <1461118677-28142-1-git-send-email-kys@microsoft.com>
References: <1461118655-28103-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-1-git-send-email-kys@microsoft.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D55FB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of K. Y. Srinivasan
> Sent: Tuesday, April 19, 2016 7:18 PM
> To: davem at davemloft.net; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; devel at linuxdriverproject.org; olaf at aepfle.de;
> apw at canonical.com; jasowang at redhat.com; eli at mellanox.com;
> jackm at mellanox.com; yevgenyp at mellanox.com; Ronciak, John
> <john.ronciak@intel.com>; intel-wired-lan at lists.osuosl.org;
> alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [PATCH net-next V5 1/2] ethernet: intel: Add the
> device ID's presented while running on Hyper-V
> 
> Intel SR-IOV cards present different ID when running on Hyper-V.
> Add the device IDs presented while running on Hyper-V.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
> 	V5: No change from V1
> 
>  drivers/net/ethernet/intel/ixgbevf/defines.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
New device IDs present
