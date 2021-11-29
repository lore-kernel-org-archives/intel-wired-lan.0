From: Ertman, David M <david.m.ertman@intel.com>
Date: Mon, 29 Nov 2021 16:51:49 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: add support for DSCP
 QoS for IDC
In-Reply-To: <10cc4a54-0b25-3c3c-bcc0-41b8bd096cb5@molgen.mpg.de>
References: <20211123182536.315714-1-david.m.ertman@intel.com>
 <10cc4a54-0b25-3c3c-bcc0-41b8bd096cb5@molgen.mpg.de>
Message-ID: <MW5PR11MB58116167F5FF6CA513C7B741DD669@MW5PR11MB5811.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Wednesday, November 24, 2021 1:52 AM
> To: Ertman, David M <david.m.ertman@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: add support for DSCP
> QoS for IDC
> 
> Dear Dave,
> 
> 
> Am 23.11.21 um 19:25 schrieb Dave Ertman:
> > The ice driver provides QoS information to auxiliary drivers
> > through the exported function ice_get_qos_params.  This function
> > doesn't currently support L3 DSCP QoS.
> >
> > Add the necessary defines, structure elements and code to support
> > DSCP QoS through the IDC functions.
> 
> How did you test this?
> 
> In what datasheet (name, revision, section) is that documented?
> 
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_idc.c | 5 +++++
> >   include/linux/net/intel/iidc.h           | 5 +++++
> >   2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c
> b/drivers/net/ethernet/intel/ice/ice_idc.c
> > index fc3580167e7b..263a2e7577a2 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_idc.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_idc.c
> > @@ -227,6 +227,11 @@ void ice_get_qos_params(struct ice_pf *pf, struct
> iidc_qos_params *qos)
> >
> >   	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
> >   		qos->tc_info[i].rel_bw = dcbx_cfg->etscfg.tcbwtable[i];
> > +
> > +	qos->pfc_mode = dcbx_cfg->pfc_mode;
> > +	if (qos->pfc_mode == IIDC_DSCP_PFC_MODE)
> 
> Just a nit as the compiler will probably do it itself, but you could use
> `dcbx_cfg->pfc_mode` in the check, and move the assignment into the body.

That would be an incorrect implementation.  the assignment needs to happen regardless of the results
of the test.

> 
> > +		for (i = 0; i < IIDC_MAX_DSCP_MAPPING; i++)
> > +			qos->dscp_map[i] = dcbx_cfg->dscp_map[i];
> >   }
> >   EXPORT_SYMBOL_GPL(ice_get_qos_params);
> >
> > diff --git a/include/linux/net/intel/iidc.h b/include/linux/net/intel/iidc.h
> > index 1289593411d3..0a90f301679d 100644
> > --- a/include/linux/net/intel/iidc.h
> > +++ b/include/linux/net/intel/iidc.h
> > @@ -32,6 +32,9 @@ enum iidc_rdma_protocol {
> >   };
> >
> >   #define IIDC_MAX_USER_PRIORITY		8
> > +#define IIDC_MAX_DSCP_MAPPING		64
> > +#define IIDC_VLAN_PFC_MODE		0x0
> > +#define IIDC_DSCP_PFC_MODE		0x1
> >
> >   /* Struct to hold per RDMA Qset info */
> >   struct iidc_rdma_qset_params {
> > @@ -60,6 +63,8 @@ struct iidc_qos_params {
> >   	u8 vport_relative_bw;
> >   	u8 vport_priority_type;
> >   	u8 num_tc;
> > +	u8 pfc_mode;
> > +	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
> >   };
> >
> >   struct iidc_event {
> 
> 
> Kind regards,
> 
> Paul
