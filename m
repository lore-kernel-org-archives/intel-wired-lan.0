From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jun 2018 17:17:31 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 1/7] net-sysfs:
 Drop support for XPS and traffic_class on single queue device
In-Reply-To: <20180612151830.86792.69449.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
 <20180612151830.86792.69449.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C80D9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, June 12, 2018 8:19 AM
> To: intel-wired-lan at osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org
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


