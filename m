From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Jul 2018 21:15:45 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 1/7] net-sysfs:
 Drop support for XPS and traffic_class on single queue device
In-Reply-To: <20180709161932.8383.5753.stgit@ahduyck-green-test.jf.intel.com>
References: <20180709161743.8383.97754.stgit@ahduyck-green-test.jf.intel.com>
 <20180709161932.8383.5753.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2D368F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 1/7] net-sysfs:
> Drop support for XPS and traffic_class on single queue device
> 
> This patch makes it so that we do not report the traffic class or allow XPS
> configuration on single queue devices. This is mostly to avoid unnecessary
> complexity with changes I have planned that will allow us to reuse the
> unused tc_to_txq and XPS configuration on a single queue device to allow it
> to make use of a subset of queues on an underlying device.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  net/core/net-sysfs.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


