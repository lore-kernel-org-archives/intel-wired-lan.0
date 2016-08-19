From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 21:47:45 +0000
Subject: [Intel-wired-lan] [next PATCH S42-V2 2/2] i40e: Initialize
 pointer	in client_release function
In-Reply-To: <1471295839-13587-2-git-send-email-bimmy.pujari@intel.com>
References: <1471295839-13587-1-git-send-email-bimmy.pujari@intel.com>
 <1471295839-13587-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F942A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, August 15, 2016 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S42-V2 2/2] i40e: Initialize pointer in
> client_release function
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> The function i40e_client_release has a print statement that uses an adapter
> pointer which is not initialized if a previous if statement is not true. Hence,
> intialize it in the right place.
> 
> Testing Hints: Compile check
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Change-ID: I1afdaa2c46771ac42be56edcc41bb56b455b06c8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Base driver functions normally, code changes applied properly


