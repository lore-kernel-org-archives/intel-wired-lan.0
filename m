From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 7 Nov 2017 06:04:34 -0800
Subject: [Intel-wired-lan] [next PATCH S82 9/9] i40e: Suppress
 compilation warning on kernels older than 3.12
In-Reply-To: <2D74C616BCD7994CBB86279EC09C10B429DBBFDE@IRSMSX104.ger.corp.intel.com>
References: <20171103110511.76793-1-alice.michael@intel.com>
 <20171103110511.76793-9-alice.michael@intel.com>
 <de798a1b-1068-8118-1f48-c6bd4cca2dcd@oracle.com>
 <2D74C616BCD7994CBB86279EC09C10B429DBBFDE@IRSMSX104.ger.corp.intel.com>
Message-ID: <c1d22d6f-b758-a8ff-12f3-ca2f3bceb705@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/6/2017 1:41 AM, Jablonski, Pawel wrote:
> This patch is only for older kernels (where the driver is compiling form source on older systems). In newest ones is not needed.

Then there's no need for it to be pushed upstream.
sln


> 
> -----Original Message-----
> From: Shannon Nelson [mailto:shannon.nelson at oracle.com]
> Sent: Friday, November 3, 2017 9:13 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
> Subject: Re: [Intel-wired-lan] [next PATCH S82 9/9] i40e: Suppress compilation warning on kernels older than 3.12
> 
> On 11/3/2017 4:05 AM, Alice Michael wrote:
>> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
>>
>> In kernels before 3.12 the second parameter in netif_set_xps_queue
>> function has no const qualifier. It is generating warning in older
>> kernels. get_cpu_mask function always returns a pointer with const
>> qualifier. Adding the cast is enough to remove compilation warning.
>>
>> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
>> ---
>>    drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index 8657ef6..1fe8099 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -3062,8 +3062,7 @@ static void i40e_config_xps_tx_ring(struct i40e_ring *ring)
>>    		return;
>>    
>>    	cpu = cpumask_local_spread(ring->q_vector->v_idx, -1);
>> -	netif_set_xps_queue(ring->netdev, get_cpu_mask(cpu),
>> -			    ring->queue_index);
>> +	netif_set_xps_queue(ring->netdev, get_cpu_mask(cpu),
>> +ring->queue_index);
> 
> I see no actual code change here, no cast as advertised.
> sln
> 
>>    }
>>    
>>    /**
>>
> --------------------------------------------------------------------
> 
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
> przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
> others is strictly prohibited.
> 
