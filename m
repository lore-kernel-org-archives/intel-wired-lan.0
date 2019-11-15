From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 15 Nov 2019 01:15:27 +0000
Subject: [Intel-wired-lan] [PATCH net 06/13] mlx5: reject unsupported
 external timestamp flags
In-Reply-To: <c90050bd6a63ef3a6f0c7ea999f44ec51c07e917.camel@mellanox.com>
References: <20191114184507.18937-7-richardcochran@gmail.com>
 <c90050bd6a63ef3a6f0c7ea999f44ec51c07e917.camel@mellanox.com>
Message-ID: <02874ECE860811409154E81DA85FBB5896990AC2@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Saeed Mahameed <saeedm@mellanox.com>
> Sent: Thursday, November 14, 2019 4:03 PM
> To: Ariel Levkovich <lariel@mellanox.com>; richardcochran at gmail.com;
> netdev at vger.kernel.org
> Cc: Hall, Christopher S <christopher.s.hall@intel.com>; Eugenia Emantayev
> <eugenia@mellanox.com>; davem at davemloft.net;
> sergei.shtylyov at cogentembedded.com; Feras Daoud <ferasda@mellanox.com>;
> stefan.sorensen at spectralink.com; brandon.streiff at ni.com; Keller, Jacob E
> <jacob.e.keller@intel.com>; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> intel-wired-lan at lists.osuosl.org; felipe.balbi at linux.intel.com
> Subject: Re: [PATCH net 06/13] mlx5: reject unsupported external timestamp
> flags
> 
> On Thu, 2019-11-14 at 10:45 -0800, Richard Cochran wrote:
> > From: Jacob Keller <jacob.e.keller@intel.com>
> >
> > Fix the mlx5 core PTP support to explicitly reject any future flags
> > that
> > get added to the external timestamp request ioctl.
> >
> > In order to maintain currently functioning code, this patch accepts
> > all
> > three current flags. This is because the PTP_RISING_EDGE and
> > PTP_FALLING_EDGE flags have unclear semantics and each driver seems
> > to
> > have interpreted them slightly differently.
> >
> > [ RC: I'm not 100% sure what this driver does, but if I'm not wrong
> > it
> >       follows the dp83640:
> >
> 
> The driver will check if the PTP_FALLING_EDGE flag was set then it will
> set it in HW, if not then it is going to default to PTP_RISING_EDGE, so
> LGTM.
> 
> Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
> 
> But same story here, old tools that lazily set 0xffff or 0x0000 and
> expected every thing to work.. again not sure if they do exist.
> 
> Ariel please have a look at this patch.
> 

As long as they stick to the original ioctls this won't be a problem, because the v1 ioctl now explicitly clears unsupported bits before calling driver, so this check will pass. Obviously, this change should not be backported to earlier than 5.4 without also backporting that masking in the original ioctl functions.

Thanks,
Jake

