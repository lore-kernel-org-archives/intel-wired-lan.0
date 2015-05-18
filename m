From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Mon, 18 May 2015 22:55:32 +0000
Subject: [Intel-wired-lan] [net-next PATCH 2] ixgbe: add array of MAC
 type dependent values
In-Reply-To: <1431989501.2558.16.camel@jtkirshe-mobl>
References: <20150518163140.7168.81419.stgit@dcs-desk.jf.intel.com>
 <1431989501.2558.16.camel@jtkirshe-mobl>
Message-ID: <F6FB0E698C9B3143BDF729DF22286646912FAD0B@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Monday, May 18, 2015 3:52 PM
> To: Skidmore, Donald C
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [net-next PATCH 2] ixgbe: add array of MAC
> type dependent values
> 
> On Mon, 2015-05-18 at 12:31 -0400, Don Skidmore wrote:
> > Some of the register addresses and format where unfortunately changed
> > between MAC types. To get around this we add a const u32 *mvals
> > pointer to the ixgbe_hw struct to point to an array of
> > mac-type-dependent values.  These can include register offsets, masks,
> > whatever can be in a u32. When the ixgbe_hw struct is initialized, a
> > pointer to the appropriate array must be set.
> >
> > Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c   |    1
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |    7 -
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |   59 +++--
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h  |    2
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    6 -
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   43 ++--
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     |   44 ++--
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |  246
> > ++++++++++++++++++----
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c    |   41 ++--
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |   12 +
> >  10 files changed, 328 insertions(+), 133 deletions(-)
> 
> Not sure if there is a difference between this patch and the one you send
> later today, so I am dropping this patch and will be looking to apply your
> patch you sent later today. :-)

Sorry the earlier one wasn't up to date with you tree.  I ended up not having to make any changes so I wasn't sure I should bump the version.

Thanks for cleaning it up.

