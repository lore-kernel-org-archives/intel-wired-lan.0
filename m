From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Oct 2016 20:31:08 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 07/15] i40e: store
 MAC/VLAN	filters in a hash with the MAC Address as key
In-Reply-To: <1475685046-16900-8-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FAE0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 07/15] i40e: store MAC/VLAN
> filters in a hash with the MAC Address as key
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Replace the mac_filter_list with a static size hash table of 8bits. The primary
> advantage of this is a decrease in latency of operations related to searching
> for specific MAC filters, including .set_rx_mode. Using a linked list resulted in
> several locations which were O(n^2). Using a hash table should give us
> latency growth closer to O(n*log(n)).
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I5330bd04053b880e670210933e35830b95948ebb
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  24 ++-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 198 ++++++++++++--------
> -
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  38 ++--
>  5 files changed, 161 insertions(+), 107 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


