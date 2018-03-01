From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 1 Mar 2018 15:22:10 -0800
Subject: [Intel-wired-lan] ixgbe, TSO, and NETIF_F_TSO_MANGLEID
In-Reply-To: <CAKgT0UdWipFpwXcAUGaeq4rv5QijJ50_bg9BRLMjXNijTfjAuw@mail.gmail.com>
References: <2e4fbd7e-6ecc-7811-9275-6971d745977e@oracle.com>
 <CAKgT0UdWipFpwXcAUGaeq4rv5QijJ50_bg9BRLMjXNijTfjAuw@mail.gmail.com>
Message-ID: <3107c35f-5888-f9e4-2695-2c2746ea281c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/1/2018 3:17 PM, Alexander Duyck wrote:
> On Thu, Mar 1, 2018 at 3:05 PM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> Hi folks,
>>
>> In trying to get TSO working for ipsec offload, I've found that
>> NETIF_F_TSO_MANGLEID is not set, so the NETIF_F_TSO bit is getting stripped
>> in ixgbe_features_check().
>>
>> Back in commit
>> commit b83e30104bd9 ("ixgbe/ixgbevf: Add support for GSO partial")
>>
>> NETIF_F_TSO_MANGLEID was added to netdev->vlan_features in ixgbe_probe(),
>> but it is never added to netdev->features.  The patch also added a check for
>> NETIF_F_TSO_MANGLEID in ixgbe_features_check(), but the test is looking in
>> the "features" passed into the function.  As far as I can tell, the calls
>> into .ndo_features_check() are using dev->features, not dev->vlan_features.
>>
>> Should NETIF_F_TSO_MANGLEID be added to netdev->features as well? Something
>> like:
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 82c0543..dcb408b 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -10441,7 +10441,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const
>> struct pci_device_id *ent)
>>          if (pci_using_dac)
>>                  netdev->features |= NETIF_F_HIGHDMA;
>>
>> -       netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
>> +       netdev->features |= NETIF_F_TSO_MANGLEID;
>> +       netdev->vlan_features |= NETIF_F_TSO_MANGLEID;
>> +
>>          netdev->hw_enc_features |= netdev->vlan_features;
>>          netdev->mpls_features |= NETIF_F_SG |
>>                                   NETIF_F_TSO |
> 
> No, we didn't want to add that by default as TSO_MANGLEID can result
> in GRO not working in the case of older kernels.

But in the kernel driver we don't care about "older kernels", right?

> 
> The question I would have is why you need TSO_MANGLEID support for
> IPSEC offload? Is it using GSO_PARTIAL for the IPSec offload? Is IPSec
> setting skb->encapsulation? If so you might need to clean up
> ixgbe_features_check since we had assumed that skb->encapsulation
> meant either a GRE or UDP based tunnel offload.

Yes, IPsec's net/xfrm/xfrm_output.c sets skb->encapsulation when doing 
an offload.

I can tweak the features_check to leave TSO alone for IPsec offloads and 
we'll see if that doesn't break anything else.

sln
