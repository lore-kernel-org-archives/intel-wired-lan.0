From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Nov 2019 19:08:16 +0000
Subject: [Intel-wired-lan] [PATCH net 03/13] mv88e6xxx: reject
 unsupported external timestamp flags
In-Reply-To: <20191114184507.18937-4-richardcochran@gmail.com>
References: <20191114184507.18937-4-richardcochran@gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB589698F6A6@ORSMSX121.amr.corp.intel.com>
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
> Subject: [PATCH net 03/13] mv88e6xxx: reject unsupported external timestamp
> flags
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Fix the mv88e6xxx PTP support to explicitly reject any future flags that
> get added to the external timestamp request ioctl.
> 
> In order to maintain currently functioning code, this patch accepts all
> three current flags. This is because the PTP_RISING_EDGE and
> PTP_FALLING_EDGE flags have unclear semantics and each driver seems to
> have interpreted them slightly differently.
> 
> For the record, the semantics of this driver are:
> 
>   flags                                                 Meaning
>   ----------------------------------------------------  --------------------------
>   PTP_ENABLE_FEATURE                                    Time stamp falling edge

For the new version of the ioctl this isn't possible, but we still support the v1 ioctl which would still have this mode. Ok.

>   PTP_ENABLE_FEATURE|PTP_RISING_EDGE                    Time stamp rising edge
>   PTP_ENABLE_FEATURE|PTP_FALLING_EDGE                   Time stamp falling edge
>   PTP_ENABLE_FEATURE|PTP_RISING_EDGE|PTP_FALLING_EDGE   Time stamp
> rising edge
> 

Thanks,
Jake

