From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 19:00:26 +0000
Subject: [Intel-wired-lan] [next PATCH S29 05/14] i40e: Do not wait for
 Rx	queue disable in DCB reconfig
In-Reply-To: <1455754344-6372-6-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-6-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F265@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, February 17, 2016 4:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S29 05/14] i40e: Do not wait for Rx
> queue disable in DCB reconfig
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> Just like Tx queues don't wait for Rx queues to be disabled before DCB has
> been reconfigured.
> Check the queues are disabled only after the DCB configuration has been
> applied to the VSI(s) managed by the PF driver.
> 
> In case of any timeout issue a PF reset to recover.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: Ic51e94c25baf9a5480cee983f35d15575a88642c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 33
> +++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes properly applied, does not break base driver.

