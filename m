From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 20 Dec 2017 19:30:25 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 05/10] ixgbe: add ipsec
 offload add and remove SA
In-Reply-To: <20171221022104.GN6122@localhost.localdomain>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-6-git-send-email-shannon.nelson@oracle.com>
 <20171221010139.GM6122@localhost.localdomain>
 <85fe1cd2-e935-52dc-e36b-0973e4c03653@oracle.com>
 <20171221022104.GN6122@localhost.localdomain>
Message-ID: <6056ec27-10c5-41cd-1e46-b21746814c8e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/20/2017 6:21 PM, Marcelo Ricardo Leitner wrote:
> On Wed, Dec 20, 2017 at 05:39:13PM -0800, Shannon Nelson wrote:
>> On 12/20/2017 5:17 PM, Marcelo Ricardo Leitner wrote:
>>> Hi,
>>>
>>> On Tue, Dec 19, 2017 at 03:59:57PM -0800, Shannon Nelson wrote:
>>>> +}
>>>> +
>>>> +static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
>>>> +	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
>>>> +	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
>>>> +};
>>>> +
>>>
>>> This struct is only declared if XFRM_OFFLOAD is selected. What is
>>> selecting it for ixgbe driver?
>>> mlx5 driver has an extra option for ipsec offload and it then does
>>> 'depends on XFRM_OFFLOAD'
>>>
>>>     Marcelo
>>>
>>
>> I didn't bother putting a 'depends' item in the ixgbe's Kconfig entry, and I
>> didn't create an extra CONFIG variable to enable ixgbe's support of the
>> offload.  If CONFIG_XFRM_OFFLOAD is set, then ixgbe will support it.
> 
> You handled it via Makefile, okay. Missed it on patch 2, my bad.
> 
> Anyhow, we probably could use some standard here across the vendors
> here.  With this patchset, we have 2 drivers supporting it, and 2
> different ways to configure it.

I suspect that the mlx5 folks did an extra option as part of being the 
first to support the feature, and needing an easy way to toggle support 
while they were developing it without needing to rebuild the whole 
kernel.  Now that the feature has reached a certain level of "maturity", 
I think we can treat it like other features (e.g. CONFIG_PCI_IOV, 
CONFIG_FCOE, CONFIG_PM, CONFIG_DEBUG_FS) and not need driver specific 
toggles.

sln

