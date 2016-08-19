From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 21:47:12 +0000
Subject: [Intel-wired-lan] [next PATCH S42-V2 1/2] i40e: Check client
	is	open before calling client ops
In-Reply-To: <1471295839-13587-1-git-send-email-bimmy.pujari@intel.com>
References: <1471295839-13587-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F941E@ORSMSX104.amr.corp.intel.com>
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
> Cc: Catherine Sullivan <catherine.sullivan@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S42-V2 1/2] i40e: Check client is open
> before calling client ops
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> We were having a race between the completion of the client open and calls
> to the client ops so don't call a client op unless we are sure the client is open.
> 
> Testing Hints: Load IWARP driver and make sure it works as expected.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-Id: I741f4f2aa4fcbfdad3e40dabbbb1b005856c396b
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 25
> +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Base driver functions normally, code changes applied properly


