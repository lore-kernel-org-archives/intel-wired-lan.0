From: Ertman, David M <david.m.ertman@intel.com>
Date: Wed, 8 Sep 2021 17:30:41 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: check whether AUX
 devices/drivers are supported in ice_rebuild
In-Reply-To: <YTRweH4JMbzUtxLf@unreal>
References: <20210903012500.39407-1-yongxin.liu@windriver.com>
 <YTRweH4JMbzUtxLf@unreal>
Message-ID: <SJ0PR11MB49752B60CA91811492A9341EDDD49@SJ0PR11MB4975.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Sunday, September 5, 2021 12:24 AM
> To: Yongxin Liu <yongxin.liu@windriver.com>
> Cc: Ertman, David M <david.m.ertman@intel.com>; Saleem, Shiraz
> <shiraz.saleem@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; davem at davemloft.net; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; intel-wired-lan at lists.osuosl.org;
> kuba at kernel.org
> Subject: Re: [PATCH net] ice: check whether AUX devices/drivers are
> supported in ice_rebuild
> 
> On Fri, Sep 03, 2021 at 09:25:00AM +0800, Yongxin Liu wrote:
> > In ice_rebuild(), check whether AUX devices/drivers are supported or not
> > before calling ice_plug_aux_dev().
> >
> > Fix the following call trace, if RDMA functionality is not available.
> >
> >   auxiliary ice.roce.0: adding auxiliary device failed!: -17
> >   sysfs: cannot create duplicate filename '/bus/auxiliary/devices/ice.roce.0'
> >   Workqueue: ice ice_service_task [ice]
> >   Call Trace:
> >    dump_stack_lvl+0x38/0x49
> >    dump_stack+0x10/0x12
> >    sysfs_warn_dup+0x5b/0x70
> >    sysfs_do_create_link_sd.isra.2+0xc8/0xd0
> >    sysfs_create_link+0x25/0x40
> >    bus_add_device+0x6d/0x110
> >    device_add+0x49d/0x940
> >    ? _printk+0x52/0x6e
> >    ? _printk+0x52/0x6e
> >    __auxiliary_device_add+0x60/0xc0
> >    ice_plug_aux_dev+0xd3/0xf0 [ice]
> >    ice_rebuild+0x27d/0x510 [ice]
> >    ice_do_reset+0x51/0xe0 [ice]
> >    ice_service_task+0x108/0xe70 [ice]
> >    ? __switch_to+0x13b/0x510
> >    process_one_work+0x1de/0x420
> >    ? apply_wqattrs_cleanup+0xc0/0xc0
> >    worker_thread+0x34/0x400
> >    ? apply_wqattrs_cleanup+0xc0/0xc0
> >    kthread+0x14d/0x180
> >    ? set_kthread_struct+0x40/0x40
> >    ret_from_fork+0x1f/0x30
> >
> > Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
> > Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 0d6c143f6653..98cc708e9517 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -6466,7 +6466,9 @@ static void ice_rebuild(struct ice_pf *pf, enum
> ice_reset_req reset_type)
> >  	/* if we get here, reset flow is successful */
> >  	clear_bit(ICE_RESET_FAILED, pf->state);
> >
> > -	ice_plug_aux_dev(pf);
> > +	if (ice_is_aux_ena(pf))
> > +		ice_plug_aux_dev(pf);
> > +
> 
> The change is ok, but it hints that auxiliary bus is used horribly wrong
> in this driver. In proper implementation, which should rely on driver/core,
> every subdriver like ice.eth, ice.roce e.t.c is supposed to be retriggered
> by the code and shouldn't  ave "if (ice_is_aux_ena(pf))" checks.
> 
> Thanks

Hi Leon and Liu -

First of all, thanks Liu for tracking this down - it is an issue that needs to be fixed.  The ice_is_aux_ena() functions only
purpose is to determine if this PF supports RDMA functionality.  In probe(), the aux devices are not even initialized if
this test returns false.  If this check fixed the issue for you, the PF you are on does not currently support RDMA.
The bit this test is based on is only set one place in the driver currently - at probe time when we are checking the
capabilities (common_caps) of the device.

That being said, the call to check this should be in ice_plug_aux_dev function itself.  That way it is taken into account for all
attempts to create the auxiliary device.  There is another consideration about disabling RDMA that needs to also needs to be
taken into account to avoid a similar situation.

If it is acceptable, I will create a new patch today and get it out either this afternoon or tomorrow.

Thanks,
Dave E

> 
> >  	return;
> >
> >  err_vsi_rebuild:
> > --
> > 2.14.5
> >
