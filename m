From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 19:21:29 +0000
Subject: [Intel-wired-lan] [next PATCH S11 00/15] i40e/i40evf updates
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED1678266EC056@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Carolyn fixes an interrupt name that was truncated.
> 
> Catherine adds a check that will not allow speed get set to 0 in get_settings.
> 
> Jesse adds a little endian conversion for the checksum, and fixes up the return
> value for get_link_status.
> 
> Mitch Williams adds a patch to stop VF rings when SR-IOV is disabled.
> 
> Paul increases the amount of time we wait for a reset to complete.
>
> Shannon enables WoL operation by default, adds driver support for a new
> device, fixes a potential type compare issue, fixes a CEE status shift value that
> was incorrect, changes i40e_init_pf_fcoe to a void return, zeros the clean asq
> status report to get rid of stale errors, removes some __func__ references, and
> fixes the unicast mac address add.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h             |  5 +-
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c      |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h      |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |  5 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  8 +++
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c        | 10 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 65 +++++++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  5 ++
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c    |  2 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.h    |  3 +-
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h      |  1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  2 +-
>  17 files changed, 70 insertions(+), 53 deletions(-)
> 
> --
> 1.9.3

Fixing subject to S11
