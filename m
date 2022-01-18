From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 18 Jan 2022 21:01:30 +0100
Subject: [Intel-wired-lan] [PATCH] ice: Don't use GFP_KERNEL in atomic
 context
In-Reply-To: <YeSRUVmrdmlUXHDn@lunn.ch>
References: <40c94af2f9140794351593047abc95ca65e4e576.1642358759.git.christophe.jaillet@wanadoo.fr>
 <YeSRUVmrdmlUXHDn@lunn.ch>
Message-ID: <464d0428-42ba-cd68-f21c-630850e6f3c7@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Le 16/01/2022 ? 22:42, Andrew Lunn a ?crit?:
> On Sun, Jan 16, 2022 at 07:46:20PM +0100, Christophe JAILLET wrote:
>> ice_misc_intr() is an irq handler. It should not sleep.
>>
>> Use GFP_ATOMIC instead of GFP_KERNEL when allocating some memory.
>>
>> Fixes: 348048e724a0 ("ice: Implement iidc operations")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> I've never played a lot with irq handler. My understanding is that they
>> should never sleep.
> 
> Hi Christophe
> 
> Threaded interrupt handlers are allowed to sleep. However, this
> handler is not being used in such a way. So your are probably correct
> about GFP_KERNEL vs GFP_ATOMIC.
> 
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 30814435f779..65de01f3a504 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -3018,7 +3018,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
>>   		struct iidc_event *event;
>>   
>>   		ena_mask &= ~ICE_AUX_CRIT_ERR;
>> -		event = kzalloc(sizeof(*event), GFP_KERNEL);
>> +		event = kzalloc(sizeof(*event), GFP_ATOMIC);
>>   		if (event) {
>>   			set_bit(IIDC_EVENT_CRIT_ERR, event->type);
>>   			/* report the entire OICR value to AUX driver */
> 
> What happens next is interesting...
> 
> 
>                          event->reg = oicr;
>                          ice_send_event_to_aux(pf, event);
> 
> where:
> 
> void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_event *event)
> {
>          struct iidc_auxiliary_drv *iadrv;
> 
>          if (!pf->adev)
>                  return;
> 
>          device_lock(&pf->adev->dev);
>          iadrv = ice_get_auxiliary_drv(pf);
>          if (iadrv && iadrv->event_handler)
>                  iadrv->event_handler(pf, event);
>          device_unlock(&pf->adev->dev);
> }
> 
> device_lock() takes a mutex, not something you should be doing in
> atomic context.
> 
> So it looks to me, this handler really should be running in thread
> context...
> 
> 	Andrew
> 

Ok, thanks for the explanation.

ice_misc_intr() is registered with devm_request_irq(), so it is a 
handler that can't sleep.

I guess that more consideration should be taken into account than only:
   s/devm_request_irq(handler)/devm_request_threaded_irq(NULL, handler)/

So I'll leave this one to people with the expected know-how.

If my s/GFP_KERNEL/GFP_ATOMIC/ makes enough sense as-is, that's fine for 
me, but it looks that another solution is needed to fix the 2nd issue.


CJ
