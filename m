From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Date: Sat, 16 Apr 2022 03:33:37 +0200
Subject: [Intel-wired-lan] [PATCH] intel: igb: igb_ethtool.c: Convert
 kmap() to kmap_local_page()
In-Reply-To: <Ylnmaji5bHHp8t3p@iweiny-desk3>
References: <20220415205307.675650-1-eng.alaamohamedsoliman.am@gmail.com>
 <Ylnmaji5bHHp8t3p@iweiny-desk3>
Message-ID: <78253f3a-cdca-166a-ee54-e2173b2be5a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On ???/??/???? ??:??, Ira Weiny wrote:
> On Fri, Apr 15, 2022 at 10:53:07PM +0200, Alaa Mohamed wrote:
>> The use of kmap() is being deprecated in favor of kmap_local_page()
>> where it is feasible.
>>
>> With kmap_local_page(), the mapping is per thread, CPU local and not
>> globally visible.
>>
>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>> index 2a5782063f4c..ba93aa4ae6a0 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>> @@ -1798,14 +1798,14 @@ static int igb_check_lbtest_frame(struct igb_rx_buffer *rx_buffer,
>>   
>>   	frame_size >>= 1;
>>   
>> -	data = kmap(rx_buffer->page);
>> +	data = kmap_local_page(rx_buffer->page);
>>   
>>   	if (data[3] != 0xFF ||
>>   	    data[frame_size + 10] != 0xBE ||
>>   	    data[frame_size + 12] != 0xAF)
>>   		match = false;
>>   
>> -	kunmap(rx_buffer->page);
>> +	kunmap_local(rx_buffer->page);
> kunmap_local() is different from kunmap().  It takes an address within the
> mapped page.  From the kdoc:
>
> /**
>   * kunmap_local - Unmap a page mapped via kmap_local_page().
>   * @__addr: An address within the page mapped
>   *
>   * @__addr can be any address within the mapped page.  Commonly it is the
>   * address return from kmap_local_page(), but it can also include offsets.
>   *
>   * Unmapping should be done in the reverse order of the mapping.  See
>   * kmap_local_page() for details.
>   */
> #define kunmap_local(__addr)                                    \
> ...
Got it , Thanks
>
>
> Ira
>
>>   
>>   	return match;
>>   }
>> -- 
>> 2.35.2
>>
