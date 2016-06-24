From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jun 2016 21:20:20 +0000
Subject: [Intel-wired-lan] [next PATCH S39 3/3] i40e: Move the mutex
 lock in	i40e_client_unregister
In-Reply-To: <1466716126-9971-1-git-send-email-bimmy.pujari@intel.com>
References: <1466716126-9971-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E90BB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Thursday, June 23, 2016 2:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S39 3/3] i40e: Move the mutex lock in
> i40e_client_unregister
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> We need to lock the client list around the i40e_client_release call to prevent
> the release from interrupting the client instances while they are being
> added.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-Id: I99993f20179aaf8730207833e7d0869d2ccffa1d
> ---
> Testing Hints: Do a insmod/rmmod of i40iw quickly and see if there is a kernel
> paging failure.
> 
> HSD-number: 7661337
> 
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No kernel panic during testing
