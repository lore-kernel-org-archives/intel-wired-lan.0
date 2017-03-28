From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Mar 2017 23:12:40 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2] i40e: fix for queue
 timing	delays
In-Reply-To: <149071317310.43528.16942163405081978511.stgit@cmw-ivy.jf.intel.com>
References: <149071317310.43528.16942163405081978511.stgit@cmw-ivy.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A56A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Carolyn Wyborny
> Sent: Tuesday, March 28, 2017 8:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH v2] i40e: fix for queue timing
> delays
> 
> This patch adds a delay to rx queue disables to accommodate hw needs.
> 
> v2: Added missing check for disable only, additional details on the need for
> the ugly delay and fixed spacing on comment.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I2864ca667ce5dcc2cc44f8718113b719742a46a1
> ---
> internal v2: fixed length of commit message and end comment
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


