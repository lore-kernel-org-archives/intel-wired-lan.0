From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Aug 2016 02:07:00 +0000
Subject: [Intel-wired-lan] [net-next] igb: add function to set I210
 transmit	mode
In-Reply-To: <1470811692-24574-2-git-send-email-gangfeng.huang@ni.com>
References: <1470811692-24574-1-git-send-email-gangfeng.huang@ni.com>
 <1470811692-24574-2-git-send-email-gangfeng.huang@ni.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F7314E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Gangfeng
> Sent: Tuesday, August 9, 2016 11:48 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gangfeng Huang <gangfeng.huang@ni.com>
> Subject: [Intel-wired-lan] [net-next] igb: add function to set I210 transmit
> mode
> 
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> I210 supports two transmit modes, legacy and Qav. The transmit mode is
> configured in TQAVCTRL.QavMode register. Before this patch igb driver
> only support legacy mode. This patch makes it possible to configure the
> transmit mode.
> 
> Example:
> Get the transmit mode:
> $ echo /sys/class/net/eth0/qav_mode
> 0

I think you mean "cat /sys/class/net/eth0/qav_mode" to see the contents, echo just displays the file name.

Having said that, I really appreciate you putting detailed instructions in the description.  It's rather surprising how often basic instructions do not get included. 

> Set transmit mode to qav mode
> $ echo 1 > /sys/class/net/eth0/qav_mode
>  

<snip>

>  #define MAXIMUM_ETHERNET_VLAN_SIZE 1522
> 
> +/* In qav mode, the maximum frame size is 1536 */
> +#define IGB_MAX_QAV_FRAME_SIZE 1536
> +

When I am in qav_mode I am not able to set the MTU beyond 1514, which I believe adds up to 1536 when I add the Ethernet header and a VLAN header, so this part seems good.  However, I am able to toggle into qav_mode with the MTU set to a larger value, the MTU stays at the larger value and I do not get any indication on the console, dmesg or logs that the MTU should be reduced.  I think failing to change to qav_mode with a message stating to reduce the MTU would be the desired behavior here.
