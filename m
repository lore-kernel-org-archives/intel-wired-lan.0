From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 26 Oct 2018 16:40:59 +0000
Subject: [Intel-wired-lan] [RFC PATCH 0/4] More accurate PHC<->system
 clock synchronization
In-Reply-To: <20181026162742.631-1-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884CE4B4A@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Miroslav,

> -----Original Message-----
> From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> Sent: Friday, October 26, 2018 9:28 AM
> To: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; Richard Cochran <richardcochran@gmail.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Miroslav Lichvar <mlichvar@redhat.com>
> Subject: [RFC PATCH 0/4] More accurate PHC<->system clock synchronization
> 
> This series adds support for a more accurate synchronization between a
> PTP hardware clock and the system clock.
> 
> The first patch adds an extended version of the PTP_SYS_OFFSET ioctl,
> which returns three timestamps for each measurement. The idea is to
> shorten the interval between the system timestamps to contain just the
> reading of the lowest register of the PHC in order to reduce the error
> in the measured offset and give a better bound on the maximum error.
> 
> The other patches add support for the new ioctl to the e1000e, igb,
> and ixgbe driver. Tests with few different NICs in different machines
> (and PCIe slots) show that:
> - with an I219 (e1000e) the measured delay improved from 2500 to 1300 ns
>   and the error in the measured offset, when compared to cross
>   timestamping, was reduced by a factor of 5
> - with an I210 (igb) the delay improved from 5100 to 1700 ns
> - with an I350 (igb) the delay improved from 2300 to 750 ns
> - with an X550 (ixgbe) the delay improved from 1950 to 650 ns
> 

That is some very significant improvements! Excellent find.

> There is some duplication of code in the igb and ixgbe drivers, which I
> don't like very much, but I thought it's better than extending and
> wrapping the existing functions like in the e1000e driver. Also, mixing
> SYSTIM and "system time" in the code will probably be confusing.
> 

Yea...

> I wasn't able to find a better name for the ioctl, the structures, and
> the driver function. If anyone has suggestions, please let me know.
> 

I don't have any good suggestions yet. I'll reply after reviewing if I think of any.

Thanks,
Jake
