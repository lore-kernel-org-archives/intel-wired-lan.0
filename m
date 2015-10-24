From: nick <xerofoify@gmail.com>
Date: Sat, 24 Oct 2015 14:18:40 -0400
Subject: [Intel-wired-lan] [PATCH] e1000e:Fix incorrect assumption that
 the function e1000e_up always runs successfully in e1000_change_mtu
In-Reply-To: <562B1E9E.5090005@gmail.com>
References: <1445659791-30497-1-git-send-email-xerofoify@gmail.com>
 <562B1E9E.5090005@gmail.com>
Message-ID: <562BCB80.5060500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 2015-10-24 02:01 AM, Alexander Duyck wrote:
> On 10/23/2015 09:09 PM, Nicholas Krause wrote:
>> This fixes the function e1000_change_mtu to properly check and run
>> the error code by e1000e_up as this function can fail and the error
>> code should be returned to the caller of the function e1000_change_mtu
>> to signal a error has occurred when calling this particular function
> 
> The function e1000e_up always returns 0.  It should probably be switched to a void instead of an int.  You could probably go through and drop a bunch of dead code that is checking for the result of that function as well.
> 
There is none that I known of but if you want I will check again to make sure and make the
function e1000_up_always void.
Nick
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index faf4b3f..aebccb1 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -5931,6 +5931,7 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
>>   {
>>       struct e1000_adapter *adapter = netdev_priv(netdev);
>>       int max_frame = new_mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
>> +    int err = 0;
>>         /* Jumbo frame support */
>>       if ((max_frame > (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)) &&
>> @@ -5984,7 +5985,9 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
>>           adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
>>         if (netif_running(netdev))
>> -        e1000e_up(adapter);
>> +        err = e1000e_up(adapter);
>> +        if (err)
>> +            e_err("Failed to successfully bring up this adapter\n");
>>       else
>>           e1000e_reset(adapter);
>>   @@ -5992,7 +5995,7 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
>>         clear_bit(__E1000_RESETTING, &adapter->state);
>>   -    return 0;
>> +    return err;
>>   }
>>     static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
> 
