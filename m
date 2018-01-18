From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Jan 2018 18:47:28 +0000
Subject: [Intel-wired-lan] [PATCH v2 next-queue 02/12] virtchnl: Add
 virtchl structures to support queue channels
In-Reply-To: <20180117161607.49344-3-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
 <20180117161607.49344-3-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A935B48@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 next-queue 02/12] virtchnl: Add virtchl
> structures to support queue channels
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch defines new structs in support of the virtchannel message that the
> VF sends to the PF to create a queue channel specified by the user via tc tool.
> 
> v2: Fixed structure hole on 32 bit systems.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 40
> ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


