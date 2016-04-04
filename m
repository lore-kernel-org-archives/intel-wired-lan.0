From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 4 Apr 2016 19:37:28 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: make 'action' field in
	struct	ixgbe_fdir_filter a u64 value
In-Reply-To: <1459532078-11858-1-git-send-email-sridhar.samudrala@intel.com>
References: <1459532078-11858-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9AA98C@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Friday, April 01, 2016 10:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: make 'action' field in struct
> ixgbe_fdir_filter a u64 value
> 
> This field is used to record the RX queue index for a redirect action passed via
> ring_cookie field in struct ethtool_rx_flow_spec which is a u64 value.
> 
> For ex: after adding a filter rule to redirect to a VF using ethtool
>   # echo 4 > /sys/class/net/p4p1/device/sriov_numvfs
>   # ethtool -N p4p1 flow-type ip4 src-ip 192.168.0.1 action 0x100000000
> 
> querying for the rule shows the Action as 'Direct to queue 0'
> 
>   # ethtool -n p4p1
>   4 RX rings available
>   Total 1 rules
> 
>   Filter: 2045
>  	Rule Type: Raw IPv4
> 	Src IP addr: 192.168.0.1 mask: 0.0.0.0
> 	Dest IP addr: 0.0.0.0 mask: 255.255.255.255
> 	TOS: 0x0 mask: 0xff
> 	Protocol: 0 mask: 0xff
> 	L4 bytes: 0x0 mask: 0xffffffff
> 	VLAN EtherType: 0x0 mask: 0xffff
> 	VLAN: 0x0 mask: 0xffff
> 	User-defined: 0x0 mask: 0xffffffffffffffff
> 	Action: Direct to queue 0
> 
> With this fix, ethtool will report the right queue index even for VFs.
> 	Action: Direct to queue 4294967296
> 
> Here 4294967296 corresponds to 0x100000000.
> We need to update 'ethtool' to report the queue index as a Hex value so that
> it is more  user friendly and matches with the 'action' value that is passed
> when adding the rule.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethool shows correct value with patch applied
