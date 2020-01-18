From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 17 Jan 2020 16:01:13 -0800
Subject: [Intel-wired-lan] [PATCH RFC rdma 01/16] RDMA/irdma: Add driver
 framework definitions
In-Reply-To: <20200116230508.1814-2-shiraz.saleem@intel.com>
References: <20200116230508.1814-1-shiraz.saleem@intel.com>
 <20200116230508.1814-2-shiraz.saleem@intel.com>
Message-ID: <69b30196-f854-0e5d-3971-818e720fd410@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Shiraz,

On 1/16/2020 3:04 PM, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Register irdma as a platform driver capable of supporting platform
> devices from multi-generation RDMA capable Intel HW. Establish the
> interface with all supported netdev peer devices and initialize HW.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>


> +enum irdma_dl_param_id {
> +	IRDMA_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
> +	IRDMA_DEVLINK_PARAM_ID_LIMITS_SELECTOR,
> +	IRDMA_DEVLINK_PARAM_ID_UPLOAD_CONTEXT,
> +	IRDMA_DEVLINK_PARAM_ID_ROCE_ENABLE,
> +};
> +
> +static const struct devlink_param irdma_devlink_params[] = {
> +	/* Common */
> +	DEVLINK_PARAM_DRIVER(IRDMA_DEVLINK_PARAM_ID_LIMITS_SELECTOR,
> +			     "resource_limits_selector", DEVLINK_PARAM_TYPE_U8,
> +			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> +			      NULL, NULL, irdma_devlink_rsrc_limits_validate),
> +	DEVLINK_PARAM_DRIVER(IRDMA_DEVLINK_PARAM_ID_UPLOAD_CONTEXT,
> +			     "upload_context", DEVLINK_PARAM_TYPE_BOOL,
> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> +			     irdma_devlink_upload_ctx_get,
> +			     irdma_devlink_upload_ctx_set, NULL),
> +#define IRDMA_DL_COMMON_PARAMS_ARRAY_SZ 2
> +	/* GEN_2 only */
> +	DEVLINK_PARAM_DRIVER(IRDMA_DEVLINK_PARAM_ID_ROCE_ENABLE,
> +			     "roce_enable", DEVLINK_PARAM_TYPE_BOOL,
> +			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> +			      NULL, NULL, NULL),
> +};
> +
The devlink parameter "roce_enable" should really be the standard
generic "enable_roce", as documented in
Documentation/networking/devlink/devlink-params.rst (Previously
Documentation/networking/devlink-params.txt).

It does not make sense to proliferate additional similar names when a
generic one already exists.

Thanks,
Jake
