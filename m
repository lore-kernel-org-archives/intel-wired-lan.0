From: John Fastabend <john.fastabend@gmail.com>
Date: Thu, 03 Mar 2016 16:30:32 -0800
Subject: [Intel-wired-lan] [net-next] ixgbe: fix error handling in tc
 cls_u32 offload routines
In-Reply-To: <56D8D6DA.7080702@gmail.com>
References: <1457047192-17092-1-git-send-email-sridhar.samudrala@intel.com>
 <56D8D6DA.7080702@gmail.com>
Message-ID: <56D8D728.3050304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-03-03 04:29 PM, John Fastabend wrote:
> On 16-03-03 03:42 PM, Jeff Kirsher wrote:
>> From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
>>
>> Check for handle ids when adding/deleting hash nodes OR adding/deleting
>> filter entries and limit them to max number of links or header nodes
>> supported(IXGBE_MAX_LINK_HANDLE).
>>
>> Start from bit 0 when setting hash table bit-map.(adapter->tables)
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>
>> Sending this to the correct mailing list (get_maintainer.pl is your
>> friend, please use it in the future)
>>
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 52 +++++++++++++++++----------
>>  1 file changed, 34 insertions(+), 18 deletions(-)
>>
> 
> 
> Looks like a good cleanup to me.
> 
> Acked-by: John Fastabend <john.r.fastabend@intel.com>
> 

Also just checking Sridhar you tested both the adding just to
the first list e.g. matching ip address for example and doing
matches deeper in the stack ala match on sport/dport?

Thanks,
John
