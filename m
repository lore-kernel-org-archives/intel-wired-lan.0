From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Jan 2018 19:02:38 +0000
Subject: [Intel-wired-lan] [PATCH v2 next-queue 09/12] virtchnl: Add a
 macro to check the size of a union
In-Reply-To: <20180117161607.49344-10-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
 <20180117161607.49344-10-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A935BAB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, January 17, 2018 8:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 next-queue 09/12] virtchnl: Add a macro
> to check the size of a union
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch adds a macro to check if the size of a union is correct.
> It throws a divide by zero error if the union is not of the correct size.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


