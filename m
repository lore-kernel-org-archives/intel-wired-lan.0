From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Sat, 12 Oct 2019 19:36:31 +0000
Subject: [Intel-wired-lan] [net-next v3 3/7] mv88e6xxx: reject
 unsupported external timestamp flags
In-Reply-To: <20191012182409.GD3165@localhost>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-4-jacob.e.keller@intel.com>
 <20191012182409.GD3165@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB5896926B0B@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Saturday, October 12, 2019 11:24 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: netdev at vger.kernel.org; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandon Streiff
> <brandon.streiff@ni.com>
> Subject: Re: [net-next v3 3/7] mv88e6xxx: reject unsupported external
> timestamp flags
> 
> On Thu, Sep 26, 2019 at 11:11:05AM -0700, Jacob Keller wrote:
> > Fix the mv88e6xxx PTP support to explicitly reject any future flags that
> > get added to the external timestamp request ioctl.
> >
> > In order to maintain currently functioning code, this patch accepts all
> > three current flags. This is because the PTP_RISING_EDGE and
> > PTP_FALLING_EDGE flags have unclear semantics
> 
> For the record, the semantics are (or should be):
> 
>   flags                                                 Meaning
>   ----------------------------------------------------  --------------------------
>   PTP_ENABLE_FEATURE                                    invalid
>   PTP_ENABLE_FEATURE|PTP_RISING_EDGE                    Time stamp rising edge
>   PTP_ENABLE_FEATURE|PTP_FALLING_EDGE                   Time stamp falling edge
>   PTP_ENABLE_FEATURE|PTP_RISING_EDGE|PTP_FALLING_EDGE   Time stamp
> both edges
> 
> > and each driver seems to
> > have interpreted them slightly differently.
> 
> This driver has:
> 
>   flags                                                 Meaning
>   ----------------------------------------------------  --------------------------
>   PTP_ENABLE_FEATURE                                    Time stamp falling edge
>   PTP_ENABLE_FEATURE|PTP_RISING_EDGE                    Time stamp rising edge
>   PTP_ENABLE_FEATURE|PTP_FALLING_EDGE                   Time stamp falling edge
>   PTP_ENABLE_FEATURE|PTP_RISING_EDGE|PTP_FALLING_EDGE   Time stamp
> rising edge
> 
> > Cc: Brandon Streiff <brandon.streiff@ni.com>
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Reviewed-by: Richard Cochran <richardcochran@gmail.com>

Right, so in practice, unless it supports both edges, it should reject setting both RISING and FALLING together.

Thanks,
Jake
