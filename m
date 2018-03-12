From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Mar 2018 21:21:54 +0000
Subject: [Intel-wired-lan] [S87 v5 6/7] i40e: fix for wrong partition id
 calculation on OCP mezz cards
In-Reply-To: <20180308225211.12254-6-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
 <20180308225211.12254-6-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94BE4E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, March 8, 2018 2:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [S87 v5 6/7] i40e: fix for wrong partition id
> calculation on OCP mezz cards
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> This patch overwrites number of ports for X722 devices with support for OCP
> PHY mezzanine.
> The old method with checking if port is disabled in the PRTGEN_CNF register
> cannot be used in this case. When the OCP is removed, ports were seen as
> disabled, which resulted in wrong calculation of partition id, that caused WoL
> to be disabled on certain ports.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 23
> ++++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 +++
>  2 files changed, 25 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


