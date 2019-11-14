From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Nov 2019 19:16:44 +0000
Subject: [Intel-wired-lan] [PATCH net 00/13] ptp: Validate the ancillary
 ioctl flags more carefully.
In-Reply-To: <20191114184507.18937-1-richardcochran@gmail.com>
References: <20191114184507.18937-1-richardcochran@gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB589698F714@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Thursday, November 14, 2019 10:45 AM
> To: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; David Miller <davem@davemloft.net>;
> Brandon Streiff <brandon.streiff@ni.com>; Hall, Christopher S
> <christopher.s.hall@intel.com>; Eugenia Emantayev <eugenia@mellanox.com>;
> Felipe Balbi <felipe.balbi@linux.intel.com>; Feras Daoud
> <ferasda@mellanox.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>; Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com>; Stefan Sorensen
> <stefan.sorensen@spectralink.com>
> Subject: [PATCH net 00/13] ptp: Validate the ancillary ioctl flags more carefully.
> 
> The flags passed to the ioctls for periodic output signals and
> time stamping of external signals were never checked, and thus formed
> a useless ABI inadvertently.  More recently, a version 2 of the ioctls
> was introduced in order make the flags meaningful.  This series
> tightens up the checks on the new ioctl flags.
> 
> - Patch 1 ensures at least one edge flag is set for the new ioctl.
> - Patches 2-7 are Jacob's recent checks, picking up the tags.
> - Patch 8 introduces a "strict" flag for passing to the drivers when the
>   new ioctl is used.
> - Patches 9-12 implement the "strict" checking in the drivers.
> - Patch 13 extends the test program to exercise combinations of flags.
> 
> Jacob Keller (6):
>   net: reject PTP periodic output requests with unsupported flags
>   mv88e6xxx: reject unsupported external timestamp flags
>   dp83640: reject unsupported external timestamp flags
>   igb: reject unsupported external timestamp flags
>   mlx5: reject unsupported external timestamp flags
>   renesas: reject unsupported external timestamp flags
> 

The patches from me accurately represent what I submitted and I'm happy to have them committed via this series.

> Richard Cochran (7):
>   ptp: Validate requests to enable time stamping of external signals.
>   ptp: Introduce strict checking of external time stamp options.
>   mv88e6xxx: Reject requests to enable time stamping on both edges.
>   dp83640: Reject requests to enable time stamping on both edges.
>   igb: Reject requests that fail to enable time stamping on both edges.
>   mlx5: Reject requests to enable time stamping on both edges.
>   ptp: Extend the test program to check the external time stamp flags.

My only suggestion here would be to implement the STRICT flag without modifying drivers, and have drivers allow STRICT and begin checking for it at the same time.

Given this series all lands together though, it's not really a big deal because the resulting tree after all patches apply is the same.

Overall:

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake
> 
>  drivers/net/dsa/mv88e6xxx/ptp.c               | 13 +++++
>  drivers/net/ethernet/broadcom/tg3.c           |  4 ++
>  drivers/net/ethernet/intel/igb/igb_ptp.c      | 17 ++++++
>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 17 ++++++
>  drivers/net/ethernet/microchip/lan743x_ptp.c  |  4 ++
>  drivers/net/ethernet/renesas/ravb_ptp.c       | 11 ++++
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  4 ++
>  drivers/net/phy/dp83640.c                     | 16 ++++++
>  drivers/ptp/ptp_chardev.c                     | 20 +++++--
>  include/uapi/linux/ptp_clock.h                |  5 +-
>  tools/testing/selftests/ptp/testptp.c         | 53 ++++++++++++++++++-
>  11 files changed, 156 insertions(+), 8 deletions(-)
> 
> --
> 2.20.1

