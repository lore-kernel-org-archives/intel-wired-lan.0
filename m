From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Jan 2018 23:32:09 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 09/12] virtchnl: Add a
 macro to check the size of a union
In-Reply-To: <20180123165106.28900-10-avinash.dayanand@intel.com>
References: <20180123165106.28900-1-avinash.dayanand@intel.com>
 <20180123165106.28900-10-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A2BF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Tuesday, January 23, 2018 8:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 09/12] virtchnl: Add a macro
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


