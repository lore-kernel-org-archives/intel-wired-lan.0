From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 18:24:11 +0000
Subject: [Intel-wired-lan] [next PATCH S29 04/14] i40e: Add a
	client	definition of I40E_MAX_USER_PRIORITY
In-Reply-To: <1455754344-6372-5-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-5-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F227@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S29 04/14] i40e: Add a client definition
> of I40E_MAX_USER_PRIORITY
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> IWARP uses I40E_MAX_USER_PRIORITY in i40e_client.h but it is not defined
> there so add a I40E_CLIENT_MAX_USER_PRIORITY definition to i40e_client.h
> and a comment to i40e.h that we need to keep the two definitions synced.
> 
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I0fc8868c2b090f54914ab738ec52b48ae4f523e2
> ---
> Testing Hints: Make sure it compiles.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes properly applied
