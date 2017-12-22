From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 22 Dec 2017 14:33:30 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 08/10] ixgbe: process
 the Tx ipsec offload
In-Reply-To: <6dc35153-0615-2132-a8d7-ab6ab05f0ab5@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-9-git-send-email-shannon.nelson@oracle.com>
 <6dc35153-0615-2132-a8d7-ab6ab05f0ab5@oracle.com>
Message-ID: <5d74c5f8-0bd3-6a4e-3318-ac9616119978@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/22/2017 12:24 AM, Yanjun Zhu wrote:
> On 2017/12/20 8:00, Shannon Nelson wrote:
>> If the skb has a security association referenced in the skb, then
>> set up the Tx descriptor with the ipsec offload bits.? While we're
>> here, we fix an oddly named field in the context descriptor struct.
>>

[...]

>> +int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
>> +?????????? struct ixgbe_tx_buffer *first,
>> +?????????? struct ixgbe_ipsec_tx_data *itd)
>> +{
>> +??? struct ixgbe_adapter *adapter = netdev_priv(tx_ring->netdev);
>> +??? struct ixgbe_ipsec *ipsec = adapter->ipsec;
>> +??? struct xfrm_state *xs;
>> +??? struct tx_sa *tsa;
>> +
>> +??? if (!first->skb->sp->len) {
> Hi, Nelson
> 
> The function ixgbe_ipsec_tx is called in tx fastpath. Can we add 
> unlikely as below:
> if (unlikely(!first->skb->sp->len)) ?
> 
> If I am wrong, please correct me.
> 
> Thanks a lot.
> Zhu Yanjun

Yes, we can probably throw those in.  I'll be working on this code in 
the new year to get the checksum and TSO bits working and can add these 
at that time.

sln


