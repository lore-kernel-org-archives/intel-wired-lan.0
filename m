From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 26 Oct 2018 16:51:25 +0000
Subject: [Intel-wired-lan] [RFC PATCH 0/4] More accurate PHC<->system
 clock synchronization
In-Reply-To: <20181026162742.631-1-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884CE4B79@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> Sent: Friday, October 26, 2018 9:28 AM
> To: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; Richard Cochran <richardcochran@gmail.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Miroslav Lichvar <mlichvar@redhat.com>
> Subject: [RFC PATCH 0/4] More accurate PHC<->system clock synchronization
> 

I read the whole series, and it looks good to me.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> There is some duplication of code in the igb and ixgbe drivers, which I
> don't like very much, but I thought it's better than extending and
> wrapping the existing functions like in the e1000e driver. Also, mixing
> SYSTIM and "system time" in the code will probably be confusing.
> 
> I wasn't able to find a better name for the ioctl, the structures, and
> the driver function. If anyone has suggestions, please let me know.
> 

Hmm.. Yea, I don't really have better names either.

> Miroslav Lichvar (4):
>   ptp: add PTP_SYS_OFFSET_EXTENDED ioctl
>   e1000e: add support for extended PHC gettime
>   igb: add support for extended PHC gettime
>   ixgbe: add support for extended PHC gettime
> 
>  drivers/net/ethernet/intel/e1000e/e1000.h    |  3 ++
>  drivers/net/ethernet/intel/e1000e/netdev.c   | 48 +++++++++++++----
>  drivers/net/ethernet/intel/e1000e/ptp.c      | 21 ++++++++
>  drivers/net/ethernet/intel/igb/igb_ptp.c     | 43 +++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 57 ++++++++++++++++++++
>  drivers/ptp/ptp_chardev.c                    | 39 ++++++++++++++
>  include/linux/ptp_clock_kernel.h             | 26 +++++++++
>  include/uapi/linux/ptp_clock.h               | 12 +++++
>  8 files changed, 239 insertions(+), 10 deletions(-)
> 
> --
> 2.17.2

