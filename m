From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 17:16:40 +0000
Subject: [Intel-wired-lan] [next PATCH S37 14/15] i40e: add VSI info
	to	macaddr messages
In-Reply-To: <1463419605-30746-15-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-15-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D690F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 14/15] i40e: add VSI info to
> macaddr messages
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Since the macaddr add and delete happens asynchronously, error messages
> don't easily get associated to the actual request. Here we add a bit of
> information to the error messages to help determine the source of the error.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Id2d6df5287141c3579677d72d8bd21122823d79f
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 31
> ++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Tested messages show VSI information
