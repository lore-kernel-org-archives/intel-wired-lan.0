From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Apr 2018 22:15:28 +0000
Subject: [Intel-wired-lan] [iwl next-queue PATCH 06/10] macvlan: Add
 function to test for destination filtering support
In-Reply-To: <20180403211624.7880.72399.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211624.7880.72399.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95AF1F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, April 3, 2018 2:16 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [iwl next-queue PATCH 06/10] macvlan: Add
> function to test for destination filtering support
> 
> This patch adds a function indicating if a given macvlan can fully supports
> destination filtering, especially as it relates to unicast traffic. For those
> macvlan interfaces that do not support destination filtering such passthru or
> source mode filtering we should not be enabling offload support.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  include/linux/if_macvlan.h |    9 +++++++++
>  1 file changed, 9 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


