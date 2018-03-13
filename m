From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 12 Mar 2018 19:05:40 -0700
Subject: [Intel-wired-lan] [PATCH 06/15] ice: Initialize PF and setup
 miscellaneous interrupt
In-Reply-To: <20180309172136.9073-7-anirudh.venkataramanan@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-7-anirudh.venkataramanan@intel.com>
Message-ID: <b0d74c67-a22c-d764-a8ea-d452797f1aac@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/9/2018 9:21 AM, Anirudh Venkataramanan wrote:
> This patch continues the initialization flow as follows:
> 
> 1) Allocate and initialize necessary fields (like vsi, num_alloc_vsi,
>     irq_tracker, etc) in the ice_pf instance.
> 
> 2) Setup the miscellaneous interrupt handler. This also known as the
>     "other interrupt causes" (OIC) handler and is used to handle non
>     hotpath interrupts (like control queue events, link events,
>     exceptions, etc.
> 
> 3) Implement a background task to process admin queue receive (ARQ)
>     events received by the driver.
> 
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h            |  84 +++
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |   2 +
>   drivers/net/ethernet/intel/ice/ice_common.c     |   6 +
>   drivers/net/ethernet/intel/ice/ice_common.h     |   3 +
>   drivers/net/ethernet/intel/ice/ice_controlq.c   | 101 ++++
>   drivers/net/ethernet/intel/ice/ice_controlq.h   |   8 +
>   drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  63 +++
>   drivers/net/ethernet/intel/ice/ice_main.c       | 719 +++++++++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_txrx.h       |  43 ++
>   drivers/net/ethernet/intel/ice/ice_type.h       |  11 +
>   10 files changed, 1039 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_txrx.h
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 9681e971bcab..c8079c852a48 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -26,29 +26,113 @@
>   #include <linux/compiler.h>
>   #include <linux/etherdevice.h>
>   #include <linux/pci.h>
> +#include <linux/workqueue.h>
>   #include <linux/aer.h>
> +#include <linux/interrupt.h>
> +#include <linux/timer.h>
>   #include <linux/delay.h>
>   #include <linux/bitmap.h>
> +#include <linux/if_bridge.h>
>   #include "ice_devids.h"
>   #include "ice_type.h"
> +#include "ice_txrx.h"
>   #include "ice_switch.h"
>   #include "ice_common.h"
>   #include "ice_sched.h"
>   
>   #define ICE_BAR0		0
> +#define ICE_INT_NAME_STR_LEN	(IFNAMSIZ + 16)
>   #define ICE_AQ_LEN		64
> +#define ICE_MIN_MSIX		2
> +#define ICE_MAX_VSI_ALLOC	130
> +#define ICE_MAX_TXQS		2048
> +#define ICE_MAX_RXQS		2048
> +#define ICE_RES_VALID_BIT	0x8000
> +#define ICE_RES_MISC_VEC_ID	(ICE_RES_VALID_BIT - 1)
>   
>   #define ICE_DFLT_NETIF_M (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
>   
> +struct ice_res_tracker {
> +	u16 num_entries;
> +	u16 search_hint;
> +	u16 list[1];
> +};
> +
> +struct ice_sw {
> +	struct ice_pf *pf;
> +	u16 sw_id;		/* switch ID for this switch */
> +	u16 bridge_mode;	/* VEB/VEPA/Port Virtualizer */
> +};
> +
>   enum ice_state {
>   	__ICE_DOWN,
> +	__ICE_PFR_REQ,			/* set by driver and peers */
> +	__ICE_ADMINQ_EVENT_PENDING,
> +	__ICE_SERVICE_SCHED,
>   	__ICE_STATE_NBITS		/* must be last */
>   };
>   
> +/* struct that defines a VSI, associated with a dev */
> +struct ice_vsi {
> +	struct net_device *netdev;
> +	struct ice_port_info *port_info; /* back pointer to port_info */
> +	u16 vsi_num;			 /* HW (absolute) index of this VSI */
> +} ____cacheline_internodealigned_in_smp;
> +
> +enum ice_pf_flags {
> +	ICE_FLAG_MSIX_ENA,
> +	ICE_FLAG_FLTR_SYNC,
> +	ICE_FLAG_RSS_ENA,
> +	ICE_PF_FLAGS_NBITS		/* must be last */
> +};
> +
>   struct ice_pf {
>   	struct pci_dev *pdev;
> +	struct msix_entry *msix_entries;
> +	struct ice_res_tracker *irq_tracker;
> +	struct ice_vsi **vsi;		/* VSIs created by the driver */
> +	struct ice_sw *first_sw;	/* first switch created by firmware */
>   	DECLARE_BITMAP(state, __ICE_STATE_NBITS);
> +	DECLARE_BITMAP(avail_txqs, ICE_MAX_TXQS);
> +	DECLARE_BITMAP(avail_rxqs, ICE_MAX_RXQS);
> +	DECLARE_BITMAP(flags, ICE_PF_FLAGS_NBITS);
> +	unsigned long serv_tmr_period;
> +	unsigned long serv_tmr_prev;
> +	struct timer_list serv_tmr;
> +	struct work_struct serv_task;
> +	struct mutex avail_q_mutex;	/* protects access to avail_[rx|tx]qs */
> +	struct mutex sw_mutex;		/* lock for protecting VSI alloc flow */
>   	u32 msg_enable;
> +	u32 oicr_idx;		/* Other interrupt cause vector index */
> +	u32 num_lan_msix;	/* Total MSIX vectors for base driver */
> +	u32 num_avail_msix;	/* remaining MSIX vectors left unclaimed */
> +	u16 num_lan_tx;		/* num lan tx queues setup */
> +	u16 num_lan_rx;		/* num lan rx queues setup */
> +	u16 q_left_tx;		/* remaining num tx queues left unclaimed */
> +	u16 q_left_rx;		/* remaining num rx queues left unclaimed */
> +	u16 next_vsi;		/* Next free slot in pf->vsi[] - 0-based! */
> +	u16 num_alloc_vsi;
> +
>   	struct ice_hw hw;
> +	char int_name[ICE_INT_NAME_STR_LEN];
>   };
> +
> +/**
> + * ice_irq_dynamic_ena - Enable default interrupt generation settings
> + * @hw: pointer to hw struct
> + */
> +static inline void ice_irq_dynamic_ena(struct ice_hw *hw)
> +{
> +	u32 vector = ((struct ice_pf *)hw->back)->oicr_idx;
> +	int itr = ICE_ITR_NONE;
> +	u32 val;
> +
> +	/* clear the PBA here, as this function is meant to clean out all
> +	 * previous interrupts and enable the interrupt
> +	 */
> +	val = GLINT_DYN_CTL_INTENA_M | GLINT_DYN_CTL_CLEARPBA_M |
> +	      (itr << GLINT_DYN_CTL_ITR_INDX_S);
> +
> +	wr32(hw, GLINT_DYN_CTL(vector), val);
> +}
>   #endif /* _ICE_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 13e3b7f3e24d..1acd936eec49 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -597,11 +597,13 @@ struct ice_aq_desc {
>   /* FW defined boundary for a large buffer, 4k >= Large buffer > 512 bytes */
>   #define ICE_AQ_LG_BUF	512
>   
> +#define ICE_AQ_FLAG_ERR_S	2
>   #define ICE_AQ_FLAG_LB_S	9
>   #define ICE_AQ_FLAG_RD_S	10
>   #define ICE_AQ_FLAG_BUF_S	12
>   #define ICE_AQ_FLAG_SI_S	13
>   
> +#define ICE_AQ_FLAG_ERR		BIT(ICE_AQ_FLAG_ERR_S) /* 0x4    */
>   #define ICE_AQ_FLAG_LB		BIT(ICE_AQ_FLAG_LB_S)  /* 0x200  */
>   #define ICE_AQ_FLAG_RD		BIT(ICE_AQ_FLAG_RD_S)  /* 0x400  */
>   #define ICE_AQ_FLAG_BUF		BIT(ICE_AQ_FLAG_BUF_S) /* 0x1000 */
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 78677a3fe448..4b94f737d7f3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -298,6 +298,12 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
>   	if (status)
>   		return status;
>   
> +	/* set these values to minimum allowed */
> +	hw->itr_gran_200 = ICE_ITR_GRAN_MIN_200;
> +	hw->itr_gran_100 = ICE_ITR_GRAN_MIN_100;
> +	hw->itr_gran_50 = ICE_ITR_GRAN_MIN_50;
> +	hw->itr_gran_25 = ICE_ITR_GRAN_MIN_25;
> +
>   	status = ice_init_all_ctrlq(hw);
>   	if (status)
>   		goto err_unroll_cqinit;
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
> index 3e3b18fc421d..ab47204dfc5a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> @@ -31,6 +31,9 @@ enum ice_status ice_reset(struct ice_hw *hw, enum ice_reset_req req);
>   enum ice_status ice_init_all_ctrlq(struct ice_hw *hw);
>   void ice_shutdown_all_ctrlq(struct ice_hw *hw);
>   enum ice_status
> +ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
> +		  struct ice_rq_event_info *e, u16 *pending);
> +enum ice_status
>   ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
>   		enum ice_aq_res_access_type access);
>   void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res);
> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
> index b1143d66d4bd..3f63a20b45c0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
> @@ -977,3 +977,104 @@ void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode)
>   	desc->opcode = cpu_to_le16(opcode);
>   	desc->flags = cpu_to_le16(ICE_AQ_FLAG_SI);
>   }
> +
> +/**
> + * ice_clean_rq_elem
> + * @hw: pointer to the hw struct
> + * @cq: pointer to the specific Control queue
> + * @e: event info from the receive descriptor, includes any buffers
> + * @pending: number of events that could be left to process
> + *
> + * This function cleans one Admin Receive Queue element and returns
> + * the contents through e.  It can also return how many events are
> + * left to process through 'pending'.
> + */
> +enum ice_status
> +ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
> +		  struct ice_rq_event_info *e, u16 *pending)
> +{
> +	u16 ntc = cq->rq.next_to_clean;
> +	enum ice_status ret_code = 0;
> +	struct ice_aq_desc *desc;
> +	struct ice_dma_mem *bi;
> +	u16 desc_idx;
> +	u16 datalen;
> +	u16 flags;
> +	u16 ntu;
> +
> +	/* pre-clean the event info */
> +	memset(&e->desc, 0, sizeof(e->desc));
> +
> +	/* take the lock before we start messing with the ring */
> +	mutex_lock(&cq->rq_lock);
> +
> +	if (!cq->rq.count) {
> +		ice_debug(hw, ICE_DBG_AQ_MSG,
> +			  "Control Receive queue not initialized.\n");
> +		ret_code = ICE_ERR_AQ_EMPTY;
> +		goto clean_rq_elem_err;
> +	}
> +
> +	/* set next_to_use to head */
> +	ntu = (u16)(rd32(hw, cq->rq.head) & cq->rq.head_mask);
> +
> +	if (ntu == ntc) {
> +		/* nothing to do - shouldn't need to update ring's values */
> +		ret_code = ICE_ERR_AQ_NO_WORK;
> +		goto clean_rq_elem_out;
> +	}
> +
> +	/* now clean the next descriptor */
> +	desc = ICE_CTL_Q_DESC(cq->rq, ntc);
> +	desc_idx = ntc;
> +
> +	flags = le16_to_cpu(desc->flags);
> +	if (flags & ICE_AQ_FLAG_ERR) {
> +		ret_code = ICE_ERR_AQ_ERROR;
> +		cq->rq_last_status = (enum ice_aq_err)le16_to_cpu(desc->retval);
> +		ice_debug(hw, ICE_DBG_AQ_MSG,
> +			  "Control Receive Queue Event received with error 0x%x\n",
> +			  cq->rq_last_status);
> +	}
> +	memcpy(&e->desc, desc, sizeof(e->desc));
> +	datalen = le16_to_cpu(desc->datalen);
> +	e->msg_len = min(datalen, e->buf_len);
> +	if (e->msg_buf && e->msg_len)
> +		memcpy(e->msg_buf, cq->rq.r.rq_bi[desc_idx].va, e->msg_len);
> +
> +	ice_debug(hw, ICE_DBG_AQ_MSG, "ARQ: desc and buffer:\n");
> +
> +	ice_debug_cq(hw, ICE_DBG_AQ_CMD, (void *)desc, e->msg_buf,
> +		     cq->rq_buf_size);
> +
> +	/* Restore the original datalen and buffer address in the desc,
> +	 * FW updates datalen to indicate the event message size
> +	 */
> +	bi = &cq->rq.r.rq_bi[ntc];
> +	memset(desc, 0, sizeof(*desc));
> +
> +	desc->flags = cpu_to_le16(ICE_AQ_FLAG_BUF);
> +	if (cq->rq_buf_size > ICE_AQ_LG_BUF)
> +		desc->flags |= cpu_to_le16(ICE_AQ_FLAG_LB);
> +	desc->datalen = cpu_to_le16(bi->size);
> +	desc->params.generic.addr_high = cpu_to_le32(upper_32_bits(bi->pa));
> +	desc->params.generic.addr_low = cpu_to_le32(lower_32_bits(bi->pa));
> +
> +	/* set tail = the last cleaned desc index. */
> +	wr32(hw, cq->rq.tail, ntc);
> +	/* ntc is updated to tail + 1 */
> +	ntc++;
> +	if (ntc == cq->num_rq_entries)
> +		ntc = 0;
> +	cq->rq.next_to_clean = ntc;
> +	cq->rq.next_to_use = ntu;
> +
> +clean_rq_elem_out:
> +	/* Set pending if needed, unlock and return */
> +	if (pending)
> +		*pending = (u16)((ntc > ntu ? cq->rq.count : 0) + (ntu - ntc));
> +clean_rq_elem_err:
> +	mutex_unlock(&cq->rq_lock);
> +
> +	return ret_code;
> +}
> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
> index 835c035419a3..403613606652 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.h
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
> @@ -81,6 +81,14 @@ struct ice_sq_cd {
>   
>   #define ICE_CTL_Q_DETAILS(R, i) (&(((struct ice_sq_cd *)((R).cmd_buf))[i]))
>   
> +/* rq event information */
> +struct ice_rq_event_info {
> +	struct ice_aq_desc desc;
> +	u16 msg_len;
> +	u16 buf_len;
> +	u8 *msg_buf;
> +};
> +
>   /* Control Queue information */
>   struct ice_ctl_q_info {
>   	enum ice_ctl_q qtype;
> diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> index e258a12099b8..700edc7e7280 100644
> --- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> +++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
> @@ -28,6 +28,12 @@
>   #define PF_FW_ARQLEN			0x00080280
>   #define PF_FW_ARQLEN_ARQLEN_S		0
>   #define PF_FW_ARQLEN_ARQLEN_M		ICE_M(0x3FF, PF_FW_ARQLEN_ARQLEN_S)
> +#define PF_FW_ARQLEN_ARQVFE_S		28
> +#define PF_FW_ARQLEN_ARQVFE_M		BIT(PF_FW_ARQLEN_ARQVFE_S)
> +#define PF_FW_ARQLEN_ARQOVFL_S		29
> +#define PF_FW_ARQLEN_ARQOVFL_M		BIT(PF_FW_ARQLEN_ARQOVFL_S)
> +#define PF_FW_ARQLEN_ARQCRIT_S		30
> +#define PF_FW_ARQLEN_ARQCRIT_M		BIT(PF_FW_ARQLEN_ARQCRIT_S)
>   #define PF_FW_ARQLEN_ARQENABLE_S	31
>   #define PF_FW_ARQLEN_ARQENABLE_M	BIT(PF_FW_ARQLEN_ARQENABLE_S)
>   #define PF_FW_ARQT			0x00080480
> @@ -39,6 +45,12 @@
>   #define PF_FW_ATQLEN			0x00080200
>   #define PF_FW_ATQLEN_ATQLEN_S		0
>   #define PF_FW_ATQLEN_ATQLEN_M		ICE_M(0x3FF, PF_FW_ATQLEN_ATQLEN_S)
> +#define PF_FW_ATQLEN_ATQVFE_S		28
> +#define PF_FW_ATQLEN_ATQVFE_M		BIT(PF_FW_ATQLEN_ATQVFE_S)
> +#define PF_FW_ATQLEN_ATQOVFL_S		29
> +#define PF_FW_ATQLEN_ATQOVFL_M		BIT(PF_FW_ATQLEN_ATQOVFL_S)
> +#define PF_FW_ATQLEN_ATQCRIT_S		30
> +#define PF_FW_ATQLEN_ATQCRIT_M		BIT(PF_FW_ATQLEN_ATQCRIT_S)
>   #define PF_FW_ATQLEN_ATQENABLE_S	31
>   #define PF_FW_ATQLEN_ATQENABLE_M	BIT(PF_FW_ATQLEN_ATQENABLE_S)
>   #define PF_FW_ATQT			0x00080400
> @@ -57,6 +69,57 @@
>   #define PFGEN_CTRL			0x00091000
>   #define PFGEN_CTRL_PFSWR_S		0
>   #define PFGEN_CTRL_PFSWR_M		BIT(PFGEN_CTRL_PFSWR_S)
> +#define PFHMC_ERRORDATA			0x00520500
> +#define PFHMC_ERRORINFO			0x00520400
> +#define GLINT_DYN_CTL(_INT)		(0x00160000 + ((_INT) * 4))
> +#define GLINT_DYN_CTL_INTENA_S		0
> +#define GLINT_DYN_CTL_INTENA_M		BIT(GLINT_DYN_CTL_INTENA_S)
> +#define GLINT_DYN_CTL_CLEARPBA_S	1
> +#define GLINT_DYN_CTL_CLEARPBA_M	BIT(GLINT_DYN_CTL_CLEARPBA_S)
> +#define GLINT_DYN_CTL_ITR_INDX_S	3
> +#define GLINT_DYN_CTL_SW_ITR_INDX_S	25
> +#define GLINT_DYN_CTL_SW_ITR_INDX_M	ICE_M(0x3, GLINT_DYN_CTL_SW_ITR_INDX_S)
> +#define GLINT_DYN_CTL_INTENA_MSK_S	31
> +#define GLINT_DYN_CTL_INTENA_MSK_M	BIT(GLINT_DYN_CTL_INTENA_MSK_S)
> +#define GLINT_ITR(_i, _INT)		(0x00154000 + ((_i) * 8192 + (_INT) * 4))
> +#define PFINT_FW_CTL			0x0016C800
> +#define PFINT_FW_CTL_MSIX_INDX_S	0
> +#define PFINT_FW_CTL_MSIX_INDX_M	ICE_M(0x7FF, PFINT_FW_CTL_MSIX_INDX_S)
> +#define PFINT_FW_CTL_ITR_INDX_S		11
> +#define PFINT_FW_CTL_ITR_INDX_M		ICE_M(0x3, PFINT_FW_CTL_ITR_INDX_S)
> +#define PFINT_FW_CTL_CAUSE_ENA_S	30
> +#define PFINT_FW_CTL_CAUSE_ENA_M	BIT(PFINT_FW_CTL_CAUSE_ENA_S)
> +#define PFINT_OICR			0x0016CA00
> +#define PFINT_OICR_INTEVENT_S		0
> +#define PFINT_OICR_INTEVENT_M		BIT(PFINT_OICR_INTEVENT_S)
> +#define PFINT_OICR_HLP_RDY_S		14
> +#define PFINT_OICR_HLP_RDY_M		BIT(PFINT_OICR_HLP_RDY_S)
> +#define PFINT_OICR_CPM_RDY_S		15
> +#define PFINT_OICR_CPM_RDY_M		BIT(PFINT_OICR_CPM_RDY_S)
> +#define PFINT_OICR_ECC_ERR_S		16
> +#define PFINT_OICR_ECC_ERR_M		BIT(PFINT_OICR_ECC_ERR_S)
> +#define PFINT_OICR_MAL_DETECT_S		19
> +#define PFINT_OICR_MAL_DETECT_M		BIT(PFINT_OICR_MAL_DETECT_S)
> +#define PFINT_OICR_GRST_S		20
> +#define PFINT_OICR_GRST_M		BIT(PFINT_OICR_GRST_S)
> +#define PFINT_OICR_PCI_EXCEPTION_S	21
> +#define PFINT_OICR_PCI_EXCEPTION_M	BIT(PFINT_OICR_PCI_EXCEPTION_S)
> +#define PFINT_OICR_GPIO_S		22
> +#define PFINT_OICR_GPIO_M		BIT(PFINT_OICR_GPIO_S)
> +#define PFINT_OICR_STORM_DETECT_S	24
> +#define PFINT_OICR_STORM_DETECT_M	BIT(PFINT_OICR_STORM_DETECT_S)
> +#define PFINT_OICR_HMC_ERR_S		26
> +#define PFINT_OICR_HMC_ERR_M		BIT(PFINT_OICR_HMC_ERR_S)
> +#define PFINT_OICR_PE_CRITERR_S		28
> +#define PFINT_OICR_PE_CRITERR_M		BIT(PFINT_OICR_PE_CRITERR_S)
> +#define PFINT_OICR_CTL			0x0016CA80
> +#define PFINT_OICR_CTL_MSIX_INDX_S	0
> +#define PFINT_OICR_CTL_MSIX_INDX_M	ICE_M(0x7FF, PFINT_OICR_CTL_MSIX_INDX_S)
> +#define PFINT_OICR_CTL_ITR_INDX_S	11
> +#define PFINT_OICR_CTL_ITR_INDX_M	ICE_M(0x3, PFINT_OICR_CTL_ITR_INDX_S)
> +#define PFINT_OICR_CTL_CAUSE_ENA_S	30
> +#define PFINT_OICR_CTL_CAUSE_ENA_M	BIT(PFINT_OICR_CTL_CAUSE_ENA_S)
> +#define PFINT_OICR_ENA			0x0016C900
>   #define GLLAN_RCTL_0			0x002941F8
>   #define GLNVM_FLA			0x000B6108
>   #define GLNVM_FLA_LOCKED_S		6
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 2ee4a0547ba3..b07ce86381bb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -40,6 +40,294 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all), hw debug_mask (0x8XXXX
>   MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
>   #endif /* !CONFIG_DYNAMIC_DEBUG */
>   
> +static struct workqueue_struct *ice_wq;
> +
> +/**
> + * ice_search_res - Search the tracker for a block of resources
> + * @res: pointer to the resource
> + * @needed: size of the block needed
> + * @id: identifier to track owner
> + * Returns the base item index of the block, or -ENOMEM for error
> + */
> +static int ice_search_res(struct ice_res_tracker *res, u16 needed, u16 id)
> +{
> +	int start = res->search_hint;
> +	int end = start;
> +
> +	id |= ICE_RES_VALID_BIT;
> +
> +	do {
> +		/* skip already allocated entries */
> +		if (res->list[end++] & ICE_RES_VALID_BIT) {
> +			start = end;
> +			if ((start + needed) > res->num_entries)
> +				break;
> +		}
> +
> +		if (end == (start + needed)) {
> +			int i = start;
> +
> +			/* there was enough, so assign it to the requestor */
> +			while (i != end)
> +				res->list[i++] = id;
> +
> +			if (end == res->num_entries)
> +				end = 0;
> +
> +			res->search_hint = end;
> +			return start;
> +		}
> +	} while (1);
> +
> +	return -ENOMEM;
> +}
> +
> +/**
> + * ice_get_res - get a block of resources
> + * @pf: board private structure
> + * @res: pointer to the resource
> + * @needed: size of the block needed
> + * @id: identifier to track owner
> + *
> + * Returns the base item index of the block, or -ENOMEM for error
> + * The search_hint trick and lack of advanced fit-finding only works
> + * because we're highly likely to have all the same size lump requests.

The new naming for this resource tracking is much better than what 
someone used in i40e, but you can probably replace the "lump" reference 
here as well.

Now that there is a 2nd driver using essentially the same code, should 
there be some effort to make it generic and only have the code once in 
the kernel, if it isn't already available?

sln
