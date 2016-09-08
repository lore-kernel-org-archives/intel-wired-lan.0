From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Sep 2016 21:19:52 +0000
Subject: [Intel-wired-lan] [next PATCH S45 05/10] i40e: fix deleting
	mac	filters
In-Reply-To: <1473210312-29592-6-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FC8E4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 06, 2016 6:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S45 05/10] i40e: fix deleting mac filters
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> There exists a bug in which deleting a mac filter does not actually occur.  The
> driver reports that the filter has been deleted with no error.  The problem
> occurs because the wrong cmd_flag is passed to the firmware when deleting
> the filter.  The firmware reports an error back to the driver but it is expressly
> ignored.
> 
> This fixes the bug by using the correct flag when deleting a filter.
> Without this patch, deleted filters remain in firmware and function as if they
> had not been deleted.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: I5f22b874f3b83f457702f18f0d5602ca21ac40c3
> ---
> Testing-hints:
>         I used 'tcpdump -npi <iface>' to watch traffic.
> 
>         1.  Pass traffic with mac header 00:aa:00:aa:02:01 - no traffic
>         2.  Add mac filter - ip maddr add 00:aa:00:aa:02:01 dev enp5s0f0
>         3.  Pass traffic with mac header 00:aa:00:aa:02:01 - traffic
>         4.  Delete mac filter - ip maddr del 00:aa:00:aa:02:01 dev enp5s0f0
>         5.  Pass traffic with mac header 00:aa:00:aa:02:01
>                 Expected - no traffic
>                 Actual - traffic
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Bug/behavior no longer present, mac filters work as designed

