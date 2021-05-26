From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Wed, 26 May 2021 16:34:32 -0500
Subject: [Intel-wired-lan] [PATCH][next] i40e: Replace one-element array
 with flexible-array member
In-Reply-To: <bf46b428deef4e9e89b0ea1704b1f0e5@intel.com>
References: <20210525230038.GA175516@embeddedor>
 <bf46b428deef4e9e89b0ea1704b1f0e5@intel.com>
Message-ID: <b6ad65c6-da10-fd5d-e7ec-add0c607af26@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/26/21 16:29, Saleem, Shiraz wrote:
>> Subject: [PATCH][next] i40e: Replace one-element array with flexible-array member
>>
>> There is a regular need in the kernel to provide a way to declare having a
>> dynamically sized set of trailing elements in a structure. Kernel code should always
>> use ?flexible array members?[1] for these cases. The older style of one-element or
>> zero-length arrays should no longer be used[2].
>>
>> Refactor the code according to the use of a flexible-array member in struct
>> i40e_qvlist_info instead of one-element array, and use the struct_size() helper.
>>
>> [1] https://en.wikipedia.org/wiki/Flexible_array_member
>> [2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-
>> and-one-element-arrays
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> This looks ok to me.
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> 
> It seems we should add this to the new irdma driver submission as well which replaces i40iw.
> I will fold it into v7 of the rdma portion of the series
> https://lore.kernel.org/linux-rdma/20210520200326.GX1096940 at ziepe.ca/

OK. Just please, when you fold it, add my Signed-off-by tag like this:

[flexible array transformation]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> 
> Additionally we will add this patch when we resend this PR on iwl-next.
> https://lore.kernel.org/linux-rdma/62555c6de641e10cb4169653731389a51d086345.camel at intel.com/
> 
> 
>> ---
>>  drivers/infiniband/hw/i40iw/i40iw_main.c      | 5 ++---
>>  drivers/net/ethernet/intel/i40e/i40e_client.c | 2 +-
>>  include/linux/net/intel/i40e_client.h         | 2 +-
>>  3 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c
>> b/drivers/infiniband/hw/i40iw/i40iw_main.c
>> index b496f30ce066..364f69cd620f 100644
>> --- a/drivers/infiniband/hw/i40iw/i40iw_main.c
>> +++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
>> @@ -1423,7 +1423,7 @@ static enum i40iw_status_code
>> i40iw_save_msix_info(struct i40iw_device *iwdev,
>>  	struct i40e_qv_info *iw_qvinfo;
>>  	u32 ceq_idx;
>>  	u32 i;
>> -	u32 size;
>> +	size_t size;
>>
>>  	if (!ldev->msix_count) {
>>  		i40iw_pr_err("No MSI-X vectors\n");
>> @@ -1433,8 +1433,7 @@ static enum i40iw_status_code
>> i40iw_save_msix_info(struct i40iw_device *iwdev,
>>  	iwdev->msix_count = ldev->msix_count;
>>
>>  	size = sizeof(struct i40iw_msix_vector) * iwdev->msix_count;
>> -	size += sizeof(struct i40e_qvlist_info);
>> -	size +=  sizeof(struct i40e_qv_info) * iwdev->msix_count - 1;
>> +	size += struct_size(iw_qvlist, qv_info, iwdev->msix_count);
>>  	iwdev->iw_msixtbl = kzalloc(size, GFP_KERNEL);
>>
>>  	if (!iwdev->iw_msixtbl)
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
>> b/drivers/net/ethernet/intel/i40e/i40e_client.c
>> index 32f3facbed1a..63eab14a26df 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
>> @@ -579,7 +579,7 @@ static int i40e_client_setup_qvlist(struct i40e_info *ldev,
>>  	u32 v_idx, i, reg_idx, reg;
>>
>>  	ldev->qvlist_info = kzalloc(struct_size(ldev->qvlist_info, qv_info,
>> -				    qvlist_info->num_vectors - 1), GFP_KERNEL);
>> +				    qvlist_info->num_vectors), GFP_KERNEL);
>>  	if (!ldev->qvlist_info)
>>  		return -ENOMEM;
>>  	ldev->qvlist_info->num_vectors = qvlist_info->num_vectors; diff --git
>> a/include/linux/net/intel/i40e_client.h b/include/linux/net/intel/i40e_client.h
>> index f41387a8969f..fd7bc860a241 100644
>> --- a/include/linux/net/intel/i40e_client.h
>> +++ b/include/linux/net/intel/i40e_client.h
>> @@ -48,7 +48,7 @@ struct i40e_qv_info {
>>
>>  struct i40e_qvlist_info {
>>  	u32 num_vectors;
>> -	struct i40e_qv_info qv_info[1];
>> +	struct i40e_qv_info qv_info[];
>>  };
>>
>>
>> --
>> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
