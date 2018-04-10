From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Apr 2018 22:15:58 +0000
Subject: [Intel-wired-lan] [iwl next-queue PATCH 07/10] macvlan: Provide
 function for interfaces to release HW offload
In-Reply-To: <20180403211630.7880.85594.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211630.7880.85594.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95AF2F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, April 3, 2018 2:17 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [iwl next-queue PATCH 07/10] macvlan: Provide
> function for interfaces to release HW offload
> 
> This patch provides a basic function to allow a lower device to disable
> macvlan offload if it was previously enabled on a given macvlan. The idea
> here is to allow for recovery from failure should the lowerdev run out of
> resources.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  include/linux/if_macvlan.h |    8 ++++++++
>  1 file changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


