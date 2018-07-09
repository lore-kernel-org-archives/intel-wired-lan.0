From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Jul 2018 21:16:23 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 2/7] net: Add
 support for subordinate device traffic classes
In-Reply-To: <20180709161937.8383.20925.stgit@ahduyck-green-test.jf.intel.com>
References: <20180709161743.8383.97754.stgit@ahduyck-green-test.jf.intel.com>
 <20180709161937.8383.20925.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2D469F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, July 9, 2018 9:20 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 2/7] net: Add
> support for subordinate device traffic classes
> 
> This patch is meant to provide the basic tools needed to allow us to create
> subordinate device traffic classes. The general idea here is to allow
> subdividing the queues of a device into queue groups accessible through an
> upper device such as a macvlan.
> 
> The idea here is to enforce the idea that an upper device has to be a single
> queue device, ideally with IFF_NO_QUQUE set. With that being the case we
> can pretty much guarantee that the tc_to_txq mappings and XPS maps for
> the upper device are unused. As such we could reuse those in order to
> support subdividing the lower device and distributing those queues between
> the subordinate devices.
> 
> In order to distinguish between a regular set of traffic classes and if a device
> is carrying subordinate traffic classes I changed num_tc from a u8 to a s16
> value and use the negative values to represent the suboordinate pool
> values. So starting at -1 and running to -32768 we can encode those as pool
> values, and the existing values of 0 to 15 can be maintained.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  include/linux/netdevice.h |   16 ++++++++
>  net/core/dev.c            |   89
> +++++++++++++++++++++++++++++++++++++++++++++
>  net/core/net-sysfs.c      |   21 ++++++++++-
>  3 files changed, 124 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



