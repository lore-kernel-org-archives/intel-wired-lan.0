From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Thu,  3 Feb 2022 14:23:40 +0100
Subject: [Intel-wired-lan] [PATCH net-next 05/19] iecm: add vport alloc
 and virtchnl messages
In-Reply-To: <CO1PR11MB51865CAB7217DC106C5F95308F279@CO1PR11MB5186.namprd11.prod.outlook.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-6-alan.brady@intel.com>
 <20220128123244.21159-1-alexandr.lobakin@intel.com>
 <CO1PR11MB51865CAB7217DC106C5F95308F279@CO1PR11MB5186.namprd11.prod.outlook.com>
Message-ID: <20220203132340.10518-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>
Date: Wed, 2 Feb 2022 23:21:54 +0100

> > -----Original Message-----
> > From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Sent: Friday, January 28, 2022 4:33 AM
> > To: Brady, Alan <alan.brady@intel.com>
> > Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; intel-wired-
> > lan at lists.osuosl.org; Burra, Phani R <phani.r.burra@intel.com>; Chittim, Madhu
> > <madhu.chittim@intel.com>; Linga, Pavan Kumar
> > <pavan.kumar.linga@intel.com>
> > Subject: Re: [Intel-wired-lan] [PATCH net-next 05/19] iecm: add vport alloc and
> > virtchnl messages
> > 
> > From: Alan Brady <alan.brady@intel.com>
> > Date: Thu, 27 Jan 2022 16:09:55 -0800
> > 
> > > After handling hard reset, we end up in init task. This starts by
> > > allocating and setting up a vport. To do that we need implement virtchnl
> > > messages.
> > >
> > > The virtchnl messages are also offloaded into function pointers so that a
> > > device driver may override them. Here a default implementation is provided
> > > for devices using virtchnl 2.0 but there exists the flexibility add
> > > virtchnl 1.1 support through function pointers.
> > >
> > > Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> > > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > > Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> > > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > > Signed-off-by: Alan Brady <alan.brady@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/iecm/Makefile      |    4 +-
> > >  drivers/net/ethernet/intel/iecm/iecm_lib.c    |  167 ++-
> > >  drivers/net/ethernet/intel/iecm/iecm_txrx.c   |   22 +
> > >  .../net/ethernet/intel/iecm/iecm_virtchnl.c   | 1299 +++++++++++++++++
> > >  drivers/net/ethernet/intel/include/iecm.h     |  316 +++-
> > >  .../net/ethernet/intel/include/iecm_txrx.h    |   94 ++
> > >  6 files changed, 1898 insertions(+), 4 deletions(-)
> > >  create mode 100644 drivers/net/ethernet/intel/iecm/iecm_txrx.c
> > >
> > > diff --git a/drivers/net/ethernet/intel/iecm/Makefile
> > b/drivers/net/ethernet/intel/iecm/Makefile
> > > index db8fecb075a6..fcb49402334f 100644
> > > --- a/drivers/net/ethernet/intel/iecm/Makefile
> > > +++ b/drivers/net/ethernet/intel/iecm/Makefile
> > > @@ -7,11 +7,13 @@
> > >
> > >  obj-$(CONFIG_IECM) += iecm.o
> > >
> > > -ccflags-y += -I$(srctree)/drivers/net/ethernet/intel/include
> > > +ccflags-y += -I$(srctree)/drivers/net/ethernet/intel/include \
> > > +	     -I$(srctree)/include/linux/avf
> > >
> > >  iecm-y := \
> > >  	iecm_lib.o \
> > >  	iecm_virtchnl.o \
> > > +	iecm_txrx.o \
> > >  	iecm_controlq.o \
> > >  	iecm_controlq_setup.o \
> > >  	iecm_main.o
> > > diff --git a/drivers/net/ethernet/intel/iecm/iecm_lib.c
> > b/drivers/net/ethernet/intel/iecm/iecm_lib.c
> > > index 64cdbce2c842..e2e523f0700e 100644
> > > --- a/drivers/net/ethernet/intel/iecm/iecm_lib.c
> > > +++ b/drivers/net/ethernet/intel/iecm/iecm_lib.c
> > > @@ -5,6 +5,11 @@
> > >
> > >  #include "iecm.h"
> > >
> > > +const char * const iecm_vport_vc_state_str[] = {
> > > +	IECM_FOREACH_VPORT_VC_STATE(IECM_GEN_STRING)
> > > +};
> > > +EXPORT_SYMBOL(iecm_vport_vc_state_str);
> > > +
> > >  /**
> > >   * iecm_cfg_hw - Initialize HW struct
> > >   * @adapter: adapter to setup hw struct for
> > > @@ -24,6 +29,113 @@ static int iecm_cfg_hw(struct iecm_adapter *adapter)
> > >  	return 0;
> > >  }
> > >
> > > +/**
> > > + * iecm_get_free_slot - get the next non-NULL location index in array
> > > + * @array: array to search
> > > + * @size: size of the array
> > > + * @curr: last known occupied index to be used as a search hint
> > > + *
> > > + * void * is being used to keep the functionality generic. This lets us use this
> > > + * function on any array of pointers.
> > > + */
> > > +static int iecm_get_free_slot(void *array, int size, int curr)
> > > +{
> > > +	int **tmp_array = (int **)array;
> > > +	int next;
> > > +
> > > +	if (curr < (size - 1) && !tmp_array[curr + 1]) {
> > 
> > Redundant braces around `size - 1`.
> 
> Will fix
> 
> > 
> > > +		next = curr + 1;
> > > +	} else {
> > > +		int i = 0;
> > > +
> > > +		while ((i < size) && (tmp_array[i]))
> > > +			i++;
> > > +		if (i == size)
> > > +			next = IECM_NO_FREE_SLOT;
> > > +		else
> > > +			next = i;
> > > +	}
> > 
> > One indent level is redundant here. First condition is an oneliner:
> > 
> > 	if (curr < (size - 1) && !tmp_array[curr + 1]) {
> > 		return curr + 1;
> > 
> > 	while ((i < size) && (tmp_array[i])) {
> > 		...
> > 
> > > +	return next;
> > > +}
> > > +
> > > +/**
> > > + * iecm_vport_rel - Delete a vport and free its resources
> > > + * @vport: the vport being removed
> > > + */
> > > +static void iecm_vport_rel(struct iecm_vport *vport)
> > > +{
> > > +	mutex_destroy(&vport->stop_mutex);
> > > +	kfree(vport);
> > > +}
> > > +
> > > +/**
> > > + * iecm_vport_rel_all - Delete all vports
> > > + * @adapter: adapter from which all vports are being removed
> > > + */
> > > +static void iecm_vport_rel_all(struct iecm_adapter *adapter)
> > > +{
> > > +	int i;
> > > +
> > > +	if (!adapter->vports)
> > > +		return;
> > > +
> > > +	for (i = 0; i < adapter->num_alloc_vport; i++) {
> > > +		if (!adapter->vports[i])
> > > +			continue;
> > > +
> > > +		iecm_vport_rel(adapter->vports[i]);
> > > +		adapter->vports[i] = NULL;
> > > +		adapter->next_vport = 0;
> > > +	}
> > > +	adapter->num_alloc_vport = 0;
> > > +}
> > > +
> > > +/**
> > > + * iecm_vport_alloc - Allocates the next available struct vport in the adapter
> > > + * @adapter: board private structure
> > > + * @vport_id: vport identifier
> > > + *
> > > + * returns a pointer to a vport on success, NULL on failure.
> > > + */
> > > +static struct iecm_vport *
> > > +iecm_vport_alloc(struct iecm_adapter *adapter, int vport_id)
> > > +{
> > > +	struct iecm_vport *vport = NULL;
> > > +
> > > +	if (adapter->next_vport == IECM_NO_FREE_SLOT)
> > > +		return vport;
> > > +
> > > +	/* Need to protect the allocation of the vports at the adapter level */
> > > +	mutex_lock(&adapter->sw_mutex);
> > > +
> > > +	vport = kzalloc(sizeof(*vport), GFP_KERNEL);
> > > +	if (!vport)
> > > +		goto unlock_adapter;
> > > +
> > > +	vport->adapter = adapter;
> > > +	vport->idx = adapter->next_vport;
> > > +	vport->compln_clean_budget = IECM_TX_COMPLQ_CLEAN_BUDGET;
> > > +	adapter->num_alloc_vport++;
> > > +
> > > +	/* Setup default MSIX irq handler for the vport */
> > > +	vport->irq_q_handler = iecm_vport_intr_clean_queues;
> > > +	vport->q_vector_base = IECM_NONQ_VEC;
> > > +
> > > +	mutex_init(&vport->stop_mutex);
> > > +
> > > +	/* fill vport slot in the adapter struct */
> > > +	adapter->vports[adapter->next_vport] = vport;
> > > +
> > > +	/* prepare adapter->next_vport for next use */
> > > +	adapter->next_vport = iecm_get_free_slot(adapter->vports,
> > > +						 adapter->num_alloc_vport,
> > > +						 adapter->next_vport);
> > > +
> > > +unlock_adapter:
> > > +	mutex_unlock(&adapter->sw_mutex);
> > > +	return vport;
> > > +}
> > > +
> > >  /**
> > >   * iecm_statistics_task - Delayed task to get statistics over mailbox
> > >   * @work: work_struct handle to our data
> > > @@ -55,7 +167,25 @@ static void iecm_service_task(struct work_struct
> > *work)
> > >   */
> > >  static void iecm_init_task(struct work_struct *work)
> > >  {
> > > -	/* stub */
> > > +	struct iecm_adapter *adapter = container_of(work,
> > > +						    struct iecm_adapter,
> > > +						    init_task.work);
> > > +	struct iecm_vport *vport;
> > > +	struct pci_dev *pdev;
> > > +	int vport_id, err;
> > > +
> > > +	err = adapter->dev_ops.vc_ops.core_init(adapter, &vport_id);
> > > +	if (err)
> > > +		return;
> > > +
> > > +	pdev = adapter->pdev;
> > > +	vport = iecm_vport_alloc(adapter, vport_id);
> > > +	if (!vport) {
> > > +		err = -EFAULT;
> > > +		dev_err(&pdev->dev, "failed to allocate vport: %d\n",
> > > +			err);
> > > +		return;
> > > +	}
> > >  }
> > >
> > >  /**
> > > @@ -81,6 +211,31 @@ static int iecm_api_init(struct iecm_adapter *adapter)
> > >  		return -EINVAL;
> > >  	}
> > >
> > > +	if (adapter->dev_ops.vc_ops_init) {
> > > +		struct iecm_virtchnl_ops *vc_ops;
> > > +
> > > +		adapter->dev_ops.vc_ops_init(adapter);
> > > +		vc_ops = &adapter->dev_ops.vc_ops;
> > > +		if (!(vc_ops->core_init &&
> > > +		      vc_ops->vport_init &&
> > > +		      vc_ops->vport_queue_ids_init &&
> > > +		      vc_ops->get_caps &&
> > > +		      vc_ops->config_queues &&
> > > +		      vc_ops->enable_queues &&
> > > +		      vc_ops->disable_queues &&
> > > +		      vc_ops->irq_map_unmap &&
> > > +		      vc_ops->get_set_rss_lut &&
> > > +		      vc_ops->get_set_rss_hash &&
> > > +		      vc_ops->adjust_qs &&
> > > +		      vc_ops->get_ptype &&
> > > +		      vc_ops->init_max_queues)) {
> > 
> > if (!op1 ||
> >     !op2 ||
> >     !opn) would look more natural and more readable here.
> > 
> 
> I'm not sure I understand this comment.  Adding an extra symbol for '!' seems worse.

But now you have two extra spaces, one for leading '!' and another
one for leading '('.
I just wrote how it's usually being done in the kernel code,
e.g. [0].

> 
> > > +			dev_err(&pdev->dev, "Invalid device, missing one or
> > more virtchnl functions\n");
> > > +			return -EINVAL;
> > > +		}
> > > +	} else {
> > > +		iecm_vc_ops_init(adapter);
> > > +	}

--- 8< ---

> > > --
> > > 2.33.0
> > 
> > Thanks,
> > Al

[0] https://elixir.bootlin.com/linux/v5.17-rc2/source/net/mac80211/main.c#L552

Thanks,
Al
