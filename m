From: Stefan Assmann <sassmann@kpanic.de>
Date: Tue, 3 Sep 2019 09:09:16 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: clear
 __I40E_VIRTCHNL_OP_PENDING on invalid min tx rate
In-Reply-To: <36909884-1de6-a537-0341-b060d01e4c0d@molgen.mpg.de>
References: <20190903060810.30775-1-sassmann@kpanic.de>
 <36909884-1de6-a537-0341-b060d01e4c0d@molgen.mpg.de>
Message-ID: <58a1b74a-574e-ed95-e33e-49a230017773@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 03.09.19 08:42, Paul Menzel wrote:
> Dear Stefan,

Hi Paul,

> On 03.09.19 08:08, Stefan Assmann wrote:
>> In the case of an invalid min tx rate being requested
>> i40e_ndo_set_vf_bw() immediately returns -EINVAL instead of releasing
>> __I40E_VIRTCHNL_OP_PENDING first.
> 
> What problem does this cause?

If the __I40E_VIRTCHNL_OP_PENDING bit never gets cleared no further
virtchnl op can be processed. For example you can no longer destroy the
VFs.

  Stefan

>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> index f8aa4deceb5e..3d2440838822 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> @@ -4263,7 +4263,8 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
>>   	if (min_tx_rate) {
>>   		dev_err(&pf->pdev->dev, "Invalid min tx rate (%d) (greater than 0) specified for VF %d.\n",
>>   			min_tx_rate, vf_id);
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto error;
>>   	}
>>   
>>   	vf = &pf->vf[vf_id];
> 
> 
> Kind regards,
> 
> Paul
> 

