From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 1 May 2017 22:20:28 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 11/13] virtchnl: Add pad
 fields to a couple of structures
In-Reply-To: <a9dac743-fbe8-89c5-fa53-c711b7ef9ee8@oracle.com>
References: <1493663091-27870-1-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-2-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-3-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-4-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-5-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-6-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-7-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-8-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-9-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-10-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-11-git-send-email-jesse.brandeburg@intel.com>
 <1493663091-27870-12-git-send-email-jesse.brandeburg@intel.com>
 <a9dac743-fbe8-89c5-fa53-c711b7ef9ee8@oracle.com>
Message-ID: <b02baa8a-5110-6842-9ae9-37b1b6c95ef9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/1/2017 10:18 PM, Shannon Nelson wrote:
> On 5/1/2017 11:24 AM, Jesse Brandeburg wrote:
>> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>
>> This removes holes and makes structure sizes consistent across
>> 32 and 64 bit builds.
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>
>> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
>> index 3f15d6a..ea34154 100644
>> --- a/include/linux/avf/virtchnl.h
>> +++ b/include/linux/avf/virtchnl.h
>> @@ -275,8 +275,10 @@ struct virtchnl_rxq_info {
>>      u16 splithdr_enabled; /* deprecated with AVF 1.0 */
>
> Isn't there a 2 byte hole here as well?
> sln

Oh, nevermind, I misread the diff.
sln

>
>>      u32 databuffer_size;
>>      u32 max_pkt_size;
>> +    u32 pad1;
>>      u64 dma_ring_addr;
>>      enum virtchnl_rx_hsplit rx_split_pos; /* deprecated with AVF 1.0 */
>> +    u32 pad2;
>>  };
>>
>>  /* VIRTCHNL_OP_CONFIG_VSI_QUEUES
>> @@ -295,6 +297,7 @@ struct virtchnl_queue_pair_info {
>>  struct virtchnl_vsi_queue_config_info {
>>      u16 vsi_id;
>>      u16 num_queue_pairs;
>> +    u32 pad;
>>      struct virtchnl_queue_pair_info qpair[1];
>>  };
>>
>>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
