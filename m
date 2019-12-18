From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:35:40 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: remove current MAC address
 filter on VF reset
In-Reply-To: <20191217102923.3274961-1-sassmann@kpanic.de>
References: <20191217102923.3274961-1-sassmann@kpanic.de>
Message-ID: <0b5c9869aadd45f9b3643ab6b63704c9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Tuesday, December 17, 2019 2:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] iavf: remove current MAC address filter
> on VF reset
> 
> Currently MAC filters are not altered during a VF reset event. This may lead
> to a stale filter when an administratively set MAC is forced by the PF.
> 
> For an administratively set MAC the PF driver deletes the VFs filters,
> overwrites the VFs MAC address and triggers a VF reset. However the VF
> driver itself is not aware of the filter removal, which is what the VF reset is
> for.
> The VF reset queues all filters present in the VF driver to be re-added to the
> PF filter list (including the filter for the now stale VF MAC
> address) and triggers a VIRTCHNL_OP_GET_VF_RESOURCES event, which
> provides the new MAC address to the VF.
> 
> When this happens i40e will complain and reject the stale MAC filter, at least
> in the untrusted VF case.
> i40e 0000:08:00.0: Setting MAC 3c:fa:fa:fa:fa:01 on VF 0 iavf 0000:08:02.0:
> Reset warning received from the PF iavf 0000:08:02.0: Scheduling reset task
> i40e 0000:08:00.0: Bring down and up the VF interface to make this change
> effective.
> i40e 0000:08:00.0: VF attempting to override administratively set MAC
> address, bring down and up the VF interface to resume normal operation
> i40e 0000:08:00.0: VF 0 failed opcode 10, retval: -1 iavf 0000:08:02.0: Failed to
> add MAC filter, error IAVF_ERR_NVM
> 
> To avoid re-adding the stale MAC filter it needs to be removed from the VF
> driver's filter list before queuing the existing filters. Then during the
> VIRTCHNL_OP_GET_VF_RESOURCES event the correct filter needs to be
> added again, at which point the MAC address has been updated.
> 
> As a bonus this change makes bringing the VF down and up again superfluous
> for the administratively set MAC case.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h          |  2 ++
>  drivers/net/ethernet/intel/iavf/iavf_main.c     | 17 +++++++++++++----
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  3 +++
>  3 files changed, 18 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


