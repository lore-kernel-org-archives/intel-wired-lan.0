From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 21 May 2015 20:18:40 +0000
Subject: [Intel-wired-lan] [net-next PATCH 2] ixgbe: add array of MAC
 type dependent values
In-Reply-To: <1431989501.2558.16.camel@jtkirshe-mobl>
References: <20150518163140.7168.81419.stgit@dcs-desk.jf.intel.com>
 <1431989501.2558.16.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F83A07C@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, May 18, 2015 3:52 PM
> To: Skidmore, Donald C
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [net-next PATCH 2] ixgbe: add array of MAC type
> dependent values
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
> Not sure if there is a difference between this patch and the one you send later
> today, so I am dropping this patch and will be looking to apply your patch you
> sent later today. :-)

Failing patch.
With patch applied, attempting to load ixgbe fails with:
[    3.277824] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.0.1-k
[    3.278207] ixgbe: Copyright (c) 1999-2014 Intel Corporation.
[   37.573935] ixgbe 0000:03:00.0 0000:03:00.0 (uninitialized): eeprom read at offset 40 failed
[   37.574324] ixgbe 0000:03:00.0 0000:03:00.0 (uninitialized): eeprom read at offset 39 failed
[   37.574711] ixgbe 0000:03:00.0: The EEPROM Checksum Is Not Valid
[   37.575023] ixgbe: probe of 0000:03:00.0 failed with error -5
[   71.864405] ixgbe 0000:03:00.1 0000:03:00.1 (uninitialized): eeprom read at offset 40 failed
[   71.864792] ixgbe 0000:03:00.1 0000:03:00.1 (uninitialized): eeprom read at offset 39 failed
[   71.865178] ixgbe 0000:03:00.1: The EEPROM Checksum Is Not Valid
[   71.865476] ixgbe: probe of 0000:03:00.1 failed with error -5
Thanks,
Phil




