From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 15:00:10 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 01/12] i40e: Fix a bug
 where a	client close can be called before an open is complete
In-Reply-To: <1469646161-30024-2-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB88C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 01/12] i40e: Fix a bug where a
> client close can be called before an open is complete
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The client->open call in this path was not protected with the client instance
> mutex, and hence the client->close can get initiated before the open
> completes.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-Id: I0ed60c38868dd3f44966b6ed49a063d0e5b7edf5
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
