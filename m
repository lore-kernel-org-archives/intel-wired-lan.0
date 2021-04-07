From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 7 Apr 2021 21:21:28 +0000
Subject: [Intel-wired-lan] [PATCH V2 net] ice: fix memory leak of aRFS
 after resuming from suspend
In-Reply-To: <c30428155948b44cf08aa438db8bebff67730207.camel@intel.com>
References: <20210319064038.15315-1-yongxin.liu@windriver.com>
 <PH0PR11MB5175BAF6F45C7F862CD0A33DE57C9@PH0PR11MB5175.namprd11.prod.outlook.com>
 <c30428155948b44cf08aa438db8bebff67730207.camel@intel.com>
Message-ID: <CO1PR11MB510576338209FFCBAF1465F4FA759@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Thursday, April 1, 2021 1:27 PM
> To: Chittim, Madhu <madhu.chittim@intel.com>;
> Yongxin.Liu at windriver.com; andrewx.bowers at intel.com;
> jeffrey.t.kirsher at intel.com; Creeley, Brett <brett.creeley@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH V2 net] ice: fix memory leak of aRFS
> after resuming from suspend
> 
> On Wed, 2021-03-31 at 02:28 +0000, Liu, Yongxin wrote:
> > Hello Brett,
> >
> > Could you please help to review this V2?
> >
> 
> Hi Yongxin,
> 
> I have this applied to the Intel-wired-lan tree to go through some testing.
> Also, adding the Intel-wired-lan list for reviews.
> 
> Thanks,
> Tony
> 
> > Thanks,
> > Yongxin
> >
> > > -----Original Message-----
> > > From: Liu, Yongxin <yongxin.liu@windriver.com>
> > > Sent: Friday, March 19, 2021 14:44
> > > To: brett.creeley at intel.com; madhu.chittim at intel.com;
> > > anthony.l.nguyen at intel.com; andrewx.bowers at intel.com;
> > > jeffrey.t.kirsher at intel.com
> > > Cc: netdev at vger.kernel.org
> > > Subject: [PATCH V2 net] ice: fix memory leak of aRFS after resuming
> > > from suspend
> > >
> > > In ice_suspend(), ice_clear_interrupt_scheme() is called, and then
> > > irq_free_descs() will be eventually called to free irq and its
> > > descriptor.
> > >
> > > In ice_resume(), ice_init_interrupt_scheme() is called to allocate
> > > new irqs.
> > > However, in ice_rebuild_arfs(), struct irq_glue and struct cpu_rmap
> > > maybe cannot be freed, if the irqs that released in ice_suspend()
> > > were reassigned to other devices, which makes irq descriptor's
> > > affinity_notify lost.
> > >
> > > So call ice_free_cpu_rx_rmap() before ice_clear_interrupt_scheme(),
> > > which can make sure all irq_glue and cpu_rmap can be correctly
> > > released before corresponding irq and descriptor are released.
> > >
> > > Fix the following memory leak.
> > >
> > > unreferenced object 0xffff95bd951afc00 (size 512):
> > >   comm "kworker/0:1", pid 134, jiffies 4294684283 (age 13051.958s)
> > >   hex dump (first 32 bytes):
> > >     18 00 00 00 18 00 18 00 70 fc 1a 95 bd 95 ff ff
> > > ........p.......
> > >     00 00 ff ff 01 00 ff ff 02 00 ff ff 03 00 ff ff
> > > ................
> > >   backtrace:
> > >     [<0000000072e4b914>] __kmalloc+0x336/0x540
> > >     [<0000000054642a87>] alloc_cpu_rmap+0x3b/0xb0
> > >     [<00000000f220deec>] ice_set_cpu_rx_rmap+0x6a/0x110 [ice]
> > >     [<000000002370a632>] ice_probe+0x941/0x1180 [ice]
> > >     [<00000000d692edba>] local_pci_probe+0x47/0xa0
> > >     [<00000000503934f0>] work_for_cpu_fn+0x1a/0x30
> > >     [<00000000555a9e4a>] process_one_work+0x1dd/0x410
> > >     [<000000002c4b414a>] worker_thread+0x221/0x3f0
> > >     [<00000000bb2b556b>] kthread+0x14c/0x170
> > >     [<00000000ad2cf1cd>] ret_from_fork+0x1f/0x30 unreferenced object
> > > 0xffff95bd81b0a2a0 (size 96):
> > >   comm "kworker/0:1", pid 134, jiffies 4294684283 (age 13051.958s)
> > >   hex dump (first 32 bytes):
> > >     38 00 00 00 01 00 00 00 e0 ff ff ff 0f 00 00
> > > 00  8...............
> > >     b0 a2 b0 81 bd 95 ff ff b0 a2 b0 81 bd 95 ff ff
> > > ................
> > >   backtrace:
> > >     [<00000000582dd5c5>] kmem_cache_alloc_trace+0x31f/0x4c0
> > >     [<000000002659850d>] irq_cpu_rmap_add+0x25/0xe0
> > >     [<00000000495a3055>] ice_set_cpu_rx_rmap+0xb4/0x110 [ice]
> > >     [<000000002370a632>] ice_probe+0x941/0x1180 [ice]
> > >     [<00000000d692edba>] local_pci_probe+0x47/0xa0
> > >     [<00000000503934f0>] work_for_cpu_fn+0x1a/0x30
> > >     [<00000000555a9e4a>] process_one_work+0x1dd/0x410
> > >     [<000000002c4b414a>] worker_thread+0x221/0x3f0
> > >     [<00000000bb2b556b>] kthread+0x14c/0x170
> > >     [<00000000ad2cf1cd>] ret_from_fork+0x1f/0x30
> > >
> > > Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_main.c | 1 +
> > >  1 file changed, 1 insertion(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


