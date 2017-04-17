From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Apr 2017 17:34:44 +0000
Subject: [Intel-wired-lan] [next PATCH S70 02/12] i40e: DCR 287 new
	AQ	commands
In-Reply-To: <20170413084555.6962-2-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BF4D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Wu, Jingjing <jingjing.wu@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S70 02/12] i40e: DCR 287 new AQ
> commands
> 
> From: Jingjing Wu <jingjing.wu@intel.com>
> 
> Add admin queue functions for Pipeline Personalization Profile AQ
> commands defined in DCR 287:
>  - Write Recipe Command buffer (Opcode: 0x0270)
>  - Get Applied Profiles list (Opcode: 0x0271)
> 
> Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
> Change-ID: I558b4145364140f624013af48d4bbf79d21ebb0d
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  34 ++++
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 212
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  17 ++
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |  80 ++++++++
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  34 ++++
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    | 212
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h |  17 ++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h      |  80 ++++++++
>  8 files changed, 686 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


