From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 23:43:53 +0000
Subject: [Intel-wired-lan] [v4, 14/15] ice: Support link events,
 reset and rebuild
In-Reply-To: <20180320145819.19133-15-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-15-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F232@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Anirudh Venkataramanan
> [mailto:anirudh.venkataramanan at intel.com]
> Sent: Tuesday, March 20, 2018 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [v4,14/15] ice: Support link events, reset and rebuild
> 
> Link events are posted to a PF's admin receive queue (ARQ). This patch adds
> the ability to detect and process link events.
> 
> This patch also adds the ability to process resets.
> 
> The driver can process the following resets:
>     1) EMP Reset (EMPR)
>     2) Global Reset (GLOBR)
>     3) Core Reset (CORER)
>     4) Physical Function Reset (PFR)
> 
> EMPR is the largest level of reset that the driver can handle. An EMPR resets
> the manageability block and also the data path, including PHY and link for all
> the PFs. The affected PFs are notified of this event through a miscellaneous
> interrupt.
> 
> GLOBR is a subset of EMPR. It does everything EMPR does except that it
> doesn't reset the manageability block.
> 
> CORER is a subset of GLOBR. It does everything GLOBR does but doesn't
> reset PHY and link.
> 
> PFR is a subset of CORER and affects only the given physical function.
> In other words, PFR can be thought of as a CORER for a single PF. Since only
> the issuing PF is affected, a PFR doesn't result in the miscellaneousi interrupt
> being triggered.
> 
> All the resets have the following in common:
> 1) Tx/Rx is halted and all queues are stopped.
> 2) All the VSIs and filters programmed for the PF are lost and have to be
>    reprogrammed.
> 3) Control queue interfaces are reset and have to be reprogrammed.
> 
> In the rebuild flow, control queues are reinitialized, VSIs are reallocated and
> filters are restored.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  19 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  19 +
>  drivers/net/ethernet/intel/ice/ice_common.c     |  60 +++
>  drivers/net/ethernet/intel/ice/ice_common.h     |   5 +
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c       | 581
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_type.h       |   1 +
>  7 files changed, 681 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


