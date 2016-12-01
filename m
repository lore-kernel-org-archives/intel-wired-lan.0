From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 19:39:46 +0000
Subject: [Intel-wired-lan] [next PATCH S55 07/14] i40e: don't check
 params	until after checking for client instance
In-Reply-To: <1480377971-23412-8-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38F3A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S55 07/14] i40e: don't check params
> until after checking for client instance
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We can avoid the minor bit of work by calling check params after we check
> for the client instance, since we're about to return early in cases where we
> do not have a client.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I56f8ea2ba48d4f571fa331c9ace50819a022fa1c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


