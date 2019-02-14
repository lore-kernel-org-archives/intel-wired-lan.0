From: Xuguizhu (Guzhu Xu, Intelligent Computing Business Dept) <xuguizhu@huawei.com>
Date: Thu, 14 Feb 2019 03:48:09 +0000
Subject: [Intel-wired-lan] [net] ixgbe: fix older devices that do not
 support IXGBE_MRQC_L3L4TXSWEN
Message-ID: <315E3AFC3F1FCC4A88C68B5581547E0682A71DE4@dggemm513-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi guys:
	We would like to know what kind of issues this patch may cause before it is modified, or what triggers you to make this change. How can we reproduce this issue in the lab? The cards we can find in our lab are 82599, X540 and X550. Please guide us to verify this issue, thank you very much. After comparing the data sheets of the 82599 and X550, we found that the L3L4TXSWEN bit in the 82599 NIC is reserved, but this flag is writable.

-----????-----
???: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] ?? Bowers, AndrewX
????: 2019?1?31? 3:40
???: intel-wired-lan at lists.osuosl.org
??: Re: [Intel-wired-lan] [net] ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On 
> Behalf Of Jeff Kirsher
> Sent: Monday, January 28, 2019 9:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net] ixgbe: fix older devices that do not 
> support IXGBE_MRQC_L3L4TXSWEN
> 
> The enabling L3/L4 filtering for transmit switched packets for all 
> devices caused unforeseen issue on older devices when trying to send 
> UDP traffic in an ordered sequence.  This bit was originally intended 
> for X550 devices, which supported this feature, so limit the scope of 
> this bit to only X550 devices.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
