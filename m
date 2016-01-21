From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Jan 2016 17:30:46 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix build warnings
In-Reply-To: <1453348382-79870-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1453348382-79870-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98BEA5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, January 20, 2016 7:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Eric Dumazet <edumazet@google.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: fix build warnings
> 
> From: Eric Dumazet <edumazet@google.com>
> 
> Fixes following build warnings :
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:7057:13: warning:
> 'i40e_sync_udp_filters_subtask' defined but not used [-Wunused-function]
> drivers/net/ethernet/intel/i40e/i40e_main.c:8524:13: warning:
> 'i40e_add_vxlan_port' defined but not used [-Wunused-function]
> drivers/net/ethernet/intel/i40e/i40e_main.c:8569:13: warning:
> 'i40e_del_vxlan_port' defined but not used [-Wunused-function]
> drivers/net/ethernet/intel/i40e/i40e_main.c:8604:13: warning:
> 'i40e_add_geneve_port' defined but not used [-Wunused-function]
> drivers/net/ethernet/intel/i40e/i40e_main.c:8651:13: warning:
> 'i40e_del_geneve_port' defined but not used [-Wunused-function]
> 
> Fixes: 6a899024058d ("i40e: geneve tunnel offload support")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no build warnings
