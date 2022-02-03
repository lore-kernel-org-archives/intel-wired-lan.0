From: Brady, Alan <alan.brady@intel.com>
Date: Thu, 3 Feb 2022 03:40:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next 04/19] iecm: add api_init and
 controlq init
In-Reply-To: <CO1PR11MB518657515DD2AEBF539B9B768F289@CO1PR11MB5186.namprd11.prod.outlook.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-5-alan.brady@intel.com>
 <CAP-MU4MB=vAFb7B92yhx+CfX+NnRSJNzA3HH_X9geMaR6p4RTg@mail.gmail.com>
 <CO1PR11MB518657515DD2AEBF539B9B768F289@CO1PR11MB5186.namprd11.prod.outlook.com>
Message-ID: <CO1PR11MB518632ED417B553A3CF06F2C8F289@CO1PR11MB5186.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Brady, Alan
> Sent: Wednesday, February 2, 2022 7:25 PM
> To: Shannon Nelson <shannon.lee.nelson@gmail.com>
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Burra, Phani R
> <phani.r.burra@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Linga, Pavan Kumar <Pavan.Kumar.Linga@intel.com>
> Subject: RE: [Intel-wired-lan] [PATCH net-next 04/19] iecm: add api_init and
> controlq init
> 
> > -----Original Message-----
> > From: Shannon Nelson <shannon.lee.nelson@gmail.com>
> > Sent: Tuesday, February 1, 2022 1:27 PM
> > To: Brady, Alan <alan.brady@intel.com>
> > Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Burra, Phani R
> > <phani.r.burra@intel.com>; Chittim, Madhu
> <madhu.chittim@intel.com>;
> > Linga, Pavan Kumar <pavan.kumar.linga@intel.com>
> > Subject: Re: [Intel-wired-lan] [PATCH net-next 04/19] iecm: add api_init
> and
> > controlq init
> >
> > On Thu, Jan 27, 2022 at 4:35 PM Alan Brady <alan.brady@intel.com>
> > wrote:
> > >
> > > Initializing device registers is offloaded into function pointers given
> > > to iecm from the dependent device driver for a given device, as offsets
> > > can vary wildly. This also adds everything needed to setup and use a
> > > controlq which uses some of those registers.
> > >
> > > At the end of probe we kicked off a hard reset and this implements
> what's
> > > needed to handle that reset and continue init.
> > >
> > > Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> > > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > > Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> > > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > > Signed-off-by: Alan Brady <alan.brady@intel.com>
> > > ---

<snip/>

> > > +/**
> > > + * iecm_ctlq_add - add one control queue
> > > + * @hw: pointer to hardware struct
> > > + * @qinfo: info for queue to be created
> > > + * @cq_out: (output) double pointer to control queue to be created
> > > + *
> > > + * Allocate and initialize a control queue and add it to the control
> queue
> > list.
> > > + * The cq parameter will be allocated/initialized and passed back to the
> > caller
> > > + * if no errors occur.
> > > + *
> > > + * Note: iecm_ctlq_init must be called prior to any calls to
> > iecm_ctlq_add
> > > + */
> > > +int iecm_ctlq_add(struct iecm_hw *hw,
> > > +                 struct iecm_ctlq_create_info *qinfo,
> > > +                 struct iecm_ctlq_info **cq_out)
> > > +{
> > > +       bool is_rxq = false;
> > > +       int status = 0;
> > > +
> > > +       if (!qinfo->len || !qinfo->buf_size ||
> > > +           qinfo->len > IECM_CTLQ_MAX_RING_SIZE ||
> > > +           qinfo->buf_size > IECM_CTLQ_MAX_BUF_LEN)
> > > +               return -EINVAL;
> > > +
> > > +       *cq_out = kcalloc(1, sizeof(struct iecm_ctlq_info), GFP_KERNEL);
> > > +       if (!(*cq_out))
> > > +               return -ENOMEM;
> >
> > You might keep this as a local variable until you get to a successful
> > end, then set *cq_out when done.
> > Else, you need to be sure to clear it back to NULL on error return to
> > be sure no one uses a bogus value.
> >
> 
> This one I'm not sure I follow.  If it's NULL we fall into the if(!*cq_out) and
> don't need to set it to NULL (it already is?). If it's not NULL then we go on to
> use it like a valid memory address so I hope it's valid.
> 
> > > +
> > > +       (*cq_out)->cq_type = qinfo->type;
> > > +       (*cq_out)->q_id = qinfo->id;
> > > +       (*cq_out)->buf_size = qinfo->buf_size;
> > > +       (*cq_out)->ring_size = qinfo->len;
> > > +
> > > +       (*cq_out)->next_to_use = 0;
> > > +       (*cq_out)->next_to_clean = 0;
> > > +       (*cq_out)->next_to_post = (*cq_out)->ring_size - 1;
> > > +
> > > +       switch (qinfo->type) {
> > > +       case IECM_CTLQ_TYPE_MAILBOX_RX:
> > > +               is_rxq = true;
> > > +               fallthrough;
> > > +       case IECM_CTLQ_TYPE_MAILBOX_TX:
> > > +               status = iecm_ctlq_alloc_ring_res(hw, *cq_out);
> > > +               break;
> > > +       default:
> > > +               status = -EBADR;
> > > +               break;

Ah wait I think I understand, if we end up in error state later in the function like here we probably shouldn't be giving the memory back to the caller.  Will fix.

> > > +       }
> > > +
> > > +       if (status)
> > > +               goto init_free_q;
> > > +
> > > +       if (is_rxq) {
> > > +               iecm_ctlq_init_rxq_bufs(*cq_out);
> > > +       } else {
> > > +               /* Allocate the array of msg pointers for TX queues */
> > > +               (*cq_out)->bi.tx_msg = kcalloc(qinfo->len,
> > > +                                              sizeof(struct iecm_ctlq_msg *),
> > > +                                              GFP_KERNEL);
> > > +               if (!(*cq_out)->bi.tx_msg) {
> > > +                       status = -ENOMEM;
> > > +                       goto init_dealloc_q_mem;
> > > +               }
> > > +       }
> > > +
> > > +       iecm_ctlq_setup_regs(*cq_out, qinfo);
> > > +
> > > +       iecm_ctlq_init_regs(hw, *cq_out, is_rxq);
> > > +
> > > +       mutex_init(&(*cq_out)->cq_lock);
> > > +
> > > +       list_add(&(*cq_out)->cq_list, &hw->cq_list_head);
> > > +
> > > +       return status;
> > > +
> > > +init_dealloc_q_mem:
> > > +       /* free ring buffers and the ring itself */
> > > +       iecm_ctlq_dealloc_ring_res(hw, *cq_out);
> > > +init_free_q:
> > > +       kfree(*cq_out);
.
> >
> 
> Will fix.
> 
> > > +
> > > +       return status;
> > > +}
> > > +

<snip/>
