From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 5 Aug 2021 20:56:41 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: don't remove
 netdev->dev_addr from uc sync list
In-Reply-To: <9e0bce1b48e0c5f6d16757054ca12a8424c75991.camel@intel.com>
References: <20210728203457.325482-1-brett.creeley@intel.com>
 <5a641af5-e3fc-3b7c-6ddd-ef25e3f4a1ad@molgen.mpg.de>
 <9e0bce1b48e0c5f6d16757054ca12a8424c75991.camel@intel.com>
Message-ID: <a9d41ed8-9464-d74c-b85e-dae5c3aba773@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Brett,


Am 05.08.21 um 20:30 schrieb Creeley, Brett:
> On Thu, 2021-08-05 at 08:51 +0200, Paul Menzel wrote:

>> Am 28.07.21 um 22:34 schrieb Brett Creeley:
>>> In some circumstances, such as with bridging, it's possible that
>>> the
>>> stack will add the device's own MAC address to its unicast address
>>> list.
>>>
>>> If, later, the stack deletes this address, the driver will receive
>>> a
>>> request to remove this address.
>>>
>>> The driver stores its current MAC address as part of the VSI MAC
>>> filter
>>> list instead of separately. So, this causes a problem when the
>>> device's
>>> MAC address is deleted unexpectedly, which results in traffic
>>> failure
>>> in some cases.
>>>
>>> Fix this by making sure to not delete the netdev->dev_addr during
>>> MAC address sync.
>>
>> Is it easy to reproduce?
> 
> Yes, I will add more details when I re-spin the patch.
> 
>>
>>> There is a possibility of a race condition between .set_mac and
>>> .set_rx_mode. Fix this by calling netif_addr_lock_bh() and
>>> netif_addr_unlock_bh() on the device's netdev when the netdev-
>>>> dev_addr
>>> is going to be updated in .set_mac.
>>>
>>> Also, change the netdev_warn() to netdev_dbg() when the device is
>>> already using the requested mac in .set_mac. The dev_warn() was
>>> causing
>>> a lot of unnecessary noise when configuring/unconfiguring bridging
>>> and
>>> provides no benefit.
>>>
>>> Lastly, instead of using memcpy() to save the netdev->dev_addr, use
>>> ether_addr_copy() in .set_mac.
>>
>> It?d be great, if you split the three items out into separate
>> patches, and submit it in a patch series.
> 
> I'm thinking that this is actually a 2 patch series. With the fix
> to not delete the device's address, the netdev_warn() was causing
> a lot of noise. Based on this I believe that the netdev_warn() to
> netdev_dbg() should be part of the same patch that fixes the
> previously mentioned problem.
> 
> However, I will send the ether_addr_copy() change to net-next/ as
> a separate patch since it is not fixing anything, just a general
> improvement.
> 
> Hopefully this works for you and thanks for the feedback!

Perfect. Thank you.


Kind regards,

Paul
