From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:27:32 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 07/16] ice: Enable RSS
 Configure for AVF
In-Reply-To: <20200710010644.33817-8-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-8-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB21458D983BFB372E31995C1B8C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 9, 2020 6:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v5 07/16] ice: Enable RSS Configure for
> AVF
> 
> The virtual channel is going to be extended to support FDIR and RSS
> configure from AVF. New data structures and OP codes will be added, the
> patch enable the RSS part.
> 
> To support above advanced AVF feature, we need to figure out what kind of
> data structure should be passed from VF to PF to describe an FDIR rule or RSS
> config rule. The common part of the requirement is we need a data structure
> to represent the input set selection of a rule's hash key.
> 
> An input set selection is a group of fields be selected from one or more
> network protocol layers that could be identified as a specific flow.
> For example, select dst IP address from an IPv4 header combined with dst
> port from the TCP header as the input set for an IPv4/TCP flow.
> 
> The patch adds a new data structure virtchnl_proto_hdrs to abstract a
> network protocol headers group which is composed of layers of network
> protocol header(virtchnl_proto_hdr).
> 
> A protocol header contains a 32 bits mask (field_selector) to describe which
> fields are selected as input sets, as well as a header type (enum
> virtchnl_proto_hdr_type). Each bit is mapped to a field in enum
> virtchnl_proto_hdr_field guided by its header type.
> 
> +------------+-----------+------------------------------+
> |            | Proto Hdr | Header Type A                |
> |            |           +------------------------------+
> |            |           | BIT 31 | ... | BIT 1 | BIT 0 |
> |            |-----------+------------------------------+
> |Proto Hdrs  | Proto Hdr | Header Type B                |
> |            |           +------------------------------+
> |            |           | BIT 31 | ... | BIT 1 | BIT 0 |
> |            |-----------+------------------------------+
> |            | Proto Hdr | Header Type C                |
> |            |           +------------------------------+
> |            |           | BIT 31 | ... | BIT 1 | BIT 0 |
> |            |-----------+------------------------------+
> |            |    ....                                  |
> +-------------------------------------------------------+
> 
> All fields in enum virtchnl_proto_hdr_fields are grouped with header type
> and the value of the first field of a header type is always 32 aligned.
> 
> enum proto_hdr_type {
>         header_type_A = 0;
>         header_type_B = 1;
>         ....
> }
> 
> enum proto_hdr_field {
>         /* header type A */
>         header_A_field_0 = 0,
>         header_A_field_1 = 1,
>         header_A_field_2 = 2,
>         header_A_field_3 = 3,
> 
>         /* header type B */
>         header_B_field_0 = 32, // = header_type_B << 5
>         header_B_field_0 = 33,
>         header_B_field_0 = 34
>         header_B_field_0 = 35,
>         ....
> };
> 
> So we have:
> proto_hdr_type = proto_hdr_field / 32
> bit offset = proto_hdr_field % 32
> 
> To simply the protocol header's operations, couple help macros are added.
> For example, to select src IP and dst port as input set for an IPv4/UDP flow.
> 
> we have:
> struct virtchnl_proto_hdr hdr[2];
> 
> VIRTCHNL_SET_PROTO_HDR_TYPE(&hdr[0], IPV4)
> VIRTCHNL_ADD_PROTO_HDR_FIELD(&hdr[0], IPV4, SRC)
> 
> VIRTCHNL_SET_PROTO_HDR_TYPE(&hdr[1], UDP)
> VIRTCHNL_ADD_PROTO_HDR_FIELD(&hdr[1], UDP, DST)
> 
> A protocol header also contains a byte array, this field should only be used by
> an FDIR rule and should be ignored by RSS. For an FDIR rule, the byte array is
> used to store the protocol header of a training package. The byte array must
> be network order.
> 
> Signed-off-by: Jeff Guo <jia.guo@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.h        |   3 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 454
> +++++++++++++++++++++++
>  include/linux/avf/virtchnl.h                     | 186 +++++++++-
>  3 files changed, 635 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


