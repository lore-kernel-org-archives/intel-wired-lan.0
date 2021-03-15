From: Chen, BoX C <box.c.chen@intel.com>
Date: Mon, 15 Mar 2021 08:20:09 +0000
Subject: [Intel-wired-lan] [Patch v5 07/18] ice: Enable FDIR Configure
 for AVF
In-Reply-To: <BN8PR11MB3795F68FC7D640CD383ECE88F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-8-haiyue.wang@intel.com>
 <BN8PR11MB3795F68FC7D640CD383ECE88F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
Message-ID: <DM6PR11MB30990A21137B235832A0901FD96C9@DM6PR11MB3099.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: March 15, 2021 16:19
> To: intel-wired-lan at lists.osuosl.org
> Cc: Su, Simei <simei.su@intel.com>; Guo, Jia <jia.guo@intel.com>; Liang,
> Cunming <cunming.liang@intel.com>; Cao, Yahui <yahui.cao@intel.com>;
> Zhang, Qi Z <qi.z.zhang@intel.com>; Xing, Beilei <beilei.xing@intel.com>;
> Chen, BoX C <box.c.chen@intel.com>
> Subject: RE: [Intel-wired-lan] [Patch v5 07/18] ice: Enable FDIR Configure for
> AVF
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Haiyue Wang
> > Sent: Tuesday, March 9, 2021 11:08
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Su, Simei <simei.su@intel.com>; Guo, Jia <jia.guo@intel.com>;
> > Liang, Cunming <cunming.liang@intel.com>; Cao, Yahui
> > <yahui.cao@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>; Xing,
> > Beilei <beilei.xing@intel.com>
> > Subject: [Intel-wired-lan] [Patch v5 07/18] ice: Enable FDIR Configure
> > for AVF
> >
> > From: Qi Zhang <qi.z.zhang@intel.com>
> >
> > The virtual channel is going to be extended to support FDIR and RSS
> > configure from AVF. New data structures and OP codes will be added,
> > the patch enable the FDIR part.
> >
> > To support above advanced AVF feature, we need to figure out what kind
> > of data structure should be passed from VF to PF to describe an FDIR
> > rule or RSS config rule. The common part of the requirement is we need
> > a data structure to represent the input set selection of a rule's hash
> > key.
> >
> > An input set selection is a group of fields be selected from one or
> > more network protocol layers that could be identified as a specific flow.
> > For example, select dst IP address from an IPv4 header combined with
> > dst port from the TCP header as the input set for an IPv4/TCP flow.
> >
> > The patch adds a new data structure virtchnl_proto_hdrs to abstract a
> > network protocol headers group which is composed of layers of network
> > protocol header(virtchnl_proto_hdr).
> >
> > A protocol header contains a 32 bits mask (field_selector) to describe
> > which fields are selected as input sets, as well as a header type
> > (enum virtchnl_proto_hdr_type). Each bit is mapped to a field in enum
> > virtchnl_proto_hdr_field guided by its header type.
> >
> > +------------+-----------+------------------------------+
> > |            | Proto Hdr | Header Type A                |
> > |            |           +------------------------------+
> > |            |           | BIT 31 | ... | BIT 1 | BIT 0 |
> > |            |-----------+------------------------------+
> > |Proto Hdrs  | Proto Hdr | Header Type B                |
> > |            |           +------------------------------+
> > |            |           | BIT 31 | ... | BIT 1 | BIT 0 |
> > |            |-----------+------------------------------+
> > |            | Proto Hdr | Header Type C                |
> > |            |           +------------------------------+
> > |            |           | BIT 31 | ... | BIT 1 | BIT 0 |
> > |            |-----------+------------------------------+
> > |            |    ....                                  |
> > +-------------------------------------------------------+
> >
> > All fields in enum virtchnl_proto_hdr_fields are grouped with header
> > type and the value of the first field of a header type is always 32 aligned.
> >
> > enum proto_hdr_type {
> >         header_type_A = 0;
> >         header_type_B = 1;
> >         ....
> > }
> >
> > enum proto_hdr_field {
> >         /* header type A */
> >         header_A_field_0 = 0,
> >         header_A_field_1 = 1,
> >         header_A_field_2 = 2,
> >         header_A_field_3 = 3,
> >
> >         /* header type B */
> >         header_B_field_0 = 32, // = header_type_B << 5
> >         header_B_field_0 = 33,
> >         header_B_field_0 = 34
> >         header_B_field_0 = 35,
> >         ....
> > };
> >
> > So we have:
> > proto_hdr_type = proto_hdr_field / 32
> > bit offset = proto_hdr_field % 32
> >
> > To simply the protocol header's operations, couple help macros are added.
> > For example, to select src IP and dst port as input set for an
> > IPv4/UDP flow.
> >
> > we have:
> > struct virtchnl_proto_hdr hdr[2];
> >
> > VIRTCHNL_SET_PROTO_HDR_TYPE(&hdr[0], IPV4)
> > VIRTCHNL_ADD_PROTO_HDR_FIELD(&hdr[0], IPV4, SRC)
> >
> > VIRTCHNL_SET_PROTO_HDR_TYPE(&hdr[1], UDP)
> > VIRTCHNL_ADD_PROTO_HDR_FIELD(&hdr[1], UDP, DST)
> >
> > A protocol header also contains a byte array, this field should only
> > be used by an FDIR rule and should be ignored by RSS. For an FDIR
> > rule, the byte array is used to store the protocol header of a
> > training package. The byte array must be network order.
> >
> > The patch added virtual channel support for iAVF FDIR add/validate/delete
> filter.
> > iAVF FDIR is Flow Director for Intel Adaptive Virtual Function which
> > can direct Ethernet packets to the queues of the Network Interface Card.
> > Add/delete command is adding or deleting one rule for each virtual
> > channel message, while validate command is just verifying if this rule
> > is valid without any other operations.
> >
> > To add or delete one rule, driver needs to config TCAM and Profile,
> > build training packets which contains the input set value, and send
> > the training packets through FDIR Tx queue. In addition, driver needs
> > to manage the software context to avoid adding duplicated rules,
> > deleting non-existent rule, input set conflicts and other invalid cases.
> >
> > NOTE:
> > Supported pattern/actions and their parse functions are not be
> > included in this patch, they will be added in a separate one.
> >
> > Signed-off-by: Jeff Guo <jia.guo@intel.com>
> > Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> > Signed-off-by: Simei Su <simei.su@intel.com>
> > Signed-off-by: Beilei Xing <beilei.xing@intel.com>
> > Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/Makefile       |    2 +-
> >  .../net/ethernet/intel/ice/ice_ethtool_fdir.c |    4 +
> >  drivers/net/ethernet/intel/ice/ice_fdir.c     |    6 +-
> >  drivers/net/ethernet/intel/ice/ice_fdir.h     |    5 +
> >  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |    2 +
> >  .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 1034 +++++++++++++++++
> >  .../ethernet/intel/ice/ice_virtchnl_fdir.h    |   24 +
> >  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   17 +-
> >  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |    6 +
> >  include/linux/avf/virtchnl.h                  |  278 +++++
> >  10 files changed, 1372 insertions(+), 6 deletions(-)  create mode
> > 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
> >
> 
> Re-send to Bo, as a new member.
> 

Tested-by: Chen Bo <BoX.C.Chen@intel.com>

BRs,
Chen Bo

> > --
> > 2.30.1
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
