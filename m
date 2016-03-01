From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 1 Mar 2016 17:14:33 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Make all unchanging ops
 structures	const
In-Reply-To: <20160107181303.82798.52945.stgit@mdrustad-wks.jf.intel.com>
References: <20160107181303.82798.52945.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99B0D4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Thursday, January 07, 2016 10:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Make all unchanging ops structures
> const
> 
> The source for the ops structure contents are const, so make them so. Copy
> them in place with structure assignments instead of memcpys.
> Make the mbx_ops accessed by reference instead of making a copy of the
> source structure. Update copyright date on the touched files.
> 
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Access mbx_ops by reference instead of copying the structure. Saves a
>   little bloat.
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |   12 ++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |   10 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |   10 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   10 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c   |   40 ++++++++++++--------
> ----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   |    4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |   12 ++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  |   10 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |   18 +++++------
>  9 files changed, 63 insertions(+), 63 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied
