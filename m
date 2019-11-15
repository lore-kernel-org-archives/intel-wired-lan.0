From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 15 Nov 2019 01:14:15 +0000
Subject: [Intel-wired-lan] [PATCH net 02/13] net: reject PTP periodic
 output requests with unsupported flags
In-Reply-To: <7275436b02f9551807f68784d4f4ebaf0adbc35e.camel@mellanox.com>
References: <20191114184507.18937-3-richardcochran@gmail.com>
 <7275436b02f9551807f68784d4f4ebaf0adbc35e.camel@mellanox.com>
Message-ID: <02874ECE860811409154E81DA85FBB5896990A94@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Saeed Mahameed <saeedm@mellanox.com>
> Sent: Thursday, November 14, 2019 3:58 PM
> To: richardcochran at gmail.com; netdev at vger.kernel.org
> Cc: Hall, Christopher S <christopher.s.hall@intel.com>; Eugenia Emantayev
> <eugenia@mellanox.com>; davem at davemloft.net;
> sergei.shtylyov at cogentembedded.com; Feras Daoud <ferasda@mellanox.com>;
> stefan.sorensen at spectralink.com; Brown, Aaron F <aaron.f.brown@intel.com>;
> brandon.streiff at ni.com; Keller, Jacob E <jacob.e.keller@intel.com>; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org;
> felipe.balbi at linux.intel.com
> Subject: Re: [PATCH net 02/13] net: reject PTP periodic output requests with
> unsupported flags
> 
> On Thu, 2019-11-14 at 10:44 -0800, Richard Cochran wrote:
> > From: Jacob Keller <jacob.e.keller@intel.com>
> >
> LGTM, just there might be a problem with old tools that didn't clear
> the flags upon request and expected PTP periodic .. they will stop to
> work with new kernel, am i am not sure if such tools do exist.
> 

Not quite. This is why there is a V2 ioctl now. The V1 ioctl now explicitly disables any bits set beyond the originally defined ones, so that callers of v1 will continue to work, even if they send junk data.

Thus, old tools should continue working with the old interface, while tools that want new functionality must be upgraded to use the v2 ioctls.

Thanks,
Jake

> But the fact now that we have PTP_PEROUT_ONE_SHOT, we need to trust
> both driver and tools to do the right thing.
> 
> What are the tools to test PTP_PEROUT_ONE_SHOT ? to support this in
> mlx5 it is just a matter of a flipping a bit.
> 
> Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
> 

