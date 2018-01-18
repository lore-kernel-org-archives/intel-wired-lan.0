From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Jan 2018 19:03:05 +0000
Subject: [Intel-wired-lan] [PATCH v2 next-queue 10/12] virtchnl: Add
 filter data structures
In-Reply-To: <20180117161607.49344-11-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
 <20180117161607.49344-11-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A935BB7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 next-queue 10/12] virtchnl: Add filter
> data structures
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch adds infrastructure to send virtchnl messages to the PF to
> configure filters on the VF. The patch adds a struct called virtchnl_filter which
> contains information about the fields in the user-specified tc filter.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 59
> ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


