From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Aug 2019 18:09:04 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Remove EMPR traces from debugfs
 facility
In-Reply-To: <20190806133826.18480-1-maurosr@linux.vnet.ibm.com>
References: <20190806133826.18480-1-maurosr@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F49D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Mauro S. M. Rodrigues
> Sent: Tuesday, August 6, 2019 6:38 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Remove EMPR traces from debugfs
> facility
> 
> Since commit
> '5098850c9b9b ("i40e/i40evf: i40e_register.h updates")'
> it is no longer possible to trigger an EMP Reset from debugfs, but it's possible
> to request it either way, to end up with a bad reset request:
> 
> echo empr > /sys/kernel/debug/i40e/0002\:01\:00.1/command
> i40e 0002:01:00.1: debugfs: forcing EMPR i40e 0002:01:00.1: bad reset request
> 0x00010000
> 
> So let's remove this piece of code and show the available valid commands as
> it is when any invalid command is issued.
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 1 -
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ----
>  2 files changed, 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


