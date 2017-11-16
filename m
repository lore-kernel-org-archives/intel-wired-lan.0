From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 18:09:14 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] ethtool: correct display of VF
 when showing vf/queue filters
In-Reply-To: <20171110185553.14657-1-jacob.e.keller@intel.com>
References: <20171110185553.14657-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEDC7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, November 10, 2017 10:56 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 1/3] ethtool: correct display of VF when
> showing vf/queue filters
> 
> The original code that implemented this accidentally had an inverted check,
> so it would never show the VF number properly.
> 
> Fix this code to correctly display the VF number when we have one.
> 
> Fixes: 36ee712b0fbc ("ethtool: support queue and VF fields for rxclass
> filters", 2017-03-23)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  rxclass.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


