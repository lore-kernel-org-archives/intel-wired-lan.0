From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Jan 2018 22:49:18 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 05/12] i40evf: Alloc
 queues for ADq on VF
In-Reply-To: <20180123165106.28900-6-avinash.dayanand@intel.com>
References: <20180123165106.28900-1-avinash.dayanand@intel.com>
 <20180123165106.28900-6-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A259@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Tuesday, January 23, 2018 8:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 05/12] i40evf: Alloc queues
> for ADq on VF
> 
> This patch allocates number of queues requested by the user as a part of TC
> command when ADq is enabled on a VF.
> 
> In order to be consistent in design with PF implementation of ADq, don't
> allow to set channels via ethtool from VF when ADq is already enabled. This
> means the users will not be able to change the number of queues/channels
> via ethtool for a VF when ADq is ON. In order to be able to use set channels,
> users will be required to disable ADq first and then try setting the channels
> again.
> 
> When ADq is enabled on VF, it goes through a reset during which VSIs and
> queues are re-configured. Meanwhile if we receive link status message from
> PF even before the queues are re-configured, just ignore this link up
> message.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  6 ++++++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


