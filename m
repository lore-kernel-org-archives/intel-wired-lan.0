From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Mar 2017 00:27:03 +0000
Subject: [Intel-wired-lan] [next PATCH S64 1/1] i40e/i40evf: Add
 capability	exchange for outer checksum
In-Reply-To: <1490650998-14889-1-git-send-email-bimmy.pujari@intel.com>
References: <1490650998-14889-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A592@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, March 27, 2017 2:43 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Alexander Duyck <aduyck@mirantis.com>
> Subject: [Intel-wired-lan] [next PATCH S64 1/1] i40e/i40evf: Add capability
> exchange for outer checksum
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> This patch adds a capability negotiation between VF and PF using ENCAP/
> ENCAP_CSUM offload flags in order for the VF to support outer checksum
> and TSO offloads for encapsulated packets. These capabilities were assumed
> by default and enabled in current hardware. Going forward, these features
> needs to be negotiated with PF before advertising to the stack.
> Additionally, strip out the mac.type checks for X722 since outer checksums
> are enabled based on the ENCAP_CSUM offload negotiation flag and
> maintain consistency between drivers in how the features are configured.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ie380a6f57eca557a2bb575b66b12fae36d308920
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 52 +++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h    |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  7 +++
> drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  |  3 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 61 ++++++++++++-------
> ---
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  4 +-
>  6 files changed, 74 insertions(+), 56 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


