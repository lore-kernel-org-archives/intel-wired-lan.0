From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 26 Aug 2020 18:30:28 +0000
Subject: [Intel-wired-lan] [PATCH net 2/2] ice: add additional debug
 logging for firmware update
In-Reply-To: <20200826181448.1176594-2-jacob.e.keller@intel.com>
References: <20200826181448.1176594-1-jacob.e.keller@intel.com>
 <20200826181448.1176594-2-jacob.e.keller@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB58C8BA9AEA@fmsmsx101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Keller, Jacob E <jacob.e.keller@intel.com>
> Sent: Wednesday, August 26, 2020 11:15 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH net 2/2] ice: add additional debug logging for firmware update
> 
> While debugging a recent failure to update the flash of an ice device,
> I found it helpful to add additional logging which helped determine the
> root cause of the problem being a timeout issue.
> 
> Add some extra dev_dbg() logging messages which can be enabled using the
> dynamic debug facility, including one for ice_aq_wait_for_event that
> will use jiffies to capture a rough estimate of how long we waited for
> the completion of a firmware command.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---



Ooops, when I rebased this onto net-queue one of the hunks fails to compile, and I didn't remember to check that before submitting.

>  drivers/net/ethernet/intel/ice/ice_devlink.c  |  3 +++
>  .../net/ethernet/intel/ice/ice_fw_update.c    | 27 ++++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_main.c     |  9 +++++++
>  3 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c
> b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index 111d6bfe4222..b6f5faf73ec3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -271,6 +271,9 @@ ice_devlink_flash_update(struct devlink *devlink, const
> char *path,
>  		return err;
>  	}
> 
> +	dev_dbg(dev, "Beginning flash update with file '%s', preservation level
> %u\n",
> +		params->file_name, preservation);
> +

This hunk is wrong, it references code that is not yet submitted (the params structure, and the preservation level).

