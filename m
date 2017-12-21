From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 20 Dec 2017 17:39:13 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 05/10] ixgbe: add ipsec
 offload add and remove SA
In-Reply-To: <20171221010139.GM6122@localhost.localdomain>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-6-git-send-email-shannon.nelson@oracle.com>
 <20171221010139.GM6122@localhost.localdomain>
Message-ID: <85fe1cd2-e935-52dc-e36b-0973e4c03653@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/20/2017 5:17 PM, Marcelo Ricardo Leitner wrote:
> Hi,
> 
> On Tue, Dec 19, 2017 at 03:59:57PM -0800, Shannon Nelson wrote:
>> +}
>> +
>> +static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
>> +	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
>> +	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
>> +};
>> +
> 
> This struct is only declared if XFRM_OFFLOAD is selected. What is
> selecting it for ixgbe driver?
> mlx5 driver has an extra option for ipsec offload and it then does
> 'depends on XFRM_OFFLOAD'
> 
>    Marcelo
> 

I didn't bother putting a 'depends' item in the ixgbe's Kconfig entry, 
and I didn't create an extra CONFIG variable to enable ixgbe's support 
of the offload.  If CONFIG_XFRM_OFFLOAD is set, then ixgbe will support it.

sln

