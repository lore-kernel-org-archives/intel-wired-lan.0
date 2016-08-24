From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Aug 2016 22:20:54 +0000
Subject: [Intel-wired-lan] [next PATCH S44 3/6] i40e: Change some init
 flow	for the client
In-Reply-To: <1472063631-9033-4-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
 <1472063631-9033-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAA91@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, August 24, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S44 3/6] i40e: Change some init flow
> for the client
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This change makes a common flow for Client instance open during init and
> reset path. The Client subtask can handle both the cases instead of making a
> separate notify_client_of_open call.
> Also it may fix a bug during reset where the service task was leaking some
> memory and causing issues.
> 
> HSD-number: 7660752
> Testing Hints :
> The original bug related to the HSD was due the IWARP driver setting
> LAUNCH_ON_PROBE flag on its sidem which should be fixed in the IWARP
> driver. This is further cleanup.
> Test with init/reset/up/down/remove combinations on both LAN and IWARP
> driver side.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-Id: I7232a32fd52b82e863abb54266fa83122f80a0cd
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 41
> ++++++++++++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 -
>  2 files changed, 30 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


