From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Mar 2017 16:25:17 +0000
Subject: [Intel-wired-lan] [next PATCH S61 02/10] i40e: fix
 configuration of	RSS table with DCB
In-Reply-To: <1487721348-25617-3-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401EF5@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, February 21, 2017 3:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S61 02/10] i40e: fix configuration of
> RSS table with DCB
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> There exists a bug in the driver where the calculation of the RSS size was not
> taking into account the number of traffic classes enabled. This patch factors
> in the traffic classes both in the initial configuration of the table as well as
> reconfiguration.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Change-ID: I34dcd345ce52faf1d6b9614bea28d450cfd5f621
> ---
> Testing Hints: Change the number of queues and RSS hash table via ethtool
> and ensure that no packets are dropped.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