>  	devlink_flash_update_begin_notify(devlink);
>  	devlink_flash_update_status_notify(devlink, "Preparing to flash",
>  					   component, 0, 0);
> diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c
> b/drivers/net/ethernet/intel/ice/ice_fw_update.c
> index 29397a83699d..14a3b6838461 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
> @@ -43,6 +43,8 @@ ice_send_package_data(struct pldmfw *context, const u8
> *data, u16 length)
>  	enum ice_status status;
>  	u8 *package_data;
> 
> +	dev_dbg(dev, "Sending PLDM record package data to firmware\n");
> +
>  	package_data = kmemdup(data, length, GFP_KERNEL);
>  	if (!package_data)
>  		return -ENOMEM;
> @@ -229,6 +231,8 @@ ice_send_component_table(struct pldmfw *context,
> struct pldmfw_component *compon
>  	comp_tbl->cvs_len = component->version_len;
>  	memcpy(comp_tbl->cvs, component->version_string, component-
> >version_len);
> 
> +	dev_dbg(dev, "Sending component table to firmware:\n");
> +
>  	status = ice_nvm_pass_component_tbl(hw, (u8 *)comp_tbl, length,
>  					    transfer_flag, &comp_response,
>  					    &comp_response_code, NULL);
> @@ -279,11 +283,13 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16
> module, u32 offset,
> 
>  	memset(&event, 0, sizeof(event));
> 
> +	dev_dbg(dev, "Writing block of %u bytes for module 0x%02x at offset
> %u\n", block_size, module, offset);
> +
>  	status = ice_aq_update_nvm(hw, module, offset, block_size, block,
>  				   last_cmd, 0, NULL);
>  	if (status) {
> -		dev_err(dev, "Failed to program flash module 0x%02x at offset
> %u, err %s aq_err %s\n",
> -			module, offset, ice_stat_str(status),
> +		dev_err(dev, "Failed to flash module 0x%02x with block of size
> %u at offset %u, err %s aq_err %s\n",
> +			module, block_size, offset, ice_stat_str(status),
>  			ice_aq_str(hw->adminq.sq_last_status));
>  		NL_SET_ERR_MSG_MOD(extack, "Failed to program flash
> module");
>  		return -EIO;
> @@ -297,8 +303,8 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module,
> u32 offset,
>  	 */
>  	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_write, 15*HZ,
> &event);
>  	if (err) {
> -		dev_err(dev, "Timed out waiting for firmware write completion
> for module 0x%02x, err %d\n",
> -			module, err);
> +		dev_err(dev, "Timed out while trying to flash module 0x%02x
> with block of size %u at offset %u, err %d\n",
> +			module, block_size, offset, err);
>  		NL_SET_ERR_MSG_MOD(extack, "Timed out waiting for
> firmware");
>  		return -EIO;
>  	}
> @@ -324,8 +330,8 @@ ice_write_one_nvm_block(struct ice_pf *pf, u16 module,
> u32 offset,
>  	}
> 
>  	if (completion_retval) {
> -		dev_err(dev, "Firmware failed to program flash module 0x%02x
> at offset %u, completion err %s\n",
> -			module, offset,
> +		dev_err(dev, "Firmware ailed to flash module 0x%02x with block
> of size %u at offset %u, err %s\n",
> +			module, block_size, offset,
>  			ice_aq_str((enum ice_aq_err)completion_retval));
>  		NL_SET_ERR_MSG_MOD(extack, "Firmware failed to program
> flash module");
>  		return -EIO;
> @@ -356,12 +362,15 @@ ice_write_nvm_module(struct ice_pf *pf, u16 module,
> const char *component,
>  		     const u8 *image, u32 length,
>  		     struct netlink_ext_ack *extack)
>  {
> +	struct device *dev = ice_pf_to_dev(pf);
>  	struct devlink *devlink;
>  	u32 offset = 0;
>  	bool last_cmd;
>  	u8 *block;
>  	int err;
> 
> +	dev_dbg(dev, "Beginning write of flash component '%s', module
> 0x%02x\n", component, module);
> +
>  	devlink = priv_to_devlink(pf);
> 
>  	devlink_flash_update_status_notify(devlink, "Flashing",
> @@ -394,6 +403,8 @@ ice_write_nvm_module(struct ice_pf *pf, u16 module,
> const char *component,
>  						   component, offset, length);
>  	} while (!last_cmd);
> 
> +	dev_dbg(dev, "Completed write of flash component '%s', module
> 0x%02x\n", component, module);
> +
>  	if (err)
>  		devlink_flash_update_status_notify(devlink, "Flashing failed",
>  						   component, length, length);
> @@ -431,6 +442,8 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module,
> const char *component,
>  	enum ice_status status;
>  	int err;
> 
> +	dev_dbg(dev, "Beginning erase of flash component '%s', module
> 0x%02x\n", component, module);
> +
>  	memset(&event, 0, sizeof(event));
> 
>  	devlink = priv_to_devlink(pf);
> @@ -476,6 +489,8 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module,
> const char *component,
>  		goto out_notify_devlink;
>  	}
> 
> +	dev_dbg(dev, "Completed erase of flash component '%s', module
> 0x%02x\n", component, module);
> +
>  out_notify_devlink:
>  	if (err)
>  		devlink_flash_update_status_notify(devlink, "Erasing failed",
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 4634b48949bb..c623cdf29d6b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1057,7 +1057,9 @@ struct ice_aq_task {
>  int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
>  			  struct ice_rq_event_info *event)
>  {
> +	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_aq_task *task;
> +	unsigned long start;
>  	long ret;
>  	int err;
> 
> @@ -1074,6 +1076,8 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16
> opcode, unsigned long timeout,
>  	hlist_add_head(&task->entry, &pf->aq_wait_list);
>  	spin_unlock_bh(&pf->aq_wait_lock);
> 
> +	start = jiffies;
> +
>  	ret = wait_event_interruptible_timeout(pf->aq_wait_queue, task->state,
>  					       timeout);
>  	switch (task->state) {
> @@ -1092,6 +1096,11 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16
> opcode, unsigned long timeout,
>  		break;
>  	}
> 
> +	dev_dbg(dev, "Waited %u msecs (max %u msecs) for firmware response
> to op 0x%04x\n",
> +		jiffies_to_msecs(jiffies - start),
> +		jiffies_to_msecs(timeout),
> +		opcode);
> +
>  	spin_lock_bh(&pf->aq_wait_lock);
>  	hlist_del(&task->entry);
>  	spin_unlock_bh(&pf->aq_wait_lock);
> --
> 2.28.0.218.ge27853923b9d.dirty

