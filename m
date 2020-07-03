From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Fri, 3 Jul 2020 05:55:46 +0000
Subject: [Intel-wired-lan] [PATCH S48 v3 00/14] Support Advanced AVF
 features
In-Reply-To: <20200702225805.32167-1-qi.z.zhang@intel.com>
References: <20200702225805.32167-1-qi.z.zhang@intel.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D94044987498BC@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I was able to do a preliminary review, there were definitely wrapping issues, which I commented on.  I also found some code was indented with spaces and tabs.  I also found that some defines names were grossly too long and had redundant info in the name.  Most of the patches were reasonable size and easy to review EXCEPT for patch 10, which needs to be broken up.

TODO:
 - A more in depth review of the actual code and what is being done
 - Review of all defines to ensure the actual name makes sense (reduce in size/length where possible)
 - Run checkpatch.pl on these patches
 - And of course, the typical upstream testing/review
 - Break up patch 10 into 2 or 3 patches to ease future review

I have done what I can, I am now "officially" on sabbatical... See you in September

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 2, 2020 15:58
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v3 00/14] Support Advanced AVF features
> 
> The patchset add the backend code for below new advanced AVF features:
> 1. Flexible Description selection to offload metadata 2. FDIR filter rule adding /
> deleting.
> 3. Per flow configurable inputset RSS
> besides support regular l3/l4 5 tuple inputset for FDIR and RSS, the patchset
> added more protocol support which include GTP-U, L2TPv3, PFCF, ESP, AH...
> 
> v3:
> - fix couple coding style issue and typo
> - use devm alloc/free for cross function memory
> - squash patch 11/16 , 12/16 into 10/16.
> 
> v2:
> - fix typo in commit log.
> 
> Qi Zhang (14):
>   ice: Enable flexible descriptor RXDID querying and configuration
>   ice: Add more basic protocol support for flow filter
>   ice: Support non word aligned input set field
>   ice: Add more advanced protocol support in flow filter
>   ice: Support to separate GTP-U uplink and downlink
>   ice: enhanced IPV4 and IPV6 flow filter
>   ice: Enable RSS Configure for AVF
>   ice: Support RSS configure removal for AVF
>   ice: Add support for per VF ctrl VSI enabling
>   ice: Support FDIR configure for AVF
>   ice: Add non-IP Layer2 protocol FDIR filter for AVF
>   ice: Add GTPU FDIR filter for AVF
>   ice: Add more FDIR filter type for AVF
>   ice: Check FDIR program status for AVF
> 
>  drivers/net/ethernet/intel/ice/Makefile            |    2 +-
>  drivers/net/ethernet/intel/ice/ice.h               |    6 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |    4 +
>  drivers/net/ethernet/intel/ice/ice_fdir.c          |   29 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.h          |   39 +
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |  524 ++++-
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.h     |    3 +-
>  drivers/net/ethernet/intel/ice/ice_flex_type.h     |   78 +
>  drivers/net/ethernet/intel/ice/ice_flow.c          |  890 +++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h          |  168 +-
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |   22 +
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |   22 +
>  drivers/net/ethernet/intel/ice/ice_lib.c           |   64 +-
>  drivers/net/ethernet/intel/ice/ice_main.c          |   11 +-
>  drivers/net/ethernet/intel/ice/ice_protocol_type.h |   10 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c          |    5 +
>  drivers/net/ethernet/intel/ice/ice_type.h          |   18 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 2249
> ++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h |   49 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c   |  660 +++++-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h   |   11 +
>  include/linux/avf/virtchnl.h                       |  324 ++-
>  22 files changed, 5104 insertions(+), 84 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
> 
> --
> 2.13.6
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
